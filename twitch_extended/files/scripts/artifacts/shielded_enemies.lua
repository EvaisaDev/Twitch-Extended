local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )

for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 500, "enemy" ) or {} ) do
	pos_x, pos_y = EntityGetTransform( entity )
	if(EntityHasTag(entity, "has_shield")  == false)then
		local effect_id = EntityLoad( "data/scripts/streaming_integration/entities/shield.xml", pos_x, pos_y )

		EntityAddChild( entity, effect_id )
		EntityAddTag(entity, "has_shield")
	end
end