dofile_once("mods/twitch_extended/files/scripts/events/async_event_base.lua")

async(function()
	bombs = {}
	for i = 1, 5 do
		bomb = spawn_item("mods/twitch_extended/files/entities/projectiles/bomb.xml", 20, 30)
		damage_model = EntityGetFirstComponent(bomb, "DamageModelComponent")
		ComponentSetValue2(damage_model, "hp", 10000)
		table.insert(bombs, bomb)
	end
	wait(80)
	for k, bomb in pairs(bombs)do
		damage_model = EntityGetFirstComponent(bomb, "DamageModelComponent")
		ComponentSetValue2(damage_model, "hp", 0.5)
	end
	wait(5)
	EntityKill(GetUpdatedEntityID())
end)