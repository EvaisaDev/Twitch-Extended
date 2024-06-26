dofile_once("mods/twitch_extended/files/scripts/events/async_event_base.lua")

async(function()
	allowed_picks = {}
	for k, v in pairs(streaming_events)do
		if(( v.enabled == nil ) and v.id ~= "TWITCH_EXTENDED_1D20" and v.id ~= "TWITCH_EXTENDED_2D20" or ( v.enabled ) and v.id ~= "TWITCH_EXTENDED_1D20" and v.id ~= "TWITCH_EXTENDED_2D20")then
			table.insert(allowed_picks, v)
		end
	end
	event = allowed_picks[Random(1, #allowed_picks)]
	
	--timer = append_text(get_player(), TEXT)

	timer_holder, timer = text_above_entity( get_player(), GameTextGetTranslatedOrNot(event.ui_name), 0 )

	previous_event = nil

	for i=1, 20 do
		wait(15)
		index = Random(1, #allowed_picks)
		event = allowed_picks[index]
		if(previous_event ~= nil)then
			table.insert(allowed_picks, previous_event)
		end
		previous_event = event
		table.remove(allowed_picks,index)

		update_text( timer_holder, timer, GameTextGetTranslatedOrNot(event.ui_name) )
		
	end
	wait(90)
	EntityKill(timer_holder)
	GamePrintImportant(GameTextGetTranslatedOrNot(event.ui_name), GameTextGetTranslatedOrNot(event.ui_description))
	run_events({event})
	wait(5)
	EntityKill(GetUpdatedEntityID())
end)