users = {}
original_gravity = nil

dofile_once("mods/twitch_extended/files/scripts/utils/utils.lua")
dofile_once("data/scripts/perks/perk.lua")
--[[
twitch_extended_biome_scripts = GlobalsGetValue("twitch_extended_biome_scripts", "none")
twitch_extended_biome_names = GlobalsGetValue("twitch_extended_biome_names", "none")

if(twitch_extended_biome_scripts ~= "none" and twitch_extended_biome_names ~= "none")then
	biome_scripts_table = {}
	biome_names_table = {}
	for word in string.gmatch(twitch_extended_biome_scripts, '([^,]+)') do
		table.insert(biome_scripts_table, word)
	end
	for word in string.gmatch(twitch_extended_biome_names, '([^,]+)') do
		table.insert(biome_names_table, word)
	end
	
	for k, v in pairs(biome_scripts_table)do
		collect_enemies(v, biome_names_table[k])
	end
end

]]



timed_out_names = {}
getRandomViewer = function()
	user = {

	}
	str = GlobalsGetValue("random_twitch_user", "")

	if str == "" then 
		return "" 
	end

	i = 1

	users = {
		
	}

	for i = #timed_out_names, 1, -1 do
		v = timed_out_names[i]
		if(GameGetFrameNum() > v.frame + 10)then
			table.remove(timed_out_names, i)
		end
	end
	
	for word in string.gmatch(str, '([^%:]+)') do
		allow_add = true
		for word2 in string.gmatch(word, '([^,]+)') do
			if(i == 1)then
				for k, v in pairs(timed_out_names)do
					if(v.name == word2)then
						allow_add = false
					end
				end
			end
		end
		if(allow_add)then
			table.insert(users, word)
		end
	end

	if(#users == 0)then
		return ""
	end

	user_string = users[Random(1, #users)]

	for word in string.gmatch(user_string, '([^,]+)') do
		if(i == 1)then
			user.name = word
		elseif(i == 2)then
			user.color = word
		elseif(i == 3)then
			user.broadcaster = word
		elseif(i == 4)then
			user.moderator = word
		else
			user.subscriber = word
		end

		i = i + 1
	end
	GlobalsSetValue("random_twitch_user_used", user.name or "")

	return user
end

getRandomViewerName = function()
	user = {

	}
	str = GlobalsGetValue("random_twitch_user", "")

	if str == "" then 
		return "" 
	end

	i = 1

	users = {
		
	}

	for i = #timed_out_names, 1, -1 do
		v = timed_out_names[i]
		if(GameGetFrameNum() > v.frame + 10)then
			table.remove(timed_out_names, i)
		end
	end
	
	for word in string.gmatch(str, '([^%:]+)') do
		allow_add = true
		for word2 in string.gmatch(word, '([^,]+)') do
			if(i == 1)then
				for k, v in pairs(timed_out_names)do
					if(v.name == word2)then
						allow_add = false
					end
				end
			end
		end
		if(allow_add)then
			table.insert(users, word)
		end
	end

	if(#users == 0)then
		return ""
	end

	user_string = users[Random(1, #users)]

	for word in string.gmatch(user_string, '([^,]+)') do
		if(i == 1)then
			user.name = word
		elseif(i == 2)then
			user.color = word
		elseif(i == 3)then
			user.broadcaster = word
		elseif(i == 4)then
			user.moderator = word
		else
			user.subscriber = word
		end

		i = i + 1
	end

	GlobalsSetValue("random_twitch_user_used", user.name or "")

	return user.name or ""
end

function ShootProjectile( who_shot, entity_file, x, y, vx, vy, send_message )
    local entity = EntityLoad( entity_file, x, y );
    local genome = EntityGetFirstComponent( who_shot, "GenomeDataComponent" );
    -- this is the herd id string
    --local herd_id = ComponentGetMetaCustom( genome, "herd_id" );
    local herd_id = ComponentGetValueInt( genome, "herd_id" );
    if send_message == nil then send_message = true end

	GameShootProjectile( who_shot, x, y, x+vx, y+vy, entity, send_message );

    local projectile = EntityGetFirstComponent( entity, "ProjectileComponent" );
    if projectile ~= nil then
        ComponentSetValue( projectile, "mWhoShot", who_shot );
        -- NOTE the returned herd id actually breaks the herd logic, so don't bother
        --ComponentSetValue( projectile, "mShooterHerdId", herd_id );
    end

    local velocity = EntityGetFirstComponent( entity, "VelocityComponent" );
    if velocity ~= nil then
	    ComponentSetValueVector2( velocity, "mVelocity", vx, vy )
    end

	return entity;
end

function EntityGetChildrenWithTag(entity, tag)
	local children = EntityGetAllChildren(entity)
	local children_with_tag = {}
	for i, child in pairs(children) do
		if EntityHasTag(child, tag) then
			table.insert(children_with_tag, child)
		end
	end
	return children_with_tag
end

material_cache = {}
function find_material_by_id_or_name(input, is_input)
	if(#material_cache == 0)then
		for k, v in ipairs(CellFactory_GetAllLiquids( true, false ))do
			table.insert(material_cache, v)
		end
		for k, v in ipairs(CellFactory_GetAllSands( true, false ))do
			table.insert(material_cache, v)
		end
		for k, v in ipairs(CellFactory_GetAllGases( true, false ))do
			table.insert(material_cache, v)
		end
		for k, v in ipairs(CellFactory_GetAllFires( true, false ))do
			table.insert(material_cache, v)
		end
		for k, v in ipairs(CellFactory_GetAllSolids( true, false ))do
			table.insert(material_cache, v)
		end
	end

	local matches = {}

	for i, v in ipairs(material_cache)do
		if(string.lower(v) == input)then
			if(is_input and not HasSettingFlag("twitch_extended_shift_blacklist_input_"..v) or not is_input and not HasSettingFlag("twitch_extended_shift_blacklist_output_"..v))then
				if(not is_input)then
					return { v }
				else
					table.insert(matches, v)
				end
			end
		end
		if(string.lower(GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(v)))) == input)then
			if(is_input and not HasSettingFlag("twitch_extended_shift_blacklist_input_"..v) or not is_input and not HasSettingFlag("twitch_extended_shift_blacklist_output_"..v))then
				table.insert(matches, v)
			end
		end
	end
	return matches
end

function isValidMaterial(input, is_input)
	local matches = find_material_by_id_or_name(input, is_input)
	if(#matches == 0)then
		return false
	end
	return true
end

function get_random_input_material()
	local mats = {}

	for k, v in ipairs(CellFactory_GetAllLiquids( true, false ))do	
		if(not HasSettingFlag("twitch_extended_shift_blacklist_input_"..v))then
			table.insert(mats, v)
		end
	end
	for k, v in ipairs(CellFactory_GetAllSands( true, false ))do
		if(not HasSettingFlag("twitch_extended_shift_blacklist_input_"..v))then
			table.insert(mats, v)
		end
	end
	for k, v in ipairs(CellFactory_GetAllGases( true, false ))do
		if(not HasSettingFlag("twitch_extended_shift_blacklist_input_"..v))then
			table.insert(mats, v)
		end
	end
	for k, v in ipairs(CellFactory_GetAllFires( true, false ))do
		if(not HasSettingFlag("twitch_extended_shift_blacklist_input_"..v))then
			table.insert(mats, v)
		end
	end
	for k, v in ipairs(CellFactory_GetAllSolids( true, false ))do
		if(not HasSettingFlag("twitch_extended_shift_blacklist_input_"..v))then
			table.insert(mats, v)
		end
	end

	if(#mats == 0)then
		return "water"
	end

	return mats[Random(1, #mats)]
end

function get_random_output_material()
	local mats = {}

	for k, v in ipairs(CellFactory_GetAllLiquids( true, false ))do	
		if(not HasSettingFlag("twitch_extended_shift_blacklist_output_"..v))then
			table.insert(mats, v)
		end
	end
	for k, v in ipairs(CellFactory_GetAllSands( true, false ))do
		if(not HasSettingFlag("twitch_extended_shift_blacklist_output_"..v))then
			table.insert(mats, v)
		end
	end
	for k, v in ipairs(CellFactory_GetAllGases( true, false ))do
		if(not HasSettingFlag("twitch_extended_shift_blacklist_output_"..v))then
			table.insert(mats, v)
		end
	end
	for k, v in ipairs(CellFactory_GetAllFires( true, false ))do
		if(not HasSettingFlag("twitch_extended_shift_blacklist_output_"..v))then
			table.insert(mats, v)
		end
	end
	for k, v in ipairs(CellFactory_GetAllSolids( true, false ))do
		if(not HasSettingFlag("twitch_extended_shift_blacklist_output_"..v))then
			table.insert(mats, v)
		end
	end

	if(#mats == 0)then
		return "water"
	end

	return mats[Random(1, #mats)]
end

function fungal_shift_local(reward, userdata, shift_random, shift_distance, convert_flasks, random_pool)
	function trim(s)
		local from = s:match"^%s*()"
		return from > #s and "" or s:match(".*%S", from)
	end

	local shifts = {}

	local message = userdata.message

	--print(message)

	for word in string.gmatch(message, '([^>]+)') do
		local shift = string.lower(trim(word))
		--print(shift)
		if(#shifts < 1)then
			if(isValidMaterial(shift, true))then
				table.insert(shifts, shift)
			else
				table.insert(shifts, "")
			end
		elseif(#shifts < 2)then
			if(isValidMaterial(shift, false))then
				table.insert(shifts, shift)
			else
				table.insert(shifts, "")
			end
		end
	end
	if(shift_random)then
		if(#shifts == 0 or shifts[1] == "")then
			shifts[1] = random_pool and string.lower(GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(get_random_input_material() or "water")))) or (get_random_input_material() or "water")
		end

		if(#shifts == 1 or shifts[2] == "")then
			shifts[2] = random_pool and string.lower(GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType((get_random_output_material() or "water"))))) or (get_random_output_material() or "water")
		end
	end

	if(#shifts > 1)then
		local player = get_player()
		if(player ~= nil)then
			local x,y = EntityGetTransform(player)

			local found_inputs = find_material_by_id_or_name(shifts[1], true)
			local found_outputs = find_material_by_id_or_name(shifts[2], false)

			if(shift_random)then
				if(#found_inputs == 0)then
					found_inputs = {(get_random_input_material() or "water")}
				end

				if(#found_outputs == 0)then
					found_outputs = {(get_random_output_material() or "water")}
				end
			end


			if(#found_inputs == 0)then
				return
			end

			if(#found_outputs == 0)then
				return
			end

			--local input = found_inputs[Random(1, #found_inputs)]
			local output = found_outputs[Random(1, #found_outputs)]
			
			local input_string = "[ "
			for k, v in ipairs(found_inputs)do
				if(k == #found_inputs)then
					input_string = input_string..v
				else
					input_string = input_string..v..","
				end
			end
			input_string = input_string.." ]"

			GamePrint(input_string.." > "..output)
			print("[Twitch Extended] - [Local Shift]: "..input_string.." > "..output)

			GamePrintImportant(userdata.username.." redeemed Local Shift", userdata.username.." shifted nearby "..GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(found_inputs[1]))).." into "..output..".", reward.reward_image)

			if(input ~= output)then
				shift_materials_in_range(shift_distance, found_inputs, output, convert_flasks)

				if(ModIsEnabled("noita-together"))then
					dofile_once("mods/noita-together/files/store.lua")
					dofile_once("mods/noita-together/files/scripts/json.lua")

					if(GameHasFlagRun("NT_GAMEMODE_CO_OP") and GameHasFlagRun("sync_shift")) then
						local queue = json.decode(NT.wsQueue)

						table.insert(queue, {
							event="CustomModEvent", 
							payload={
								name="twitch_extended_local_shift",
								found_inputs = found_inputs,
								output = output,
								radius = shift_distance,
								game_print = input_string.." > "..output,
								print = "[Twitch Extended] - [Local Shift]: "..input_string.." > "..output,
								convert_flasks = convert_flasks,
								userdata = userdata,
								reward = reward,
								sender = StreamingGetConnectedChannelName()
							},
							ignoreSelf=true
						})

						NT.wsQueue = json.encode(queue)
					end
				end
			end
		end
	end
end

function fungal_shift_everywhere(reward, userdata, shift_random, random_pool)
	function trim(s)
		local from = s:match"^%s*()"
		return from > #s and "" or s:match(".*%S", from)
	end

	local shifts = {}

	local message = userdata.message

	

	for word in string.gmatch(message, '([^>]+)') do
		local shift = string.lower(trim(word))
		--print(shift)
		if(#shifts < 1)then
			if(isValidMaterial(shift, true))then
				table.insert(shifts, shift)
			else
				table.insert(shifts, "")
			end
		elseif(#shifts < 2)then
			if(isValidMaterial(shift, false))then
				table.insert(shifts, shift)
			else
				table.insert(shifts, "")
			end
		end
	end
	if(shift_random)then
		if(#shifts == 0 or shifts[1] == "")then
			shifts[1] = random_pool and string.lower(GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(get_random_input_material() or "water")))) or (get_random_input_material() or "water")
		end

		if(#shifts == 1 or shifts[2] == "")then
			shifts[2] = random_pool and string.lower(GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType((get_random_output_material() or "water"))))) or (get_random_output_material() or "water")
		end

		print(shifts[1])
		print(shifts[2])
	end
	

	if(#shifts > 1)then
		local player = get_player()
		if(player ~= nil)then
			local x,y = EntityGetTransform(player)

			local found_inputs = find_material_by_id_or_name(shifts[1], true)
			local found_outputs = find_material_by_id_or_name(shifts[2], false)

			if(shift_random)then
				if(#found_inputs == 0)then
					found_inputs = {(get_random_input_material() or "water")}
				end

				if(#found_outputs == 0)then
					found_outputs = {(get_random_output_material() or "water")}
				end
			end


			if(#found_inputs == 0)then
				return
			end

			if(#found_outputs == 0)then
				return
			end

			
			--local input = found_inputs[Random(1, #found_inputs)]
			local output = found_outputs[Random(1, #found_outputs)]
			
			local input_string = "[ "
			for k, v in ipairs(found_inputs)do
				if(k == #found_inputs)then
					input_string = input_string..v
				else
					input_string = input_string..v..","
				end
			end
			
			input_string = input_string.." ]"

			GamePrint(input_string.." > "..output)
			print("[Twitch Extended] - [Fungal Shift]: "..input_string.." > "..output)
			
			GamePrintImportant(userdata.username.." redeemed Fungal Shift", userdata.username.." shifted all "..GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(found_inputs[1]))).." into "..output..".", reward.reward_image)

			if(input ~= output)then
				shift_materials(found_inputs, output)
				if(ModIsEnabled("noita-together"))then
					dofile_once("mods/noita-together/files/store.lua")
					dofile_once("mods/noita-together/files/scripts/json.lua")
		
					if(GameHasFlagRun("NT_GAMEMODE_CO_OP") and GameHasFlagRun("sync_shift")) then
						local queue = json.decode(NT.wsQueue)
						table.insert(queue, {
							event="CustomModEvent", 
							payload={
								name="twitch_extended_fungal_shift",
								found_inputs = found_inputs,
								output = output,
								game_print = input_string.." > "..output,
								print = "[Twitch Extended] - [Fungal Shift]: "..input_string.." > "..output,
								userdata = userdata,
								reward = reward,
								sender = StreamingGetConnectedChannelName()
							},
							ignoreSelf=true
						})
						NT.wsQueue = json.encode(queue)
					end
				end
			end
		end
	end
end

function shift_materials_in_range(radius, materials_input, output, convert_flasks)
	local shift_entity = EntityCreateNew("shifting_guy")
	local player = get_player()
	if(player ~= nil)then
		local x,y = EntityGetTransform(player)

		-- get nearby entities
		local entities = EntityGetInRadius(x, y, radius)

		EntitySetTransform(shift_entity, x, y)
		for k, v in ipairs(materials_input)do
			EntityAddComponent2(shift_entity, "MagicConvertMaterialComponent", {
				radius = radius,
				from_material = CellFactory_GetType(v),
				to_material = CellFactory_GetType(output),
				kill_when_finished = true,
				is_circle = true,
				steps_per_frame = 256,
			})
			EntityAddComponent2(shift_entity, "LifetimeComponent", {
				lifetime = 5,
			})

			function getMaterialCount(material, inventory)
				local count_per_material_type = ComponentGetValue2( inventory, "count_per_material_type");
				for k,v in pairs(count_per_material_type) do
					if v ~= 0 then --material exists in the inventory
						material_name = CellFactory_GetName(k-1)
						material_amount = v
						if(material_name == material)then
							return material_amount
						end
					end
				end   
				return 0  
			end

			-- loop through entities
			if(convert_flasks)then
				for i, entity in ipairs(entities) do
					local material_inventory = EntityGetFirstComponentIncludingDisabled( entity, "MaterialInventoryComponent" )

					if(material_inventory ~= nil)then

						local material_amount = getMaterialCount(v, material_inventory)

						if(material_amount > 0)then

							AddMaterialInventoryMaterial( entity, output, material_amount )
							AddMaterialInventoryMaterial( entity, v, 0 )
						end
					end


					local children = EntityGetAllChildren( entity )  or {};
					for key, child in pairs( children ) do
						if EntityGetName( child ) == "inventory_quick" then
							local children2 = EntityGetAllChildren( child )  or {};
							for key, child2 in pairs( children2 ) do
								local material_inventory2 = EntityGetFirstComponentIncludingDisabled( child2, "MaterialInventoryComponent" )

								if(material_inventory2 ~= nil)then

									local material_amount = getMaterialCount(v, material_inventory2)

									if(material_amount > 0)then

										AddMaterialInventoryMaterial( child2, output, material_amount )
										AddMaterialInventoryMaterial( child2, v, 0 )
									end
								end
							end
							break;
						end
					end
				end
			end
		end
	end
end

function shift_materials(materials_input, output)
	local player = get_player()
	if(player ~= nil)then
		local x, y = EntityGetTransform(player)
		converted_any = false

		from = {materials = {}}
		to = {material = output, twitch_extended = true}

		for i,it in ipairs(materials_input) do
			table.insert(from.materials, it)
			
			local from_material = CellFactory_GetType( it )
			local to_material = CellFactory_GetType( output )
			-- convert
			if from_material ~= to_material then
				ConvertMaterialEverywhere( from_material, to_material )
				converted_any = true

				-- shoot particles of new material
				--GameCreateParticle( CellFactory_GetName(from_material), x-10, y-10, 20, rand(-100,100), rand(-100,-30), true, true )
				--GameCreateParticle( CellFactory_GetName(from_material), x+10, y-10, 20, rand(-100,100), rand(-100,-30), true, true )
			end
		end

		if converted_any then
			-- audio
			GameTriggerMusicFadeOutAndDequeueAll( 5.0 )
			GameTriggerMusicEvent( "music/oneshot/tripping_balls_01", false, x, y )

			-- particle fx
			local eye = EntityLoad( "data/entities/particles/treble_eye.xml", x,y-10 )
			if eye ~= 0 then
				EntityAddChild( player, eye )
			end

			-- add ui icon
			local add_icon = true
			local children = EntityGetAllChildren(player)
			if children ~= nil then
				for i,it in ipairs(children) do
					if ( EntityGetName(it) == "fungal_shift_ui_icon" ) then
						add_icon = false
						break
					end
				end
			end

			if add_icon then
				local icon_entity = EntityCreateNew( "fungal_shift_ui_icon" )
				EntityAddComponent( icon_entity, "UIIconComponent", 
				{ 
					name = "$status_reality_mutation",
					description = "$statusdesc_reality_mutation",
					icon_sprite_file = "data/ui_gfx/status_indicators/fungal_shift.png"
				})
				EntityAddChild( player, icon_entity )
			end
		end
	end
end

function WandGetActiveOrRandom( entity )
    local chosen_wand = nil;
    local wands = {};
    local children = EntityGetAllChildren( entity )  or {};
    for key, child in pairs( children ) do
        if EntityGetName( child ) == "inventory_quick" then
            wands = EntityGetChildrenWithTag( child, "wand" );
            break;
        end
    end
    if #wands > 0 then
        local inventory2 = EntityGetFirstComponent( entity, "Inventory2Component" );
        local active_item = tonumber( ComponentGetValue( inventory2, "mActiveItem" ) );
        for _,wand in pairs( wands ) do
            if wand == active_item then
                chosen_wand = wand;
                break;
            end
        end
        if chosen_wand == nil then
            chosen_wand =  random_from_array( wands );
        end
        return chosen_wand;
    end
end

function get_player()
    return EntityGetWithTag( "player_unit" )[1]
end

function get_player_pos()
    return EntityGetTransform(get_player())
end

function get_closest_entity(px, py, tag)
    if not py then
        tag = px
        px, py = get_player_pos()
    end
    return EntityGetClosestWithTag( px, py, tag)
end

function get_entity_mouse(tag)
    local mx, my = DEBUG_GetMouseWorld()
    return get_closest_entity(mx, my, tag or "hittable")
end

function teleport(x, y)
    EntitySetTransform(get_player(), x, y)
end

function spawn_entity(ename, offset_x, offset_y)
    local x, y = get_player_pos()
    x = x + (offset_x or 0)
    y = y + (offset_y or 0)
    return EntityLoad(ename, x, y)
end

function add_user(username)
	print(tostring(username).." has been added to viewer list!")
	table.insert(users, username)
end

function urand(mag)
    return math.floor((Random()*2.0 - 1.0)*mag)
end


function table.clone(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function table.find(tab,el)
    for index, value in pairs(tab) do
        if value == el then
            return index
        end
    end
    return nil
end

function table.has(tab,el)
    for index, value in pairs(tab) do
        if value == el then
            return true
        end
    end
    return false
end
function EntitySetVariable(entity, name, variable)
    local variable_components = EntityGetComponent( entity, "VariableStorageComponent" )
	local found_var = false
    if ( variable_components ~= nil ) then
        for key,comp_id in pairs(variable_components) do 
            local var_name = ComponentGetValue2( comp_id, "name" )
            if( var_name == name) then
				found_var = true
                if(type(variable) == "boolean")then
					ComponentSetValue2( comp_id, "value_bool", variable )
				elseif(type(variable) == "string")then
					ComponentSetValue2( comp_id, "value_string", variable )
				elseif(type(variable) == "number")then
					ComponentSetValue2( comp_id, "value_float", variable )
				else
					EntityRemoveComponent(entity, comp_id )
				end
            end
        end
    end
	
	if(found_var == false)then
		--print(type(variable))
		if(type(variable) == "boolean")then
			--print("stored variable")
			EntityAddComponent2(entity, "VariableStorageComponent", {
				name = name,
				value_bool = variable
			})
		elseif(type(variable) == "string")then
			EntityAddComponent2(entity, "VariableStorageComponent", {
				name = name,
				value_string = variable
			})
		elseif(type(variable) == "number")then
			EntityAddComponent2(entity, "VariableStorageComponent", {
				name = name,
				value_float = variable
			})
		end
	end
end

function EntityGetVariable(entity, name, variable)
    local variable_components = EntityGetComponent( entity, "VariableStorageComponent" )
	local value = nil
    if ( variable_components ~= nil ) then
        for key,comp_id in pairs(variable_components) do 
            local var_name = ComponentGetValue2( comp_id, "name" )
            if( var_name == name) then
				found_var = true
                if(variable == "boolean")then
					if(ComponentGetValue2( comp_id, "value_bool" ))then
						value = ComponentGetValue2( comp_id, "value_bool" )
						if(value == "true")then
							value = true
						elseif(value == "false")then
							value = false
						end
					end
				elseif(variable == "string")then
					if(ComponentGetValue2( comp_id, "value_string" ))then
						value = ComponentGetValue2( comp_id, "value_string" )
						value = tostring(value)
					end
				elseif(variable == "number")then
					if(ComponentGetValue2( comp_id, "value_float" ))then
						value = ComponentGetValue2( comp_id, "value_float" )
						value = tonumber(value)
					end
				end
            end
        end
    end
	return value
end
function table.remove_value(tab,el)
    for index, value in pairs(tab) do
        if value == el then
            table.remove(tab, index)
            return tab
        end
    end
    return tab
end

function table.length(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function table.merge(T)
    local new_table = {}
    for k, v in pairs(T)do
        if(v ~= nil)then
            for k2, v2 in pairs(v)do
                table.insert(new_table, v2)
            end
        end
    end
    return new_table
end

function math.round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function EntityApplyComponent(entity, component_name, values)
	local component = EntityGetFirstComponentIncludingDisabled(entity, component_name)
	if(component ~= nil)then
		for k,v in pairs(values)do
			ComponentSetValue2(component, k, v)
		end
	else
		EntityAddComponent2(entity, component_name, values)
	end
end

function text_above_entity( entity_id, text, extra_offset )
    extra_offset = extra_offset or 0
    offset_x = string.len(text)*1.9
    if(entity_id ~= nil)then
		if text ~= "" then
			ent_x, ent_y = EntityGetTransform(entity_id)
			text_holder = EntityLoad("mods/twitch_extended/files/entities/misc/text_holder.xml", ent_x, ent_y)

			EntityAddComponent(text_holder, "StreamingKeepAliveComponent")


			EntitySetTransform(text_holder, ent_x, ent_y)
            local component = EntityAddComponent2(text_holder, "SpriteComponent",
            {
                image_file="data/fonts/font_pixel_white.xml",
                is_text_sprite=true,
				offset_x=offset_x,
				offset_y= 30 + extra_offset,
                text = text, 
                update_transform=true,
                update_transform_rotation=false,
                has_special_scale=true,
                special_scale_x=0.65,
                special_scale_y=0.65,
                alpha=0.5,
			})

			EntityAddComponent(text_holder, "InheritTransformComponent")
			
			EntityAddComponent2(text_holder, "VariableStorageComponent", {
				name = "offset_base",
				value_int = 30
			})

			EntityAddComponent2(text_holder, "VariableStorageComponent", {
				name = "offset_extra",
				value_int = extra_offset
			})

			EntityAddComponent2(text_holder, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/scripts/misc/update_text_offset.lua",
				execute_every_n_frame=20
			})

			EntityAddChild(entity_id, text_holder)

            return text_holder, component
        end
    end
end

function update_text( entity_id, component, text )
    offset_x = string.len(text)*1.9
	
	if(component ~= nil and component ~= 0)then
        ComponentSetValue2( component, "text", text )
        ComponentSetValue2( component, "offset_x", offset_x )
        EntityRefreshSprite( entity_id, component )
    end
end

 -- spawns one perk
function perk_spawn2( x, y, perk_id )
	local perk_data = get_perk_with_id( perk_list, perk_id )
	if ( perk_data == nil ) then
		print_error( "spawn_perk( perk_id ) called with'" .. perk_id .. "' - no perk with such id exists." )
		return
	end

	print( "spawn_perk " .. tostring( perk_id ) .. " " .. tostring( x ) .. " " .. tostring( y ) )

	---
	local entity_id = EntityLoad( "data/entities/items/pickup/perk.xml", x, y )
	if ( entity_id == nil ) then
		return
    end
    
    EntityRemoveTag(entity_id, "perk")
    EntityAddTag(entity_id, "perk2")

    luacomp = EntityGetFirstComponent(entity_id, "LuaComponent" )

    ComponentSetValue(luacomp, "script_item_picked_up", "mods/twitch_extended/files/scripts/perks/perk_pickup.lua")

	-- init perk item
	EntityAddComponent( entity_id, "SpriteComponent", 
	{ 
		image_file = perk_data.perk_icon or "data/items_gfx/perk.xml",  
		offset_x = "8", 
		offset_y = "8", 
		update_transform = "1" ,
		update_transform_rotation = "0",
	} )

	EntityAddComponent( entity_id, "UIInfoComponent", 
	{ 
		name = perk_data.ui_name,
	} )

	EntityAddComponent( entity_id, "ItemComponent", 
	{ 
		item_name = perk_data.ui_name,
		ui_description = perk_data.ui_description,
		play_spinning_animation = "0",
		play_hover_animation = "0",
		play_pick_sound = "0",
	} )

	EntityAddComponent( entity_id, "SpriteOffsetAnimatorComponent", 
	{ 
      sprite_id="-1" ,
      x_amount="0" ,
      x_phase="0" ,
      x_phase_offset="0" ,
      x_speed="0" ,
      y_amount="2" ,
      y_speed="3",
	} )

	EntityAddComponent( entity_id, "VariableStorageComponent", 
	{ 
		name = "perk_id",
		value_string = perk_data.id,
	} )

	return entity_id
end


function spawn_wand(username,message)
	local player = get_player()
	if(player ~= nil)then
		local x,y = EntityGetTransform(player)

		rnd = Random(0,100)
		
		if( rnd <= 25 ) then
			EntityLoad( "data/entities/items/wand_level_04.xml", x + Random(-10,10), y - 4 + Random(-10,10) )
		elseif( rnd <= 50 ) then
			EntityLoad( "data/entities/items/wand_unshuffle_04.xml", x + Random(-10,10), y - 4 + Random(-10,10) )
		elseif( rnd <= 75 ) then
			EntityLoad( "data/entities/items/wand_level_05.xml", x + Random(-10,10), y - 4 + Random(-10,10) )
		elseif( rnd <= 90 ) then
			EntityLoad( "data/entities/items/wand_unshuffle_05.xml", x + Random(-10,10), y - 4 + Random(-10,10) )
		elseif( rnd <= 97 ) then
			EntityLoad( "data/entities/items/wand_level_06.xml", x + Random(-10,10), y - 4 + Random(-10,10) )
		elseif( rnd <= 100 ) then
			EntityLoad( "data/entities/items/wand_unshuffle_06.xml", x + Random(-10,10), y - 4 + Random(-10,10) )
		end
	end
end

function give_extra_modifier(entity, modifier, frames)
	local x, y = EntityGetTransform( entity )
				
	local effect_id = EntityCreateNew()
	EntityAddChild( entity, effect_id )

	EntityAddComponent(effect_id, "InheritTransformComponent")
	EntityAddComponent2(effect_id, "ShotEffectComponent", {
		extra_modifier = modifier
	})
	EntityAddComponent2(effect_id, "LifetimeComponent", {
		lifetime = frames
	})
	
	return effect_id
end

function give_perk()
    local perk = perk_list[Random(1, #perk_list)]

    local x, y = get_player_pos()

    -- player might be dead
    if x ~= nil and y ~= nil then
		local perk_entity = perk_spawn2(x, y - 8, perk.id)
		if(drop_perk_on_ground == false)then
			local players = get_players()
			if players == nil then return end
			for i, player in ipairs(players) do
				-- last argument set to false, so you dont kill others perks if triggered inside the shop
				perk_pickup(perk_entity, player, nil, true, false)
			end
		end
    end
end

function add_status_effect( game_effect_entity, icon_file, name, description, above_head )
	if game_effect_entity ~= nil then
		display_hud = true
		if(above_head)then
			display_hud = false
		end
		EntityAddComponent2( game_effect_entity, "UIIconComponent",
		{
			name = name,
			description = description,
			icon_sprite_file = icon_file,
			display_above_head = above_head,
			display_in_hud = display_hud,
			is_perk = false,
		})
	end
end

function generate_emerald_tablet(name, description)
	local tablet = spawn_item("data/entities/items/books/base_book.xml", 10, 50)

	UIInfoComponent = EntityGetFirstComponent(tablet, "UIInfoComponent")
	ItemComponent = EntityGetFirstComponent(tablet, "ItemComponent")
	AbilityComponent = EntityGetFirstComponent(tablet, "AbilityComponent")

	ComponentSetValue2(UIInfoComponent, "name", name)
	ComponentSetValue2(ItemComponent, "item_name", name)
	ComponentSetValue2(ItemComponent, "ui_description", description)
	ComponentSetValue2(AbilityComponent, "ui_name", name)
end

function spawn_enemy(username)
	local player = get_player()
	if(player ~= nil)then
		enemy = enemies_list[Random(1,table.getn(enemies_list))];
	--	print("Summoned "..enemy)
		local drone = spawn_item(enemy, 10, 50)

		
		text_above_entity(drone, username, 0)

		EntityAddTag( drone, "has_nametag")
	end
end

function spawn_homunculus(username, type_override)
	types = {
		"normal",
		"slow",
		"healer",
		"fireball",
		"laser",
		"punch"
	}
	local enemy_list = {
		"mods/twitch_extended/files/entities/animals/homunculus/homunculus.xml",
	}
	local player = get_player()
	if(player ~= nil)then
		enemy = enemy_list[Random(1,table.getn(enemy_list))];
	--	print("Summoned "..enemy)
		local drone = spawn_item(enemy, 10, 50)

		local nametag = EntityCreateNew("nametag")

		EntityAddComponent(nametag, "InheritTransformComponent")
		
		local x, y = EntityGetTransform(drone)
		EntitySetTransform(nametag, x, y)

		local herd_id
						
		edit_component( player, "GenomeDataComponent", function(comp,vars)
			herd_id = ComponentGetValue2( comp, "herd_id" )
		end)
		
		if ( herd_id ~= nil ) then
			edit_component( drone, "GenomeDataComponent", function(comp,vars)
				ComponentSetValue2( comp, "herd_id", herd_id )
			end)
		end

		our_type = types[Random(1, #types)]

		if(type_override ~= nil)then
			our_type = type_override
		end

		if(our_type ~= "normal")then
			local storages = EntityGetComponent( drone, "VariableStorageComponent" )
			if ( storages ~= nil ) then
				for j,comp in ipairs( storages ) do
					local name = ComponentGetValue2( comp, "name" )
					if ( name == "type" ) then
						ComponentSetValue2( comp, "value_string", our_type )
						break
					end
				end
			else
				type_store = EntityAddComponent2( drone, "VariableStorageComponent", {
					name = "type",
					value_string = our_type
				})
			end
		end

		text_above_entity( drone, username, 0 )

		EntityAddTag( drone, "has_nametag")
	end
end

function check_newgame_plus_level( level )
	local newgame_n = tonumber( SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") ) or 0
	
	return ( newgame_n >= level )
end

function spawn_spell()
	local player = get_player()
	if(player ~= nil)then
		local x,y = EntityGetTransform(player)

		local action = GetRandomAction( x, y, 10, 1)
		
		CreateItemActionEntity( action, x, y )
	end
end

function set_gravity(v)
    local cpc = EntityGetFirstComponent(get_player(), "CharacterPlatformingComponent")
    if not true_original_gravity then
      true_original_gravity = ComponentGetValue(cpc, "pixel_gravity")
    end
    ComponentSetValue(cpc, "pixel_gravity", v)
end

function create_hole_of_size(x, y, r)
	hole_maker = EntityCreateNew( "hole" )
	EntitySetTransform(hole_maker, x, y)
	EntityAddComponent(hole_maker, "CellEaterComponent", {
		radius=tostring(r)
	})
	EntityAddComponent(hole_maker, "LifetimeComponent", {
		lifetime="1"
	})
end

function attach_bomb(entity, radius, damage, lifetime)
	local x, y = EntityGetTransform(entity)
	local bomb = EntityLoad("mods/twitch_extended/files/entities/misc/bomb_child.xml", x, y)
	local bomb_projectile = EntityGetFirstComponent(bomb, "ProjectileComponent")
	if(bomb_projectile ~= nil)then
		ComponentSetValue2(bomb_projectile, "lifetime", lifetime)
		ComponentObjectSetValue2(bomb_projectile, "config_explosion", "damage", damage)
		ComponentObjectSetValue2(bomb_projectile, "config_explosion", "explosion_radius", radius)
	end
	EntityAddChild( entity, bomb )
end

function spawn_giant_duck(username)
	local player = get_player()
	if(player ~= nil)then
		local duck = spawn_item("mods/twitch_extended/files/entities/animals/ducks/duck_boss/duckboss_entity.xml", 150, 150, true, true)
		local x, y = EntityGetTransform(duck)
		--EntityLoad("mods/twitch_extended/files/entities/duck_hole.xml", x, y)
		create_hole_of_size(x, y, 60)
		text_above_entity(duck, username, 30)

		if(duck_boss_elite == "false" and duck_boss_force_elite == "false")then
			EntityAddTag( duck, "gkbrkn_no_champion")
		end
		if(duck_boss_force_elite == "true")then
			EntityAddTag( duck, "gkbrkn_force_champion")
		end
		EntityAddTag( duck, "has_nametag")

	end
end

function get_children_with_tag(e, tag)
	entity_children = EntityGetAllChildren( e )
	tagged_children = {}
	for k, v in pairs(entity_children)do
		if(EntityHasTag(v, tag))then
			table.insert(tagged_children, v)
		end
	end
	return tagged_children
end

function equals(o1, o2, ignore_mt)
    if o1 == o2 then return true end
    local o1Type = type(o1)
    local o2Type = type(o2)
    if o1Type ~= o2Type then return false end
    if o1Type ~= 'table' then return false end

    if not ignore_mt then
        local mt1 = getmetatable(o1)
        if mt1 and mt1.__eq then
            --compare using built in method
            return o1 == o2
        end
    end

    local keySet = {}

    for key1, value1 in pairs(o1) do
        local value2 = o2[key1]
        if value2 == nil or equals(value1, value2, ignore_mt) == false then
            return false
        end
        keySet[key1] = true
    end

    for key2, _ in pairs(o2) do
        if not keySet[key2] then return false end
    end
    return true
end

function spawn_enemy_biome(username)
	local player = get_player()
	if(player ~= nil)then
		local x, y = get_player_pos()
		local current_biome = BiomeMapGetName(x, y)

		local drone = nil

		local enemies = {
			"data/entities/animals/zombie.xml",
			"data/entities/animals/zombie_weak.xml",
			"data/entities/animals/ant.xml",
			"data/entities/animals/rat.xml",
			"data/entities/animals/slimeshooter_weak.xml",
		}


		local biome_enemies = {

		}

		__loaded["mods/twitch_extended/biome_scripts/"..current_biome..".lua"] = nil
	
		supported_scripts = dofile("mods/twitch_extended/supported_biome_scripts.lua")
	
		if(supported_scripts:match(current_biome))then
			dofile("mods/twitch_extended/biome_scripts/"..current_biome..".lua")

			if(biome_enemies[current_biome] == nil)then
				biome_enemies[current_biome] = {total_prob = 0}
			end

				
			if(g_small_enemies ~= nil)then
				for k, v in pairs(g_small_enemies)do
					if(k ~= "total_prob" and v.entity ~= "" and v.entity ~= nil and v.entity ~= "data/entities/buildings/arrowtrap_left.xml" and not string.match(v.entity, "lukki"))then
						local already_has = false
						if(biome_enemies[current_biome] ~= nil)then
							for k2, v2 in pairs(biome_enemies[current_biome])do
								if(type(v2) == "table")then
									if(v2.entity ~= nil and v.entity ~= nil)then
										--GamePrint(v2.entity)
										if(v.entity == v2.entity)then
											already_has = true
										end
									elseif(v2.entities ~= nil and v.entities ~= nil)then
										if(equals(v2.entities, v.entities, false))then
											already_has = true
										end
									end
								end
							end
						end

						if(already_has == false and ( v.ngpluslevel == nil or check_newgame_plus_level( v.ngpluslevel ) ))then
							table.insert(biome_enemies[current_biome], v)
						end
					end
				end
			end
			if(g_big_enemies ~= nil)then
				for k, v in pairs(g_big_enemies)do
					if(k ~= "total_prob" and v.entity ~= "" and v.entity ~= nil and v.entity ~= "data/entities/buildings/arrowtrap_left.xml" and not string.match(v.entity, "lukki"))then
						local already_has = false
						if(biome_enemies[current_biome] ~= nil)then
							for k2, v2 in pairs(biome_enemies[current_biome])do
								if(type(v2) == "table")then
									if(v2.entity ~= nil and v.entity ~= nil)then
										--GamePrint(v2.entity)
										if(v.entity == v2.entity)then
											already_has = true
										end
									elseif(v2.entities ~= nil and v.entities ~= nil)then
										if(equals(v2.entities, v.entities, false))then
											already_has = true
										end
									end
								end
							end
						end

						if(already_has == false and ( v.ngpluslevel == nil or check_newgame_plus_level( v.ngpluslevel ) ))then
							table.insert(biome_enemies[current_biome], v)
						end
					end
				end
			end
		end

		if(biome_enemies[current_biome] ~= nil and current_biome ~= "$biome_holymountain")then
			if(current_biome ~= "_EMPTY_")then
			--	print(table.dump(biome_enemies))
				if(biome_enemies[current_biome] ~= nil)then
					local enemies = biome_enemies[current_biome]

					if(enemies[1] ~= nil)then
						local enemy = enemies[Random(1,#enemies)]
						local our_x, our_y = get_spawn_pos(50, 80, x, y)
						--spawn_with_limited_random(enemies,our_x,our_y,0,0,{}, username)
						--print(table.dump(enemy))

							--entity_load_camera_bound(enemy, our_x, our_y, 0, 0, username)

						for i = 1, Random(enemy.min_count or 1, enemy.max_count or 1)do
							if(enemy.entities ~= nil and enemy.entities[1] ~= nil)then
								to_spawn = enemy.entities[Random(1, #enemy.entities)]

								if(to_spawn ~= nil)then

									drone = spawn_item(to_spawn, 50, 80)

									text_above_entity(drone, username, 0)
						
									EntityAddTag( drone, "has_nametag")

								else
									enemy = enemies[Random(1, #enemies)]
									count = Random(1, 4)
									for i = 1, count do
										drone = spawn_item(enemy, 50, 80)
			
										text_above_entity(drone, username, 0)
							
										EntityAddTag( drone, "has_nametag")
									end
								end
							else
								to_spawn = enemy.entity

								if(to_spawn ~= nil)then

									drone = spawn_item(to_spawn, 50, 80)

									text_above_entity(drone, username, 0)
						
									EntityAddTag( drone, "has_nametag")

								else
									enemy = enemies[Random(1, #enemies)]
									count = Random(1, 4)
									for i = 1, count do
										drone = spawn_item(enemy, 50, 80)
			
										text_above_entity(drone, username, 0)
							
										EntityAddTag( drone, "has_nametag")
									end
								end
							end
						end
					else
						enemy = enemies[Random(1, #enemies)]
						count = Random(1, 4)
						for i = 1, count do
							drone = spawn_item(enemy, 50, 80)

							text_above_entity(drone, username, 0)
				
							EntityAddTag( drone, "has_nametag")
						end
					end
				else
					enemy = enemies[Random(1, #enemies)]
					count = Random(1, 4)
					for i = 1, count do
						drone = spawn_item(enemy, 50, 80)

						text_above_entity(drone, username, 0)
			
						EntityAddTag( drone, "has_nametag")
					end
				end
			else
				enemy = enemies[Random(1, #enemies)]
				count = Random(1, 4)
				for i = 1, count do
					drone = spawn_item(enemy, 50, 80)

					text_above_entity(drone, username, 0)
		
					EntityAddTag( drone, "has_nametag")
				end
			end
		else
			if(current_biome == "$biome_holymountain")then
				enemies = {
					"data/entities/animals/fish.xml"
				}
			end


			enemy = enemies[Random(1, #enemies)]

			count = Random(1, 4)
			if(current_biome == "$biome_holymountain")then
				if(Random(0,100) <= 5)then
					enemy = "data/entities/animals/necromancer_shop.xml"
				end
				count = 1
			end
			for i = 1, count do
				drone = spawn_item(enemy, 50, 80)

				text_above_entity(drone, username, 0)
	
				EntityAddTag( drone, "has_nametag")
			end
		end
	end
end

function spawn_biome_wand()
	local biome_name = BiomeMapGetName()
	__loaded["mods/twitch_extended/biome_scripts/"..biome_name..".lua"] = nil
	
	supported_scripts = dofile("mods/twitch_extended/supported_biome_scripts.lua")

	allowed_items = {}

	if(supported_scripts:match(biome_name))then
		dofile("mods/twitch_extended/biome_scripts/"..biome_name..".lua")
	
		if g_items ~= nil then
			if(g_items[1] ~= nil)then
				for k, v in pairs(g_items)do
					if(type(v) == "table")then
						if(v.entity ~= nil and v.entity ~= "")then
							table.insert(allowed_items, v.entity)
						end
					end
				end
			end
		end
	end

	item = nil
	local x, y = get_player_pos()
	if(allowed_items[1] == nil)then
		

		SetRandomSeed( x, y )

		local biomes =
		{
			[1] = 0,
			[2] = 0,
			[3] = 0,
			[4] = 1,
			[5] = 1,
			[6] = 1,
			[7] = 2,
			[8] = 2,
			[9] = 2,
			[10] = 2,
			[11] = 2,
			[12] = 2,
			[13] = 3,
			[14] = 3,
			[15] = 3,
			[16] = 3,
			[17] = 4,
			[18] = 4,
			[19] = 4,
			[20] = 4,
			[21] = 5,
			[22] = 5,
			[23] = 5,
			[24] = 5,
			[25] = 6,
			[26] = 6,
			[27] = 6,
			[28] = 6,
			[29] = 6,
			[30] = 6,
			[31] = 6,
			[32] = 6,
			[33] = 6,
		}


		local biomepixel = math.floor(y / 512)
		local biomeid = biomes[biomepixel] or 0

		if( biomeid < 1 ) then biomeid = 1 end
		if( biomeid > 6 ) then biomeid = 6 end

		
		item = "data/entities/items/"

		local r = Random(0,100)
		if( r <= 50 ) then 
			item = item .. "wand_level_0"
		else
			item = item .. "wand_unshuffle_0"
		end

		item = item .. tostring(biomeid) .. ".xml"

	else
		item = allowed_items[Random(1, #allowed_items)]
	end

	local eid = EntityLoad( item, x, y )

	return eid
end

function sleep(seconds)
    local start = GameGetRealWorldTimeSinceStarted()
    repeat until GameGetRealWorldTimeSinceStarted() > start + seconds
end


function spawn_drone_companion(username)
	local player = get_player()
	if(player ~= nil)then
		drones = {
			"mods/twitch_extended/files/entities/animals/drones/entities/attack_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/attack_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/attack_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/attack_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/attack_drone.xml",
			"mods/twitch_extended/files/entities/animals/drones/entities/basic_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/basic_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/basic_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/basic_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/basic_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/basic_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/basic_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/basic_drone.xml",
			"mods/twitch_extended/files/entities/animals/drones/entities/missile_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/missile_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/missile_drone.xml",
			"mods/twitch_extended/files/entities/animals/drones/entities/flame_drone.xml",
			"mods/twitch_extended/files/entities/animals/drones/entities/health_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/health_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/health_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/health_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/health_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/health_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/health_drone.xml",
			"mods/twitch_extended/files/entities/animals/drones/entities/laser_drone.xml","mods/twitch_extended/files/entities/animals/drones/entities/laser_drone.xml",
			"mods/twitch_extended/files/entities/animals/drones/entities/health_drone2.xml" 
		}       
		  
		local drone = spawn_item(drones[Random(1,table.getn(drones))], 0, 5)
		text_above_entity(drone, username, 0)

		EntityAddTag( drone, "dont_bless" )
		EntityAddTag( drone, "has_nametag")
		EntityRemoveTag( drone, "enemy" )

		local damagemodels = EntityGetComponent( drone, "DamageModelComponent" )
		if( damagemodels ~= nil ) then
			for i,damagemodel in ipairs(damagemodels) do
				local max_hp = drone_health / 25
				
				--ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
				ComponentSetValue( damagemodel, "max_hp", max_hp )
				ComponentSetValue( damagemodel, "max_hp_cap", max_hp )
				ComponentSetValue( damagemodel, "hp", max_hp )
			end
		end	
	end
end

function spawn_chest()
	local player = get_player()
	if(player ~= nil)then
		local x,y = EntityGetTransform(player)
		local chance = Random(1,100)
		if(chance < 5)then
			spawn_item("data/entities/animals/chest_leggy.xml",30, 50)
		elseif(chance < 30)then
			spawn_item("data/entities/animals/chest_mimic.xml",30, 50)
		elseif(chance < 70)then
			spawn_item("data/entities/items/pickup/chest_random.xml", 30, 50)
		else
			spawn_item("data/entities/items/pickup/chest_random_super.xml", 30, 50)
		end
	end
end

function spawn_companion(username)
	local player = get_player()
	if(player ~= nil)then
		local duck = spawn_item("mods/twitch_extended/files/entities/animals/ducks/duck_companions/duck_companion.xml", 0, 10)
		text_above_entity(duck, username, 0)
		EntityAddTag( duck, "has_nametag")
		EntityAddTag( duck, "dont_bless" )
		EntityRemoveTag( duck, "enemy" )
		
		local damagemodels = EntityGetComponent( duck, "DamageModelComponent" )
		if( damagemodels ~= nil ) then
			for i,damagemodel in ipairs(damagemodels) do
				local max_hp = duck_health / 25
				
				--ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
				ComponentSetValue( damagemodel, "max_hp", max_hp )
				ComponentSetValue( damagemodel, "max_hp_cap", max_hp )
				ComponentSetValue( damagemodel, "hp", max_hp )
			end
		end		
	end
end


function TryAdjustDamageMultipliers( entity, resistances )
    local damage_models = EntityGetComponent( entity, "DamageModelComponent" );
    if damage_models ~= nil then
        for index,damage_model in pairs( damage_models ) do
            for damage_type,multiplier in pairs( resistances ) do
                local resistance = tonumber(ComponentObjectGetValue( damage_model, "damage_multipliers", damage_type ));
                resistance = resistance * multiplier;
                ComponentObjectSetValue( damage_model, "damage_multipliers", damage_type, tostring(resistance) );
            end
        end
    end
end

function spawn_companion_gold(username)
	local player = get_player()
	if(player ~= nil)then
		local duck = spawn_item("mods/twitch_extended/files/entities/animals/ducks/duck_companions/golden_duck.xml", 0, 10)
		text_above_entity(duck, username, 0)	
		EntityAddTag( duck, "has_nametag")
		EntityAddTag( duck, "dont_bless" )
		EntityRemoveTag( duck, "enemy" )
		
		local damagemodels = EntityGetComponent( duck, "DamageModelComponent" )
		if( damagemodels ~= nil ) then
			for i,damagemodel in ipairs(damagemodels) do
				local max_hp = duck_health / 25
				
				--ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
				ComponentSetValue( damagemodel, "max_hp", max_hp )
				ComponentSetValue( damagemodel, "max_hp_cap", max_hp )
				ComponentSetValue( damagemodel, "hp", max_hp )
			end
		end		
	end
end

function spawn_bomb()
	local player = get_player()
	if(player ~= nil)then
		local x,y = EntityGetTransform(player)

		EntityLoad("mods/twitch_extended/files/entities/projectiles/bomb.xml",x,y)
	end
end

function get_wands()
	local wands = {}
	if(get_player() ~= 0)then
		local childs = EntityGetAllChildren(get_player())
		
		if childs ~= nil then
			for _, child in ipairs(childs) do
				if EntityGetName(child) == "inventory_quick" then
					wands = EntityGetChildrenWithTag( child, "wand" );
				end
			end
		end
	end

    return wands or nil
end

function get_wand_spells(id)
    local childs = EntityGetAllChildren(id)
    local inven = {}
    if childs ~= nil then
        for _, child in ipairs(childs) do
            if EntityHasTag(child, "card_action") then
                inven[_] = child
            end
        end
    end
    return inven or nil
end
-- 0 to not limit axis, -1 to limit to negative values, 1 to limit to positive values
local function generate_value_in_range(max_range, min_range, limit_axis)
  local range = (max_range or 0) - (min_range or 0)
  if (limit_axis or 0) == 0 then
    limit_axis = Random(0, 1) == 0 and 1 or -1
  end

  return (Random(0, range) + (min_range or 0)) * limit_axis
end

function twiddle_health(f)
    local damagemodels = EntityGetComponent(get_player(), "DamageModelComponent")
    if (damagemodels ~= nil) then
        for i, damagemodel in ipairs(damagemodels) do
            local max_hp = tonumber(ComponentGetValue(damagemodel, "max_hp"))
            local cur_hp = tonumber(ComponentGetValue(damagemodel, "hp"))
            local new_cur, new_max = f(cur_hp, max_hp)
            ComponentSetValue(damagemodel, "max_hp", new_max)
            ComponentSetValue(damagemodel, "hp", new_cur)
        end
    end
end

function get_inventory()
	local player_child_entities = EntityGetAllChildren( get_player() )
	if ( player_child_entities ~= nil ) then
		for i,child_entity in ipairs( player_child_entities ) do
			local child_entity_name = EntityGetName( child_entity )
			
			if ( child_entity_name == "inventory_quick" ) then
				return child_entity
			end
		end
	end
	return nil
end


function spawn_item_in_range(path, min_x_range, max_x_range, min_y_range, max_y_range, limit_x_axis, limit_y_axis, spawn_blackhole)
  local x, y = get_player_pos()
  local dx = generate_value_in_range(max_x_range, min_x_range, limit_x_axis)
  local dy = generate_value_in_range(max_y_range, min_y_range, limit_y_axis)
  
  return EntityLoad(path, x + dx, y + dy)
end
--[[
function spawn_item(path, min_range, max_range, spawn_blackhole)
  local x, y = get_player_pos()
  
  local angle = Random()*math.pi*2;
  
  local dx = math.cos(angle)*Random(min_range, max_range);
  local dy = math.sin(angle)*Random(min_range, max_range);
  
  if(spawn_blackhole)then
	EntityLoad("data/entities/short_blackhole.xml", x + dx, y + dy)
  end
  
  return EntityLoad(path, x + dx, y + dy)
end
]]

function get_spawn_pos(min_range, max_range, x, y)

	SetRandomSeed( x + GameGetFrameNum(), y  + GameGetFrameNum() )

	local x2, y2 =  get_player_pos()
	
	x = x or x2 or 0
	y = y or y2 or 0
	
	local spawn_points = {}
	
	local count = 0
	
	for i = 1, 1000 do
	
		local angle = Random()*math.pi*2;
		
		local dx = x + (math.cos(angle)*Random(min_range, max_range));
		local dy = y + (math.sin(angle)*Random(min_range, max_range));		
		
		local rhit, rx, ry = RaytracePlatforms(dx - 2, dy - 2, dx + 2, dy + 2)
		
		
		
		if(rhit) then 
			--DEBUG_MARK( dx, dy, "bad_spawn_point",0, 0, 1 )
		else

			table.insert(spawn_points, {
				x = dx,
				y = dy,
			})
		end
	end

	if(#spawn_points == 0)then
		return x, y
	end
	local spawn_index = Random(1, #spawn_points)


	
	local spawn_x = spawn_points[spawn_index].x
	local spawn_y = spawn_points[spawn_index].y
	
	if(spawn_x == nil)then
		local angle = Random()*math.pi*2;
		
		local dx = x + (math.cos(angle)*Random(min_range, max_range));
		local dy = y + (math.sin(angle)*Random(min_range, max_range));		
		
		--EntityLoad("mods/twitch_extended/files/entities/short_blackhole.xml", dx, dy)
		create_hole_of_size(dx, dy, 12)
		
		return dx, dy
	else

		return spawn_x, spawn_y
	end

end


function spawn_item(entity_path, min_range, max_range, black_hole, ignore_bad_spawns, hole_size, x, y)
	min_range = min_range or 0
	max_range = max_range or 0
	ignore_bad_spawns = ignore_bad_spawns or false
	hole_size = hole_size or 12
	black_hole = black_hole or false
	if(not ignore_bad_spawns)then

		local x2, y2 = get_player_pos()
		
		x = x or x2 or 0
		y = y or y2 or 0
		
		spawn_x, spawn_y = get_spawn_pos(min_range, max_range, x, y)

		if black_hole then
			--EntityLoad("mods/twitch_extended/files/entities/short_blackhole.xml", spawn_x, spawn_y)
			create_hole_of_size(spawn_x, spawn_y, hole_size)
		end
		
		return EntityLoad(entity_path, spawn_x, spawn_y)

	else
		local x2, y2 = get_player_pos()
		
		x = x or x2 or 0
		y = y or y2 or 0
		  
		local angle = Random()*math.pi*2;
		  
		local dx = math.cos(angle)*Random(min_range, max_range);
		local dy = math.sin(angle)*Random(min_range, max_range);
		  
		if(black_hole)then
			create_hole_of_size(x + dx, y + dy, hole_size)
			--EntityLoad("mods/twitch_extended/files/entities/short_blackhole.xml", x + dx, y + dy)
		end
		  
		return EntityLoad(entity_path, x + dx, y + dy)	
	end
end