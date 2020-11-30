dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")

local entity_id = GetUpdatedEntityID()

local player = EntityGetParent(entity_id)

if(player == entity_id)then return end

local x, y, rot = EntityGetTransform( player )

local character_data = EntityGetFirstComponent( player, "CharacterDataComponent" );
if character_data ~= nil then
	local is_on_ground = ComponentGetValue2( character_data, "is_on_ground" );
	if is_on_ground == true then
		local ground_time = EntityGetVariable(entity_id, "ground_time", "number") or 2

		ground_time = ground_time - 1

		--GameCreateParticle( "lava", x, y, 20, Random(-10, 10), Random(-10, 0), true )
		--GamePrint(ground_time)
		if(ground_time > 0)then
			
			EntitySetVariable(entity_id, "ground_time", ground_time)
		else
			EntityInflictDamage( player, 0.075, "DAMAGE_PROJECTILE", "floor made of lava", "NORMAL", 0, 0, player, x, y, 0)
		end
	else
		EntitySetVariable(entity_id, "ground_time", 2)
	end
end