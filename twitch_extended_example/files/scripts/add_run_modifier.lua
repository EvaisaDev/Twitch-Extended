table.insert(run_modifiers, {
	id = "EXAMPLE_OIL_TO_WATER", -- Reference ID for the event
	ui_name = "Oil To Water", -- UI name of the event.
	ui_description = "You turn oil to water!", -- UI description of the event
	ui_author = "Evaisa", -- Author
	weight = 1, -- Weight (rarity)
	kind = STREAMING_EVENT_NEUTRAL, -- Type of event, enums can be found in data/scripts/streaming_integration/event_list.lua
	required_flag = "", -- Flag that is required for this event to be allowed to happen
	action = function(event) -- Function that gets run after the event is picked
		for i,entity_id in pairs( get_players() ) do
			local x, y = EntityGetTransform( entity_id )
			
			local effect_id = EntityLoad( "mods/twitch_extended_example/files/entities/oil_to_water.xml", x, y )
			EntityAddChild( entity_id, effect_id )
		end
	end,
})