dofile( "mods/twitch_extended/files/entities/animals/drones/scripts/customutilities.lua" )
dofile( "data/scripts/lib/utilities.lua" )

local theEntity = GetUpdatedEntityID()

local x, y = EntityGetTransform( theEntity )

local closestEntity = get_closest_enemy_in_range(theEntity, x, y, 200)	

if(closestEntity ~= nil)then
	shoot_at_entity(theEntity, closestEntity, 1, 0, 3, 2000, "mods/twitch_extended/files/entities/animals/drones/projectiles/missile.xml", 15)
end