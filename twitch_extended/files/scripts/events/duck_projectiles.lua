dofile_once( "data/scripts/lib/utilities.lua" )

for _,player_entity in pairs( get_players() ) do
	local x, y = EntityGetTransform( player_entity );
	for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 10000, "projectile" ) or {} ) do
		if(not EntityHasTag(entity, "duckified"))then
			local sprite = EntityAddComponent(entity, "SpriteComponent",{
				image_file = "data/enemies_gfx/duck.xml",
				z_index = "255"
			})
			EntityAddTag(entity, "duckified")
		end
	end
end