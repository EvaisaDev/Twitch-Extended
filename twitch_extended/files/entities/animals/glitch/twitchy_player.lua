local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )

for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 20, "player_unit" ) or {} ) do
	ent_x, ent_y = EntityGetTransform(entity)
	twitch_effect = EntityGetWithName( "glitch_twitchy_effect" )
	if twitch_effect == nil or twitch_effect == 0 then
		effect = EntityLoad("mods/twitch_extended/files/entities/animals/glitch/effect_twitchy.xml", ent_x, ent_y)
		EntityAddChild(entity, effect)
	else
		lifetime = EntityGetFirstComponent(twitch_effect, "LifetimeComponent")
		ComponentSetValue2(lifetime, "kill_frame", GameGetFrameNum() + 60)
	end
end