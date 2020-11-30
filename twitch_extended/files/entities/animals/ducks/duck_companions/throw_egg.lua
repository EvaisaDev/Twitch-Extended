dofile( "mods/twitch_extended/files/entities/animals/ducks/duck_companions/utilities.lua" )
dofile( "data/scripts/lib/utilities.lua" )

local theEntity = GetUpdatedEntityID()

local x, y = EntityGetTransform( theEntity )

local closestEntity = get_closest_enemy_in_range(theEntity, x, y, 100)	

if(closestEntity ~= nil)then
	shoot_at_entity(theEntity, closestEntity, 1, 0, 3, 200, "mods/twitch_extended/files/entities/animals/ducks/duck_companions/eggshot.xml", 15)
end