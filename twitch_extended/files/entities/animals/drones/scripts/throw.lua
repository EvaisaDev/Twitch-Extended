dofile( "data/scripts/lib/utilities.lua" )

function throw_item( from_x, from_y, to_x, to_y )
	local theEntity = GetUpdatedEntityID()
	local component = EntityGetComponent(theEntity, "ProjectileComponent")[1]
	if(component ~= nil)then
		ComponentSetValue(component, "lifetime", "1")
	end
end