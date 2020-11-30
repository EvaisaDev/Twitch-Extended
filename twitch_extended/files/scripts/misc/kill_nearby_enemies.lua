local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )

for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 50, "enemy" ) or {} ) do
	damage_model = EntityGetFirstComponent(entity, "DamageModelComponent")
	hp = ComponentGetValue2(damage_model, "hp")

	EntityInflictDamage( entity, hp, "DAMAGE_PROJECTILE", "gold_transformation", "NORMAL", 0, 0, entity, x, y, 0)
end