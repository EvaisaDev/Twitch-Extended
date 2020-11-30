dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	
	local extra_hp = math.max( 0, pos_y * 0.0002 )
	local extra_damage = math.max( 0, pos_y * 0.0001 )

	for i=1,2 do
		local rnd = Random( 1, 100 )
		
		if ( rnd > 50 ) then
			local eid = EntityLoad( "mods/twitch_extended/files/entities/animals/special_rat.xml", pos_x, pos_y )
			EntityRemoveTag( eid, "homing_target" )
			
			edit_component( eid, "DamageModelComponent", function(comp,vars)
				local hp = tonumber(ComponentGetValue( comp, "hp"))
				vars.max_hp = hp + extra_hp
				vars.hp = hp + extra_hp
			end)

			local herdComp = EntityGetFirstComponentIncludingDisabled(eid, "GenomeDataComponent")

			ComponentSetValue2(herdComp, "herd_id", StringToHerdId("rat"))
			
			edit_component( eid, "AnimalAIComponent", function(comp,vars)
				local damage_min = tonumber(ComponentGetValue( comp, "attack_melee_damage_min"))
				local damage_max = tonumber(ComponentGetValue( comp, "attack_melee_damage_max"))
				local damage_dash = tonumber(ComponentGetValue( comp, "attack_dash_damage"))
				
				vars.attack_melee_damage_min = damage_min + extra_damage
				vars.attack_melee_damage_max = damage_max + extra_damage
				vars.attack_dash_damage = damage_dash + extra_damage
			end)
		end
	end
end