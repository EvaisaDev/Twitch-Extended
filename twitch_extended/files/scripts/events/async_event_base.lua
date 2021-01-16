dofile_once("data/scripts/lib/coroutines.lua")
dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utils.lua")
dofile_once("data/scripts/streaming_integration/event_list.lua")
dofile_once("mods/twitch_extended/lib/persistent_store.lua")
dofile_once("mods/twitch_extended/config/rewards.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/wand_utils.lua")
dofile_once("mods/config_lib/files/utilities.lua")

-- run stuff here!

event_id = EntityGetVariable(GetUpdatedEntityID(), "event_id", "string")
event = nil
for k, v in pairs(streaming_events)do
	if(v.event_id == event_id)then
		event = v
	end
end

if(event == nil)then
	return
end