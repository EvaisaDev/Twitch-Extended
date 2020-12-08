
run_modifiers = {
	{
		id = "TWITCH_EXTENDED_ARTIFACT_AS_DIRECTED_BY",
		ui_name = "$twitch_extended_artifact_as_directed_by",
		ui_description = "$twitch_extended_artifact_as_directed_by_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/as_directed_by.xml", x, y )
                EntityAddChild( entity_id, effect_id )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_BASTION",
		ui_name = "$twitch_extended_artifact_bastion",
		ui_description = "$twitch_extended_artifact_bastion_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/bastion.xml", x, y )
                EntityAddChild( entity_id, effect_id )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_BATTLE_ROYALE",
		ui_name = "$twitch_extended_artifact_battle_royale",
		ui_description = "$twitch_extended_artifact_battle_royale_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			local world_entity_id = GameGetWorldStateEntity()
			if not world_entity_id then return end
			local comp_worldstate = EntityGetFirstComponent(world_entity_id, "WorldStateComponent")
			if not comp_worldstate then return end
			local global_genome = ComponentGetValue(comp_worldstate, "global_genome_relations_modifier")
			ComponentSetValue(comp_worldstate, "global_genome_relations_modifier", "-200")
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_BRITTLE_GROUND",
		ui_name = "$twitch_extended_artifact_brittle_ground",
		ui_description = "$twitch_extended_artifact_brittle_ground_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/brittle_ground.xml", x, y )
                EntityAddChild( entity_id, effect_id )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_CHAMPIONS_ONLY",
		ui_name = "$twitch_extended_artifact_champions_only",
		ui_description = "$twitch_extended_artifact_champions_only_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "gokis_things_enabled",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/champions_only.xml", x, y )
                EntityAddChild( entity_id, effect_id )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_DRUNKARD",
		ui_name = "$twitch_extended_artifact_drunkard",
		ui_description = "$twitch_extended_artifact_drunkard_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/drunkard.xml", x, y )
                EntityAddChild( entity_id, effect_id )
            end
		end,
	},
	--[[
	{
		id = "TWITCH_EXTENDED_ARTIFACT_FALL_DAMAGE",
		ui_name = "$twitch_extended_artifact_fall_damage",
		ui_description = "$twitch_extended_artifact_fall_damage_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
				local chardatacomp = EntityGetComponent(entity_id, "DamageModelComponent")
				for _, charmodel in ipairs(chardatacomp or {}) do
					ComponentSetValue2(charmodel, "falling_damage_damage_max", 1.75 )
					ComponentSetValue2(charmodel, "falling_damage_damage_min", 0.05 )
					ComponentSetValue2(charmodel, "falling_damage_height_max", 450 )
					ComponentSetValue2(charmodel, "falling_damage_height_min", 80 )
					ComponentSetValue2(charmodel, "falling_damages", true )
				end
            end
		end,
	},
	]]
	{
		id = "TWITCH_EXTENDED_ARTIFACT_FLOOR_IS_LAVA",
		ui_name = "$twitch_extended_artifact_floor_is_lava",
		ui_description = "$twitch_extended_artifact_floor_is_lava_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
				local character_data = EntityGetFirstComponent( entity_id, "CharacterDataComponent" );
				if character_data ~= nil then
					ComponentSetValue( character_data, "flying_needs_recharge", "0" );
				end

                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/floor_is_lava.xml", x, y )
                EntityAddChild( entity_id, effect_id )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_GAMBLER",
		ui_name = "$twitch_extended_artifact_gambler",
		ui_description = "$twitch_extended_artifact_gambler_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			GameAddFlagRun("hidden_perks")
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_GLASS_CANNON",
		ui_name = "$twitch_extended_artifact_glass_cannon",
		ui_description = "$twitch_extended_artifact_glass_cannon_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )

                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/glass_cannon.xml", x, y )
                EntityAddChild( entity_id, effect_id )
           
				local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
				if( damagemodels ~= nil ) then
					for i,damagemodel in ipairs(damagemodels) do
						local old_hp = tonumber( ComponentGetValue2( damagemodel, "max_hp" ) )
						local max_hp = old_hp / 2
						
						--ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
						ComponentSetValue2( damagemodel, "max_hp", max_hp )
					--	ComponentSetValue2( damagemodel, "max_hp_cap", max_hp )
						ComponentSetValue2( damagemodel, "hp", max_hp )
					end
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_HEALTH_INSURANCE",
		ui_name = "$twitch_extended_artifact_health_insurance",
		ui_description = "$twitch_extended_artifact_health_insurance_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )

				EntityAddComponent( entity_id, "LuaComponent", {
					execute_every_n_frame="-1",
					script_damage_received="mods/twitch_extended/files/scripts/artifacts/health_insurance.lua",
				});
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_HIGH_GRAVITY",
		ui_name = "$twitch_extended_artifact_high_gravity",
		ui_description = "$twitch_extended_artifact_high_gravity_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			set_gravity(900)
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_INFESTATION",
		ui_name = "$twitch_extended_artifact_infestation",
		ui_description = "$twitch_extended_artifact_infestation_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
				EntityAddComponent( entity_id, "LuaComponent", 
				{ 
					script_source_file = "mods/twitch_extended/files/scripts/artifacts/infestation.lua",
					execute_every_n_frame = "20",
				} )
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_IRON_ROBE",
		ui_name = "$twitch_extended_artifact_iron_robe",
		ui_description = "$twitch_extended_artifact_iron_robe_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			damage_types = {"ice","electricity","radioactive","slice","projectile","healing","physics_hit","explosion","poison","melee","drill","fire"}

			for i,entity_id in pairs( get_players() ) do
				local damage_models = EntityGetComponent( entity_id, "DamageModelComponent" );
				if damage_models ~= nil then
					for index,damage_model in pairs( damage_models ) do
						for k, damage_type in pairs( damage_types ) do
							local resistance = ComponentObjectGetValue2( damage_model, "damage_multipliers", damage_type )
							resistance = resistance / 2

							ComponentObjectSetValue2( damage_model, "damage_multipliers", damage_type, resistance );
						end
					end
				end

				local platformingcomponents = EntityGetComponent( entity_id, "CharacterPlatformingComponent" )
				if( platformingcomponents ~= nil ) then
					for i,component in ipairs(platformingcomponents) do
						local run_speed = ComponentGetValue2( component, "run_velocity" )  / 1.25
						local vel_x = math.abs( ComponentGetValue2( component, "velocity_max_x" )  ) / 1.25
		
						local vel_x_min = -vel_x
						local vel_x_max = vel_x
						
						ComponentSetValue2( component, "run_velocity", run_speed )
						ComponentSetValue2( component, "velocity_min_x", vel_x_min )
						ComponentSetValue2( component, "velocity_max_x", vel_x_max )
						ComponentSetValue2( component, "fly_speed_max_up", 75)	
					end
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_JETPACK_ENEMIES",
		ui_name = "$twitch_extended_artifact_jetpack_enemies",
		ui_description = "$twitch_extended_artifact_jetpack_enemies_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/jetpack_enemies.xml", x, y )
                EntityAddChild( entity_id, effect_id )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_JUMP_KING",
		ui_name = "$twitch_extended_artifact_jump_king",
		ui_description = "$twitch_extended_artifact_jump_king_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
				local CharacterDataComponent = EntityGetComponent( entity_id, "CharacterDataComponent" )
				if( CharacterDataComponent ~= nil ) then
					for i,component in ipairs(CharacterDataComponent) do
						ComponentSetValue2( component, "fly_time_max", 0.1)
						ComponentSetValue2( component, "flying_in_air_wait_frames", 55)
						ComponentSetValue2( component, "flying_recharge_removal_frames", 55)
					end
				end
				
				local platformingcomponents = EntityGetComponent( entity_id, "CharacterPlatformingComponent" )
				if( platformingcomponents ~= nil ) then
					for i,component in ipairs(platformingcomponents) do
						ComponentSetValue2( component, "run_velocity", 200 )
						ComponentSetValue2( component, "fly_velocity_x", 300 )
						ComponentSetValue2( component, "accel_x_air", 0.1 )
						ComponentSetValue2( component, "jump_velocity_y", -140)	
						ComponentSetValue2( component, "jump_velocity_x", 75)	
						ComponentSetValue2( component, "fly_speed_max_up", 140)
						ComponentSetValue2( component, "fly_speed_max_down", 0)
						ComponentSetValue2( component, "fly_speed_mult", 50)
						ComponentSetValue2( component, "fly_speed_change_spd", 100)
						
					end
				end

				EntityAddComponent2( entity_id, "LuaComponent",
				{
					execute_every_n_frame=1,	
				    script_source_file="mods/twitch_extended/files/scripts/misc/jump_script.lua"
				})		
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_SHIELDED_ENEMIES",
		ui_name = "$twitch_extended_artifact_shielded_enemies",
		ui_description = "$twitch_extended_artifact_shielded_enemies_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/shielded_enemies.xml", x, y )
                EntityAddChild( entity_id, effect_id )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_SQUIRT_GUN",
		ui_name = "$twitch_extended_artifact_squirt_gun",
		ui_description = "$twitch_extended_artifact_squirt_gun_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/squirt_gun.xml", x, y )
                EntityAddChild( entity_id, effect_id )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_STONE_SKIN",
		ui_name = "$twitch_extended_artifact_stone_skin",
		ui_description = "$twitch_extended_artifact_stone_skin_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
				local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
				if( damagemodels ~= nil ) then
					for i,damagemodel in ipairs(damagemodels) do
						ComponentSetValue2( damagemodel, "hp", 250 / 25 )
						ComponentSetValue2( damagemodel, "max_hp", 250 / 25 )
					end
				end	
				local models = EntityGetComponent( entity_id, "CharacterPlatformingComponent" )
				if( models ~= nil ) then
					for i,model in ipairs(models) do
						local swim_idle = -3
						local swim_up = -1
						local swim_down = 1.2
						
						local swim_drag = 0.8
						local swim_drag_extra = 0.7
						
						ComponentSetValue2( model, "swim_idle_buoyancy_coeff", swim_idle )
						ComponentSetValue2( model, "swim_up_buoyancy_coeff", swim_up )
						ComponentSetValue2( model, "swim_down_buoyancy_coeff", swim_down )
						
						ComponentSetValue2( model, "swim_drag", swim_drag )
						ComponentSetValue2( model, "swim_extra_horizontal_drag", swim_drag_extra )
					end
				end
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_SUPPLY_AND_DEMAND",
		ui_name = "$twitch_extended_artifact_supply_and_demand",
		ui_description = "$twitch_extended_artifact_supply_and_demand_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			GlobalsSetValue( "TEMPLE_PERK_COUNT", "1" )
			GameAddFlagRun( "cheap_shops" )
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_TWINKLE_TOES",
		ui_name = "$twitch_extended_artifact_twinkle_toes",
		ui_description = "$twitch_extended_artifact_twinkle_toes_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
				local CharacterDataComponent = EntityGetComponent( entity_id, "CharacterDataComponent" )
				if( CharacterDataComponent ~= nil ) then
					for i,component in ipairs(CharacterDataComponent) do
						ComponentSetMetaCustom( component, "fly_time_max", 1.5)
					end
				end
				
				local platformingcomponents = EntityGetComponent( entity_id, "CharacterPlatformingComponent" )
				if( platformingcomponents ~= nil ) then
					for i,component in ipairs(platformingcomponents) do
						local run_speed = tonumber( ComponentGetMetaCustom( component, "run_velocity" ) ) * 1.8
						local vel_x = math.abs( tonumber( ComponentGetMetaCustom( component, "velocity_max_x" ) ) ) * 1.8
		
						local vel_x_min = 0 - vel_x
						local vel_x_max = vel_x
						
						ComponentSetMetaCustom( component, "run_velocity", run_speed )
						ComponentSetMetaCustom( component, "velocity_min_x", vel_x_min )
						ComponentSetMetaCustom( component, "velocity_max_x", vel_x_max )	
					end
				end		
				set_gravity(150)
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ARTIFACT_WEIGHTLESS_BULLETS",
		ui_name = "$twitch_extended_artifact_weightless_bullets",
		ui_description = "$twitch_extended_artifact_weightless_bullets_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		required_flag = "",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/artifacts/weightless_bullets.xml", x, y )
                EntityAddChild( entity_id, effect_id )
            end
		end,
	},
};
