dofile_once("data/scripts/lib/coroutines.lua")
dofile_once("data/scripts/lib/utilities.lua")

dofile("mods/twitch_extended/files/scripts/misc/initial_compat.lua")


if(ModIsEnabled("spellbound_bundle"))then
	GameAddFlagRun("spellbound_enabled")
end

if(ModIsEnabled("noita-together"))then
	ModLuaFileAppend("noita-together/files/ws/events.lua", "mods/twitch_extended/files/scripts/append/noitatogether_events.lua")
end

if(ModIsEnabled("twitch_lib"))then
	dofile_once("mods/twitch_lib/files/twitch_overwrites.lua")
end

ModRegisterAudioEventMappings("mods/twitch_extended/GUIDs.txt")

local nxml = dofile("mods/twitch_extended/lib/nxml.lua")
if(ModIsEnabled( "config_lib" ))then
	dofile_once("mods/twitch_extended/lib/persistent_store.lua")
	dofile_once("mods/config_lib/files/utilities.lua")
	local try = dofile_once("mods/twitch_extended/files/scripts/utils/try_catch.lua")
	

	ModLuaFileAppend("mods/config_lib/files/config_list.lua", "mods/twitch_extended/files/scripts/config/config_list.lua")


	get_content = ModTextFileGetContent
	set_content = ModTextFileSetContent	

	function trim(s)
		return (s:gsub("^%s*(.-)%s*$", "%1"))
	end

	function get_lines(str)
		local result = {}
		for line in str:gmatch '[^\n]+' do
		line = trim(line)
		table.insert(result, line)
		end
		return result
	end

	function split_csv(str)
		local result = {}
		for word in str:gmatch('([^,]+)') do
			word = trim(word)
			table.insert(result, word)
		end
		return result
	end

	function build_spell_level_lookup_table()
		dofile_once("data/scripts/gun/gun_actions.lua")
		local s = "return {\n"
		for i,v in ipairs(actions) do
		s = s .. "  _" .. v.id .. " = " .. "{"
		-- split spell levels by comma
		for spell_level in v.spawn_level:gmatch("([^,]+)") do
			s = s .. spell_level .. ","
		end
		s = s .. "},\n"
		end
		s = s .. "}"
		return s
	end

	biome_scripts = {

	}


	function get_biome_xml_files()
		local biomes_all = ModTextFileGetContent("data/biome/_biomes_all.xml")
		
		--local xml2lua = dofile("mods/twitch_extended/lib/xml2lua/xml2lua.lua")
		--local handler = dofile("mods/twitch_extended/lib/xml2lua/xmlhandler/tree.lua")



		--local parser = xml2lua.parser(handler)


		--parser:parse(biomes_all)


		local data = nxml.parse(biomes_all)

		local xml_files = {}


		for elem in data:each_child() do
			if elem.name == "Biome" then
	
				if(elem.attr ~= nil)then
					local filename = elem.attr.biome_filename

					table.insert(xml_files, filename)
				end
	
			end
		end
		return xml_files
	end


	function get_biome_scripts(biome_xml)

		--[[local xml2lua = dofile("mods/twitch_extended/lib/xml2lua/xml2lua.lua")
		local handler = dofile("mods/twitch_extended/lib/xml2lua/xmlhandler/tree.lua")


		local parser = xml2lua.parser(handler)]]

		if not ModDoesFileExist(biome_xml) then
			return
		end

		local biomes = ModTextFileGetContent(biome_xml)
		
		--[[parser:parse(biomes)

		for i, p in pairs(handler.root.Biome) do
			if i == "Topology" then
				if(p._attr ~= nil)then
					--p._attr.limit_background_image = "0"
					--p._attr.background_edge_priority = "0"

					local biome_name = p._attr.name
					local lua_script = p._attr.lua_script

					if(lua_script ~= nil and biome_name ~= nil)then
						if(biome_scripts[biome_name] == nil)then
							biome_scripts[biome_name] = {}
						end
						table.insert(biome_scripts[biome_name], lua_script)
					end
				end
			end
		end]]

		local data = nxml.parse(biomes)

		for elem in data:each_child() do
			if elem.name == "Topology" then
				if(elem.attr ~= nil)then
					local biome_name = elem.attr.name
					local lua_script = elem.attr.lua_script

					--print(biome_name)
					--print(lua_script)

					if(lua_script ~= nil and biome_name ~= nil)then
						if(biome_scripts[biome_name] == nil)then
							biome_scripts[biome_name] = {}
						end
						table.insert(biome_scripts[biome_name], lua_script)
					end
				end
			end
		end
		
	end
end

dofile("data/scripts/gun/gun_enums.lua")
dofile("data/scripts/gun/gun_actions.lua")

dofile("mods/twitch_extended/files/scripts/utils/special_utils.lua")

dofile("data/scripts/gun/gun.lua")
dofile("data/scripts/gun/gunaction_generated.lua")
dofile("data/scripts/gun/gunshoteffects_generated.lua")

oldEntityLoad = EntityLoad
EntityLoad = function() end
Reflection_RegisterProjectile = function() end
BeginProjectile = function() end
EndProjectile = function() end
RegisterProjectile = function() end
RegisterGunAction = function() end
RegisterGunShotEffects = function() end
BeginTriggerTimer = function() end
BeginTriggerHitWorld = function() end
BeginTriggerDeath = function() end
EndTrigger = function() end
SetProjectileConfigs = function() end
StartReload = function() end
ActionUsesRemainingChanged = function() end
ActionUsed = function() end
LogAction = function() end
OnActionPlayed = function() end
OnNotEnoughManaForAction = function() end
draw_actions = function() end
draw_action = function() end

function literalize(str)
    return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c) return "%" .. c end)
end


function OnMagicNumbersAndWorldSeedInitialized()

	--local xml2lua = dofile("mods/twitch_extended/lib/xml2lua/xml2lua.lua")
	--local handler = dofile("mods/twitch_extended/lib/xml2lua/xmlhandler/tree.lua")


	--local parser = xml2lua.parser(handler)
	local modifier_base = ModTextFileGetContent("mods/twitch_extended/files/entities/misc/base_modifier_effect.xml")
	for k, v in pairs(actions)do
		if(v.type == ACTION_TYPE_MODIFIER)then
			--extra_modifiers["POTENT_POTIONS_"..v.id] = v.action

			shot_effects = {}
			c = {}
			ConfigGunActionInfo_Init(c)
			ConfigGunShotEffects_Init(shot_effects)

			c_defaults = {}
			ConfigGunActionInfo_Init(c_defaults)

			dont_draw_actions = true
			reflecting = true
			
			v.action( 1, 1 )

			reflecting = false
			dont_draw_actions = false



		
			
		
			--parser:parse(modifier_base)

			--[[for i, p in pairs(handler.root.Entity) do
				if(i == "GameEffectComponent")then
					if(p._attr == nil)then
						p._attr = {}
					end
					if(p._attr ~= nil)then
						p._attr.custom_effect_id = "TWITCH_EXTENDED_"..v.id
					end
				elseif(i == "ShotEffectComponent")then
					if(p._attr == nil)then
						p._attr = {}
					end
					if(p._attr ~= nil)then
						p._attr.extra_modifier = "base_modifier_"..v.id
					end
				end
			end


			
			handler.root.Entity.VariableStorageComponent = {

			}

			handler.root.Entity._attr = {
				name = "TWITCH_EXTENDED_"..v.id
			}

			for k, v in pairs(c)do
				--if(v ~= c_defaults[k])then
					table.insert(handler.root.Entity.VariableStorageComponent, {
						_attr = {
							name = tostring(k),
							value_string = tostring(v)
						}
					})
				--end
			end
			

			local file_content = xml2lua.toXml(handler.root, "Entity", 0)]]

			local data = nxml.parse(modifier_base)

			for elem in data:each_child() do
				if elem.name == "GameEffectComponent" then
					if(elem.attr == nil)then
						elem.attr = {}
					end
					elem.attr.custom_effect_id = "TWITCH_EXTENDED_"..v.id
				elseif elem.name == "ShotEffectComponent" then
					if(elem.attr == nil)then
						elem.attr = {}
					end
					elem.attr.extra_modifier = "base_modifier_"..v.id
				end
			end

			-- use :add_child(element : nxml.element) and :new_element(name : string[, attr : table{string => any}]) to add new elements

			if(data.attr == nil)then
				data.attr = {}
			end

			data.attr.name = "TWITCH_EXTENDED_"..v.id

			for k, v in pairs(c)do
				if(v ~= c_defaults[k])then
					local new_elem = nxml.new_element("VariableStorageComponent", {
						name = tostring(k),
						value_string = tostring(v)
					})
					data:add_child(new_elem)
				end
			end


			local file_content = tostring(data)




			

			

			--print(file_content)

			ModTextFileSetContent("mods/twitch_extended/files/entities/misc/TWITCH_EXTENDED_"..v.id..".xml", file_content)

			--print(ModTextFileGetContent("mods/modifier_potions/files/entities/status_entities/POTENT_POTIONS_"..v.id..".xml"))
			
		end
		
	end
	

	if(ModIsEnabled( "config_lib" ))then

		dofile("mods/twitch_extended/files/scripts/utils/liquid_transformation_store.lua")
		--print(tostring(StreamingGetIsConnected()))
		--if(StreamingGetIsConnected() == 1)then
			xml_files = get_biome_xml_files()
			for k, v in pairs(xml_files)do
				get_biome_scripts(v)
			end

			for k, v in pairs(biome_scripts)do
				for k2, v2 in pairs(v)do
					
						script_content = ModTextFileGetContent(v2)
				
						if(script_content ~= nil and script_content ~= "" and k2 == 1)then
							lines = {}
							for s in script_content:gmatch("[^\r\n]+") do
								
								table.insert(lines, s)
							end
							
							new_script_content = ""
						
							for i, line in ipairs(lines) do
						
								if not string.match(line, "RegisterSpawnFunction") then
									--print("eeee")
									new_script_content = new_script_content..line..string.char(10)
								end
							end

							local supported_scripts = ModTextFileGetContent("mods/twitch_extended/supported_biome_scripts.lua")
							if(supported_scripts == nil or supported_scripts == "")then
								ModTextFileSetContent("mods/twitch_extended/supported_biome_scripts.lua", 'return "'..k..',"')
							else
								ModTextFileSetContent("mods/twitch_extended/supported_biome_scripts.lua", supported_scripts .. '.."'..k..',"')
							end

							ModTextFileSetContent("mods/twitch_extended/biome_scripts/"..k..".lua", new_script_content)
							--print("mods/twitch_extended/biome_scripts/"..k..".lua")
						end

				end
			end

			ModTextFileSetContent("mods/twitch_extended/virtual_files/spell_level_lookup.lua", build_spell_level_lookup_table())
		--end
	end
end
  
function OnPausePreUpdate()
	if(ModIsEnabled( "config_lib" ))then
		if(StreamingGetIsConnected() == 1 or type(StreamingGetIsConnected()) == "boolean" and StreamingGetIsConnected())then
			dofile_once("mods/twitch_extended/config/rewards.lua")
			for k, v in pairs(channel_rewards)do
				if(GlobalsGetValue("unlinking_"..v.reward_id, "false") == "true")then
					ModSettingRemove("twitch_reward_"..v.reward_id)
					RemoveSettingFlag("twitch_extended_link_rewards_"..v.reward_id)

					GamePrint('"'..GameTextGetTranslatedOrNot(v.reward_name)..'" '..GameTextGetTranslatedOrNot("$twitch_extended_config_reward_unlinked"))
					GlobalsSetValue("unlinking_"..v.reward_id, "false")
				end
			end
		end
	end
end

function HSL(h, s, l, a)
	local r, g, b
  
	if s == 0 then
	  r, g, b = l, l, l -- achromatic
	else
	  function hue2rgb(p, q, t)
		if t < 0   then t = t + 1 end
		if t > 1   then t = t - 1 end
		if t < 1/6 then return p + (q - p) * 6 * t end
		if t < 1/2 then return q end
		if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
		return p
	  end
  
	  local q
	  if l < 0.5 then q = l * (1 + s) else q = l + s - l * s end
	  local p = 2 * l - q
  
	  r = hue2rgb(p, q, h + 1/3)
	  g = hue2rgb(p, q, h)
	  b = hue2rgb(p, q, h - 1/3)
	end

	return r, g, b, a
  end
  

color = 0
was_recently_disabled = false
was_recently_enabled = false

is_in_mountain = false


dofile("mods/twitch_extended/files/scripts/utils/utilities.lua")

function OnWorldPreUpdate() 
	dofile("mods/twitch_extended/files/scripts/utils/gui_utils.lua")



	if(not ModIsEnabled( "config_lib" ))then
		gui = gui or GuiCreate()
		GuiStartFrame(gui)
	
		color = color + 0.001
		if(color > 1)then
			color = 0
		end

		-- Menu toggle button
		GuiLayoutBeginVertical(gui, 50, 60)
		GuiBeginAutoBox( gui )
		GuiZSet( gui, -8000 ) 

		GuiOptionsAddForNextWidget( gui, GUI_OPTION.Align_HorizontalCenter )
		GuiColorSetForNextWidget(gui, 1, 1, 1, 1)
		GuiText(gui, 0, 0, GameTextGetTranslatedOrNot("$twitch_extended_config_lib_required"))

		GuiZSetForNextWidget( gui, -700 )
		GuiEndAutoBoxNinePiece( gui, 5, 0, 0, false, 0, "data/ui_gfx/decorations/9piece0_gray.png", "data/ui_gfx/decorations/9piece0_gray.png" )
		GuiLayoutEnd(gui)
	end
	if(ModIsEnabled( "config_lib" ))then
		if(StreamingGetIsConnected() == 1 or type(StreamingGetIsConnected()) == "boolean" and StreamingGetIsConnected())then
			--if(not HasSettingFlag("twitch_extended_options_perks"))then
				if(is_in_mountain == false)then
					if(BiomeMapGetName() == "$biome_holymountain" and HasSettingFlag("twitch_extended_options_pause_in_mountain") or BiomeMapGetName() == "$biome_boss_arena" and HasSettingFlag("twitch_extended_options_pause_in_boss"))then
						if(GlobalsGetValue("current_vote_type", "event") == "perk")then
							GameAddFlagRun( "twitch_perk_vote_override" )
						else
							StreamingSetVotingEnabled( false )
							GameAddFlagRun("twitch_vote_paused" )
						end
						is_in_mountain = true
					else

						if( not HasSettingFlag( "twitch_extended_options_disable_voting_system" ) )then
							if((GlobalsGetValue("current_vote_type", "event") == "event" and HasSettingFlag("twitch_extended_options_events")) or (GlobalsGetValue("current_vote_type", "event") == "artifact" and HasSettingFlag("twitch_extended_options_artifacts")) or (GlobalsGetValue("current_vote_type", "event") == "perk" and HasSettingFlag("twitch_extended_options_perks")) or (GlobalsGetValue("current_vote_type", "event") == "loadout" and HasSettingFlag("twitch_extended_options_loadouts")))then
								StreamingSetVotingEnabled( true )
							else
								StreamingSetVotingEnabled( false )
							end
						else
							StreamingSetVotingEnabled( false )
						end
					end
				else	
					if(BiomeMapGetName() ~= "$biome_holymountain" and BiomeMapGetName() ~= "$biome_boss_arena" and GameHasFlagRun("twitch_vote_paused" ))then
						GameRemoveFlagRun( "twitch_perk_vote_override" )
						if( not HasSettingFlag( "twitch_extended_options_disable_voting_system" ) )then
							if((GlobalsGetValue("current_vote_type", "event") == "event" and HasSettingFlag("twitch_extended_options_events")) or (GlobalsGetValue("current_vote_type", "event") == "artifact" and HasSettingFlag("twitch_extended_options_artifacts")) or (GlobalsGetValue("current_vote_type", "event") == "perk" and HasSettingFlag("twitch_extended_options_perks")) or (GlobalsGetValue("current_vote_type", "event") == "loadout" and HasSettingFlag("twitch_extended_options_loadouts")))then
								StreamingSetVotingEnabled( true )
							else
								StreamingSetVotingEnabled( false )
							end
						else
							StreamingSetVotingEnabled( false )
						end
						GameRemoveFlagRun("twitch_vote_paused" )
						is_in_mountain = false
					end
				end
			--end

			local open = false
			if(GameHasFlagRun("config_lib_open"))then
				open = true
			end
			if(get_player())then
				player = get_player()
				controls = EntityGetFirstComponent(player, "ControlsComponent")
				if(controls ~= nil and controls ~= 0)then
					if(open and not was_recently_disabled)then
						StreamingSetVotingEnabled( false )
						was_recently_disabled = true
						was_recently_enabled = false
					elseif(not open and not was_recently_enabled)then
						if( not HasSettingFlag( "twitch_extended_options_disable_voting_system" ) )then
							if((GlobalsGetValue("current_vote_type", "event") == "event" and HasSettingFlag("twitch_extended_options_events")) or (GlobalsGetValue("current_vote_type", "event") == "artifact" and HasSettingFlag("twitch_extended_options_artifacts")) or (GlobalsGetValue("current_vote_type", "event") == "perk" and HasSettingFlag("twitch_extended_options_perks")) or (GlobalsGetValue("current_vote_type", "event") == "loadout" and HasSettingFlag("twitch_extended_options_loadouts")))then
								StreamingSetVotingEnabled( true )
							else
								StreamingSetVotingEnabled( false )
							end
						else
							StreamingSetVotingEnabled( false )
						end
						was_recently_disabled = false
						was_recently_enabled = true
					end
				end
			end

			dofile_once("mods/twitch_extended/config/rewards.lua")
			for k, v in pairs(channel_rewards)do
				if(GlobalsGetValue("unlinking_"..v.reward_id, "false") == "true")then
					ModSettingRemove("twitch_reward_"..v.reward_id)
					RemoveSettingFlag("twitch_extended_link_rewards_"..v.reward_id)

					GamePrint('"'..GameTextGetTranslatedOrNot(v.reward_name)..'" '..GameTextGetTranslatedOrNot("$twitch_extended_config_reward_unlinked"))
					GlobalsSetValue("unlinking_"..v.reward_id, "false")
				end
			end


			dofile("mods/twitch_extended/files/scripts/ui/ui_handler.lua")
			if(not GameHasFlagRun("first_vote_has_ran"))then

				--print("Setup first voting.")

				if(HasSettingFlag("twitch_extended_options_loadouts"))then
					GlobalsSetValue("current_vote_type", "loadout")
					GlobalsSetValue("twitch_lib_force_outcome_type", "random")
					StreamingForceNewVoting() 
				elseif(HasSettingFlag("twitch_extended_options_artifacts"))then
					GlobalsSetValue("current_vote_type", "artifact")
					GlobalsSetValue("twitch_lib_force_outcome_type", "random")
					StreamingForceNewVoting() 
				else
					--current_vote_type = "event"
					GlobalsSetValue("current_vote_type", "event")
					if(HasSettingFlag("twitch_extended_options_no_vote_delay"))then
						StreamingForceNewVoting() 
					end
				end

				--[[
				async(function()
					
					if(HasSettingFlag("twitch_extended_options_no_vote_delay"))then
						StreamingForceNewVoting() 
					end
					wait(20)
					if(HasSettingFlag("twitch_extended_options_no_vote_delay"))then
						StreamingForceNewVoting() 
					end
				end)
				]]
			end
			if(not GameHasFlagRun("initialized_namers"))then
				GameAddFlagRun("initialized_namers")

				player_entity = get_player()

				if(player_entity ~= nil)then
					if(ModIsEnabled("gkbrkn_noita"))then
					--	print("add run flag")
						EntityAddComponent( player_entity, "LuaComponent", 
						{ 
							script_source_file = "mods/twitch_extended/files/scripts/misc/handle_goki_naming.lua",
							execute_every_n_frame = "20",
						})
					end
					if(ModIsEnabled("blessed_beasts"))then
						EntityAddComponent( player_entity, "LuaComponent", 
						{ 
							script_source_file = "mods/twitch_extended/files/scripts/misc/handle_beast_naming.lua",
							execute_every_n_frame = "20",
						})
					end
				end
			end
	
			wake_up_waiting_threads(1) 
		end
	end

end

if(ModIsEnabled( "config_lib" ))then
	dofile_once("mods/twitch_extended/files/scripts/utils/genome_utils.lua")

	set_genome_relations("player", "player", 10000000)
end


dofile("mods/twitch_extended/lib/translations.lua")

register_localizations("mods/twitch_extended/files/translations.csv")

function OnPlayerDied()
	death_count = ModSettingGet("twitch_extended_death_counter") or 0

	ModSettingSet("twitch_extended_death_counter", death_count + 1) 
end



--[[
function OnWorldInitialized()
	if(StreamingGetIsConnected() == 1 or type(StreamingGetIsConnected()) == "boolean" and StreamingGetIsConnected())then
		if(ModIsEnabled("thematic_random_starts"))then
			print("Disabled thematic random starts.")
			GameAddFlagRun("start_loadouts_init_done")
		end
	end
end
]]

-- wabaaa
function OnPlayerSpawned( player_entity )
	if(ModIsEnabled("noita-together"))then
		GameAddFlagRun("noita_together_enabled")
	end	

	--print("Streaming enabled? "..tostring(MagicNumbersGetValue("STREAMING_ENABLED")))
	if(ModIsEnabled( "config_lib" ))then
		--[[
		if(StreamingGetIsConnected() == 1 or type(StreamingGetIsConnected()) == "boolean" and StreamingGetIsConnected())then
			--print("Ohhhh shit just disappeared ")
			StreamingSetVotingEnabled(not HasSettingFlag( "twitch_extended_options_disable_voting_system" ))
			--print("The hell?")
			if(GameHasFlagRun( "twitch_extended_new_run" ) == false)then
				GameAddFlagRun( "twitch_extended_new_run" )
				if(HasSettingFlag("twitch_extended_options_loadouts"))then
					GlobalsSetValue("current_vote_type", "loadout")
					GlobalsSetValue("twitch_lib_force_outcome_type", "random")
					StreamingForceNewVoting() 
				elseif(HasSettingFlag("twitch_extended_options_artifacts"))then
					GlobalsSetValue("current_vote_type", "artifact")
					GlobalsSetValue("twitch_lib_force_outcome_type", "random")
					StreamingForceNewVoting() 
				else
					--current_vote_type = "event"
					GlobalsSetValue("current_vote_type", "event")
				end
				if(HasSettingFlag("twitch_extended_options_no_vote_delay"))then
					StreamingForceNewVoting() 
				end
				async(function()
				
					if(HasSettingFlag("twitch_extended_options_no_vote_delay"))then
						StreamingForceNewVoting() 
					end
				end)
			end
		end
		]]
		if(ModIsEnabled("gkbrkn_noita"))then
		--	print("add run flag")
			GameAddFlagRun("gokis_things_enabled")
			print("[Twitch Extended] Found Goki's Things!")
		end
		if(ModIsEnabled("blessed_beasts"))then
			GameAddFlagRun("blessed_beasts_enabled")
			print("[Twitch Extended] Found Blessed Beasts!")
		end
	end
end
-- aaa
if(ModIsEnabled( "config_lib" ))then
	ModLuaFileAppend( "data/scripts/lib/utilities.lua", "mods/twitch_extended/files/scripts/append/append_utilities.lua" );
	ModLuaFileAppend( "data/scripts/streaming_integration/event_utilities.lua", "mods/twitch_extended/files/scripts/append/append_event_utilities.lua")
	ModLuaFileAppend( "data/scripts/streaming_integration/event_list.lua", "mods/twitch_extended/files/scripts/append/append_events.lua")
	ModLuaFileAppend( "data/scripts/items/gold_pickup.lua", "mods/twitch_extended/files/scripts/append/append_gold_pickup.lua")
	ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/twitch_extended/files/scripts/append/append_actions.lua")
	ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/twitch_extended/files/scripts/append/append_extra_modifiers.lua")
	ModLuaFileAppend( "data/scripts/perks/perk.lua", "mods/twitch_extended/files/scripts/append/append_perk.lua")
	ModMaterialsFileAdd( "mods/twitch_extended/files/scripts/append/append_materials.xml" )
	ModLuaFileAppend( "data/scripts/items/generate_shop_item.lua", "mods/twitch_extended/files/scripts/append/append_shop.lua" );
	ModLuaFileAppend( "data/scripts/status_effects/status_list.lua", "mods/twitch_extended/files/scripts/append/status_effects.lua" );
end

