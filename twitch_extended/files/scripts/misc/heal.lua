local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity( entity_id )

x, y = EntityGetTransform(entity_id)

EntityInflictDamage( entity_id, -0.01, "DAMAGE_HEALING", "healing", "NONE", 0, 0, entity_id, x, y, 0 )