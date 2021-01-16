dofile_once("mods/twitch_extended/files/scripts/events/async_event_base.lua")

async(function()
	allowed_picks = {}
	for k, v in pairs(streaming_events)do
		if(( v.enabled == nil ) and v.id ~= "TWITCH_EXTENDED_1D20" and v.id ~= "TWITCH_EXTENDED_2D20" or ( v.enabled ) and v.id ~= "TWITCH_EXTENDED_1D20" and v.id ~= "TWITCH_EXTENDED_2D20")then
			table.insert(allowed_picks, v)
		end
	end

	allowed_picks2 = {}
	for k, v in pairs(streaming_events)do
		if(( v.enabled == nil ) and v.id ~= "TWITCH_EXTENDED_1D20" and v.id ~= "TWITCH_EXTENDED_2D20" or ( v.enabled ) and v.id ~= "TWITCH_EXTENDED_1D20" and v.id ~= "TWITCH_EXTENDED_2D20")then
			table.insert(allowed_picks2, v)
		end
	end

	event = allowed_picks[Random(1, #allowed_picks)]
	event2 = allowed_picks2[Random(1, #allowed_picks2)]
	--timer = append_text(get_player(), TEXT)

	timer_holder, timer = text_above_entity( get_player(), GameTextGetTranslatedOrNot(event.ui_name), 0 )
	timer_holder2, timer2 = text_above_entity( get_player(), GameTextGetTranslatedOrNot(event2.ui_name), 10 )
	
	previous_event = nil
	previous_event2 = nil

	for i=1, 20 do
		wait(15)
		index = Random(1, #allowed_picks)
		event = allowed_picks[index]

		index2 = Random(1, #allowed_picks2)
		event2 = allowed_picks2[index2]

		if(previous_event ~= nil)then
			table.insert(allowed_picks, previous_event)
		end

		if(previous_event2 ~= nil)then
			table.insert(allowed_picks2, previous_event2)
		end

		previous_event = event
		table.remove(allowed_picks,index)
		
		previous_event2 = event2
		table.remove(allowed_picks2,index2)

		update_text( timer_holder, timer, GameTextGetTranslatedOrNot(event.ui_name) )
		update_text( timer_holder2, timer2, GameTextGetTranslatedOrNot(event2.ui_name) )
	end
	wait(90)
	EntityKill(timer_holder)
	EntityKill(timer_holder2)
	GamePrintImportant(GameTextGetTranslatedOrNot(event.ui_name), GameTextGetTranslatedOrNot(event.ui_description))
	GamePrintImportant(GameTextGetTranslatedOrNot(event2.ui_name), GameTextGetTranslatedOrNot(event2.ui_description))
	--event.action()
	--event2.action()
	run_events({event, event2})
	wait(5)
	EntityKill(GetUpdatedEntityID())
end)