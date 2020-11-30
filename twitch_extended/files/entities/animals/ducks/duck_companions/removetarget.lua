dofile( "data/scripts/lib/utilities.lua" )

function get_player()
    return EntityGetWithTag( "player_unit" )[1]
end

local theEntity = GetUpdatedEntityID()

if(EntityHasTag( theEntity, "homing_target" ))then
    EntityRemoveTag( theEntity, "homing_target")
end






--[[
genome = EntityGetFirstComponent(theEntity, "GenomeDataComponent")

if(genome ~= nil and genome ~= 0)then
    ComponentSetValue2(genome, "herd_id", StringToHerdId("player"))
end
]]