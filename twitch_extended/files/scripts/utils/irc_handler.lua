dofile_once("data/scripts/streaming_integration/event_utilities.lua")
dofile( "data/scripts/perks/perk.lua" )
dofile( "data/scripts/game_helpers.lua" )


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



	if( userdata.broadcaster or userdata.mod )then
		words = {}

		for word in message:gmatch("%S+") do table.insert(words, word) end

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

					if(v.no_display_message ~= true)then
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
		enabled_bit_rewards = get_events_with_closest_amount(bit_rewards, userdata.bits)

		local reward = enabled_bit_rewards[Random(1,#enabled_bit_rewards)]

		if reward == nil then
			return
		end

		if(reward.reward_image == nil)then
			reward.reward_image = ""
		end

		if(reward ~= nil)then

			reward.no_display_message = reward.no_display_message or false

			if(reward.no_display_message ~= true)then
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
			--print("eeeeee")
			if(userdata.msg_id == "sub")then
				reward.no_display_message = reward.no_display_message or false

				if(reward.no_display_message ~= true)then
					if(message == nil or message == "")then
						GamePrintImportant(userdata.username.." has subscribed and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", GameTextGetTranslatedOrNot(reward.reward_description), reward.reward_image)
					else
						GamePrintImportant(userdata.username.." has subscribed and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", message, reward.reward_image)
					end
				end
				print(userdata.username.." has subscribed")
				reward.func(reward, userdata)
			elseif(userdata.msg_id == "resub")then
				reward.no_display_message = reward.no_display_message or false

				if(reward.no_display_message ~= true)then
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
