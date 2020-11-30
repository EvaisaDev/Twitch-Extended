local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )

for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 20, "player_unit" ) or {} ) do
	ent_x, ent_y = EntityGetTransform(entity)
	effect = EntityLoad("mods/twitch_extended/files/entities/animals/glitch/effect_twitchy.xml", ent_x, ent_y)
	EntityAddChild(entity, effect)
end