dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/perks/perk_list.lua" )
dofile_once("mods/config_lib/files/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
old_perk_spawn = perk_spawn
function perk_spawn( x, y, perk_id )
	local entity = old_perk_spawn( x, y, perk_id )
	if(GameHasFlagRun("hidden_perks"))then
		local sprite = EntityGetFirstComponent(entity, "SpriteComponent")
		local UIInfo = EntityGetFirstComponent(entity, "UIInfoComponent")
		local ItemComponent = EntityGetFirstComponent(entity, "ItemComponent")
		ComponentSetValue2(UIInfo, "name", "???")
		ComponentSetValue2(sprite, "image_file", "mods/twitch_extended/files/gfx/misc/hidden_perk.png")
		EntitySetVariable(entity_id, "item_name", ComponentGetValue2(ItemComponent, "item_name"))
		--EntitySetVariable(entity_id, "item_description", ComponentGetValue2(ItemComponent, "item_description"))
		--EntityRemoveTag(entity_id, "perk")
		ComponentSetValue2(ItemComponent, "item_name", "???")
		--ComponentSetValue(ItemComponent, "item_description", "")
		ComponentSetValue2(ItemComponent, "ui_display_description_on_pick_up_hint", false)
	end
	return entity
end

old_perk_spawn_many = perk_spawn_many
function perk_spawn_many( x, y )
	if(HasSettingFlag("twitch_extended_options_perks") == true)then
		--EntityLoad("mods/twitch_extended/files/entities/misc/perk_vote_starter.xml", x, y)
		if not HasSettingFlag( "twitch_extended_options_disable_voting_system" ) then
			StreamingSetVotingEnabled(true)
		end
		GlobalsSetValue("current_vote_type", "perk")

		if(not HasSettingFlag("twitch_extended_options_delay_perk"))then
			StreamingForceNewVoting() 
		end
	else
		old_perk_spawn_many( x, y )
	end
end

local old_reroll_perks = perk_reroll_perks
function perk_reroll_perks()
	if(HasSettingFlag("twitch_extended_options_perks") == true)then
		if(GameHasFlagRun("perk_vote") )then
			local perk_reroll_count = tonumber( GlobalsGetValue( "TEMPLE_PERK_REROLL_COUNT", "0" ) )
			perk_reroll_count = perk_reroll_count + 1
			GlobalsSetValue( "TEMPLE_PERK_REROLL_COUNT", tostring( perk_reroll_count ) )
			GameAddFlagRun( "reroll_vote" )
			GlobalsSetValue("current_vote_type", "perk")
			StreamingForceNewVoting() 
		end
	else
		old_reroll_perks()
	end
end

old_pickup = perk_pickup
function perk_pickup( entity_item, entity_who_picked, item_name, do_cosmetic_fx, kill_other_perks )
	if(GameHasFlagRun("hidden_perks"))then
		item_name = EntityGetVariable(entity_id, "item_name", "string")
		--item_description = EntityGetVariable(entity_id, "item_description", "string")

		ItemComponent = EntityGetFirstComponent(entity_item, "ItemComponent")

		ComponentSetValue(ItemComponent, "item_name", item_name)
	end
	old_pickup( entity_item, entity_who_picked, item_name, do_cosmetic_fx, kill_other_perks )
end