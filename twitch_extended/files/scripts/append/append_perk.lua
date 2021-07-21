dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/perks/perk_list.lua" )
dofile_once("mods/config_lib/files/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
if(ModIsEnabled("twitch_lib"))then
	dofile_once("mods/twitch_lib/files/twitch_overwrites.lua")
end

local old_perk_spawn = perk_spawn
function perk_spawn( x, y, perk_id, dont_remove_other_perks )
	local entity = old_perk_spawn( x, y, perk_id, dont_remove_other_perks )
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

local old_perk_spawn_many = perk_spawn_many
function perk_spawn_many( x, y, dont_remove_others, ignore_these )
	if(HasSettingFlag("twitch_extended_options_perks") == true)then
		--EntityLoad("mods/twitch_extended/files/entities/misc/perk_vote_starter.xml", x, y)
		if not HasSettingFlag( "twitch_extended_options_disable_voting_system" ) then
			StreamingSetVotingEnabled(true)
		end
		
		
		perk_count = tonumber(GlobalsGetValue("perk_vote_count", "0"))
		GlobalsSetValue("perk_vote_count", tostring(perk_count + 1))

		if(not GameHasFlagRun("twitch_vote_ongoing"))then
			if(GameHasFlagRun("twitch_vote_paused"))then
				GameRemoveFlagRun( "twitch_vote_paused" )
				GameAddFlagRun( "twitch_perk_vote_override" )
			end
			if(not GameHasFlagRun("perk_vote") and GlobalsGetValue("current_vote_type", "event") == "event")then
				GlobalsSetValue("current_vote_type", "perk")
				GlobalsSetValue("twitch_lib_force_outcome_type", "random")
				StreamingForceNewVoting() 
			end
		end

		if(not HasSettingFlag("twitch_extended_options_delay_perk"))then
			if(GameHasFlagRun("twitch_vote_paused"))then
				GameRemoveFlagRun( "twitch_vote_paused" )
				GameAddFlagRun( "twitch_perk_vote_override" )
			end
			if(not GameHasFlagRun("perk_vote") and GlobalsGetValue("current_vote_type", "event") == "event")then
				GlobalsSetValue("current_vote_type", "perk")
				GlobalsSetValue("twitch_lib_force_outcome_type", "random")
				StreamingForceNewVoting() 
			end
		end
	else
		old_perk_spawn_many( x, y, dont_remove_others, ignore_these )
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
			GlobalsSetValue("twitch_lib_force_outcome_type", "random")
			StreamingForceNewVoting() 
		end
	else
		old_reroll_perks()
	end
end

local old_pickup = perk_pickup
function perk_pickup( entity_item, entity_who_picked, item_name, do_cosmetic_fx, kill_other_perks, no_perk_entity )
	if(GameHasFlagRun("hidden_perks"))then
		item_name = EntityGetVariable(entity_id, "item_name", "string")
		--item_description = EntityGetVariable(entity_id, "item_description", "string")

		ItemComponent = EntityGetFirstComponent(entity_item, "ItemComponent")

		ComponentSetValue(ItemComponent, "item_name", item_name)
	end
	old_pickup( entity_item, entity_who_picked, item_name, do_cosmetic_fx, kill_other_perks, no_perk_entity )
end