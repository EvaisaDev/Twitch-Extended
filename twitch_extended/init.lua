dofile_once("data/scripts/lib/coroutines.lua")
dofile_once("data/scripts/lib/utilities.lua")
if(ModIsEnabled( "config_lib" ))then
	dofile_once("mods/twitch_extended/lib/persistent_store.lua")
	dofile_once("mods/config_lib/files/utilities.lua")
	dofile("mods/twitch_extended/files/scripts/utils/liquid_transformation_store.lua")

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
		
		local xml2lua = dofile("mods/twitch_extended/lib/xml2lua/xml2lua.lua")
		local handler = dofile("mods/twitch_extended/lib/xml2lua/xmlhandler/tree.lua")


		local parser = xml2lua.parser(handler)

		parser:parse(biomes_all)

		local xml_files = {}


		for i, p in pairs(handler.root.BiomesToLoad) do
			if i == "Biome" then
				for i2, p2 in pairs(handler.root.BiomesToLoad[i]) do
					if(p2._attr ~= nil)then
						local filename = p2._attr.biome_filename

						table.insert(xml_files, filename)

					end
				end
			end
		end
		return xml_files
	end


	function get_biome_scripts(biome_xml)

		local xml2lua = dofile("mods/twitch_extended/lib/xml2lua/xml2lua.lua")
		local handler = dofile("mods/twitch_extended/lib/xml2lua/xmlhandler/tree.lua")


		local parser = xml2lua.parser(handler)

		local biomes = ModTextFileGetContent(biome_xml)

		parser:parse(biomes)

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
		end
	end
end

function OnMagicNumbersAndWorldSeedInitialized()
	if(ModIsEnabled( "config_lib" ))then
		if(StreamingGetIsConnected())then
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
		end
	end
end
  
function OnPausePreUpdate()
	if(ModIsEnabled( "config_lib" ))then
		if(StreamingGetIsConnected())then
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
function OnWorldPreUpdate() 
	if(not ModIsEnabled( "config_lib" ))then
		gui = gui or GuiCreate()
		GuiStartFrame(gui)
	
		color = color + 0.001
		if(color > 1)then
			color = 0
		end

		-- Menu toggle button
		GuiLayoutBeginVertical(gui, 50, 0)
		GuiBeginAutoBox( gui )
		GuiZSet( gui, -800 ) 
		for i = 1, 100 do
			local r, g, b = HSL( color, .5, .5 )
			GuiOptionsAddForNextWidget( gui, GUI_OPTION.Align_HorizontalCenter )
			GuiColorSetForNextWidget(gui, r, g, b, 1)
			GuiText(gui, 0, 0, GameTextGetTranslatedOrNot("$twitch_extended_config_lib_required"))
		end
		GuiZSetForNextWidget( gui, -700 )
		GuiEndAutoBoxNinePiece( gui, 5, 0, 0, false, 0, "data/ui_gfx/decorations/9piece0_gray.png", "data/ui_gfx/decorations/9piece0_gray.png" )
		GuiLayoutEnd(gui)
	end
	if(ModIsEnabled( "config_lib" ))then
		if(StreamingGetIsConnected())then
			
			local open = false
			if(GlobalsGetValue("config_lib_open", "false") == "true")then
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
							StreamingSetVotingEnabled( true )
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

			if(GameGetFrameNum() > 30)then
				dofile("mods/twitch_extended/files/scripts/ui/ui_handler.lua")
				if(GameHasFlagRun( "twitch_extended_new_run2" ) == false)then
					GameAddFlagRun( "twitch_extended_new_run2" )
					if(HasSettingFlag("twitch_extended_options_loadouts") and ModIsEnabled("gkbrkn_noita"))then
						GlobalsSetValue("current_vote_type", "loadout")
						StreamingForceNewVoting() 
					elseif(HasSettingFlag("twitch_extended_options_artifacts"))then
						GlobalsSetValue("current_vote_type", "artifact")
						StreamingForceNewVoting() 
					else
						--current_vote_type = "event"
						GlobalsSetValue("current_vote_type", "event")
					end
					if(HasSettingFlag("twitch_extended_options_no_vote_delay"))then
						StreamingForceNewVoting() 
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

function OnPlayerSpawned( player_entity )
	if(ModIsEnabled( "config_lib" ))then
		if(StreamingGetIsConnected())then
			StreamingSetVotingEnabled(not HasSettingFlag( "twitch_extended_options_disable_voting_system" ))
			if(GameHasFlagRun( "twitch_extended_new_run" ) == false)then
				GameAddFlagRun( "twitch_extended_new_run" )
				if(HasSettingFlag("twitch_extended_options_loadouts") and ModIsEnabled("gkbrkn_noita"))then
					GlobalsSetValue("current_vote_type", "loadout")
					StreamingForceNewVoting() 
				elseif(HasSettingFlag("twitch_extended_options_artifacts"))then
					GlobalsSetValue("current_vote_type", "artifact")
					StreamingForceNewVoting() 
				else
					--current_vote_type = "event"
					GlobalsSetValue("current_vote_type", "event")
				end
				if(HasSettingFlag("twitch_extended_options_no_vote_delay"))then
					StreamingForceNewVoting() 
				end
			end

			if(ModIsEnabled("gkbrkn_noita"))then
			--	print("add run flag")
				GameAddFlagRun("gokis_things_enabled")
				EntityAddComponent( player_entity, "LuaComponent", 
				{ 
					script_source_file = "mods/twitch_extended/files/scripts/misc/handle_goki_naming.lua",
					execute_every_n_frame = "20",
				})
			end
		end
	end
end

if(ModIsEnabled( "config_lib" ))then
	ModLuaFileAppend( "data/scripts/streaming_integration/event_utilities.lua", "mods/twitch_extended/files/scripts/append/append_event_utilities.lua")
	ModLuaFileAppend( "data/scripts/streaming_integration/event_list.lua", "mods/twitch_extended/files/scripts/append/append_events.lua")
	ModLuaFileAppend( "data/scripts/items/gold_pickup.lua", "mods/twitch_extended/files/scripts/append/append_gold_pickup.lua")
	ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/twitch_extended/files/scripts/append/append_actions.lua")
	ModLuaFileAppend( "data/scripts/gun/gun_extra_modifiers.lua", "mods/twitch_extended/files/scripts/append/append_extra_modifiers.lua")
	ModLuaFileAppend( "data/scripts/perks/perk.lua", "mods/twitch_extended/files/scripts/append/append_perk.lua")
	ModMaterialsFileAdd( "mods/twitch_extended/files/scripts/append/append_materials.xml" )
	ModLuaFileAppend( "data/scripts/items/generate_shop_item.lua", "mods/twitch_extended/files/scripts/append/append_shop.lua" );
end