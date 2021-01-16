dofile_once("mods/twitch_extended/files/scripts/events/async_event_base.lua")

async(function()
	local x, y = get_player_pos()

	for i = 1, 8 do
		create_hole_of_size(x, y + (i * 8), 12)
	end
	wait(5)
	EntityLoad("mods/twitch_extended/files/entities/misc/poison_pit.xml", x, y)
	wait(5)
	EntityKill(GetUpdatedEntityID())
end)