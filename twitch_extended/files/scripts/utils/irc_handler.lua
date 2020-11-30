dofile_once("data/scripts/streaming_integration/event_utilities.lua")
dofile( "data/scripts/perks/perk.lua" )
dofile( "data/scripts/game_helpers.lua" )
function OnMessage(userdata, message)

	if(HasSettingFlag("twitch_extended_options_show_chat"))then
		if(message ~= "1" and message ~= "2" and message ~= "3" and message ~= "4")then
			GamePrint(userdata.username..": "..message)
		end
	end
	if( true --[[userdata.broadcaster or userdata.mod ]])then
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
			--GamePrint(v.reward_id)
			reward_id = ModSettingGet("twitch_reward_"..v.reward_id)
			if(v.reward_image == nil)then
				v.reward_image = ""
			end
			if(reward_id ~= nil)then
				if(reward_id == userdata.custom_reward)then
					v.func(v, userdata)
					if(not HasSettingFlag("twitch_extended_options_reward_message"))then
						message = ""
					end
					if(message == nil or message == "")then
						GamePrintImportant(userdata.username.." has redeemed \""..GameTextGetTranslatedOrNot(v.reward_name).."\"", GameTextGetTranslatedOrNot(v.reward_description), v.reward_image)
					else
						GamePrintImportant(userdata.username.." has redeemed \""..GameTextGetTranslatedOrNot(v.reward_name).."\"", message, v.reward_image)
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
				if(message == nil or message == "")then
					GamePrintImportant(userdata.username.." has subscribed and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", GameTextGetTranslatedOrNot(reward.reward_description), reward.reward_image)
				else
					GamePrintImportant(userdata.username.." has subscribed and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", message, reward.reward_image)
				end
				print(userdata.username.." has subscribed")
				reward.func(reward, userdata)
			elseif(userdata.msg_id == "resub")then
				if(message == nil or message == "")then
					GamePrintImportant(userdata.username.." has subscribed for "..tostring(userdata.total_months).." months! and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", GameTextGetTranslatedOrNot(reward.reward_description), reward.reward_image)
				else
					GamePrintImportant(userdata.username.." has subscribed for "..tostring(userdata.total_months).." months! and redeemed \""..GameTextGetTranslatedOrNot(reward.reward_name).."\"", message, reward.reward_image)				
				end
				print(userdata.username.." has subscribed")
				reward.func(reward, userdata)
			end
		end
	end
end
