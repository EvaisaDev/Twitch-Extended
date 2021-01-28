function portal_teleport_used( entity_that_was_teleported, from_x, from_y, to_x, to_y )
	dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")

	create_hole_of_size(to_x, to_y, 50)
end