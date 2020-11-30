dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()

local timeleft = 0
local formatting_string = ""
local comps = EntityGetComponent( entity_id, "VariableStorageComponent" )
if ( comps ~= nil ) then
	for i,v in ipairs( comps ) do
		local n = ComponentGetValue2( v, "name" )
		if ( n == "lifetime" ) then
			timeleft = ComponentGetValue2( v, "value_int" )
			timeleft = math.max( timeleft - 1, 0 )
			ComponentSetValue2( v, "value_int", timeleft )
		elseif( n == "formatting")then
			formatting_string = ComponentGetValue2( v, "value_string")
		end
	end
end

local s = math.floor( timeleft / 60 )
local ms = timeleft % 60

local stext = tostring(s)
local mstext = string.sub( "00" .. tostring(ms), -2)

local final = GameTextGet( "$format_timer", stext, mstext )

if(formatting_string ~= "")then
	final = GameTextGetTranslatedOrNot(formatting_string):gsub("$0", final)
end

edit_component( entity_id, "SpriteComponent", function(comp,vars)
	vars.text = final
	vars.offset_x = string.len(final)*1.9
	EntityRefreshSprite( entity_id, comp )
end)