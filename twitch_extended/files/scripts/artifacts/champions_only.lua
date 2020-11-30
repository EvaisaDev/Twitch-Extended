local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )

for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 500, "enemy" ) or {} ) do
	if(EntityHasTag(entity, "gkbrkn_force_champion") == false and EntityHasTag(entity, "gkbrkn_champions") == false and EntityHasTag(entity, "gkbrkn_no_champion") == false and EntityHasTag(entity, "drone_friendly") == false and EntityHasTag(entity, "boss_tag") == false )then
		EntityAddTag(entity, "gkbrkn_force_champion")
	end
end