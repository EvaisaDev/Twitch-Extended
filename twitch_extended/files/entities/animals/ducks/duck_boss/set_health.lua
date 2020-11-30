dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local player = get_players()[1]

local duckHealthComponent = EntityGetFirstComponent(entity_id, "DamageModelComponent")
local playerHealthComponent = EntityGetFirstComponent(player, "DamageModelComponent")

if(duckHealthComponent ~= nil and playerHealthComponent ~= nil)then
	local player_hp = ComponentGetValue2(playerHealthComponent, "max_hp")
	
	ComponentSetValue2(duckHealthComponent, "max_hp", 20+tonumber(player_hp))
end	