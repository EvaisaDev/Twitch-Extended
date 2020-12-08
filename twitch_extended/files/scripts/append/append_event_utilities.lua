dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/lib/coroutines.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utils.lua")
dofile_once("data/scripts/streaming_integration/event_list.lua")
dofile_once("mods/twitch_extended/lib/persistent_store.lua")
dofile_once("mods/twitch_extended/config/rewards.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/wand_utils.lua")
dofile_once("mods/config_lib/files/utilities.lua")

local streaming_config_events_per_vote = 4

local next_event_id = 1
local event_weights = {}

StreamingGetRandomViewerName = function()
	user = {

	}
	str = GlobalsGetValue("random_twitch_user", "")
	i = 1
	for word in string.gmatch(str, '([^,]+)') do
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


add_timer_above_head = function( entity_id, event_id, event_timer, event_formatting)
	local timer_id = EntityCreateNew( "delay_timer" )
	
	if(event_formatting == nil or event_formatting == "")then
		event_formatting = ""
	end

	EntityAddComponent2( timer_id, "InheritTransformComponent",
	{
	})
	
	EntityAddComponent2( timer_id, "SpriteComponent",
	{
		image_file="data/fonts/font_pixel_white.xml",
		is_text_sprite=true,
		offset_x=12,
		offset_y=42,
		text = "", 
		update_transform=true,
		update_transform_rotation=false,
		has_special_scale=true,
		special_scale_x=0.65,
		special_scale_y=0.65,
		alpha=0.8,
	})
	

	EntityAddComponent2( timer_id, "LifetimeComponent",
	{
		lifetime = event_timer,
	})
	
	EntityAddComponent2( timer_id, "VariableStorageComponent",
	{
		name = "event",
		value_string = event_id,
	})
	
	EntityAddComponent2( timer_id, "VariableStorageComponent",
	{
		name = "formatting",
		value_string = event_formatting,
	})

	EntityAddComponent2( timer_id, "VariableStorageComponent",
	{
		name = "lifetime",
		value_int = event_timer,
	})
	
	EntityAddComponent2( timer_id, "LuaComponent",
	{
		script_source_file = "mods/twitch_extended/files/scripts/utils/delay_timer_update_custom.lua",
		execute_every_n_frame = 1,
	})
	
	EntityAddComponent2( timer_id, "LuaComponent",
	{
		script_source_file = "data/scripts/streaming_integration/scripts/delay_timer_finish.lua",
		execute_every_n_frame = -1,
		execute_on_removed = true,
	})
	
	EntityAddChild( entity_id, timer_id )
end

_streaming_on_vote_start = function()
	for i,w in pairs( event_weights ) do
		local weight_change = w
		
		
		-- event_weights stores how much the event's weight has changed in either positive or negative direction. Every time a new vote starts, that weight change goes towards 0 by 25% so that the weight eventually returns to its default value.
		if ( math.abs( weight_change ) > 0.1 ) then
			weight_change = weight_change * 0.75
			--GamePrint(data.ui_name..": "..data.cooldown)
			--[[
			Debug print
			local data = streaming_events[i]
			print( data.id .. "'s weight changed to " .. tostring( (data.weight + weight) * 100.0 ) .. " (dynamic weight " .. tostring( w * 100.0 ) .. " -> " .. tostring( weight * 100.0 ) .. ")" )
			]]--
		else
			weight_change = nil
		end
		
		event_weights[i] = weight_change
	end
	
	for i,data in ipairs( streaming_events ) do
		-- Decrease the event's cooldown and remove it entirely if it's at zero.
		
		if ( data.cooldown ~= nil ) then
			--GamePrint(data.ui_name..": "..data.cooldown)
			if ( data.cooldown > 0 ) then
				data.cooldown = data.cooldown - 1
			else
				--print( "Set cooldown off for " .. data.id )
				data.cooldown = nil
			end
		end
	end
end

_streaming_run_event = function(id)
	for i,evt in ipairs(streaming_events) do
		if evt.id == id then
			if evt.action_delayed ~= nil then
				if evt.delay_timer ~= nil then
					local p = get_players()
					
					if ( #p > 0 ) then
						for a,b in ipairs( p ) do
							add_timer_above_head( b, evt.id, evt.delay_timer, evt.timer_formatting )
						end
					end
				end
			elseif evt.action ~= nil then	
				evt.action(evt)
			end
			
			event_weights[i] = -1.0

			perk_count = tonumber(GlobalsGetValue("perk_vote_count", "0"))
			print("Current perk count = "..tostring(perk_count))

			GameRemoveFlagRun("twitch_vote_ongoing")
			
			if(GlobalsGetValue("current_vote_type", "event") == "loadout")then
				if(HasSettingFlag("twitch_extended_options_artifacts"))then
					GlobalsSetValue("current_vote_type", "artifact")
					StreamingForceNewVoting() 
				else
					if(perk_count <= 0)then
						if(HasSettingFlag("twitch_extended_options_events"))then
							GlobalsSetValue("current_vote_type", "event")
							StreamingSetCustomPhaseDurations( -1, -1 )
							GameRemoveFlagRun("perk_vote")
							print("Switched to event vote.")
						else
							StreamingSetCustomPhaseDurations( -1, -1 )
							StreamingSetVotingEnabled(false)
							GameRemoveFlagRun("perk_vote")
							print("Disabled voting.")
						end
					else
						GlobalsSetValue("current_vote_type", "perk")
						StreamingForceNewVoting()
					end
				end
			else
				if(GlobalsGetValue("current_vote_type", "event") == "artifact" or GlobalsGetValue("current_vote_type", "event") == "perk")then
					if(GlobalsGetValue("current_vote_type", "event") == "artifact")then
						local world_entity_id = GameGetWorldStateEntity()
						if world_entity_id then 
							EntitySetVariable(world_entity_id, "run_modifier_name", evt.ui_name)
							EntitySetVariable(world_entity_id, "run_modifier_description", evt.ui_description)
						end
					end
					if(perk_count <= 0)then
						if(HasSettingFlag("twitch_extended_options_events"))then
							GlobalsSetValue("current_vote_type", "event")
							StreamingSetCustomPhaseDurations( -1, -1 )
							GameRemoveFlagRun("perk_vote")
							print("Switched to event vote.")
						else
							StreamingSetCustomPhaseDurations( -1, -1 )
							StreamingSetVotingEnabled(false)
							GameRemoveFlagRun("perk_vote")
							print("Disabled voting.")
						end
					else
						GlobalsSetValue("current_vote_type", "perk")
						StreamingForceNewVoting()
					end
				else
					if(perk_count > 0)then
						GlobalsSetValue("current_vote_type", "perk")
						StreamingForceNewVoting()
					end
				end
			end

			break
		end
	end
end


_streaming_get_event_for_vote = function()
	--print("Current vote type = "..GlobalsGetValue("current_vote_type", "event"))
	if(GlobalsGetValue("current_vote_type", "event") == "loadout")then
		--print("fuck off with that stupid shit")
		streaming_events = loadout_events
		vote_time = ModSettingGet("twitch_extended_options_loadout_vote_length")
		StreamingSetCustomPhaseDurations( 0, vote_time )
	elseif(GlobalsGetValue("current_vote_type", "event") == "artifact")then
		streaming_events = artifacts
		vote_time = ModSettingGet("twitch_extended_options_artifact_vote_length")
		StreamingSetCustomPhaseDurations( 0, vote_time )
	elseif(GlobalsGetValue("current_vote_type", "event") == "perk")then
		GameAddFlagRun("perk_vote")
		streaming_events = perk_events
		vote_time = ModSettingGet("twitch_extended_options_perk_vote_length")
		StreamingSetCustomPhaseDurations( 0, vote_time )
	else
		streaming_events = special_events
	end

	GameAddFlagRun("twitch_vote_ongoing")

	perk_count = tonumber(GlobalsGetValue("perk_vote_count", "0"))
	if(perk_count > 0)then
		GlobalsSetValue("perk_vote_count", tostring(perk_count - 1))
	end
	-- TODO: implement random event selection
	local weighted_list = {}
	local total_weight = 0
	
	for i,v in ipairs( streaming_events ) do
		local w = v.weight or 1.0
		
		if ( event_weights[i] ~= nil ) then
			w = math.max( w + event_weights[i], 0.01 )
		end

		if (( v.enabled == nil ) or ( v.enabled )) and ( v.cooldown == nil ) then
			total_weight = total_weight + w * 100
			table.insert( weighted_list, { i, total_weight, w * 100 } )
		end
	end
	
	SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() * total_weight )
	
	-- If no valid events were found, do search again but ignore cooldown
	if ( #weighted_list == 0 ) then
		print( "No valid events, ignoring cooldown" )
		
		total_weight = 0
		
		for i,v in ipairs( streaming_events ) do
			local w = v.weight or 1.0
			
			if ( event_weights[i] ~= nil ) then
				w = math.max( w + event_weights[i], 0.01 )
			end

			if (( v.enabled == nil ) or ( v.enabled )) then
				total_weight = total_weight + w * 100
				table.insert( weighted_list, { i, total_weight, w * 100 } )
			end
		end
	end
	
	-- If still no valid events were found, use NOTHING
	if ( #weighted_list == 0 ) then
		print( "No valid events!!" )
		return "HEALTH_PLUS", "$streamingevent_health_plus", "$streamingeventdesc_health_plus", "data/ui_gfx/streaming_event_icons/health_plus.png"
	end
	
	local rnd = Random( 0, math.max( total_weight - 0.1, 0.01 ) )
	local currweight = 0
	local event = streaming_events[next_event_id]
	
	for i,v in ipairs( weighted_list ) do
		if ( rnd >= currweight ) and ( rnd < v[2] ) then
			local id = v[1]
			event = streaming_events[id]
			
			-- Set the event on cooldown
			event.cooldown = 4
			
			-- Apply a modifier to the event's weight
			if ( event_weights[id] == nil ) then
				event_weights[id] = -1.0
			else
				event_weights[id] = event_weights[id] - 0.5
			end
			
			print( "Picked " .. event.id .. " with weight of " .. tostring( v[3] ) .. " out of a total of " .. tostring( total_weight ) )
			
			break
		else
			currweight = currweight + v[3]
		end
	end
	
	next_event_id = next_event_id + 1
	if next_event_id > #streaming_events then next_event_id = 1 end

	return event.id, event.ui_name, event.ui_description, event.ui_icon
end

dofile_once("mods/twitch_extended/files/scripts/utils/irc_handler.lua")

ircparser = dofile("mods/twitch_extended/lib/ircparser.lua")

old_streaming_on_irc = _streaming_on_irc
function _streaming_on_irc( is_userstate, sender_username, message, raw )
--	print("IRC MESSAGE 2: "..raw)
	local lines = ircparser.split(raw, '\r\n')
	for _, line in pairs(lines) do
		--print(line)
		if(string.match(line, "PRIVMSG") and string.sub(line, 1, 11) == "@badge-info")then
			if(line == nil or line == "" or line == "	" or line == " ")then
				return
			end
			local data = ircparser.websocketMessage(line)
			if(data ~= nil)then
				local broadcaster = false
				local mod = false
				local subscriber = false
				local turbo = false

				--print(table.dump(data))

				if(string.match(data["tags"]["badges"], "broadcaster"))then
					broadcaster = true
				end

				if(tonumber(data["tags"]["mod"]) == 1)then
					mod = true
				end
				if(tonumber(data["tags"]["subscriber"]) == 1)then
					subscriber = true
				end
				if(tonumber(data["tags"]["turbo"]) == 1)then
					turbo = true
				end

				local userdata = {
					username = data["tags"]["display-name"],
					user_id = data["tags"]["user-id"],
					message_id = data["tags"]["id"],
					broadcaster = broadcaster,
					mod = mod,
					subscriber = subscriber,
					turbo = turbo,
					color = data["tags"]["color"],
					custom_reward = data["tags"]["custom-reward-id"],
					message = message
				}

				--local message = data["params"][2]
				
				OnMessage(userdata, message)

			end
		elseif(string.match(line, "USERNOTICE") and string.sub(line, 1, 11) == "@badge-info")then
			if(line == nil or line == "" or line == "	" or line == " ")then
				return
			end
			---print(raw)
			local data = ircparser.websocketMessage(line)
			if(data ~= nil)then
				if(data["tags"]["msg-id"] == "resub" or data["tags"]["msg-id"] == "sub")then
					local broadcaster = false
					local mod = false
					local subscriber = false

					if(string.match(data["tags"]["badges"], "broadcaster"))then
						broadcaster = true
					end

					if(tonumber(data["tags"]["mod"]) == 1)then
						mod = true
					end
					if(tonumber(data["tags"]["subscriber"]) == 1)then
						subscriber = true
					end

					local message = data["params"][2]

					if(data["tags"]["msg-param-cumulative-months"] ~= nil)then
						data["tags"]["msg-param-cumulative-months"]	= 1
					end

					if(data["tags"]["msg-param-streak-months"] ~= nil)then
						data["tags"]["msg-param-streak-months"]	= 1
					end

					local sub_data = {
						username = data["tags"]["display-name"],
						user_id = data["tags"]["user-id"],
						broadcaster = broadcaster,
						mod = mod,
						subscriber = subscriber,
						msg_id = data["tags"]["msg-id"],
						color = data["tags"]["color"],
						total_months = tonumber(data["tags"]["msg-param-cumulative-months"]),
						streak = tonumber(data["tags"]["msg-param-streak-months"]),
						message = message
					}

					if(message == nil)then
						message = ""
					end


					OnSub(sub_data, message)
				end
			end
		end
	end

	if(old_streaming_on_irc ~= nil)then
		old_streaming_on_irc( is_userstate, sender_username, message, raw )
	end
end