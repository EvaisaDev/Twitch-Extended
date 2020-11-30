dofile_once("data/scripts/lib/utilities.lua")

function damage_received( damage, desc, entity_who_caused, is_fatal )
--	print("eeeeeeeee")

	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	if ( entity_who_caused == entity_id ) or ( ( EntityGetParent( entity_id ) ~= NULL_ENTITY ) and ( entity_who_caused == EntityGetParent( entity_id ) ) ) then return end
	
	local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
	if( damagemodels ~= nil ) then
		for i,damagemodel in ipairs(damagemodels) do
			local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
			local max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )
			
			if(hp < (max_hp / 2) and (hp + damage) > (max_hp / 2))then
				for i = 1, Random(5, 10)do
					EntityLoad("data/entities/misc/perks/plague_rats_rat.xml", pos_x, pos_y)
					EntityLoad( "data/entities/misc/perks/plague_rats_rat_poof.xml", pos_x, pos_y )
				end
			end
		end
	end	
end
