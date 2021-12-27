local old_shoot_projectile_from_projectile = shoot_projectile_from_projectile
shoot_projectile_from_projectile = function( who_shot, entity_file, x, y, vel_x, vel_y, send_message )
	projectile = old_shoot_projectile_from_projectile( who_shot, entity_file, x, y, vel_x, vel_y, send_message )
	EntityAddTag(projectile, "shot_from_projectile")
	return projectile
end