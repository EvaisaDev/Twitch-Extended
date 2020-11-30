dofile( "mods/twitch_extended/files/entities/animals/drones/scripts/customutilities.lua" )
dofile( "data/scripts/lib/utilities.lua" )

local theEntity = GetUpdatedEntityID()

local x, y = EntityGetTransform( theEntity )

local closestEntity = get_players()[1]
local damageComponent = EntityGetFirstComponent( closestEntity, "DamageModelComponent" )


if(closestEntity ~= nil)then
	local currentHP = tonumber(ComponentGetValue( damageComponent, "hp" ))
	local maxHP = tonumber(ComponentGetValue( damageComponent, "max_hp" ))
	if(currentHP < maxHP)then
		shoot_at_entity(theEntity, closestEntity, 1, 0, 3, 2000, "mods/twitch_extended/files/entities/animals/drones/projectiles/heal_bullet.xml", 50)
	end
end