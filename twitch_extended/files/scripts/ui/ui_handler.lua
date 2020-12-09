handler_gui = handler_gui or GuiCreate()
current_id = 2
stored_users = stored_users or {}


function new_id()
    current_id = current_id + 1
    return current_id
end


GuiStartFrame(handler_gui)

GuiIdPushString( handler_gui, "twitch_extended" )


-- Shared Functions
function GuiText2(gui, x, y, text, z_index)
	local count = 0
	GuiLayoutBeginVertical( gui, 0, 0, false, 0, 0 )
	for s in text:gmatch("[^\r\n]+") do
		count = count + 1
		GuiZSetForNextWidget( gui, z_index )
		if(count > 1)then
			y = 0
		end
		GuiText(gui, x, y, s)
	end
	GuiLayoutEnd( gui )
end

function hex2argb(hex)
	hex = hex:gsub("#", "FF")
	local n = tonumber(hex, 16)
	return bit.band(bit.rshift(n, 24), 0xFF)/255, bit.band(bit.rshift(n, 16), 0xFF)/255, bit.band(bit.rshift(n, 8), 0xFF)/255, bit.band(n, 0xFF)/255
end

function splitIntoLines(inputs, len)
	output = {}
	current_length = 0
	current_string = ""
	for word in inputs:gmatch("%S+") do
		current_length = current_length + #word + 1
		if(current_length > len)then
			table.insert(output, current_string)
			current_length = #word + 1
			current_string = word .. " "
		else
			current_string = current_string .. word .. " "
		end
	end
	if(#current_string > 0)then
		table.insert(output, current_string)
	end

	return output
end

for i = #stored_users, 1, -1 do
	local v = stored_users[i]
	if( GameGetFrameNum() > v.frame + ((ModSettingGet("twitch_extended_options_remove_user_minutes") or 10) * 60 * 60) or v.broadcaster and not HasSettingFlag("twitch_extended_options_include_broadcaster") or v.moderator and not HasSettingFlag("twitch_extended_options_include_moderators") or not v.subscriber and HasSettingFlag("twitch_extended_options_only_subscribers") or GlobalsGetValue("random_twitch_user_used", "") == v.name and HasSettingFlag("twitch_extended_options_remove_after_used"))then
		table.remove(stored_users, i)
		GlobalsSetValue("random_twitch_user_used", "")
	end
end

if(stored_users[1] ~= nil)then
	user_string = ""
	for k, v in pairs(stored_users)do
		user_string = user_string .. v.name..","..v.color..","..tostring(v.broadcaster)..","..tostring(v.moderator)..","..tostring(v.subscriber)..":"
	end
	GlobalsSetValue("random_twitch_user", user_string)
else
	GlobalsSetValue("random_twitch_user", "")
end
-- GamePrint("Current random user = "..GlobalsGetValue("random_twitch_user", "nil"))
-- Render Nametags
tracked_entities = {
	--[[
	{
		id = 1,
		string = "",
		color = "#ffffff"
	}
	]]
}



-- Run Modifier Display
run_modifier_name = run_modifier_name or nil
run_modifier_description = run_modifier_description or nil

local world_entity_id = GameGetWorldStateEntity()
if world_entity_id then 

	if(run_modifier_name ~= nil and run_modifier_name ~= "" and run_modifier_description ~= nil and run_modifier_description ~= "")then
		
		GuiLayoutBeginHorizontal(handler_gui, 50, 97)

		GuiOptionsAddForNextWidget( handler_gui, 16 )
		GuiText( handler_gui, 0, 0, GameTextGetTranslatedOrNot(run_modifier_name) .. " - " ..GameTextGetTranslatedOrNot(run_modifier_description) ) -- works


		GuiLayoutEnd(handler_gui)
	else
		run_modifier_name = EntityGetVariable(world_entity_id, "run_modifier_name", "string")
		run_modifier_description = EntityGetVariable(world_entity_id, "run_modifier_description", "string")
	end

end

-- Twitch Chat
function GuiMessage(gui, x, y, user_data, color, message, z_index, is_action)
	user = user_data.username
	local a, r, g, b = hex2argb(color)
	GuiZSet( gui, z_index )
	GuiLayoutBeginHorizontal( gui, 0, 0, false, 0, 0 )
	GuiLayoutBeginHorizontal( gui, 0, 0, false, 1, 1 )
		if(HasSettingFlag("twitch_extended_options_show_chat_badges"))then
			--print("test eee")
			
			if(user_data.broadcaster)then
				GuiImage( gui, new_id(), x, y + 1, "mods/twitch_extended/files/gfx/chat_badges/broadcaster_badge.png", 1, 1, 0, 0, 1, "" )
			end
			if(user_data.moderator)then
				GuiImage( gui, new_id(), x, y + 1, "mods/twitch_extended/files/gfx/chat_badges/mod_badge.png", 1, 1, 0, 0, 1, "" )
			end
			if(user_data.subscriber)then
				GuiImage( gui, new_id(), x, y + 1, "mods/twitch_extended/files/gfx/chat_badges/sub_badge.png", 1, 1, 0, 0, 1, "" )
			end
			
		end
		GuiColorSetForNextWidget(gui, r, g, b, a)
		if(is_action == false)then
			GuiText(gui, x, y, user..": ")
		else
			GuiText(gui, x, y, user.." ")
		end
		
		GuiLayoutBeginVertical( handler_gui, 0, 0, false, 0, 0 )
		if(type(message) == "table")then
			for k, v in pairs(message)do
				if(k > 1)then
					y = 0
				end
				GuiText(gui, x, y, v)
			end
		else
			GuiText(gui, x, y, message)
		end
		GuiLayoutEnd( gui )
		GuiZSet( gui, 0 )
	GuiLayoutEnd( gui )
	GuiLayoutEnd( gui )	
end

stored_chat_messages = stored_chat_messages or {}

if(GlobalsGetValue("twitch_chat_message_id", "") ~= "")then
	if(#stored_chat_messages >= (ModSettingGet("twitch_extended_options_chat_count") or 7))then
		table.remove(stored_chat_messages, 1)
	end
	
	local message_table = {
		id = GlobalsGetValue("twitch_chat_message_id", ""),
		color = GlobalsGetValue("twitch_chat_message_color", ""),
		name = GlobalsGetValue("twitch_chat_message_name", ""),
		message = GlobalsGetValue("twitch_chat_message_message", ""),
		broadcaster = (GlobalsGetValue("twitch_chat_message_broadcaster", "") == "true" or false),
		subscriber = (GlobalsGetValue("twitch_chat_message_subscriber", "") == "true" or false),
		moderator = (GlobalsGetValue("twitch_chat_message_moderator", "") == "true" or false),
		frame = tonumber(GlobalsGetValue("twitch_chat_message_frames", "0"))
	}

	--print(table.dump(message_table))

	table.insert(stored_chat_messages, message_table)

	has_user = false
	for k, v in pairs(stored_users)do
		if(v.name == GlobalsGetValue("twitch_chat_message_name", ""))then
			has_user = true
		end
	end

	if(has_user == false)then
		current_user = {
			name = GlobalsGetValue("twitch_chat_message_name", ""),
			color = GlobalsGetValue("twitch_chat_message_color", ""),
			broadcaster = (GlobalsGetValue("twitch_chat_message_broadcaster", "") == "true" or false),
			subscriber = (GlobalsGetValue("twitch_chat_message_subscriber", "") == "true" or false),
			moderator = (GlobalsGetValue("twitch_chat_message_moderator", "") == "true" or false),
			frame = tonumber(GlobalsGetValue("twitch_chat_message_frames", "0"))
		}

		if(current_user.broadcaster and not HasSettingFlag("twitch_extended_options_include_broadcaster") or current_user.moderator and not HasSettingFlag("twitch_extended_options_include_moderators") or not current_user.subscriber and HasSettingFlag("twitch_extended_options_only_subscribers"))then
			--print("ignored user")
		else
			table.insert(stored_users, current_user)
		end
	end

	GlobalsSetValue("twitch_chat_message_id", "")
	GlobalsSetValue("twitch_chat_message_color", "")
	GlobalsSetValue("twitch_chat_message_name", "")
	GlobalsSetValue("twitch_chat_message_message", "")
	GlobalsSetValue("twitch_chat_message_broadcaster", "")
	GlobalsSetValue("twitch_chat_message_subscriber", "")
	GlobalsSetValue("twitch_chat_message_moderator", "")
	GlobalsSetValue("twitch_chat_message_frames", "")
end

if(not GameHasFlagRun("config_lib_open"))then
	if(#stored_chat_messages > 0)then
		local sx, sy = GuiGetScreenDimensions( handler_gui )
		for i = #stored_chat_messages, 1, -1 do
			message = stored_chat_messages[i]
			
			--print(table.dump(message))

			if(GameGetFrameNum() > message.frame + ((ModSettingGet("twitch_extended_options_chat_timeout") or 10) * 60) or message.message:find("^%s*$") )then
				table.remove(stored_chat_messages, i)
			end
		end

		for k, message in pairs(stored_chat_messages)do
			if(message.split == nil)then
				if(message.message == "" )then
					message.message = "..."
				end

				message.message = string.trim(message.message)

				if(string.sub(message.message, 1, 7) == "ACTION" and string.sub(message.message, -1) == "")then
					message.action = true
					message.message = string.sub(message.message, 8, #message.message - 1)--"Quack"
				else
					message.action = false
				end

				--print(tostring(ModSettingGet("twitch_extended_options_chat_line_split")))
				message.message_split = splitIntoLines(message.message, ModSettingGet("twitch_extended_options_chat_line_split") or 50)
			--	print(table.dump(message.message_split))
				message.split = true
			end
		end
		text_width, text_height = GuiGetTextDimensions( handler_gui, "normal message", 1, 2)

		local true_height = 0

		--y_offset = text_height * #stored_chat_messages
		y_offset = 0

		if(HasSettingFlag("twitch_extended_options_show_chat"))then
			if(HasSettingFlag("twitch_extended_options_chat_background"))then
				GuiBeginAutoBox( handler_gui )
			end
			GuiLayoutBeginVertical( handler_gui, ModSettingGet("twitch_extended_options_chat_position_x") or 1, ModSettingGet("twitch_extended_options_chat_position_y") or 15, false, 0, 0 )
			for k, message in pairs(stored_chat_messages)do
			--	GamePrint(true_height)
				if(message.message ~= "1" and message.message ~= "2" and message.message ~= "3" and message.message ~= "4")then
					GuiMessage(handler_gui, 0, y_offset + true_height, {username = message.name, broadcaster = message.broadcaster, subscriber = message.subscriber, moderator = message.moderator}, message.color, message.message_split, 50, message.action)
					for i = 1, #message.message_split do
						true_height = true_height + text_height
					end
					y_offset = y_offset - text_height
				end
			end
			GuiLayoutEnd( handler_gui )
			if(HasSettingFlag("twitch_extended_options_chat_background"))then
				GuiEndAutoBoxNinePiece( handler_gui, 5, 0, 0, false, 0, "mods/twitch_extended/files/gfx/misc/chat_background.png", "mods/twitch_extended/files/gfx/misc/chat_background.png" )
			end
		end
	end
end


-- Paused Votes
if GameHasFlagRun( "twitch_vote_paused" ) and not GameHasFlagRun("config_lib_open") then
	GuiStartFrame( handler_gui )
	local sx, sy = GuiGetScreenDimensions( handler_gui )
	GuiBeginAutoBox( handler_gui )
	text_width, text_height = GuiGetTextDimensions( handler_gui, GameTextGetTranslatedOrNot("$twitch_extended_vote_paused"), 1, 2)
	if HasSettingFlag("twitch_extended_options_left_side_votes")then
		GuiText2(handler_gui, 13, sy - text_height - 11, GameTextGetTranslatedOrNot("$twitch_extended_vote_paused"), -90)
	else
		GuiText2(handler_gui, sx - text_width - 13, sy - text_height - 11, GameTextGetTranslatedOrNot("$twitch_extended_vote_paused"), -90)
	end
	GuiZSetForNextWidget( handler_gui, -85 )
	GuiEndAutoBoxNinePiece( handler_gui, 5, 0, 0, false, 0, "data/ui_gfx/decorations/9piece0_gray.png", "data/ui_gfx/decorations/9piece0_gray.png" )
end


GuiIdPop( handler_gui )