dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once("mods/config_lib/files/utilities.lua")

local function ends_with(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

customEvents["twitch_extended_fungal_shift"] = function(data)
	if(HasSettingFlag("twitch_extended_options_noita_together_shifts"))then
		GamePrint(data.game_print)
		print(data.print)

		local found_inputs = data.found_inputs
		local output = data.output
		local userdata = data.userdata
		local reward = data.reward
		local sender = data.sender

		local sender_string = (ends_with(sender, "s") or ends_with(sender, "S")) and sender.."' chat" or sender.."'s chat"
		
		GamePrintImportant(userdata.username.." redeemed Fungal Shift in "..sender_string, userdata.username.." shifted all "..GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(found_inputs[1]))).." into "..output..".", reward.reward_image)

		shift_materials(found_inputs, output)
	end
end

customEvents["twitch_extended_local_shift"] = function(data)
	print("local shift")
	if(HasSettingFlag("twitch_extended_options_noita_together_shifts"))then
		GamePrint(data.game_print)
		print(data.print)

		local found_inputs = data.found_inputs
		local output = data.output
		local userdata = data.userdata
		local reward = data.reward
		local sender = data.sender

		local sender_string = (ends_with(sender, "s") or ends_with(sender, "S")) and sender.."' chat" or sender.."'s chat"
		
		GamePrintImportant(userdata.username.." redeemed Local Shift in "..sender_string, userdata.username.." shifted nearby "..GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(found_inputs[1]))).." into "..output..".", reward.reward_image)

		shift_materials_in_range(data.radius, found_inputs, output, data.convert_flasks)
	end
end

--[[
	payload={
		name="twitch_extended_local_shift",
		materials_input = found_inputs,
		output = output,
		radius = shift_distance,
		game_print = input_string.." > "..output,
		print = "[Twitch Extended] - [Fungal Shift]: "..input_string.." > "..output,
		userdata = userdata,
		reward = reward,
		sender = StreamingGetConnectedChannelName()
	},
]]