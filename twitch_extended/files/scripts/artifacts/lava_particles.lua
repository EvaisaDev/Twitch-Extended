dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")

local entity_id = GetUpdatedEntityID()

local player = EntityGetParent(entity_id)

if(player == entity_id)then return end

local x, y, rot = EntityGetTransform( player )

local character_data = EntityGetFirstComponent( player, "CharacterDataComponent" );
if character_data ~= nil then
	local is_on_ground = ComponentGetValue2( character_data, "is_on_ground" );
	if is_on_ground == true then
		GameCreateParticle( "spark_lava_1", x + Random(-3, 3), y + 4, 1, Random(-10, 10), Random(-10, 0), true )
		GameCreateParticle( "spark_lava_2", x + Random(-3, 3), y + 4, 1, Random(-10, 10), Random(-10, 0), true )
		GameCreateParticle( "spark_lava_3", x + Random(-3, 3), y + 4, 1, Random(-10, 10), Random(-10, 0), true )
	end
end