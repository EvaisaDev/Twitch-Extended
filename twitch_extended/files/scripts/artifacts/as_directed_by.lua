local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )

for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 250, "player_projectile" ) or {} ) do
	if(EntityHasTag(entity, "extra_explosive") == false)then
		local projectileComponent = EntityGetFirstComponent(entity, "ProjectileComponent")		

		if(projectileComponent ~= nil)then

			ComponentSetValue(projectileComponent, "on_death_explode", "1")
			ComponentSetValue(projectileComponent, "on_collision_die", "1")
			ComponentSetValue(projectileComponent, "on_lifetime_out_explode", "1")
			ComponentObjectSetValue(projectileComponent, "config_explosion", "hole_enabled", 1)  
			ComponentObjectSetValue(projectileComponent, "config_explosion", "damage_mortals", 1)  
			ComponentObjectSetValue(projectileComponent, "config_explosion", "explosion_sprite", "data/particles/explosion_012.xml")  
			ComponentObjectSetValue(projectileComponent, "config_explosion", "explosion_sprite_lifetime", "0")  
			ComponentObjectSetValue(projectileComponent, "config_explosion", "load_this_entity", "data/entities/particles/particle_explosion/main_small.xml")  
			local value =  5
			local current_radius = tonumber(ComponentObjectGetValue(projectileComponent, "config_explosion", "explosion_radius"))
			if(tonumber(current_radius) < tonumber(value))then
				ComponentObjectSetValue(projectileComponent, "config_explosion", "explosion_radius", value)   
			end

			value = 2
			local current_damage = tonumber(ComponentObjectGetValue(projectileComponent, "config_explosion", "damage"))
			if(tonumber(current_damage) < tonumber(value))then
				ComponentObjectSetValue(projectileComponent, "config_explosion", "damage", value)   
			end

			value =  1.5
			local current_radius = tonumber(ComponentObjectGetValue(projectileComponent, "config_explosion", "explosion_radius"))
			ComponentObjectSetValue(projectileComponent, "config_explosion", "explosion_radius", tostring(current_radius * value))   

		end						
		EntityAddTag(entity, "extra_explosive")
	end
end