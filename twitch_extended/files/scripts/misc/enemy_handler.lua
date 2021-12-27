dofile_once("mods/twitch_extended/files/scripts/utils/special_utils.lua")

local entity_id = GetUpdatedEntityID()


if(entity_id == nil or entity_id == 0)then
	return
end

local parent_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform(entity_id)

if(parent_id == entity_id)then return end


if(EntityHasTag(parent_id, "player_unit"))then
	return
end


dofile("data/scripts/gun/gunaction_generated.lua")



c = {}

c_defaults = {}
ConfigGunActionInfo_Init(c_defaults)

for i, comp in ipairs(EntityGetComponent(entity_id, "VariableStorageComponent") or {}) do
	name = ComponentGetValue2(comp, "name")
	value = ComponentGetValue2(comp, "value_string")

	c[name] = value
end


--print(table.dump(c))


if not EntityHasFlag(parent_id, "modified_potion"..EntityGetName(entity_id)) then
	EntityAddFlag(parent_id, "modified_potion"..EntityGetName(entity_id))
	
	if tonumber(c.fire_rate_wait) > 0 and tonumber(c.reload_time) > 0 then
		attack_speed_adjust = math.max(c.fire_rate_wait, c.reload_time)
	elseif tonumber(c.fire_rate_wait) < 0 and tonumber(c.reload_time) < 0 then
		attack_speed_adjust = math.min(c.fire_rate_wait, c.reload_time)
	else
		attack_speed_adjust = c.fire_rate_wait + c.reload_time
	end
	
	for i, animal_ai_comp in ipairs(EntityGetComponent(parent_id, "AnimalAIComponent") or {}) do
		default_attack_speed = ComponentGetValue2(animal_ai_comp, "attack_ranged_frames_between")
		ComponentSetValue2(animal_ai_comp, "attack_ranged_frames_between", default_attack_speed + attack_speed_adjust)
	end

	for i, ai_attack_comp in ipairs(EntityGetComponent(parent_id, "AIAttackComponent") or {}) do
		default_attack_speed = ComponentGetValue2(ai_attack_comp, "frames_between")
		ComponentSetValue2(ai_attack_comp, "frames_between", default_attack_speed + attack_speed_adjust)
		ComponentSetValue2(ai_attack_comp, "frames_between_global", default_attack_speed + attack_speed_adjust)
	end
end


local projectiles = EntityGetInRadiusWithTag( x, y, 50, "projectile" )

if ( #projectiles > 0 ) then
	for i,projectile_id in ipairs( projectiles ) do

		if EntityHasFlag(projectile_id, "modified_potion"..EntityGetName(entity_id)..parent_id) == false and EntityHasTag(projectile_id, "shot_from_projectile") == false then

			

			projectile_component = EntityGetFirstComponent(projectile_id, "ProjectileComponent")
			sprite_component = EntityGetFirstComponent(projectile_id, "SpriteComponent")
			velocity_component = EntityGetFirstComponent(projectile_id, "VelocityComponent")

			if(projectile_component ~= nil)then
				local who_shot = ComponentGetValue2( projectile_component, "mWhoShot" )

				--print(who_shot)
				

				if(who_shot == parent_id and EntityGetVariable(entity_id, "in_air", "bool") ~= nil)then
					--print("that one worked.")

					if(c.extra_entities ~= c_defaults.extra_entities)then
						for entity in string.gmatch(c.extra_entities, '([^,]+)') do
							EntityLoadToEntity( entity, projectile_id )

						end
					end

					if(c.game_effect_entities ~= c_defaults.game_effect_entities)then
						for entity in string.gmatch(c.game_effect_entities, '([^,]+)') do
							LoadGameEffectEntityTo( projectile_id, entity )
						end
					end
					
					--Ordered alphabetically below
	
					for i,area_damage_component in ipairs(EntityGetComponent(projectile_id, "AreaDamageComponent") or {}) do
						if ComponentGetValue2(area_damage_component, "entities_with_tag") == "homing_target" then
							ComponentSetValue2(area_damage_component, "entities_with_tag", "prey")
						end
					end	
					
					if(c.bounces ~= c_defaults.bounces)then
						if(projectile_component ~= nil)then
							default_bounces = ComponentGetValue2(projectile_component, "bounces_left")
							ComponentSetValue2(projectile_component, "bounces_left", default_bounces + c.bounces)
						end
					end

					if(c.damage_electricity_add ~= c_defaults.damage_electricity_add)then
						if(projectile_component ~= nil)then
							default_damage_electricity_add = ComponentObjectGetValue2(projectile_component, "damage_by_type", "electricity")
							ComponentObjectSetValue2(projectile_component, "damage_by_type", "electricity", default_damage_electricity_add + c.damage_electricity_add)
						end
					end
					
					if(c.damage_explosion_add ~= c_defaults.damage_explosion_add)then
						if(projectile_component ~= nil)then
							default_damage_explosion_add = ComponentObjectGetValue2(projectile_component, "config_explosion", "damage")
							ComponentObjectSetValue2(projectile_component, "config_explosion", "damage", default_damage_explosion_add + c.damage_explosion_add)
						end
					end

					if(c.damage_fire_add ~= c_defaults.damage_fire_add)then
						if(projectile_component ~= nil)then
							default_damage_fire_add = ComponentObjectGetValue2(projectile_component, "damage_by_type", "fire")
							ComponentObjectSetValue2(projectile_component, "damage_by_type", "fire", default_damage_fire_add + c.damage_fire_add)
						end
					end

					if(c.damage_melee_add ~= c_defaults.damage_melee_add)then
						if(projectile_component ~= nil)then
							default_damage_melee_add = ComponentObjectGetValue2(projectile_component, "damage_by_type", "melee")
							ComponentObjectSetValue2(projectile_component, "damage_by_type", "melee", default_damage_melee_add + c.damage_melee_add)
						end
					end

					if(c.damage_projectile_add ~= c_defaults.damage_projectile_add)then
						if(projectile_component ~= nil)then
							default_damage_projectile_add = ComponentGetValue2(projectile_component, "damage")
							ComponentSetValue2(projectile_component, "damage", default_damage_projectile_add + c.damage_projectile_add)
						end
					end

					if(c.explosion_radius ~= c_defaults.explosion_radius)then
						if(projectile_component ~= nil)then
							default_explosion_radius = ComponentObjectGetValue2(projectile_component, "config_explosion", "explosion_radius")
							ComponentObjectSetValue2(projectile_component, "config_explosion", "explosion_radius", default_explosion_radius + c.explosion_radius)
						end
					end
					
					if(c.friendly_fire ~= c_defaults.friendly_fire)then
						if(projectile_component ~= nil)then
							value = false
							if(c.friendly_fire == "1")then
								value = true
							end
							ComponentSetValue2(projectile_component, "friendly_fire", value)
						end
					end
					
					for i,homing_component in ipairs(EntityGetComponent(projectile_id, "HomingComponent") or {}) do
						if ComponentGetValue2(homing_component, "target_tag") == "homing_target" then
							ComponentSetValue2(homing_component, "target_tag", "prey")
						end
					end

					if(c.knockback_force ~= c_defaults.knockback_force)then
						if(projectile_component ~= nil)then
							default_knockback_force = ComponentGetValue2(projectile_component, "knockback_force")
							ComponentSetValue2(projectile_component, "knockback_force", default_knockback_force + c.knockback_force)
						end
					end

					if(c.lifetime_add ~= c_defaults.lifetime_add)then
						if(projectile_component ~= nil)then
							default_lifetime_add = ComponentGetValue2(projectile_component, "lifetime")
							if default_lifetime_add >= 0 then
								ComponentSetValue2(projectile_component, "lifetime", math.max(0, default_lifetime_add + c.lifetime_add))
							end
						end
					end

					if(c.speed_multiplier ~= c_defaults.speed_multiplier)then
						vel_x, vel_y = ComponentGetValue2(velocity_component, "mVelocity")
						if(velocity_component ~= nil)then
							ComponentSetValue2(velocity_component, "mVelocity", vel_x * c.speed_multiplier, vel_y * c.speed_multiplier)
						end
					end

					if(c.sprite ~= c_defaults.sprite)then
						if(sprite_component ~= nil)then
							ComponentSetValue2(sprite_component, "image_file", c.sprite)
							EntityRefreshSprite(projectile_id, sprite_component)
						end
					end
					
					if(c.trail_material ~= c_defaults.trail_material)then
						for material in string.gmatch(c.trail_material, '([^,]+)') do
							EntityAddComponent2(projectile_id, "ParticleEmitterComponent", {
								airflow_force=0,
								airflow_scale=1,
								airflow_time=1,
								area_circle_sector_degrees=360,
								attractor_force=0,
								b2_force=0,
								collide_with_gas_and_fire=true,
								collide_with_grid=true,
								color=0,
								cosmetic_force_create=true,
								count_max=c.trail_material_amount + 3,
								count_min=c.trail_material_amount + 1,
								create_real_particles=false,
								delay_frames=0,
								direction_random_deg=0,
								draw_as_long=true,
								emission_chance=100,
								emission_interval_max_frames=0,
								emission_interval_min_frames=0,
								emit_cosmetic_particles=false,
								emit_real_particles=true,
								emitted_material_name=material,
								emitter_lifetime_frames=-1,
								fade_based_on_lifetime=false,
								fire_cells_dont_ignite_damagemodel=false,
								friction=0,
								image_animation_colors_file="",
								image_animation_emission_probability=1,
								image_animation_file="",
								image_animation_loop=true, 
								image_animation_phase=0, 
								image_animation_raytrace_from_center=false, 
								image_animation_speed=1, 
								image_animation_use_entity_rotation=false, 
								is_emitting=true, 
								is_trail=true, 
								lifetime_max=10, 
								lifetime_min=5, 
								particle_single_width=true, 
								render_back=true, 
								render_on_grid=false, 
								set_magic_creation=false, 
								trail_gap=0, 
								use_material_inventory=false, 
								velocity_always_away_from_center=0, 
								x_pos_offset_max=2.23607, 
								x_pos_offset_min=-2.23607, 
								x_vel_max=0, 
								x_vel_min=0, 
								y_pos_offset_max=2.23607, 
								y_pos_offset_min=-2.23607, 
								y_vel_max=0, 
								y_vel_min=0,
							})
						end
					end
				end
			end

			EntityAddFlag(projectile_id, "modified_potion"..EntityGetName(entity_id)..parent_id)
			
			--[[
			
			local projectilecomponents = EntityGetComponent( projectile_id, "ProjectileComponent" )

			if ( projectilecomponents ~= nil ) then





				
				for j,comp_id in ipairs( projectilecomponents ) do
					local who_shot = ComponentGetValue2( comp_id, "mWhoShot" )

					
					if(who_shot == parent_id)then
					
						
						for k, v in pairs(c)do
							--print(k)
							for k2, v2 in pairs(ComponentObjectGetMembers( comp_id, "config" ))do
								--print(k2.."=="..k)
								if(k2 == k)then
									ComponentObjectSetValue(comp_id, "config", k, v)
									--print(k.." = "..v)
								end
							end
						end
					end
				end
			end
			]]

		end
	end
end
EntitySetVariable(entity_id, "in_air", "bool", true)