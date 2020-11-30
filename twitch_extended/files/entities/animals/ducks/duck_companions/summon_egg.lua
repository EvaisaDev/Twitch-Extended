dofile( "data/scripts/lib/utilities.lua" )

local theEntity = GetUpdatedEntityID()

local x, y = EntityGetTransform( theEntity )

local closestEntity = get_players()[1]
local damageComponent = EntityGetFirstComponent( closestEntity, "DamageModelComponent" )


if(closestEntity ~= nil)then
	local currentHP = tonumber(ComponentGetValue( damageComponent, "hp" ))
	local maxHP = tonumber(ComponentGetValue( damageComponent, "max_hp" ))
	if(currentHP < maxHP)then
		EntityLoad("mods/twitch_extended/files/entities/animals/ducks/duck_companions/healing_egg.xml", x, y)
	end
end