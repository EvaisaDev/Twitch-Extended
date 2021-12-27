dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/gun/gun_actions.lua" )
dofile_once( "data/scripts/game_helpers.lua" )

function on_open( entity_item )
	local x, y = EntityGetTransform( entity_item )
	local rand_x = x
	local rand_y = y

	-- PositionSeedComponent
	local position_comp = EntityGetFirstComponent( entity_item, "PositionSeedComponent" )
	if( position_comp ) then
		rand_x = tonumber(ComponentGetValue( position_comp, "pos_x") )
		rand_y = tonumber(ComponentGetValue( position_comp, "pos_y") )
	end

	SetRandomSeed( rand_x, rand_y )

	for i = 1, 10 do
		EntityLoad("mods/twitch_extended/files/entities/misc/cheese_wheel.xml", x, y)
	end

	EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", x, y)

end

function item_pickup( entity_item, entity_who_picked, name )
	GamePrintImportant( "Opened a cheese chest!", "" )
	-- GameTriggerMusicCue( "item" )

	--if (remove_entity == false) then
	--	EntityLoad( "data/entities/misc/chest_random_dummy.xml", x, y )
	--end

	on_open( entity_item )
	
	EntityKill( entity_item )
end

function physics_body_modified( is_destroyed )
	-- GamePrint( "A chest was broken open" )
	-- GameTriggerMusicCue( "item" )
	local entity_item = GetUpdatedEntityID()
	
	on_open( entity_item )

	edit_component( entity_item, "ItemComponent", function(comp,vars)
		EntitySetComponentIsEnabled( entity_item, comp, false )
	end)
	
	EntityKill( entity_item )
end