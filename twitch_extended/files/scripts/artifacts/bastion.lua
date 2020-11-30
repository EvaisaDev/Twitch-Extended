dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once("data/scripts/lib/utilities.lua")

base_damage = {}
damage_types = {"ice","electricity","radioactive","slice","projectile","healing","physics_hit","explosion","poison","melee","drill","fire"}


for _,player_entity in pairs( get_players() ) do
	local x, y = EntityGetTransform( player_entity );
	local component = EntityGetFirstComponent(player_entity, "CharacterDataComponent")

	local velx, vely = ComponentGetValue2(component, "mVelocity")
	local average_velocity = (velx + vely) / 2
	--GamePrint(average_velocity)
	if(average_velocity > 29 and average_velocity < 31)then
		if(EntityHasTag(player_entity, "not_shielded"))then
			EntityRemoveTag(player_entity, "not_shielded")
			
			local damage_models = EntityGetComponent( player_entity, "DamageModelComponent" );
			if damage_models ~= nil then
				for index,damage_model in pairs( damage_models ) do
					for k, damage_type in pairs( damage_types ) do
						local resistance = ComponentObjectGetValue2( damage_model, "damage_multipliers", damage_type )
						resistance = resistance / 2

						if(EntityHasTag(player_entity, "divide_twice"))then
							resistance = resistance / 2
							
							EntityRemoveTag(player_entity, "divide_twice")
						end

						EntityAddTag(player_entity, "multiply_twice")
						ComponentObjectSetValue2( damage_model, "damage_multipliers", damage_type, resistance );
						--ComponentObjectSetValue2( damage_model, "damage_multipliers", damage_type, resistance );
						
					end
				end
			end
			--GamePrint("Modified damage 1")

			children = EntityGetAllChildren( player_entity ) 
			has_shield = false
			for k, v in pairs(children)do
				if(EntityHasTag(v, "bastion_shield"))then
					has_shield = true
				end
			end

			if(has_shield == false)then
				shield_entity = EntityLoad( "mods/twitch_extended/files/entities/misc/shield.xml", x, y );

				EntityAddChild( player_entity, shield_entity )					
			end
		end
	else	
		if(EntityHasTag(player_entity, "not_shielded") ~= true)then
			

			local damage_models = EntityGetComponent( player_entity, "DamageModelComponent" );
			if damage_models ~= nil then
				for index,damage_model in pairs( damage_models ) do
					for k, damage_type in pairs( damage_types ) do
						local resistance = ComponentObjectGetValue2( damage_model, "damage_multipliers", damage_type )
						resistance = resistance * 2

						if(EntityHasTag(player_entity, "multiply_twice"))then
							resistance = resistance * 2
							
							EntityRemoveTag(player_entity, "multiply_twice")
						end

						EntityAddTag(player_entity, "divide_twice")
						ComponentObjectSetValue2( damage_model, "damage_multipliers", damage_type, resistance );

						
						--ComponentObjectSetValue2( damage_model, "damage_multipliers", damage_type, resistance );
					end
				end
			end
			--GamePrint("Modified damage 2")
			children = EntityGetAllChildren( player_entity ) 
			for k, v in pairs(children)do
				if(EntityHasTag(v, "bastion_shield"))then
					EntityKill(v)
				end
			end

			EntityAddTag(player_entity, "not_shielded")
		end				
	end
end
