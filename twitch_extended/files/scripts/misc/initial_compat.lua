function literalize(str)
    return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c) return "%" .. c end)
end


if(ModIsEnabled("thematic_random_starts"))then
	local content = ModTextFileGetContent("mods/thematic_random_starts/init.lua")
	content = string.gsub(content, "OnPlayerSpawned", "OldOnPlayerSpawned")


		
	content = content:gsub(literalize("EntityAddChild( inventory, new_wand )"), "GamePickUpInventoryItem(player_entity, new_wand, false)")
	content = content:gsub(literalize("EntityAddChild( inventory, item_entity )"), "GamePickUpInventoryItem(player_entity, item_entity, false)")


	if(string.find(content, "OnWorldPreUpdate"))then
		content = string.gsub(content, "OnWorldPreUpdate", "OldOnWorldPreUpdate")

		content = content..[[

			dofile_once("data/scripts/lib/coroutines.lua")
			dofile_once("data/scripts/lib/utilities.lua")

			function OnWorldPreUpdate(player)
				wake_up_waiting_threads(1) 
				OldOnWorldPreUpdate()
			end

		]]
	else
		content = content..[[

			dofile_once("data/scripts/lib/coroutines.lua")
			dofile_once("data/scripts/lib/utilities.lua")

			function OnWorldPreUpdate(player)
				wake_up_waiting_threads(1) 
			end

		]]
	end

	content = content..[[
		
		function OnPlayerSpawned(player)
			if(ModIsEnabled( "config_lib" ))then
				dofile_once("mods/config_lib/files/utilities.lua")
				async(function ()
					wait( 40 )
					print("[Twitch Extended] Thematic Random Starts - OnPlayerSpawned was delayed 40 frames")
					if(HasSettingFlag("twitch_extended_options_loadouts"))then
						if(StreamingGetIsConnected() == 1 or type(StreamingGetIsConnected()) == "boolean" and StreamingGetIsConnected())then
							print("[Twitch Extended] Thematic Random Starts was prevented from loading. Streaming is connected")
							return
						end
					end
					OldOnPlayerSpawned(player)
				end)
			end
		end

	]]

	ModTextFileSetContent("mods/thematic_random_starts/init.lua", content)

	
end