dofile_once("data/scripts/streaming_integration/event_utilities.lua")
dofile( "data/scripts/perks/perk.lua" )
dofile( "data/scripts/game_helpers.lua" )
if(ModIsEnabled("twitch_lib"))then
	dofile_once("mods/twitch_lib/files/twitch_overwrites.lua")
end

function StartsWith(str, start)
	return str:sub(1, #start) == start
end


command_cooldowns = command_cooldowns or {}
player_cooldowns = player_cooldowns or {}

function CheckCommandPermission(id, userdata)
	local setting = ModSettingGet("twitch_extended_commands_"..id.."_permission")
	if(setting == nil)then
		setting = "everyone"
	end

	if(setting == "everyone")then
		return true
	elseif(setting == "sub")then
		if(userdata.subscriber or userdata.mod or userdata.broadcaster)then
			return true
		end
	elseif(setting == "mod")then
		if(userdata.mod or userdata.broadcaster)then
			return true
		end
	elseif(setting == "broadcaster")then
		if(userdata.broadcaster)then
			return true
		end
	end

	return false
end

function CheckCommandCooldown(id, userdata)
	local cooldown_type = ModSettingGet("twitch_extended_commands_"..id.."_cooldown_type")
	if(cooldown_type == nil)then
		cooldown_type = "global"
	end

	local cooldown = ModSettingGet("twitch_extended_commands_"..id.."_cooldown")
	if(cooldown == nil)then
		cooldown = 0
	end

	-- cooldown is in seconds, so multiply by 60

	if(cooldown_type == "global")then
		if(command_cooldowns[id] == nil)then
			command_cooldowns[id] = 0
		end

		if(command_cooldowns[id] > GameGetFrameNum())then
			return false
		end

		command_cooldowns[id] = GameGetFrameNum() + (cooldown * 60)

		return true
	elseif(cooldown_type == "user")then
		if(player_cooldowns[userdata.user_id] == nil)then
			player_cooldowns[userdata.user_id] = {}
		end

		if(player_cooldowns[userdata.user_id][id] == nil)then
			player_cooldowns[userdata.user_id][id] = 0
		end

		if(player_cooldowns[userdata.user_id][id] > GameGetFrameNum())then
			return false
		end

		player_cooldowns[userdata.user_id][id] = GameGetFrameNum() + (cooldown * 60)

		return true
	end
end

function OnMessage(userdata, message)
	

	
		--GamePrint(userdata.username..": "..message)

		--[[
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
		]]

		

	async(function()
		while(GlobalsGetValue("twitch_chat_message_id", "") ~= "")do
			--print("eee")
			wait(1)
		end
		--print("aaa")
		--print(message)

		if(userdata.color == "" or userdata.color == nil)then
			userdata.color = "#8f8f8f"
		end

		GlobalsSetValue("twitch_chat_message_id", userdata.message_id or "0")
		GlobalsSetValue("twitch_chat_message_color", userdata.color)
		GlobalsSetValue("twitch_chat_message_name", userdata.username or "")
		GlobalsSetValue("twitch_chat_message_message", userdata.message or "")
		GlobalsSetValue("twitch_chat_message_broadcaster", tostring(userdata.broadcaster or "false"))
		GlobalsSetValue("twitch_chat_message_subscriber", tostring(userdata.subscriber or "false"))
		GlobalsSetValue("twitch_chat_message_moderator", tostring(userdata.mod or "false"))
		GlobalsSetValue("twitch_chat_message_frames", GameGetFrameNum())
	end)

	--if(userdata.custom_reward)then
	--	print("Reward redeemed by ["..userdata.username.."]:"..tostring(userdata.custom_reward))
	--end

	words = {}

	for word in message:gmatch("%S+") do table.insert(words, word) end

	if( userdata.broadcaster or userdata.mod )then

		if(words[1] ~= nil)then
			if(words[1] == "!reward")then
				if(words[2] ~= nil)then
					--GamePrint("test reward redeemed.")
					userdata.custom_reward = words[2]
                end
            elseif(words[1] == "!refresh")then
				StreamingForceNewVoting()
			elseif(words[1] == "!sub")then
				userdata.msg_id = "sub"
				
				OnSub(userdata, message)
			elseif(words[1] == "!bits")then
				if(words[2] ~= nil)then
					if(tonumber(words[2]) ~= nil)then
						userdata.bits = tonumber(words[2])
					end
				end
			end
		end
	end
	
	--[[
		example command:
		{
			command_id = "ping",
			command_name = "Ping",
			command_description = "Pong!",
			command_image = nil,
			required_flag = "",
			permission = "moderator", -- "moderator", "subscriber", "everyone", "broadcaster"
			func = function(reward, userdata)
				print("Pong!")
				GamePrint("Pong!")
			end,
		}
	]]

	

	-- loop through commands
	for k, v in ipairs(commands)do
		if(v.required_flag == "" or HasFlagPersistent(v.required_flag) or GameHasFlagRun(v.required_flag))then
			if(HasSettingFlag("twitch_extended_commands_"..v.reward_id) and CheckCommandPermission(v.reward_id, userdata) and CheckCommandCooldown(v.reward_id, userdata))then
				local command = ModSettingGet("twitch_extended_commands_"..v.reward_id.."_command") or ("!"..v.reward_id)
				if(words[1] ~= nil and StartsWith(message, command))then

					v.no_display_message = v.no_display_message or false
					
					

					if(v.no_display_message ~= true and HasSettingFlag("twitch_extended_commands_"..v.reward_id.."_no_message") == false)then
						GamePrintImportant(userdata.username.." used command \""..GameTextGetTranslatedOrNot(v.reward_name).."\"", GameTextGetTranslatedOrNot(v.reward_description), v.reward_image)
					end

					v.func(v, userdata)
				end
			end
		end
	end

	if(userdata.custom_reward ~= nil--[[ and HasSettingFlag("twitch_extended_options_channel_point_rewards")]])then

		enabled_channelrewards = {}

		for k, v in pairs(channel_rewards)do
			if(v.required_flag == "" or HasFlagPersistent(v.required_flag) or GameHasFlagRun(v.required_flag))then
				--if(HasSettingFlag("twitch_extended_sub_rewards_"..v.reward_id))then
					table.insert(enabled_channelrewards, v)
				--end
			end
		end

		for k, v in pairs(enabled_channelrewards)do
			
			reward_id = ModSettingGet("twitch_reward_"..v.reward_id)
			if(v.reward_image == nil)then
				v.reward_image = ""
			end
			if(reward_id ~= nil)then
				--GamePrint(reward_id)
				--GamePrint(userdata.custom_reward)
				if(reward_id == userdata.custom_reward)then
					--GamePrint(v.reward_id)
					v.func(v, userdata)
					if(not HasSettingFlag("twitch_extended_options_reward_message"))then
						message = ""
					end

					v.no_display_message = v.no_display_message or false
					
					

					if(v.no_display_message ~= true and HasSettingFlag("twitch_extended_link_rewards_"..v.reward_id.."_no_message") == false)then
						if(message == nil or message == "")then
							GamePrintImportant(userdata.username.." has redeemed \""..GameTextGetTranslatedOrNot(v.reward_name).."\"", GameTextGetTranslatedOrNot(v.reward_description), v.reward_image)
						else
							GamePrintImportant(userdata.username.." has redeemed \""..GameTextGetTranslatedOrNot(v.reward_name).."\"", message, v.reward_image)
						end
					end
				end
			end

			if(GlobalsGetValue("linking_"..v.reward_id, "false") == "true")then
				ModSettingSet("twitch_reward_"..v.reward_id, userdata.custom_reward)
				AddSettingFlag("twitch_extended_link_rewards_link_"..v.reward_id)

				GameAddFlagRun("config_lib_update_config")

				GamePrint('"'..GameTextGetTranslatedOrNot(v.reward_name)..'" '..GameTextGetTranslatedOrNot("$twitch_extended_config_reward_linked"))
				GlobalsSetValue("linking_"..v.reward_id, "false")
			end
		end

		

	end

end

function get_events_with_closest_amount(events, amount)
	local current_amount = -1
	local was_exact = false
	for k, v in pairs(events)do
		v.amount = tonumber(ModSettingGet("twitch_extended_bit_rewards_"..v.reward_id.."_bit_amount"))
		v.exact_amount = HasSettingFlag("twitch_extended_bit_rewards_"..v.reward_id.."_exact_amount")
		if(v.amount ~= nil)then
			if(v.amount <= amount and v.amount > current_amount)then
				current_amount = v.amount
				if(v.exact_amount)then
					was_exact = true
				else
					was_exact = false
				end
			end
		end
	end

	if(was_exact == true)then
		current_amount = -1
	end

	for k, v in pairs(events)do
		if(v.amount ~= nil)then
			if(v.exact_amount)then
				if(v.amount == amount)then
					current_amount = v.amount
					break
				end
			end
		end
	end

	local available_events = {}

	for k, v in pairs(events)do
		if(v.required_flag == "" or v.required_flag == nil or HasFlagPersistent(v.required_flag) or GameHasFlagRun(v.required_flag))then
			if(v.amount ~= nil)then
				if(v.amount == current_amount)then
					table.insert(available_events, v)
				end
			end
		end
	end

	return available_events
end

function OnBits(userdata, message)
	
	if(not HasSettingFlag("twitch_extended_options_reward_message"))then
		message = ""
	end
	if(#bit_rewards > 0)then
		--print("heck")

		enabled_bitrewards = {}

		for k, v in pairs(bit_rewards)do
			if(v.required_flag == "" or v.required_flag == nil or HasFlagPersistent(v.required_flag) or GameHasFlagRun(v.required_flag))then
				if(HasSettingFlag("twitch_extended_bit_rewards_"..v.reward_id))then
					table.insert(enabled_bitrewards, v)
				end
			end
		end

		enabled_bit_rewards = get_events_with_closest_amount(enabled_bitrewards, userdata.bits)

		local reward = enabled_bit_rewards[Random(1,#enabled_bit_rewards)]

		if reward == nil then
			return
		end

		if(reward.reward_image == nil)then
			reward.reward_image = ""
		end

		if(reward ~= nil)then

			reward.no_display_message = reward.no_display_message or false

			if(reward.no_display_message ~= true and HasSettingFlag("twitch_extended_bit_rewards_"..reward.reward_id.."_no_message") == false)then
				if(message == nil or message == "")then
					GamePrintImportant(userdata.username.." donated "..userdata.bits.." bits and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", GameTextGetTranslatedOrNot(reward.reward_description), reward.reward_image)
				else
					GamePrintImportant(userdata.username.." donated "..userdata.bits.." bits and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", message, reward.reward_image)
				end
			end
			--print(userdata.username.." has subscribed")
			reward.func(reward, userdata)

		end
	end
end

function OnSub(userdata, message)
	
	if(not HasSettingFlag("twitch_extended_options_reward_message"))then
		message = ""
	end
	if(#sub_rewards > 0 and HasSettingFlag("twitch_extended_options_subscription_rewards"))then
		--print("heck")
		
		

		enabled_subrewards = {}

		for k, v in pairs(sub_rewards)do
			if(v.required_flag == "" or v.required_flag == nil or HasFlagPersistent(v.required_flag) or GameHasFlagRun(v.required_flag))then
				if(HasSettingFlag("twitch_extended_sub_rewards_"..v.reward_id))then
					table.insert(enabled_subrewards, v)
				end
			end
		end

		local reward = enabled_subrewards[Random(1,table.getn(enabled_subrewards))]

		if(reward.reward_image == nil)then
			reward.reward_image = ""
		end

		if(reward ~= nil)then
			--print(table.dump(userdata))

			if(userdata.msg_id == "sub")then
				reward.no_display_message = reward.no_display_message or false

				if(reward.no_display_message ~= true and HasSettingFlag("twitch_extended_sub_rewards_"..reward.reward_id.."_no_message") == false)then
					if(message == nil or message == "")then
						GamePrintImportant(userdata.username.." has subscribed and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", GameTextGetTranslatedOrNot(reward.reward_description), reward.reward_image)
					else
						GamePrintImportant(userdata.username.." has subscribed and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", message, reward.reward_image)
					end
				end
				print(userdata.username.." has subscribed")
				reward.func(reward, userdata)
			elseif(userdata.msg_id == "resub" and false)then
				reward.no_display_message = reward.no_display_message or false

				if(reward.no_display_message ~= true and HasSettingFlag("twitch_extended_sub_rewards_"..reward.reward_id.."_no_message") == false)then
					if(message == nil or message == "")then
						GamePrintImportant(userdata.username.." has subscribed for "..tostring(userdata.total_months).." months! and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", GameTextGetTranslatedOrNot(reward.reward_description), reward.reward_image)
					else
						GamePrintImportant(userdata.username.." has subscribed for "..tostring(userdata.total_months).." months! and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", message, reward.reward_image)				
					end
				end
				print(userdata.username.." has subscribed")
				reward.func(reward, userdata)
			end
		end
	end
end
