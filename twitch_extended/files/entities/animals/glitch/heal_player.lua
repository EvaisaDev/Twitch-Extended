local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )

for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 20, "player_unit" ) or {} ) do
	damage_model = EntityGetFirstComponent(entity, "DamageModelComponent")
	hp = ComponentGetValue2(damage_model, "hp")
	max_hp = ComponentGetValue2(damage_model, "max_hp")
	if(hp < max_hp)then
		ent_x, ent_y = EntityGetTransform(entity)
		EntityInflictDamage( entity, -0.025, "DAMAGE_HEALING", "Healing", "NONE", 0, 0, entity_id, ent_x, ent_y, 0)
		effect = EntityLoad("mods/twitch_extended/files/entities/particles/heal_effect.xml", ent_x, ent_y)
		EntityAddChild(entity, effect)
	end
end