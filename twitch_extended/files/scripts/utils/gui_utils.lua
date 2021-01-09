current_id = 2
function new_id()
    current_id = current_id + 1
    return current_id
end

function hex2argb(hex)
	hex = hex:gsub("#", "FF")
	local n = tonumber(hex, 16)
	return bit.band(bit.rshift(n, 24), 0xFF)/255, bit.band(bit.rshift(n, 16), 0xFF)/255, bit.band(bit.rshift(n, 8), 0xFF)/255, bit.band(n, 0xFF)/255
end
function draw_text( gui, font, text, color, x, y, scale_x, scale_y, margin_x, margin_y )
	local data = {};
	local a, r, g, b = hex2argb(color)
	GuiLayoutBeginHorizontal( gui, 0, 0, true, margin_x, margin_y )
	--GuiLayoutBeginVertical( gui, 0, 0, false, 0, ModSettingGet("twitch_extended_options_text_slider") or 0 )
	for i = 1, #text do
		local char = text:sub(i,i)
		--GuiLayoutBeginVertical( gui, 0, 0, false, 0, 0 )
		GuiColorSetForNextWidget(gui, r, g, b, a)
		GuiImage( gui, new_id(), x, y, font.sprite_filepath, 1, scale_x, scale_x, 0, GUI_RECT_ANIMATION_PLAYBACK.PlayToEndAndPause, tostring(string.byte(char)) )
		--GuiLayoutEnd(gui)
	end
	GuiLayoutEnd(gui)
end
--[[
function draw_text( gui, font, text, color, x, y, scale_x, scale_y, alpha, horizontal_alignment, vertical_alignment )
	scale_x = scale_x or 1
	scale_y = scale_y or 1
	z_index = z_index or -1
	alpha = alpha or 1
	horizontal_alignment = horizontal_alignment or 0
	vertical_alignment = vertical_alignment or 0
	local a, r, g, b = hex2argb(color)
	local cx = x;
	local cy = y;
	local data = {};
	for i = 1, #text do
		local c = text:sub(i,i):upper();
		local spacing_before = 0;
		local spacing_after = font.character_spacing;
		local spacing = font.character_specific_spacing[c];
		if spacing ~= nil then
			spacing_before = spacing[1];
			spacing_after = spacing[2];
		end
		cx = cx + (spacing_before) * scale_x;
		--local s = draw_sprite( font.sprite_filepath, cx, cy, 0, 0, scale_x, scale_y, 0, alpha, emissive, z_index, c );
		--table.insert( sprites, s );
		table.insert( data, { rect_animation = c, x = cx, y = cy } );
		cx = cx + (font.character_width + spacing_after) * scale_x;
	end
	local offset_x = 0;
	local offset_y = 0;
	if horizontal_alignment ~= 0 or vertical_alignment ~= 0 then   
		offset_x = -( cx - x ) * horizontal_alignment;
		offset_y = -( font.character_height * scale_y ) * vertical_alignment;
	end
	GuiLayoutBeginHorizontal( gui, 0, 0, false, 0, 0 )
	for _,character in pairs( data or {} ) do
		--print(table.dump(data))
		GuiColorSetForNextWidget(gui, r, g, b, a)
		GuiImage( gui, new_id(), character.x + offset_x, character.y + offset_y, font.sprite_filepath, alpha, scale_x, scale_y, 0, GUI_RECT_ANIMATION_PLAYBACK.Loop, character.rect_animation );
	end
	GuiLayoutEnd(gui)
end
]]