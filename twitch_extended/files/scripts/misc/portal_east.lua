dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
pos_x = pos_x + 512 * 70
local teleport_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "TeleportComponent" )


-- go to east biomes




ComponentSetValue2(teleport_comp, "target", pos_x, pos_y)

-- make sure teleporter doesn't work before it's initialized here
EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_script", true )
