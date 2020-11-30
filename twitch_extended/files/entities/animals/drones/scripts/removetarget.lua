dofile( "data/scripts/lib/utilities.lua" )
dofile( "mods/twitch_extended/files/entities/animals/drones/scripts/customutilities.lua" )

local theEntity = GetUpdatedEntityID()

if(EntityHasTag( theEntity, "homing_target" ))then
    EntityRemoveTag( theEntity, "homing_target")
end