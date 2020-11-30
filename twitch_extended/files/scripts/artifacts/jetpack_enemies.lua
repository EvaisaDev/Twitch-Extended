local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )

for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 500, "enemy" ) or {} ) do
	if(EntityHasTag(entity, "has_jetpack")  == false)then
		local animal_ais = EntityGetComponent( entity, "AnimalAIComponent" )
		for _, ai in pairs(animal_ais or {}) do
			ComponentSetValue2(ai, "can_fly", true)
		end
		local path_finding = EntityGetFirstComponent( entity, "PathFindingComponent" );
		if path_finding then
			ComponentSetValue2(path_finding, "can_fly", true)
		end

		local jetpack_particles = EntityAddComponent2( entity, "ParticleEmitterComponent", {
			_tags="jetpack",
			emitted_material_name="rocket_particles",
			x_pos_offset_min=-1,
			x_pos_offset_max=1,
			y_pos_offset_min=0,
			y_pos_offset_max=0,
			x_vel_min=-7,
			x_vel_max=7,
			y_vel_min=80,
			y_vel_max=180,
			count_min=3,
			count_max=7,
			lifetime_min=0.1,
			lifetime_max=0.2,
			create_real_particles=false,
			emit_cosmetic_particles=true,
			emission_interval_min_frames=0,
			emission_interval_max_frames=1,
			is_emitting=true,
		})
		EntityAddTag(entity, "has_jetpack")
	end
end