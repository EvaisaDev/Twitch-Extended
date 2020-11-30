local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )

for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 40, "homing_target" ) or {} ) do
	damage_model = EntityGetFirstComponent(entity, "DamageModelComponent")
	max_hp = ComponentGetValue2(damage_model, "max_hp")

	damage = 0.1 + max_hp / 50

	ent_x, ent_y = EntityGetTransform(entity)
	EntityInflictDamage( entity, damage, "DAMAGE_MELEE", "Damage Field", "NORMAL", 0, 0, entity_id, ent_x, ent_y, 0)
end