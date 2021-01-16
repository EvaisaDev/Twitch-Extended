dofile_once("mods/twitch_extended/files/scripts/events/async_event_base.lua")

async(function()
	local x, y = get_player_pos()
	
	x2 = -150
	for i = 1, 60 do
		create_hole_of_size(x + x2, y - 130, 10)
		x2 = x2 + 5
	end
	wait(5)
	EntityLoad("mods/twitch_extended/files/entities/misc/acid_trap.xml", x, y - 130)
	wait(5)
	EntityKill(GetUpdatedEntityID())
end)