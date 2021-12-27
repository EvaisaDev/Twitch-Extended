dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

EntityLoad( "data/entities/misc/convert_radioactive_with_delay.xml", x,y )