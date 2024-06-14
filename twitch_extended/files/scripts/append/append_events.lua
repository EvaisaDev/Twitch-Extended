dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/lib/coroutines.lua")
dofile_once("data/scripts/streaming_integration/event_utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/wand_utils.lua")
dofile_once("mods/twitch_extended/config/loadouts.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/loadout_utils.lua")


dofile_once("data/scripts/gun/procedural/wands.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
dofile( "data/scripts/gun/gun_enums.lua")
dofile( "data/scripts/perks/perk_list.lua")
dofile( "data/scripts/perks/perk.lua")

--[[
function shuffle(t)
	local tbl = {}
	for i = 1, #t do
	  tbl[i] = t[i]
	end
	for i = #tbl, 2, -1 do
	  local j = Random(i)
	  tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end
]]

function run_events(table)
	for k, evt in pairs(table)do
		if evt.action_delayed ~= nil then
			if evt.delay_timer ~= nil then
				local p = get_players()
				
				if ( #p > 0 ) then
					for a,b in ipairs( p ) do
						if(HasSettingFlag("twitch_extended_options_no_event_timers"))then
							evt.delay_timer = 0
						end
						add_timer_above_head( b, evt.id, evt.delay_timer, evt.timer_formatting )
					end
				end
			end
		elseif evt.action ~= nil then	
			evt.action(evt)
		end
	end
end


function shuffle( tInput )
    local tReturn = {}
    for i = #tInput, 1, -1 do
        local j = Random(1, i)
        tInput[i], tInput[j] = tInput[j], tInput[i]
        table.insert(tReturn, tInput[i])
    end
    return tReturn
end

potion_materials_standard = 
{
	"lava",
	"water",
	"blood",
	"alcohol",
	"oil",
	"slime",
	"acid",
	"radioactive_liquid",
	"gunpowder_unstable",
	"liquid_fire",
	"blood_cold"
}

potion_materials_magic = 
{
	"magic_liquid_movement_faster",
	"magic_liquid_worm_attractor",
	"magic_liquid_protection_all",
	"magic_liquid_mana_regeneration",
	"magic_liquid_teleportation",
	"magic_liquid_hp_regeneration",
	"magic_liquid_hp_regeneration_unstable",
	"magic_liquid_polymorph",
	"magic_liquid_random_polymorph",
	"magic_liquid_berserk",
	"magic_liquid_charm",
	"magic_liquid_invisibility"
}

enemies_list = {
	"data/entities/animals/acidshooter.xml",
	"data/entities/animals/acidshooter_weak.xml",
	"data/entities/animals/alchemist.xml",
	"data/entities/animals/ant.xml",
	"data/entities/animals/assassin.xml",
	"data/entities/animals/barfer.xml",
	"data/entities/animals/bat.xml",
	"data/entities/animals/bigbat.xml",
	"data/entities/animals/bigfirebug.xml",
	"data/entities/animals/bigzombie.xml",
	"data/entities/animals/bigzombiehead.xml",
	"data/entities/animals/bigzombietorso.xml",
	"data/entities/animals/blob.xml",
	"data/entities/animals/bloodcrystal_physics.xml",
	"data/entities/animals/bloom.xml",
	"data/entities/animals/boss_dragon.xml",
	"data/entities/animals/chest_leggy.xml",
	"data/entities/animals/chest_mimic.xml",
	"data/entities/animals/crystal_physics.xml",
	"data/entities/animals/deer.xml",
	"data/entities/animals/drone_lasership.xml",
	"data/entities/animals/drone_physics.xml",
	"data/entities/animals/duck.xml",
	"data/entities/animals/eel.xml",
	"data/entities/animals/elk.xml",
	"data/entities/animals/enlightened_alchemist.xml",
	"data/entities/animals/failed_alchemist.xml",
	"data/entities/animals/failed_alchemist_b.xml",
	"data/entities/animals/firebug.xml",
	"data/entities/animals/firemage.xml",
	"data/entities/animals/firemage_weak.xml",
	"data/entities/animals/fireskull.xml",
	"data/entities/animals/fireskull_weak.xml",
	"data/entities/animals/fish.xml",
	"data/entities/animals/fish_large.xml",
	"data/entities/animals/flamer.xml",
	"data/entities/animals/fly.xml",
	"data/entities/animals/frog.xml",
	"data/entities/animals/frog_big.xml",
	"data/entities/animals/fungus.xml",
	"data/entities/animals/fungus_big.xml",
	"data/entities/animals/gazer.xml",
	"data/entities/animals/ghost.xml",
	"data/entities/animals/ghoul.xml",
	"data/entities/animals/giant.xml",
	"data/entities/animals/giantshooter.xml",
	"data/entities/animals/giantshooter_weak.xml",
	"data/entities/animals/goblin_bomb.xml",
	"data/entities/animals/healerdrone_physics.xml",
	"data/entities/animals/icer.xml",
	"data/entities/animals/iceskull.xml",
	"data/entities/animals/lasershooter.xml",
	"data/entities/animals/longleg.xml",
	"data/entities/animals/lurker.xml",
	"data/entities/animals/maggot.xml",
	"data/entities/animals/mimic_physics.xml",
	"data/entities/animals/miner.xml",
	"data/entities/animals/miner_fire.xml",
	"data/entities/animals/miner_santa.xml",
	"data/entities/animals/miner_weak.xml",
	"data/entities/animals/miniblob.xml",
	"data/entities/animals/missilecrab.xml",
	"data/entities/animals/monk.xml",
	"data/entities/animals/pebble_physics.xml",
	"data/entities/animals/phantom_a.xml",
	"data/entities/animals/phantom_b.xml",
	"data/entities/animals/playerghost.xml",
	"data/entities/animals/rat.xml",
	"data/entities/animals/roboguard.xml",
	"data/entities/animals/scavenger_clusterbomb.xml",
	"data/entities/animals/scavenger_grenade.xml",
	"data/entities/animals/scavenger_heal.xml",
	"data/entities/animals/scavenger_invis.xml",
	"data/entities/animals/scavenger_leader.xml",
	"data/entities/animals/scavenger_mine.xml",
	"data/entities/animals/scavenger_poison.xml",
	"data/entities/animals/scavenger_shield.xml",
	"data/entities/animals/scavenger_smg.xml",
	"data/entities/animals/scorpion.xml",
	"data/entities/animals/shaman.xml",
	"data/entities/animals/sheep.xml",
	"data/entities/animals/sheep_bat.xml",
	"data/entities/animals/sheep_fly.xml",
	"data/entities/animals/shooterflower.xml",
	"data/entities/animals/shotgunner.xml",
	"data/entities/animals/shotgunner_weak.xml",
	"data/entities/animals/skullfly.xml",
	"data/entities/animals/skullrat.xml",
	"data/entities/animals/skycrystal_physics.xml",
	"data/entities/animals/slimeshooter.xml",
	"data/entities/animals/slimeshooter_nontoxic.xml",
	"data/entities/animals/slimeshooter_weak.xml",
	"data/entities/animals/sniper.xml",
	"data/entities/animals/spearbot.xml",
	"data/entities/animals/spitmonster.xml",
	"data/entities/animals/tank.xml",
	"data/entities/animals/tank_rocket.xml",
	"data/entities/animals/tank_super.xml",
	"data/entities/animals/tentacler.xml",
	"data/entities/animals/tentacler_small.xml",
	"data/entities/animals/thundermage.xml",
	"data/entities/animals/thunderskull.xml",
	"data/entities/animals/turret_left.xml",
	"data/entities/animals/turret_right.xml",
	"data/entities/animals/ultimate_killer.xml",
	"data/entities/animals/wand_ghost.xml",
	"data/entities/animals/wand_ghost_charmed.xml",
	"data/entities/animals/wizard_dark.xml",
	"data/entities/animals/wizard_neutral.xml",
	"data/entities/animals/wizard_poly.xml",
	"data/entities/animals/wizard_returner.xml",
	"data/entities/animals/wizard_tele.xml",
	"data/entities/animals/wolf.xml",
	"data/entities/animals/wraith.xml",
	"data/entities/animals/wraith_glowing.xml",
	"data/entities/animals/wraith_storm.xml",
	"data/entities/animals/zombie.xml",
	"data/entities/animals/zombie_weak.xml",
	"data/entities/animals/lukki/lukki.xml",
	"data/entities/animals/lukki/lukki_creepy.xml",
	"data/entities/animals/lukki/lukki_creepy_long.xml",
	"data/entities/animals/lukki/lukki_longleg.xml",
	"data/entities/animals/lukki/lukki_tiny.xml",
	"data/entities/animals/boss_centipede/boss_centipede.xml",
}

local potion_materials = {
	"water",
	"blood",
	"alcohol",
	"oil",
	"slime",
	"radioactive_liquid",
	"poison",
	"liquid_fire",
	"magic_liquid_movement_faster",
	"magic_liquid_worm_attractor",
	"magic_liquid_protection_all",
	"magic_liquid_mana_regeneration",
	"magic_liquid_teleportation",
	"magic_liquid_hp_regeneration",
	"magic_liquid_hp_regeneration_unstable",
	"magic_liquid_berserk",
	"magic_liquid_charm",
	"magic_liquid_invisibility"	
};

local potion_names = {
	"water",
	"blood",
	"whisky",
	"oil",
	"slime",
	"toxic sludge",
	"poison",
	"liquid fire",
	"Acceleratium",
	"Worm Pheromone",
	"Ambrosia",
	"Concentrated Mana",
	"Teleportatium",
	"Healthium",
	"Lively Concoction",
	"Berserkium",
	"Pheromone",
	"Invisibilium"
};



for k, v in pairs(streaming_events)do
	if(v.id == "SPAWN_CHEST")then
		v.action = function(event)
			local chance = Random(1,100)
			if(chance < 5)then
				spawn_item("data/entities/animals/chest_leggy.xml",30, 50)
			elseif(chance < 30)then
				spawn_item("data/entities/animals/chest_mimic.xml",30, 50)
			elseif(chance < 70)then
				spawn_item("data/entities/items/pickup/chest_random.xml", 30, 50)
			else
				spawn_item("data/entities/items/pickup/chest_random_super.xml", 30, 50)
			end
		end
	elseif(v.id == "WET_PLAYER")then
		v.ui_name = "$twitch_extended_depression"
		v.ui_description = "$twitch_extended_depression_description"
	elseif(v.id == "RAIN_WORM")then
		v.ui_name = "$twitch_extended_worm_rain"
	elseif(v.id == "PLAYER_GAS")then
		v.ui_name = "$twitch_extended_farts"
		v.ui_description = "$twitch_extended_farts_description"
	elseif(v.id == "SEA_OF_WATER")then
		table.remove(streaming_events, k)
	elseif(v.id == "PORTAL_EAST")then
		v.action = function(event)
			local effect_id = spawn_item("mods/twitch_extended/files/entities/misc/portal_east.xml", 0, 5, true, false, 50)
			set_lifetime( effect_id )		
			local pos_x, pos_y = EntityGetTransform( effect_id )
			pos_x = pos_x + 512 * 70
			
		end
	elseif(v.id == "PORTAL_BEGINNING")then
		v.action = function(event)
			local effect_id = spawn_item("data/scripts/streaming_integration/entities/portal_beginning.xml", 0, 5, true, false, 50)
			set_lifetime( effect_id )	
			
		end
	elseif(v.id == "PORTAL_RANDOM")then
		v.action = function(event)
			local effect_id = spawn_item("data/scripts/streaming_integration/entities/portal_random.xml", 0, 5, true, false, 50)
			set_lifetime( effect_id )	
		end
	end
end

function is_wand_always_cast_valid( wand )
    local children = EntityGetAllChildren( wand ) or {};
    for i,v in ipairs( children ) do
        local components = EntityGetAllComponents( v );
        local has_a_valid_spell = false;
        for _,component in pairs(components) do
            if ComponentGetValue( component, "permanently_attached" ) == "0" and ComponentGetValue( component, "is_frozen" ) == "0" then
                has_a_valid_spell = true;
                break;
            end
        end
        if has_a_valid_spell then
            return true;
        end
    end
    return false;
end


append_events = {
	{
		id = "TWITCH_EXTENDED_ACID_TRAP",
		ui_name = "$twitch_extended_acid_trap",
		ui_description = "$twitch_extended_acid_trap_description",
		ui_icon = "",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		ui_author = "Evaisa",
		action = function(event)
			handler_entity = EntityCreateNew()
			EntityAddComponent2(handler_entity, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/scripts/events/acid_trap.lua",
				vm_type="ONE_PER_COMPONENT_INSTANCE",
				execute_on_added=true,
				execute_every_n_frame=-1,
				execute_times=1,
				enable_coroutines=true,
			})
		end,
	},
	{
		id = "TWITCH_EXTENDED_ALWAYS_CAST",
		ui_name = "$twitch_extended_always_cast",
		ui_description = "$twitch_extended_always_cast_description",
		ui_icon = "",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		ui_author = "Evaisa",
		action = function(event)
			local wands = get_wands()
			if wands == nil then return end
			local wand = wands[Random(1,table.getn(wands))]

			local player = get_player()
			local x, y = EntityGetTransform(player)

			AddGunActionPermanent( wand, GetRandomAction( x, y, 6, 666))


			local ability = EntityGetAllComponents(wand)
			for _, c in ipairs(ability) do
				if ComponentGetTypeName(c) == "AbilityComponent" then
					local deck_capacity = tonumber(ComponentObjectGetValue(c, "gun_config", "deck_capacity"))
					deck_capacity = deck_capacity + 1
					ComponentObjectSetValue(c, "gun_config", "deck_capacity", tostring(deck_capacity))
				end
			end		
			local inventory2 = EntityGetFirstComponent( player, "Inventory2Component" );
			if inventory2 ~= nil then
				ComponentSetValue2( inventory2, "mForceRefresh", true );
				ComponentSetValue2( inventory2, "mActualActiveItem", 0)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_BIGGY_HOLE",
		ui_name = "$twitch_extended_biggy_hole",
		ui_description = "$twitch_extended_biggy_hole_description",
		ui_icon = "",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		ui_author = "Evaisa",

		action = function(event)
			local x, y = get_player_pos()
			local player = get_players()[1]
		  
			for i = 1, 35 do
				create_hole_of_size(x, y + (i * 8), 28)
	
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_BLACK_HOLES",
		ui_name = "$twitch_extended_black_holes",
		ui_description = "$twitch_extended_black_holes_description",
		ui_icon = "",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		ui_author = "Evaisa",

		action = function(event)
			for i = 1, 3 do
				spawn_item("data/entities/projectiles/deck/black_hole_big.xml", 100, 150, true, true)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_BLINDNESS",
		ui_name = "$twitch_extended_blindness",
		ui_description = "$twitch_extended_blindness_description",
		ui_icon = "",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		ui_author = "Evaisa",
		action = function(event)
			for _,entity_id in pairs( get_players() ) do
				--[[local game_effect = GetGameEffectLoadTo( player_entity, "BLINDNESS", false );
				if game_effect ~= nil then
					ComponentSetValue( game_effect, "frames", 900 );
				end]]

				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/blindness.xml", x, y )
				--set_lifetime( effect_id )
				EntityAddChild( entity_id, effect_id )
				
				add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/blindness.png", event )
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_BOMB",
		ui_name = "$twitch_extended_bomb",
		ui_description = "$twitch_extended_bomb_description",
		ui_icon = "",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		ui_author = "Evaisa",
		action = function(event)
			handler_entity = EntityCreateNew()
			EntityAddComponent2(handler_entity, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/scripts/events/bomb.lua",
				vm_type="ONE_PER_COMPONENT_INSTANCE",
				execute_on_added=true,
				execute_every_n_frame=-1,
				execute_times=1,
				enable_coroutines=true,
			})
		end,
	},
	{
		id = "TWITCH_EXTENDED_BOMB_CURSE",
		ui_name = "$twitch_extended_bomb_curse",
		ui_description = "$twitch_extended_bomb_curse_description",
		ui_icon = "",
		weight = 1.0,
		kind = STREAMING_EVENT_AWFUL,
		ui_author = "Evaisa",
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
                
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/bomb_curse.xml", x, y )
                --set_lifetime( effect_id )
                EntityAddChild( entity_id, effect_id )
                
                add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/bomb_curse.png", event )
            end
		end,
	},	
	{
		id = "TWITCH_EXTENDED_CHEESE",
		ui_name = "$twitch_extended_cheese",
		ui_description = "$twitch_extended_cheese_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			spawn_item("mods/twitch_extended/files/entities/misc/cheese.xml", 0, 0, false, true)
		end,
	},
	{
		id = "TWITCH_EXTENDED_GNOME",
		ui_name = "$twitch_extended_duende",
		ui_description = "$twitch_extended_duende_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			spawn_item("mods/twitch_extended/files/entities/misc/gnome_bomb.xml", 0, 0, false, true)
		end,
	},
	{
		id = "TWITCH_EXTENDED_DEERPOCALYPSE",
		ui_name = "$twitch_extended_deerpocalypse",
		ui_description = "$twitch_extended_deerpocalypse_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			for i = 1, 12 do
				deer = spawn_item("data/entities/animals/deer.xml", 50, 160, true)
				if(deer ~= nil and deer ~= 0)then
					damage_model = EntityGetFirstComponent(deer, "DamageModelComponent")
					ComponentSetValue2(damage_model, "hp", 5)
					attach_bomb(deer, 30, 5, 300)
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_DIGGY_HOLE",
		ui_name = "$twitch_extended_diggy_hole",
		ui_description = "$twitch_extended_diggy_hole_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			local x, y = get_player_pos()
			local player = get_players()[1]
		  
			for i = 1, 25 do
				create_hole_of_size(x, y + (i * 8), 12)
	
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_DUCK_PROJECTILES",
		ui_name = "$twitch_extended_duck_projectiles",
		ui_description = "$twitch_extended_duck_projectiles_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
                
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/duck_projectiles.xml", x, y )
               -- set_lifetime( effect_id )
                EntityAddChild( entity_id, effect_id )
                
                add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/duck_projectiles.png", event )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_EARTHQUAKE",
		ui_name = "$twitch_extended_earthquake",
		ui_description = "$twitch_extended_earthquake_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		delay_timer = 300,
		timer_formatting = "$twitch_extended_earthquake_timer",
		action_delayed = function(event)		 
			spawn_item("data/entities/projectiles/deck/crumbling_earth.xml", 10, 10, false, true)
		end,
	},
	{
		id = "TWITCH_EXTENDED_ENEMY_BOMBERS",
		ui_name = "$twitch_extended_enemy_bombers",
		ui_description = "$twitch_extended_enemy_bombers_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			for _,player_entity in pairs( get_players() ) do
				local x, y = EntityGetTransform( player_entity );
				for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 2000, "enemy" ) or {} ) do
					attach_bomb(entity, 30, 5, 300)
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_FIRE_TRAP",
		ui_name = "$twitch_extended_fire_trap",
		ui_description = "$twitch_extended_fire_trap_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			spawn_item("data/entities/projectiles/deck/circle_fire.xml", 100, 200, true)
		end,
	},
	{
		id = "TWITCH_EXTENDED_GOLD_RUSH",
		ui_name = "$twitch_extended_gold_rush",
		ui_description = "$twitch_extended_gold_rush_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			for i = 1, 30 do
				spawn_item("data/entities/items/pickup/goldnugget.xml", 50, 100)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_HOLY_BOMB",
		ui_name = "$twitch_extended_holy_bomb",
		ui_description = "$twitch_extended_holy_bomb_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.8,
		kind = STREAMING_EVENT_AWFUL,
		action = function(event)
			barrel = spawn_item("data/entities/projectiles/bomb_holy.xml", 5, 10, false, true)
			
			damage_model = EntityGetFirstComponent(barrel, "DamageModelComponent")
			ComponentSetValue2(damage_model, "hp", 10000)
		end,
	},
	{
		id = "TWITCH_EXTENDED_ICE_AGE",
		ui_name = "$twitch_extended_ice_age",
		ui_description = "$twitch_extended_ice_age_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			spawn_item("mods/twitch_extended/files/entities/misc/iceage.xml", 0, 0, false, true)
		end,
	},
	{
		id = "TWITCH_EXTENDED_INSTANT_OCEAN",
		ui_name = "$twitch_extended_instant_ocean",
		ui_description = "$twitch_extended_instant_ocean_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
                
				EntityLoad("data/entities/projectiles/deck/sea_water.xml", x, y -256)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_INVERT_CONTROLS",
		ui_name = "$twitch_extended_invert_controls",
		ui_description = "$twitch_extended_invert_controls_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
                
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/confusion.xml", x, y )
                --set_lifetime( effect_id )
                EntityAddChild( entity_id, effect_id )
                
                add_icon_in_hud( effect_id, "data/ui_gfx/status_indicators/confusion.png", event )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_LAVA_PIT",
		ui_name = "$twitch_extended_lava_pit",
		ui_description = "$twitch_extended_lava_pit_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			handler_entity = EntityCreateNew()
			EntityAddComponent2(handler_entity, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/scripts/events/lava_pit.lua",
				vm_type="ONE_PER_COMPONENT_INSTANCE",
				execute_on_added=true,
				execute_every_n_frame=-1,
				execute_times=1,
				enable_coroutines=true,
			})
		end,
	},
	{
		id = "TWITCH_EXTENDED_POISON_PIT",
		ui_name = "$twitch_extended_poison_pit",
		ui_description = "$twitch_extended_poison_pit_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			handler_entity = EntityCreateNew()
			EntityAddComponent2(handler_entity, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/scripts/events/poison_pit.lua",
				vm_type="ONE_PER_COMPONENT_INSTANCE",
				execute_on_added=true,
				execute_every_n_frame=-1,
				execute_times=1,
				enable_coroutines=true,
			})
		end,
	},
	{
		id = "TWITCH_EXTENDED_LEGOS",
		ui_name = "$twitch_extended_legos",
		ui_description = "$twitch_extended_legos_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i=1, 150 do
				color_table = {
					"blue",
					"red",
					"yellow",
					"green"
				}
				spawn_item("mods/twitch_extended/files/entities/misc/legos/lego_"..color_table[Random(1,#color_table)]..".xml", 40, 200)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_MIGHTY_DUCK",
		ui_name = "$twitch_extended_mighty_duck",
		ui_description = "$twitch_extended_mighty_duck_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.5,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			spawn_giant_duck(StreamingGetRandomViewerName())
		end,
	},
	{
		id = "TWITCH_EXTENDED_LOCK_SPELL",
		ui_name = "$twitch_extended_lock_spell",
		ui_description = "$twitch_extended_lock_spell_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			local player = get_player()
			local children = EntityGetAllChildren( player );
			for key,child in pairs( children ) do
				if EntityGetName( child ) == "inventory_quick" then
					wands = get_children_with_tag(child, "wand");
					break;
				end
			end
			if #wands > 0 then
				local filtered_wands = {};
				for _,wand in pairs(wands) do
					if is_wand_always_cast_valid( wand ) then
						table.insert( filtered_wands, wand );
					end
				end
				if #filtered_wands > 0 then
					wands = filtered_wands;
					local inventory2 = EntityGetFirstComponent( player, "Inventory2Component" );
					local active_item = tonumber( ComponentGetValue( inventory2, "mActiveItem" ) );
					if base_wand == nil then
						base_wand =  random_from_array( wands );
					end
				end
			end
			if base_wand ~= nil then
				local children = EntityGetAllChildren( base_wand );
				local ability_component = EntityGetFirstComponentIncludingDisabled( base_wand, "AbilityComponent" );
					if ability_component ~= nil then
					local deck_capacity = tonumber( ComponentObjectGetValue( ability_component, "gun_config", "deck_capacity" ) );
					ComponentObjectSetValue( ability_component, "gun_config", "deck_capacity", tostring( deck_capacity + 1 ) );
				end
		
				local actions = {};
				for i,v in ipairs( children ) do
					local components = EntityGetAllComponents( v );
					for _,component in pairs(components) do
						if ComponentGetValue( component, "permanently_attached" ) == "0" and ComponentGetValue( component, "is_frozen" ) == "0" then
							table.insert( actions, component );
						end
					end
				end
				if #actions > 0 then
					local to_attach = random_from_array( actions );
					if to_attach ~= nil then
						ComponentSetValue( to_attach, "is_frozen", "1" );
					end
				end
			end
			local inventory2 = EntityGetFirstComponent( player, "Inventory2Component" );
			if inventory2 ~= nil then
				ComponentSetValue2( inventory2, "mForceRefresh", true );
				ComponentSetValue2( inventory2, "mActualActiveItem", 0)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_LOTS_OF_MANA",
		ui_name = "$twitch_extended_lots_of_mana",
		ui_description = "$twitch_extended_lots_of_mana_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
				for i = 1, 4 do
					effect = EntityLoad( "mods/twitch_extended/files/entities/misc/infinite_mana.xml", x, y )
					--set_lifetime( effect )
                	EntityAddChild( entity_id, effect )
				end
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/infinite_mana.xml", x, y )
                --set_lifetime( effect_id )
                EntityAddChild( entity_id, effect_id )
                
                add_icon_in_hud( effect_id, "data/ui_gfx/status_indicators/mana_regeneration.png", event )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_HEALTHY_RAIN",
		ui_name = "$twitch_extended_healthy_rain",
		ui_description = "$twitch_extended_healthy_rain_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			local x, y = get_player_pos()
      
			EntityLoad("mods/twitch_extended/files/entities/misc/cloud_healthium.xml", x, y - 50)
		end,
	},
	{
		id = "TWITCH_EXTENDED_GENOCIDE",
		ui_name = "$twitch_extended_genocide",
		ui_description = "$twitch_extended_genocide_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			local enemies = EntityGetWithTag( "enemy" )
			for k, enemy in pairs(enemies) do 
				local x, y = EntityGetTransform(enemy)
				if(not EntityHasTag(enemy, "drone_friendly"))then
					EntityInflictDamage( enemy, 999999, "DAMAGE_PROJECTILE", "genocide", "NORMAL", 0, 0, enemy, x, y, 0)
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_MORE_GOLD",
		ui_name = "$twitch_extended_more_gold",
		ui_description = "$twitch_extended_more_gold_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
				for i = 1, 2 do
					effect = EntityLoad( "mods/twitch_extended/files/entities/misc/more_gold.xml", x, y )
					--set_lifetime( effect )
                	EntityAddChild( entity_id, effect )
				end
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/more_gold.xml", x, y )
               -- set_lifetime( effect_id )
                EntityAddChild( entity_id, effect_id )
                
                add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/more_gold.png", event )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_PLAGUE",
		ui_name = "$twitch_extended_plague",
		ui_description = "$twitch_extended_plague_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local rats = Random(15, 30)
			local plague = Random(15, 30)
		
			for i = 1, rats do
				spawn_item("data/entities/animals/rat.xml", 150, 250, true)
			end
			for i = 1, plague do
				spawn_item("data/entities/misc/perks/plague_rats_rat.xml", 150, 250, true)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_PROJECTILE_ATTRACTION",
		ui_name = "$twitch_extended_projectile_attraction",
		ui_description = "$twitch_extended_projectile_attraction_description",
		ui_icon = "data/ui_gfx/streaming_event_icons/speedy_enemies.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )

                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/projectile_attraction.xml", x, y )
               -- set_lifetime( effect_id )
                EntityAddChild( entity_id, effect_id )
                
				--add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/projectile_attraction.png", event )
				--add_icon_above_head( effect_id, "mods/twitch_extended/files/gfx/status_effects/projectile_attraction.png", event )
				
				add_status_effect( effect_id, "mods/twitch_extended/files/gfx/status_effects/projectile_attraction.png", event.ui_name, event.ui_description, true )
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_RANDOM_DOWSE",
		ui_name = "$twitch_extended_random_dowse",
		ui_description = "$twitch_extended_random_dowse_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.5,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			index = Random(1, table.getn(potion_materials))
			local player = get_player()
			local liquid = EntityCreateNew();
			local x, y = get_player_pos();
			local material = potion_materials[index];
			EntitySetTransform(liquid, x, y - 10, 0, 1, 1);

			EntityAddComponent2(liquid, "InheritTransformComponent")
			
			EntityAddComponent2(liquid, "ParticleEmitterComponent", {
				emitted_material_name=material,
				create_real_particles=true,
				lifetime_min=8,
				lifetime_max=15,
				count_min=3,
				count_max=3,
				render_on_grid=true,
				fade_based_on_lifetime=true,
				airflow_force=0.251,
				airflow_time=1.01,
				airflow_scale=0.05,
				emission_interval_min_frames=1,
				emission_interval_max_frames=1,
				emit_cosmetic_particles=false,
				image_animation_file="data/particles/image_emitters/circle_reverse_64.png",
				image_animation_speed=10,
				image_animation_loop=false,
				image_animation_raytrace_from_center=true,
				set_magic_creation=true,
				is_emitting=true,
			});
			EntityAddComponent(liquid, "LifetimeComponent", {
				lifetime="120",
			});	
		end,
	},
	{
		id = "TWITCH_EXTENDED_RANDOM_POTION",
		ui_name = "$twitch_extended_random_potion",
		ui_description = "$twitch_extended_random_potion_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			local potion_material = ""
			if (Random(0, 100) <= 75) then
				if (Random(0, 100000) <= 50) then
					potion_material = "magic_liquid_hp_regeneration"
				elseif (Random(200, 100000) <= 250) then
					potion_material = "purifying_powder"
				else
					potion_material = random_from_array(potion_materials_magic)
				end
			else
				potion_material = random_from_array(potion_materials_standard)
			end
			local x, y = get_player_pos()
			-- just go ahead and assume cheatgui is installed
			local entity = EntityLoad("mods/twitch_extended/files/entities/misc/potion_empty.xml", x, y)
			AddMaterialInventoryMaterial(entity, potion_material, 1000)
		end,
	},
	{
		id = "TWITCH_EXTENDED_RANDOMIZE_WAND",
		ui_name = "$twitch_extended_randomize_wand",
		ui_description = "$twitch_extended_randomize_wand_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			entity_id = get_player()

			if(entity_id ~= nil)then
				local x, y = EntityGetTransform( entity_id )
				local inventory = get_inventory()

				if ( inventory ~= nil ) then
					local inventory_items = get_wands()
					
					if inventory_items ~= nil then
						local replaced_wand = inventory_items[Random(1,table.getn(inventory_items))]

						local wand_level = wand_compute_level(replaced_wand)

						local wand_entity = nil
						if(wand_level == 0)then
							local rand = Random(1, 17)
							local extra_string = ""
							if(rand < 10)then
								extra_string = "00"..tostring(rand)
							else
								extra_string = "0"..tostring(rand)
							end
							wand_entity = EntityLoad("data/entities/items/wands/level_01/wand_"..extra_string..".xml",x, y)
						else
							wand_entity = EntityLoad("data/entities/items/wand_level_0"..math.max(wand_level, 1)..".xml", x, y)
						end

						if(wand_entity ~= nil)then
							GameKillInventoryItem( entity_id, replaced_wand )
							--EntityAddChild( inventory, wand_entity )
							GamePickUpInventoryItem(entity_id, wand_entity, false)
							local inventory2 = EntityGetFirstComponent( entity_id, "Inventory2Component" );
							if inventory2 ~= nil then
								ComponentSetValue2( inventory2, "mForceRefresh", true );
								ComponentSetValue2( inventory2, "mActualActiveItem", 0)
							end
						end
						
					end	
				end	
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_REFLECT_MELEE",
		ui_name = "$twitch_extended_reflect_melee",
		ui_description = "$twitch_extended_reflect_melee_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
				
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/reflect_melee.xml", x, y )
               -- set_lifetime( effect_id )
                EntityAddChild( entity_id, effect_id )
                
                add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/reflect_melee.png", event )
            end
		end,
	},
	{
		id = "TWITCH_EXTENDED_REGULAR_DUCKS",
		ui_name = "$twitch_extended_regular_ducks",
		ui_description = "$twitch_extended_regular_ducks_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			for i = 1, 25 do
				spawn_item("data/entities/animals/duck.xml", 10, 50, false)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_REGULAR_DUCKS_2",
		ui_name = "$twitch_extended_regular_ducks_2",
		ui_description = "$twitch_extended_regular_ducks_2_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.5,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			for i = 1, 4 do
				local duck = spawn_item("mods/twitch_extended/files/entities/animals/ducks/duck_leg.xml", 50, 70, false)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_HUNTING_DOGS",
		ui_name = "$twitch_extended_hunting_dogs",
		ui_description = "$twitch_extended_hunting_dogs_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			count = Random(4, 12)
			for i = 1, count do
				spawn_item("data/entities/animals/wolf.xml", 50, 70, false)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_SCATTER_GOLD",
		ui_name = "$twitch_extended_scatter_gold",
		ui_description = "$twitch_extended_scatter_gold_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			local player = get_player()
			local wallet = EntityGetFirstComponent(player, "WalletComponent")
			if(wallet ~= nil)then
				local money = tonumber(ComponentGetValueInt(wallet, "money"))
				ComponentSetValue(wallet, "money", 0)

				nugget_count = 100
				nugget_value = math.floor(money / 100)
				

				if(money < 100)then
					nugget_count = money
					nugget_value = 1
				end
				


				for i = 1, nugget_count do
					nugget = spawn_item("data/entities/items/pickup/goldnugget.xml", 50, 150)
					storage_comps = EntityGetComponent(nugget, "VariableStorageComponent")
					lifetime = EntityGetFirstComponent(nugget, "LifetimeComponent")
					if(lifetime ~= nil)then
						ComponentSetValue2(lifetime, "lifetime", 1400)
					end
					for k, v in pairs(storage_comps)do
						if(ComponentGetValue2(v, "name") == "gold_value")then
							ComponentSetValue2(v, "value_int", nugget_value) 
						end
					end
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_SHUFFLE_WAND",
		ui_name = "$twitch_extended_shuffle_wand",
		ui_description = "$twitch_extended_shuffle_wand_description",
		ui_icon = "data/ui_gfx/streaming_event_icons/speedy_enemies.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local player = get_players()[1]
    
			local wands = get_wands()
			if wands == nil then return end
			local to_boost = table.getn(wands)
	  
		 	 local good_wands = {}
		  
			for i = 1, to_boost do
				local ability = EntityGetAllComponents(wands[i])
				for _, c in ipairs(ability) do
					if ComponentGetTypeName(c) == "AbilityComponent" then
				if(tonumber(ComponentObjectGetValue(c, "gun_config", "shuffle_deck_when_empty")) == 0)then
				  table.insert(good_wands, wands[i])
				end    
					end
				end
			end
		  
			local chosen_wand = good_wands[Random(1, table.getn(good_wands))]
			ability = EntityGetAllComponents(chosen_wand)
			for _, c in ipairs(ability) do
				if ComponentGetTypeName(c) == "AbilityComponent" then
				ComponentObjectSetValue(c, "gun_config", "shuffle_deck_when_empty", tostring(1))
				end
			end
			  
			local inventory2 = EntityGetFirstComponent( player, "Inventory2Component" );
			if inventory2 ~= nil then
				ComponentSetValue2( inventory2, "mForceRefresh", true );
				ComponentSetValue2( inventory2, "mActualActiveItem", 0)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_UNSHUFFLE_WAND",
		ui_name = "$twitch_extended_unshuffle_wand",
		ui_description = "$twitch_extended_unshuffle_wand_description",
		ui_icon = "data/ui_gfx/streaming_event_icons/speedy_enemies.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			local player = get_players()[1]
	
			local wands = get_wands()
			if wands == nil then return end
			local to_boost = table.getn(wands)
		
			local good_wands = {}
			
			for i = 1, to_boost do
				local ability = EntityGetAllComponents(wands[i])
				for _, c in ipairs(ability) do
					if ComponentGetTypeName(c) == "AbilityComponent" then
						if(tonumber(ComponentObjectGetValue(c, "gun_config", "shuffle_deck_when_empty")) == 1)then
							table.insert(good_wands, wands[i])
						end    
					end
				end
			end
			
			local chosen_wand = good_wands[Random(1, table.getn(good_wands))]
			ability = EntityGetAllComponents(chosen_wand)
			for _, c in ipairs(ability) do
				if ComponentGetTypeName(c) == "AbilityComponent" then
					ComponentObjectSetValue(c, "gun_config", "shuffle_deck_when_empty", tostring(0))
				end
			end
			local inventory2 = EntityGetFirstComponent( player, "Inventory2Component" );
			if inventory2 ~= nil then
				ComponentSetValue2( inventory2, "mForceRefresh", true );
				ComponentSetValue2( inventory2, "mActualActiveItem", 0)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_SPICY_DUCKS",
		ui_name = "$twitch_extended_spicy_ducks",
		ui_description = "$twitch_extended_spicy_ducks_description",
		ui_icon = "data/ui_gfx/streaming_event_icons/speedy_enemies.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i = 1, 20 do
				local duck = spawn_item("data/entities/animals/duck.xml", 30, 80, false)
				--local x, y = EntityGetTransform(duck)
				attach_bomb(duck, 30, 5, 300)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_STRENGTH",
		ui_name = "$twitch_extended_strength",
		ui_description = "$twitch_extended_strength_description",
		ui_icon = "data/ui_gfx/streaming_event_icons/speedy_enemies.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)

			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/strength.xml", x, y )
				--set_lifetime( effect_id )
				EntityAddChild( entity_id, effect_id )
				
				add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/super_damage.png", event )
			end

		end,
	},
	{
		id = "TWITCH_EXTENDED_STUN",
		ui_name = "$twitch_extended_stun",
		ui_description = "$twitch_extended_stun_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local player = get_player()
			local game_effect = GetGameEffectLoadTo( player, "ELECTROCUTION", true );
			if game_effect ~= nil then ComponentSetValue( game_effect, "frames", 120 ); end
		end,
	},
	{
		id = "TWITCH_EXTENDED_TP_STREAMER",
		ui_name = "$twitch_extended_tp_streamer",
		ui_description = "$twitch_extended_tp_streamer_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			async(function()
				for _,player_entity in pairs( get_players() ) do
					--[[
					local px, py = EntityGetTransform(player_entity)
					local tele = EntityLoad("mods/twitch_extended/files/entities/particles/teleport.xml", px, py)
					EntityAddChild(player_entity, tele)
					wait(2)
					local x, y = get_spawn_pos(500, 1000)
					EntityApplyTransform(player_entity, x, y)
					]]

					
					local game_effect = GetGameEffectLoadTo( player_entity, "TELEPORTATION", false );
					if game_effect ~= nil then
						ComponentSetValue( game_effect, "frames", 60 );
					end
				end
			end)
		end,
	},
	{
		id = "TWITCH_EXTENDED_TENTACLES",
		ui_name = "$twitch_extended_tentacles",
		ui_description = "$twitch_extended_tentacles_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i = 1, 4 do
				spawn_item("data/entities/projectiles/deck/tentacle_portal.xml", 30, 120, true)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_THUNDERSTONES",
		ui_name = "$twitch_extended_thunderstones",
		ui_description = "$twitch_extended_thunderstones_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i = 1, 10 do
				spawn_item("data/entities/items/pickup/thunderstone.xml", 50, 250, false, true)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_THUNDERSTORM",
		ui_name = "$twitch_extended_thunderstorm",
		ui_description = "$twitch_extended_thunderstorm_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i = 1, 2 do
				local x, y = get_player_pos()
			  
				EntityLoad("data/entities/projectiles/deck/cloud_thunder.xml", x + Random(-30, 30), y - 50)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_WHISKY_RAIN",
		ui_name = "$twitch_extended_whisky_rain",
		ui_description = "$twitch_extended_whisky_rain_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local x, y = get_player_pos()
	  
			EntityLoad("mods/twitch_extended/files/entities/misc/cloud_whisky.xml", x, y - 50)
		end,
	},
	{
		id = "TWITCH_EXTENDED_WHISKY_WORLD",
		ui_name = "$twitch_extended_whisky_world",
		ui_description = "$twitch_extended_whisky_world_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			spawn_item("mods/twitch_extended/files/entities/misc/whisky.xml", 0, 0, false, true)
		end,
	},
	{
		id = "TWITCH_EXTENDED_WINDY",
		ui_name = "$twitch_extended_windy",
		ui_description = "$twitch_extended_windy_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)

			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/wind.xml", x, y )
				--set_lifetime( effect_id )
				EntityAddChild( entity_id, effect_id )
				
				add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/windy.png", event )
			end

		end,
	},
--[[	--Disabled while being reworked
	{
		id = "TWITCH_EXTENDED_ZOMBIE_APOCALYPSE",
		ui_name = "$twitch_extended_zombie_apocalypse",
		ui_description = "$twitch_extended_zombie_apocalypse",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.5,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			async(function()
				local TEXT = {
					font="data/fonts/font_pixel_white.xml",
					string="10",
					offset_x="2",
					offset_y="32",
					alpha="0.50",
					scale_x="0.8",
					scale_y="0.8"
				}
				if(get_player() == nil)then return end
				local timer = append_text(get_player(), TEXT)
				
				local tnt = Random(5, 9)
				local small_bombs = Random(10, 15)
				local bombs = Random(5, 10)
		
				for i=1, tonumber(TEXT.string) do
					wait(60)
					if(get_player() == nil)then return end
					local num = tonumber(TEXT.string) - i
					ComponentSetValue( timer, "text", tostring(num) )
				end
				wait(60)
				if(get_player() == nil)then return end
				EntityRemoveComponent(get_player(), timer)
		
				GameScreenshake( 200 )
				enemies = {"data/entities/animals/zombie_weak.xml","data/entities/animals/longleg.xml","data/entities/animals/worm.xml","data/entities/animals/shotgunner_weak.xml","data/entities/animals/miner_weak.xml"}
				for i = 1, small_bombs do
					spawn_item(enemies[Random(1,table.getn(enemies))], 80, 200)
				end
		
				TEXT.string = "10"
				if(get_player() == nil)then return end
				timer = append_text(get_player(), TEXT)
				for i=1, tonumber(TEXT.string) do
					wait(60)
					if(get_player() == nil)then return end
					local num = tonumber(TEXT.string) - i
					ComponentSetValue( timer, "text", tostring(num) )
				end
				wait(60)
				if(get_player() == nil)then return end
				EntityRemoveComponent(get_player(), timer)
		
				GameScreenshake( 400 )
				pre_bosses = {"data/entities/animals/acidshooter_weak.xml","data/entities/animals/fireskull.xml","data/entities/animals/giantshooter_weak.xml","data/entities/animals/shotgunner_weak.xml"}
		
				for i = 1, bombs do
					spawn_item(pre_bosses[Random(1,table.getn(pre_bosses))], 80, 200)
				end
		
				TEXT.string = "10"
				if(get_player() == nil)then return end
				timer = append_text(get_player(), TEXT)
				for i=1, tonumber(TEXT.string) do
					wait(60)
					if(get_player() == nil)then return end
					local num = tonumber(TEXT.string) - i
					ComponentSetValue( timer, "text", tostring(num) )
				end
				wait(60)
				if(get_player() == nil)then return end
				EntityRemoveComponent(get_player(), timer)
				GameScreenshake( 1000 )
				bosses = {"data/entities/animals/worm_big.xml","data/entities/animals/thundermage.xml","data/entities/animals/iceskull.xml","data/entities/animals/scavenger_grenade.xml"}
				for i = 1, 2 do
					spawn_item(bosses[Random(1,table.getn(bosses))], 80, 200)
				end
				TEXT.string = "10"
				if(get_player() == nil)then return end
				timer = append_text(get_player(), TEXT)
				for i=1, tonumber(TEXT.string) do
					wait(60)
					if(get_player() == nil)then return end
					local num = tonumber(TEXT.string) - i
					ComponentSetValue( timer, "text", tostring(num) )
				end
				wait(60)
				if(get_player() == nil)then return end
				EntityRemoveComponent(get_player(), timer)
				GameScreenshake( 1000 )
				  for i = 1, 40 do
					spawn_item("data/entities/items/pickup/goldnugget.xml", 50, 100)
				  end
			end)
		end,
	},]]
	{
		id = "TWITCH_EXTENDED_MESS_WAND",
		ui_name = "$twitch_extended_mess_wand",
		ui_description = "$twitch_extended_mess_wand_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
			local player = get_player()
			wands_unfiltered = get_wands()
			wands = {}
			for k, v in pairs(wands_unfiltered)do
				local children = EntityGetAllChildren( v );
				if(children ~= nil)then
					if(#children > 0)then
						table.insert(wands, v)
					end
				end
			end
			if #wands > 0 then
				local filtered_wands = {};
				for _,wand in pairs(wands) do
					if is_wand_always_cast_valid( wand ) then
						table.insert( filtered_wands, wand );
					end
				end
				if #filtered_wands > 0 then
					wands = filtered_wands;
					local inventory2 = EntityGetFirstComponent( player, "Inventory2Component" );
					local active_item = tonumber( ComponentGetValue( inventory2, "mActiveItem" ) );
					if base_wand == nil then
						base_wand =  random_from_array( wands );
					end
				end
			end

			if base_wand ~= nil then
				local children = EntityGetAllChildren( base_wand );
		
				local old_actions = {};
				for i,v in ipairs( children ) do
					local allow = false
					for k, v2 in pairs(EntityGetAllComponents( v ))do
						if ComponentGetTypeName( v2 ) == "ItemComponent" then
							if ComponentGetValue2( v2, "permanently_attached" ) == false and ComponentGetValue2( v2, "is_frozen" ) == false then
								allow = true
								spell = {
									uses_remaining = ComponentGetValue2( v2, "uses_remaining" ),
								}
								table.insert(old_actions, spell)
							end
						end
					end

					for k, v2 in pairs(EntityGetAllComponents( v ))do
						--print(ComponentGetTypeName( v2 ))


						if(ComponentGetTypeName(v2) == "ItemActionComponent")then
							for o, p in pairs(ComponentGetMembers( v2 ))do

								if(allow == true)then
									old_actions[#old_actions].spell = p
								end
							end
						end
					end

					if(allow == true)then
						EntityKill(v)
					end
					--[[
					local inventory2 = EntityGetFirstComponent( player, "Inventory2Component" );
					if inventory2 ~= nil then
						ComponentSetValue2( inventory2, "mForceRefresh", true );
						ComponentSetValue2( inventory2, "mActualActiveItem", 0)
					end]]
				end

				actions = shuffle(old_actions)

				for k, action in pairs(actions)do
					local action_entity = CreateItemActionEntity( action.spell )
					if action_entity ~= 0 then
						EntityAddChild( base_wand, action_entity )
						EntitySetComponentsWithTagEnabled( action_entity, "enabled_in_world", false )
					end
					for k2, v2 in pairs(EntityGetAllComponents( action_entity ))do
						if ComponentGetValue( v2, "permanently_attached" ) == "0" and ComponentGetValue( v2, "is_frozen" ) == "0" then
							ComponentSetValue2(v2, "uses_remaining", action.uses_remaining)
						end
					end
				end

			end
			
			local inventory2 = EntityGetFirstComponent( player, "Inventory2Component" );
			if inventory2 ~= nil then
				ComponentSetValue2( inventory2, "mForceRefresh", true );
				ComponentSetValue2( inventory2, "mActualActiveItem", 0)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_MESS_WANDS",
		ui_name = "$twitch_extended_mess_wands",
		ui_description = "$twitch_extended_mess_wands_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.8,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
			local player = get_player()
			wands_unfiltered = get_wands()
			wands = {}
			for k, v in pairs(wands_unfiltered)do
				local children = EntityGetAllChildren( v );
				if(children ~= nil)then
					if(#children > 0)then
						table.insert(wands, v)
					end
				end
			end

			if(#wands > 0)then
				local old_actions = {};
				for k, base_wand in pairs(wands)do

					local children = EntityGetAllChildren( base_wand );
		
					for i,v in ipairs( children ) do
						spell_id = nil
						for k, v2 in pairs(EntityGetAllComponents( v ))do
	
							if(ComponentGetTypeName(v2) == "ItemActionComponent")then
								for o, p in pairs(ComponentGetMembers( v2 ))do
									spell_id = p
								end
							end
						end

						allow = false
						if(spell_id ~= nil)then
							for k, v2 in pairs(EntityGetAllComponents( v ))do
								if ComponentGetTypeName( v2 ) == "ItemComponent" then
									if ComponentGetValue2( v2, "permanently_attached" ) == false and ComponentGetValue2( v2, "is_frozen" ) == false then
										allow = true
										spell = {
											uses_remaining = ComponentGetValue2( v2, "uses_remaining" ),
											spell = spell_id
										}
										table.insert(old_actions, spell)
										EntityKill(v)
									end
								end
							end

							
						end
					end
				end
				actions = shuffle(old_actions)
				actions_left = #actions
				action_id = 0

				wand_table = {
				}

				function wand_in_table(id)
					exists = false
					for k, v in pairs(wand_table)do
						if(v.wand_id == id)then
							exists = true
						end
					end
					return exists
				end

				while(actions_left > 0)do
					for k, base_wand in pairs(wands)do
						wand_prototype = {
							wand_id = 0,
							spells = {}
						}
		
						local ability_component = EntityGetFirstComponentIncludingDisabled( base_wand, "AbilityComponent" );

						if ability_component ~= nil then
							local deck_capacity = ComponentObjectGetValue2( ability_component, "gun_config", "deck_capacity" );
							if(wand_in_table(base_wand) == false)then
								wand_prototype.wand_id = base_wand
								table.insert(wand_table, wand_prototype)
							end
							for k, v in pairs(wand_table)do
								if(v.wand_id == base_wand)then
									if(#v.spells < deck_capacity)then
										action_id = action_id + 1
										
										if(actions_left > 0)then
											new_action = actions[action_id]
											if(new_action.spell)then
												table.insert(v.spells, new_action.spell)
												local action_entity = CreateItemActionEntity( new_action.spell )
												if action_entity ~= 0 then
													EntityAddChild( base_wand, action_entity )
													EntitySetComponentsWithTagEnabled( action_entity, "enabled_in_world", false )
												end
												for k2, v2 in pairs(EntityGetAllComponents( action_entity ))do
													if ComponentGetValue( v2, "permanently_attached" ) == "0" and ComponentGetValue( v2, "is_frozen" ) == "0" then
														ComponentSetValue2(v2, "uses_remaining", actions[action_id].uses_remaining)
													end
												end
											end
										end
										actions_left = actions_left - 1
									end
								end
							end
						end
					end
				end
			end
			local inventory2 = EntityGetFirstComponent( player, "Inventory2Component" );
			if inventory2 ~= nil then
				ComponentSetValue2( inventory2, "mForceRefresh", true );
				ComponentSetValue2( inventory2, "mActualActiveItem", 0)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_1D20",
		ui_name = "$twitch_extended_1d20",
		ui_description = "$twitch_extended_1d20_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.9,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			handler_entity = EntityCreateNew()
			EntityAddComponent2(handler_entity, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/scripts/events/1d20.lua",
				vm_type="ONE_PER_COMPONENT_INSTANCE",
				execute_on_added=true,
				execute_every_n_frame=-1,
				execute_times=1,
				enable_coroutines=true,
			})
		end,
	},
	{
		id = "TWITCH_EXTENDED_2D20",
		ui_name = "$twitch_extended_2d20",
		ui_description = "$twitch_extended_2d20_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.9,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			handler_entity = EntityCreateNew()
			EntityAddComponent2(handler_entity, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/scripts/events/2d20.lua",
				vm_type="ONE_PER_COMPONENT_INSTANCE",
				execute_on_added=true,
				execute_every_n_frame=-1,
				execute_times=1,
				enable_coroutines=true,
			})

		end,
	},
	{
		id = "TWITCH_EXTENDED_GOLD_HURTS",
		ui_name = "$twitch_extended_gold_hurts",
		ui_description = "$twitch_extended_gold_hurts_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.9,
		kind = STREAMING_EVENT_AWFUL,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/gold_hurts.xml", x, y )
				--set_lifetime( effect_id )
				EntityAddChild( entity_id, effect_id )
				
				add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/gold_hurts.png", event )
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_MATERIAL_TRANSFORMATION",
		ui_name = "$twitch_extended_material_transformation",
		ui_description = "$twitch_extended_material_transformation_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.9,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				EntityLoad( "mods/twitch_extended/files/entities/misc/liquid_transformation.xml", x, y )
				--set_lifetime( effect_id )
				--EntityAddChild( entity_id, effect_id )
				
				--add_icon_in_hud( effect_id, "mods/twitch_extended/files/events/icons/liquid_transformation.png", event )
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_HOLY_CARPENTER",
		ui_name = "$twitch_extended_holy_carpenter",
		ui_description = "$twitch_extended_holy_carpenter_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.9,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/water_to_alcohol.xml", x, y )
				--set_lifetime( effect_id )
				EntityAddChild( entity_id, effect_id )
				
				add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/liquid_to_alcohol.png", event )
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_HALF_HEALTH",
		ui_name = "$twitch_extended_half_health",
		ui_description = "$twitch_extended_half_health_description",
		ui_icon = "",
		ui_author = STREAMING_EVENT_AUTHOR_NOLLAGAMES.."/".."Evaisa",
		weight = 0.75,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i,entity_id in ipairs( get_players() ) do
				local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
				
				local max_hp = 0
				local hp = 0
				
				if( damagemodels ~= nil ) then
					for a,damagemodel in ipairs(damagemodels) do
						max_hp = ComponentGetValue2( damagemodel, "max_hp" )
						hp = max_hp / 2
						
						ComponentSetValue2( damagemodel, "hp", hp )
					end
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_REDUCE_MAX_HP",
		ui_name = "$twitch_extended_reduce_max_hp",
		ui_description = "$twitch_extended_reduce_max_hp_description",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = STREAMING_EVENT_AUTHOR_NOLLAGAMES.."/".."Evaisa",
		weight = 0.75,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i,entity_id in ipairs( get_players() ) do
				local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
				
				local max_hp_old = 0
				local max_hp = 0
				local hp = 0
				
				if( damagemodels ~= nil ) then
					for a,damagemodel in ipairs(damagemodels) do
						max_hp = ComponentGetValue2( damagemodel, "max_hp" )
						hp = ComponentGetValue2( damagemodel, "hp" )
						
						new_max_hp = max_hp / 100 * 85
						new_hp = max_hp / 100 * 85

						ComponentSetValue2( damagemodel, "max_hp", new_max_hp )
						ComponentSetValue2( damagemodel, "hp", new_hp )
					end
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_SANDS_OF_TIME",
		ui_name = "$twitch_extended_sands_of_time",
		ui_description = "$twitch_extended_sands_of_time_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.8,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			x, y = get_player_pos()
			EntityLoad("mods/twitch_extended/files/entities/misc/sands_of_time.xml", x, y)
		end,
	},
	{
		id = "TWITCH_EXTENDED_TENTACLE_MONSTER",
		ui_name = "$twitch_extended_tentacle_monster",
		ui_description = "$twitch_extended_tentacle_monster_description",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 0.8,
		kind = STREAMING_EVENT_AWFUL,
		action = function(event)
			spawn_item("mods/twitch_extended/files/entities/misc/tentacle_orb.xml", 100, 200)
		end,
	},
	-- New Events
	{
		id = "TWITCH_EXTENDED_FOOD",
		ui_name = "Overeating",
		ui_description = "You are stuffed with food.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local players = get_players()

			for i,entity_id in ipairs( players ) do
				IngestionComps = EntityGetComponent(entity_id, "IngestionComponent")

				for k, v in pairs(IngestionComps)do
					ComponentSetValue2(v, "ingestion_size", 9000)
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_CHAOTIC_POLYMORPH_ENEMIES",
		ui_name = "Chaotic Polymorph Creatures",
		ui_description = "Apply chaotic polymorph to all creatures in range",
		ui_icon = "data/ui_gfx/streaming_event_icons/polymorph_enemies.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local t = GameGetFrameNum()
			for id,enemy in pairs(get_enemies_in_radius(400)) do
				local game_effect_comp,game_effect_entity = GetGameEffectLoadTo( enemy, "POLYMORPH_RANDOM", false )
				local icon = "polymorph_random"
				
				if (game_effect_comp ~= nil) and (game_effect_entity ~= nil) and (icon ~= nil) then
					ComponentSetValue2( game_effect_comp, "frames", get_lifetime() )
					add_icon_above_head( game_effect_entity, "data/ui_gfx/status_indicators/" .. icon .. ".png", event )
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_SUPER_CHEST",
		ui_name = "Spawn Super Chest",
		ui_description = "A super chest has been spawned!",
		ui_icon = "data/ui_gfx/streaming_event_icons/polymorph_enemies.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			spawn_item("data/entities/items/pickup/chest_random_super.xml", 10, 15)
		end,
	},
	{
		id = "TWITCH_EXTENDED_RANDOM_MASTER",
		ui_name = "Random Masters",
		ui_description = "Spawn random masters.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		delay_timer = 300,
		action_delayed = function(event)
			local players = get_players()
			
			local pool = {
				"wizard_dark",
				"wizard_hearty",
				"wizard_neutral",
				"wizard_poly",
				"wizard_returner",
				"wizard_swapper",
				"wizard_tele",
				"wizard_twitchy",
				"wizard_weaken",
				"wizard_wither",
			}

			for i,entity_id in ipairs( players ) do
				for i = 1, 3 do
					spawn_item("data/entities/animals/"..pool[Random(1, #pool)]..".xml", 80, 180, false)
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_RANDOM_MAGE",
		ui_name = "Random Mages",
		ui_description = "Spawn random mages",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		delay_timer = 300,
		action_delayed = function(event)
			local players = get_players()
			
			local pool = {
				"thundermage",
				"firemage",
				"firemage_weak",
			}

			for i,entity_id in ipairs( players ) do
				for i = 1, 3 do
					spawn_item("data/entities/animals/"..pool[Random(1, #pool)]..".xml", 80, 180, false)
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_CHAOS_DIE",
		ui_name = "Chaos Die",
		ui_description = "Spawns a chaos die",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			local players = get_players()

			for i,entity_id in ipairs( players ) do
				
				local x, y = EntityGetTransform(entity_id)
				die = spawn_item( "data/entities/items/pickup/physics_die.xml", 50, 80, false)
				x_vel = Random(200, 300)
				if(Random(0,100) >= 50)then
					x_vel = -x_vel
				end
				PhysicsApplyForce( die, x_vel, Random(100, 200) )
				PhysicsApplyTorque( die, x_vel / 2 )

				local variablestorages = EntityGetComponent( die, "VariableStorageComponent" )
				if ( variablestorages ~= nil ) then
					for j,storage_id in ipairs(variablestorages) do
						local var_name = ComponentGetValue( storage_id, "name" )
						if ( var_name == "rolling" ) then
							if ( ComponentGetValue2( storage_id, "value_int" ) == 0 ) then
								local players = EntityGetInRadiusWithTag( pos_x, pos_y, 480, "player_unit" )
								
								if ( #players > 0 ) then
									GamePrint( "$item_die_roll" )
								end
							end
							
							ComponentSetValue2( storage_id, "value_int", 1 )
							
							edit_component2( die, "SpriteComponent", function(comp,vars)
								ComponentSetValue2( comp, "rect_animation", "roll")
							end)
						end
					end
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_SAFE_HAVEN",
		ui_name = "Safe Haven",
		ui_description = "Summon a cozy hut",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_GOOD,
		action = function(event)
			local players = get_players()

			for i,entity_id in ipairs( players ) do
				
				local pos_x, pos_y = EntityGetTransform(entity_id)

				GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/heart_fullhp/create", pos_x, pos_y )
				EntityLoad("data/entities/buildings/safe_haven_building.xml", pos_x, pos_y)
				
				local hp = 4.0
				local player = entity_id
				if player ~= nil then
					component_read( EntityGetFirstComponent(player, "DamageModelComponent"), { max_hp = 4.0 }, function(comp)
						hp = comp.max_hp
					end)
				end

				-- spawn healing projectiles
				local storage_comp = get_variable_storage_component(entity_id, "player_hp")
				local hp = hp * 0.6 -- max 60% healing
				local projectile_count = math.floor(math.min(20, hp * 3)) -- limit shots for performance reasons
				--print("total heal: " .. hp .. ". projectile amount " .. projectile_count)
				hp = hp / projectile_count -- hp per shot
				--print("heal per projectile: " .. hp)
				for i=1,projectile_count do
					local x = pos_x + ProceduralRandom(pos_x, pos_y - i, -10, 10)
					local y = pos_y + ProceduralRandom(pos_x + i, pos_y * 0.63, -8, 8) - 10
					local e = EntityLoad("data/entities/projectiles/healshot_safe_haven.xml", x, y)
					-- scale healing power of shots
					comp = EntityGetFirstComponent(e, "ProjectileComponent")
					ComponentObjectSetValue2(comp, "damage_by_type", "healing", -hp)
				end
			
				-- props
				EntityLoad("data/entities/props/physics/lantern_small.xml", pos_x - 1, pos_y - 32)
				EntityLoad("data/entities/props/furniture_bed.xml", pos_x - 36, pos_y - 8)
				EntityLoad("data/entities/props/furniture_wood_table.xml", pos_x + 41, pos_y - 8)
				EntityLoad("data/entities/props/physics_box_explosive.xml", pos_x + 46, pos_y - 12)
				
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_GREED_CURSE",
		ui_name = "Greed Curse",
		ui_description = "30 seconds of greed curse.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/greed_curse.xml", x, y )
				
				EntityAddChild( entity_id, effect_id )
				add_icon_in_hud( effect_id, "data/ui_gfx/status_indicators/greed_curse.png", event )
				
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_HAMIS",
		ui_name = "Revenge Of Hämis",
		ui_description = "They have arrived to claim your life.",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			for i=1, 15 do
				spawn_item("data/entities/animals/longleg.xml", 20, 80, false, true)
			end	
		end,
	},
	{
		id = "TWITCH_EXTENDED_CIRCLE_OF_LIFE",
		ui_name = "Circle Of Life",
		ui_description = "It's.. It's a healing circle.",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			spawn_item("mods/twitch_extended/files/entities/misc/circle_life.xml", 0, 0)
		end,
	},
	{
		id = "TWITCH_EXTENDED_SPAWN_KAKKAKIKKARE",
		ui_name = "Summon Kakkakikkare",
		ui_description = "A poop stone is summoned.",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			spawn_item("data/entities/items/pickup/poopstone.xml", 10, 20)
		end,
	},
	{
		id = "TWITCH_EXTENDED_FART",
		ui_name = "Greater Fart",
		ui_description = "Feeling a little gassy are we?",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
				local x, y = EntityGetTransform(entity_id)

				EntityLoad("mods/twitch_extended/files/entities/misc/fart.xml", x, y)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_SUMMON_TAIKASAUVA",
		ui_name = "Summon Taikasauva",
		ui_description = "A magic wand comes to aid!",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			spawn_item("mods/twitch_extended/files/entities/misc/wand_ghost.xml", 5, 10)
		end,
	},
	{
		id = "TWITCH_EXTENDED_LIQUID_BARRIER",
		ui_name = "Barrier Liquid",
		ui_description = "Liquid is now barriers.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
				local x, y = EntityGetTransform(entity_id)

				EntityLoad("mods/twitch_extended/files/entities/misc/materials_to_barrier.xml", x, y)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_PANDORIUM",
		ui_name = "Pandorium",
		ui_description = "Nearby liquid is transformed to pandorium.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 0.4,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
				local x, y = EntityGetTransform(entity_id)

				EntityLoad("mods/twitch_extended/files/entities/misc/materials_to_pandorium.xml", x, y)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_UNSTABLE_PANDORIUM",
		ui_name = "Unstable Pandorium",
		ui_description = "Nearby liquid is transformed to unstable pandorium.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 0.1,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
				local x, y = EntityGetTransform(entity_id)

				EntityLoad("mods/twitch_extended/files/entities/misc/materials_to_unstable_pandorium.xml", x, y)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_POPROCKS",
		ui_name = "Poprocks",
		ui_description = "Nearby liquid is transformed to poprocks.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 0.1,
		kind = STREAMING_EVENT_BAD,
		action = function(event)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
				local x, y = EntityGetTransform(entity_id)

				EntityLoad("mods/twitch_extended/files/entities/misc/materials_to_poprocks.xml", x, y)
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_TRANSFORM_BOMBS",
		ui_name = "Spells To Bombs",
		ui_description = "Spells are converted to bombs.",
		ui_icon = "data/ui_gfx/streaming_event_icons/protect_enemies.png",
		ui_author = "Evaisa",
		weight = 0.1,
		kind = STREAMING_EVENT_BAD,
		delay_timer = 180,
		action_delayed = function(event)
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/effect_bombs.xml", x, y )
				EntityAddChild( entity_id, effect_id )
				
				add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/bomb.png", event )
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_TRANSFORM_BLACKHOLES",
		ui_name = "Spells To Blackholes",
		ui_description = "Spells are converted to black holes.",
		ui_icon = "data/ui_gfx/streaming_event_icons/protect_enemies.png",
		ui_author = "Evaisa",
		weight = 0.1,
		kind = STREAMING_EVENT_BAD,
		delay_timer = 180,
		action_delayed = function(event)
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/effect_blackholes.xml", x, y )
				EntityAddChild( entity_id, effect_id )
				
				add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/blackhole.png", event )
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_TRANSFORM_GIGA_BLACKHOLES",
		ui_name = "Spells To Giga Blackholes",
		ui_description = "Spells are converted to giga blackholes.",
		ui_icon = "data/ui_gfx/streaming_event_icons/protect_enemies.png",
		ui_author = "Evaisa",
		weight = 0.1,
		kind = STREAMING_EVENT_BAD,
		delay_timer = 180,
		action_delayed = function(event)
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/effect_giga_blackholes.xml", x, y )
				EntityAddChild( entity_id, effect_id )
				
				add_icon_in_hud( effect_id, "mods/twitch_extended/files/gfx/status_effects/blackhole_big.png", event )
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_CIRCLE_OF_ACID",
		ui_name = "Circle Of Acid",
		ui_description = "A circle of acid has appeared, you better run..",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		delay_timer = 180,
		action_delayed = function(event)
			spawn_item("mods/twitch_extended/files/entities/misc/circle_acid.xml", 150, 200, true, false, 50)
		end,
	},
	{
		id = "TWITCH_EXTENDED_ENEMIES_EXPLODE",
		ui_name = "Explode Enemies",
		ui_description = "All nearby enemies explode.",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_NEUTRAL,
		action = function(event)
			for _,player_entity in pairs( get_players() ) do
				local x, y = EntityGetTransform( player_entity );
				for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 2000, "enemy" ) or {} ) do
					attach_bomb(entity, 30, 5, 1)
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_CURSED_ROCK",
		ui_name = "Cursed Rock",
		ui_description = "Slowly turn the area into cursed rock.",
		ui_icon = "",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)

			spawn_item("mods/twitch_extended/files/entities/misc/cursed_rock.xml", 50, 80, false, true)

		end,
	},
	{
		id = "TWITCH_EXTENDED_SPAWN_SPELL",
		ui_name = "Spawn Spell",
		ui_description = "Spawn a random spell.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)			
			spawn_spell()
		end,
	},
	{
		id = "TWITCH_EXTENDED_HASTIUM",
		ui_name = "Hastium",
		ui_description = "100 seconds of hastium.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)			
			for _,enemy in pairs(get_players()) do
				local game_effect_comp,game_effect_entity = GetGameEffectLoadTo( enemy, "MOVEMENT_FASTER_2X", false )
				if game_effect_comp ~= nil then
					ComponentSetValue2( game_effect_comp, "frames", 6000 )
					add_icon_in_hud( game_effect_entity, "data/ui_gfx/status_indicators/movement_faster.png", event )
				end

				game_effect_comp,game_effect_entity = GetGameEffectLoadTo( enemy, "FASTER_LEVITATION", false )
				if game_effect_comp ~= nil then
					ComponentSetValue2( game_effect_comp, "frames", 6000 )
					add_icon_in_hud( game_effect_entity, "data/ui_gfx/status_indicators/faster_levitation.png", event )
				end
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_WORM_VISOR",
		ui_name = "Worm Visor",
		ui_description = "200 seconds of worm vision",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_BAD,
		action = function(event)	
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				local effect_id = EntityLoad( "data/entities/misc/effect_nightvision.xml", x, y )
				
				local effect_comp = EntityGetFirstComponentIncludingDisabled(effect_id, "GameEffectComponent")

				ComponentSetValue2( effect_comp, "frames", 12000 )

				EntityAddChild( entity_id, effect_id )
				add_icon_in_hud( effect_id, "data/ui_gfx/status_indicators/nightvision.png", event )
				
			end		
		end,
	},
	{
		id = "TWITCH_EXTENDED_RANDOM_LETTER",
		ui_name = "Random Letter",
		ui_description = "Random Letter Modifier",
		ui_icon = "data/ui_gfx/streaming_event_icons/protect_enemies.png",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		--no_message = true,
		action = function(event)

			modifiers = {
				{
					icon = "data/ui_gfx/gun_actions/alpha.png",
					id = "twitch_projectile_alpha",
					name = "$action_alpha",
					description = "$actiondesc_alpha",
				},
				{
					icon = "data/ui_gfx/gun_actions/gamma.png",
					id = "twitch_projectile_gamma",
					name = "$action_gamma",
					description = "$actiondesc_delta",
				},
				{
					icon = "data/ui_gfx/gun_actions/tau.png",
					id = "twitch_projectile_tau",
					name = "$action_tau",
					description = "$actiondesc_tau",
				},
				{
					icon = "data/ui_gfx/gun_actions/omega.png",
					id = "twitch_projectile_omega",
					name = "$action_omega",
					description = "$actiondesc_omega",
				},
				{
					icon = "data/ui_gfx/gun_actions/mu.png",
					id = "twitch_projectile_mu",
					name = "$action_mu",
					description = "$actiondesc_mu",
				},
				{
					icon = "data/ui_gfx/gun_actions/phi.png",
					id = "twitch_projectile_phi",
					name = "$action_phi",
					description = "$actiondesc_phi",
				},
				{
					icon = "data/ui_gfx/gun_actions/sigma.png",
					id = "twitch_projectile_sigma",
					name = "$action_sigma",
					description = "$actiondesc_sigma",
				},
				{
					icon = "data/ui_gfx/gun_actions/zeta.png",
					id = "twitch_projectile_zeta",
					name = "$action_zeta",
					description = "$actiondesc_zeta",
				},
			}

			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				modifier = modifiers[Random(1, #modifiers)]
				
				local effect_id = give_extra_modifier(entity_id, modifier.id, 3600 )

				
				add_icon_in_hud( effect_id, modifier.icon, {ui_name = modifier.name, ui_description = modifier.description} )
				
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_RANDOM_MODIFIER",
		ui_name = "Random Modifier",
		ui_description = "You got a random modifier for 60 seconds",
		ui_icon = "data/ui_gfx/streaming_event_icons/protect_enemies.png",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		--no_message = true,
		action = function(event)
			dofile("data/scripts/gun/gun_actions.lua")
			dofile("data/scripts/gun/gun_enums.lua")
			modifiers = {
			}

			for k, v in pairs(actions)do
				if(v.type == ACTION_TYPE_MODIFIER)then
					table.insert(modifiers, {
						icon = v.sprite,
						id = "base_modifier_"..v.id,
						name = v.name,
						description = v.description
					})
				end
			end

			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				
				modifier = modifiers[Random(1, #modifiers)]
				
				local effect_id = give_extra_modifier(entity_id, modifier.id, 3600 )

				
				add_icon_in_hud( effect_id, modifier.icon, {ui_name = modifier.name, ui_description = modifier.description} )
				
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_CHEESE_CHEST",
		ui_name = "Cheese Chest",
		ui_description = "Chat loves this.",
		ui_icon = "data/ui_gfx/streaming_event_icons/protect_enemies.png",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		--no_message = true,
		action = function(event)
			spawn_item("mods/twitch_extended/files/entities/misc/cheese_chest.xml", 15, 20)
		end,
	},
	{
		id = "TWITCH_EXTENDED_GOLD_DECAY",
		ui_name = "Gold Decay",
		ui_description = "Gold decay has been released upon the world.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 0.2,
		kind = STREAMING_EVENT_AWFUL,
		action = function(event)
			spawn_item("mods/twitch_extended/files/entities/misc/corrupted_gold_spawn.xml", 10, 100, true, false, 50)
		end,
	},
	{
		id = "TWITCH_EXTENDED_RANDOM_MODIFIER_ENEMIES",
		ui_name = "Random Modifiers For Enemies",
		ui_description = "All nearby enemies get a random modifier for 60 seconds",
		ui_icon = "data/ui_gfx/streaming_event_icons/protect_enemies.png",
		ui_author = "Evaisa",
		weight = 1,
		kind = STREAMING_EVENT_NEUTRAL,
		--no_message = true,
		action = function(event)
			dofile("data/scripts/gun/gun_actions.lua")
			dofile("data/scripts/gun/gun_enums.lua")
			modifiers = {
			}

			for k, v in pairs(actions)do
				if(v.type == ACTION_TYPE_MODIFIER)then
					table.insert(modifiers, {
						icon = v.sprite,
						id = v.id,
						name = v.name,
						description = v.description
					})
				end
			end

			local enemies = EntityGetWithTag( "enemy" )
			for k, entity_id in pairs(enemies) do 
				local x, y = EntityGetTransform( entity_id )
				
				modifier = modifiers[Random(1, #modifiers)]
				
				local effect_id = LoadGameEffectEntityTo( entity_id, "mods/twitch_extended/files/entities/misc/TWITCH_EXTENDED_"..modifier.id..".xml" )

				
				add_icon_above_head( effect_id, modifier.icon, {ui_name = modifier.name, ui_description = modifier.description} )
				
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_FUNGAL_SHIFT",
		ui_name = "Fungal Shift",
		ui_description = "Things aren't what they seem anymore.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 1.0,
		kind = STREAMING_EVENT_AWFUL,
		action = function(event)
			dofile("data/scripts/magic/fungal_shift.lua")
			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				fungal_shift( entity_id, x, y, true )
			end
		end,
	},
	{
		id = "TWITCH_EXTENDED_ORBITAL_LASER",
		ui_name = "Orbital Laser",
		ui_description = "Jarvis, end the run.",
		ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
		ui_author = "Evaisa",
		weight = 0.8,
		kind = STREAMING_EVENT_AWFUL,
		delay_timer = 300,
		action_delayed = function(event)

			for i,entity_id in pairs( get_players() ) do
				local x, y = EntityGetTransform( entity_id )
				GamePlaySound( "data/audio/Desktop/misc.bank", "misc/beam_from_sky_kick", x, y )
				EntityLoad( "data/entities/particles/beamstone_kick.xml", x, y )
				EntityLoad( "mods/twitch_extended/files/entities/misc/beam_from_sky.xml", x, y )
			end
		end,
	},
}

dofile("mods/twitch_extended/config/run_modifiers.lua")
artifacts = {}
for k, v in pairs(run_modifiers)do
	if(v.required_flag == "" or HasFlagPersistent(v.required_flag) or GameHasFlagRun(v.required_flag))then
		if(v.id ~= "TWITCH_EXTENDED_ARTIFACT_GAMBLER" and v.id ~= "TWITCH_EXTENDED_ARTIFACT_SUPPLY_AND_DEMAND" or not HasSettingFlag("twitch_extended_options_perks"))then
			if(HasSettingFlag("twitch_extended_run_modifiers_"..v.id))then
				table.insert(artifacts, v)
			end
		end
	end
end

special_events = {}
for k, event in pairs(append_events)do
    table.insert(special_events, event)
end

for k, event in pairs(streaming_events)do
	table.insert(special_events, event)
end

streaming_events = {}

function sorting( a,b )  
	return GameTextGetTranslatedOrNot(a.ui_name) < GameTextGetTranslatedOrNot(b.ui_name) 
end

table.sort(special_events, sorting)

streaming_events = special_events

perk_events = {};

loadout_events = {};

for k, v in pairs(perk_list)do
	if(v.id ~= "EXTRA_PERK" and v.id ~= "PERKS_LOTTERY")then
		if(HasSettingFlag("twitch_extended_perk_list_"..v.id))then
			perk_event = {
				id = "PERK_VOTE_"..v.id,
				ui_name = v.ui_name,
				ui_icon = "",
				ui_description = v.ui_description,
				weight = 1.0,
				kind = STREAMING_EVENT_NEUTRAL,
				ui_author = STREAMING_EVENT_AUTHOR_NOLLAGAMES,
				action = function(event)
					local x, y = get_player_pos()
				
					if x ~= nil and y ~= nil then
						local perk_entity = perk_spawn(x, y - 8, event.id:gsub("PERK_VOTE_", ""))
						local players = get_players()
						if players == nil then return end
						for i, player in ipairs(players) do
							perk_pickup(perk_entity, player, nil, true, false)
						end
					end
				end,
			}
		end
	end

	table.insert(perk_events, perk_event)
end

--if(ModIsEnabled("gkbrkn_noita"))then
local seed = MagicNumbersGetValue("WORLD_SEED")
SetRandomSeed(seed, seed)
for k, loadout in pairs(twitch_loadouts)do
	if(HasSettingFlag("twitch_extended_loadouts_"..loadout.id) and (loadout.required_flag == "" or GameHasFlagRun(loadout.required_flag)))then
		if(loadout.extension_type == "thematic_random_starts")then
			local description_index = #loadout.description > 0 and Random(1, #loadout.description) or nil
			local description = description_index and loadout.description[description_index] or ""
			loadout_event = {
				loadout_data = loadout,
				id = "loadout_"..loadout.id,
				ui_name = loadout.name,
				ui_icon = "",
				ui_description = description,
				weight = 1.0,
				kind = STREAMING_EVENT_GOOD,
				ui_author = loadout.author,
				action = function(event)
					dofile_once("mods/twitch_extended/files/flags.lua")
					player = get_player()
					dofile_once("mods/thematic_random_starts/init.lua")
					SetPlayerLoadout( player, loadout.special_id, HasSettingFlag( FLAGS.Loadouts.CustomSprites ), false)
				end,
			}

			table.insert(loadout_events, loadout_event)

		else
			local spellcaster_types = string_split( GameTextGetTranslatedOrNot("$twitch_extended_loadout_spellcaster_types"), "," );
			local spellcaster_types_rnd = Random( 1, #spellcaster_types );
			local loadout_name = loadout.name;
			if(loadout_name ~= nil and spellcaster_types[1] ~= nil)then
				loadout_name2 = GameTextGetTranslatedOrNot(loadout_name):gsub( "TYPE", spellcaster_types[spellcaster_types_rnd] );
				local note = "";
				if loadout.author ~= nil then
					note = "By "..GameTextGetTranslatedOrNot(loadout.author);
				end
				--GamePrintImportant( string.format( GameTextGetTranslatedOrNot("$loadout_message_format"), loadout_name ), note );

				-- print the loadout id and the loadout name
				--print( "loadout_id: "..loadout.id.." loadout_name: "..loadout_name2);
				
				loadout_event = {
					loadout_data = loadout,
					id = "loadout_"..loadout.id,
					ui_name = loadout_name2,
					ui_icon = "",
					ui_description = note,
					weight = 1.0,
					kind = STREAMING_EVENT_GOOD,
					ui_author = loadout.author,
					action = function(event)
						player = get_player()
						handle_loadout( player, event.loadout_data );
					end,
				}

				table.insert(loadout_events, loadout_event)
			end
		end

	end
end
--end

--[[
for i,it in ipairs(loadout_events) do
	RegisterStreamingEvent( it.id, it.ui_name, it.ui_description, it.kind, it.weight )
end
]]
--[[


]]
