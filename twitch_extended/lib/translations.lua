function register_localizations(translation_file)
    local loc_content = ModTextFileGetContent("data/translations/common.csv") -- Gets the original translations of the game

	local append_content = ModTextFileGetContent(translation_file) -- Gets my own translations file

	local i = 0
	lines = {}
	for s in append_content:gmatch("[^\r\n]+") do
		i = i + 1
		if(i ~= 1)then
			table.insert(lines, s)
		end
	end

	for k, v in pairs(lines)do
		if(k ~= 1)then
			loc_content = loc_content .. string.char(10) .. v
		else
			loc_content = loc_content .. v
		end
	end

	ModTextFileSetContent("data/translations/common.csv", loc_content)
end