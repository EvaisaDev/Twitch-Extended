local WAND_STAT_SETTER = {
    Direct = 1,
    Gun = 2,
    GunAction = 3
}

local WAND_STAT_SETTERS = {
    shuffle_deck_when_empty = WAND_STAT_SETTER.Gun,
    actions_per_round = WAND_STAT_SETTER.Gun,
    speed_multiplier = WAND_STAT_SETTER.GunAction,
    deck_capacity = WAND_STAT_SETTER.Gun,
    reload_time = WAND_STAT_SETTER.Gun,
    fire_rate_wait = WAND_STAT_SETTER.GunAction,
    spread_degrees = WAND_STAT_SETTER.GunAction,
    mana_charge_speed = WAND_STAT_SETTER.Direct,
    mana_max = WAND_STAT_SETTER.Direct,
    mana = WAND_STAT_SETTER.Direct,
}

dofile_once("mods/config_lib/files/utilities.lua")
dofile_once("mods/twitch_extended/files/flags.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua");
dofile_once( "data/scripts/gun/procedural/gun_procedural.lua" );
dofile_once("mods/twitch_extended/files/scripts/utils/utils.lua")
dofile_once( "data/scripts/perks/perk.lua" );

local function add_to_inventory( item, inventory )
    EntityAddChild( inventory, item );
    EntitySetComponentsWithTagEnabled( item, "enabled_in_world", false );
end

function ability_component_get_stat( ability, stat )
    local setter = WAND_STAT_SETTERS[stat];
    if setter ~= nil then
        if setter == WAND_STAT_SETTER.Direct then
            return ComponentGetValue2( ability, stat );
        elseif setter == WAND_STAT_SETTER.Gun then
            return ComponentObjectGetValue2( ability, "gun_config", stat );
        elseif setter == WAND_STAT_SETTER.GunAction then
            return ComponentObjectGetValue2( ability, "gunaction_config", stat );
        end
    end
end

function ability_component_set_stat( ability, stat, value )
    local setter = WAND_STAT_SETTERS[stat];
    if setter ~= nil then
        if setter == WAND_STAT_SETTER.Direct then
            ComponentSetValue2( ability, stat, value );
        elseif setter == WAND_STAT_SETTER.Gun then
            ComponentObjectSetValue2( ability, "gun_config", stat, value );
        elseif setter == WAND_STAT_SETTER.GunAction then
            ComponentObjectSetValue2( ability, "gunaction_config", stat, value );
        end
    end
end

function initialize_wand( wand, wand_data )
    local ability = EntityGetFirstComponentIncludingDisabled( wand, "AbilityComponent" );
    local item = EntityGetFirstComponent( wand, "ItemComponent" );
    if wand_data.name ~= nil then
        ComponentSetValue2( ability, "ui_name", wand_data.name );
        if item ~= nil then
            ComponentSetValue2( item, "item_name", wand_data.name );
            ComponentSetValue2( item, "always_use_item_name_in_ui", true );
        end
    end

    for stat,value in pairs( wand_data.stats or {} ) do
        ability_component_set_stat( ability, stat, value );
    end

    for stat,range in pairs( wand_data.stat_ranges or {} ) do
        ability_component_set_stat( ability, stat, Random( range[1], range[2] ) );
    end

    for stat,random_values in pairs( wand_data.stat_randoms or {} ) do
        ability_component_set_stat( ability, stat, random_values[ Random( 1, #random_values ) ] );
    end

    ability_component_set_stat( ability, "mana", ability_component_get_stat( ability, "mana_max" ) );

    for _,actions in pairs( wand_data.permanent_actions or {} ) do
        local random_action = actions[ Random( 1, #actions ) ];
        if random_action ~= nil then
            AddGunActionPermanent( wand, random_action );
        end
    end

    --for _,actions in pairs( wand_data.actions or {} ) do
    if wand_data.actions then
        for action_index=1,#wand_data.actions,1 do
            local actions = wand_data.actions[action_index];
            if actions ~= nil then
                local random_action = actions[ Random( 1, #actions ) ];
                if random_action ~= nil then
                    if type( random_action ) == "table" then
                        local amount = random_action.amount or 1;
                        for _=1,amount,1 do
                            local action_entity = CreateItemActionEntity( random_action.action_id or random_action.action );
                            if action_entity then
                                local item = EntityGetFirstComponentIncludingDisabled( action_entity, "ItemComponent" );
                                if HasSettingFlag( FLAGS.Loadouts.UnlockSpells ) ~= true and random_action.locked == true then
                                    ComponentSetValue2( item, "is_frozen", true );
                                end
                                if random_action.permanent == true then
                                    ComponentSetValue2( item, "permanently_attached", true );
                                end
                                ComponentSetValue2( item, "inventory_slot", action_index - 1, 0 );
                                EntitySetComponentsWithTagEnabled( action_entity, "enabled_in_world", false );
                                EntityAddChild( wand, action_entity );
                            end
                        end
                    else
                        local action_entity = CreateItemActionEntity( random_action );
                        if action_entity then
                            local item = EntityGetFirstComponentIncludingDisabled( action_entity, "ItemComponent" );
                            if item ~= nil then
                                ComponentSetValue2( item, "inventory_slot", action_index - 1, 0 );
                            end
                            EntitySetComponentsWithTagEnabled( action_entity, "enabled_in_world", false );
                            EntityAddChild( wand, action_entity );
                            --AddGunAction( wand, random_action );
                        end
                    end
                end
            end
        end
    end
    
    if wand_data.sprite ~= nil then
        if wand_data.sprite.file ~= nil then
            ComponentSetValue2( ability, "sprite_file", wand_data.sprite.file );
            -- TODO this takes a second to apply, probably worth fixing, but for now just prefer using custom file
            local sprite = EntityGetFirstComponent( wand, "SpriteComponent", "item" );
            if sprite ~= nil then
                ComponentSetValue2( sprite, "image_file", wand_data.sprite.file );
                EntityRefreshSprite( wand, sprite );
            end
        end
        if wand_data.sprite.hotspot ~= nil then
            local hotspot = EntityGetFirstComponent( wand, "HotspotComponent", "shoot_pos" );
            if hotspot ~= nil then
                ComponentSetValue2( hotspot, "offset", wand_data.sprite.hotspot.x, wand_data.sprite.hotspot.y );
            end
        end
    else
        local gun = {
            deck_capacity               = ability_component_get_stat( ability, "deck_capacity" ),
            actions_per_round           = ability_component_get_stat( ability, "actions_per_round" ),
            reload_time                 = ability_component_get_stat( ability, "reload_time" ),
            shuffle_deck_when_empty     = ability_component_get_stat( ability, "shuffle_deck_when_empty" ) and 1 or 0,
            fire_rate_wait              = ability_component_get_stat( ability, "fire_rate_wait" ),
            spread_degrees              = ability_component_get_stat( ability, "spread_degrees" ),
            speed_multiplier            = ability_component_get_stat( ability, "speed_multiplier" ),
            mana_charge_speed           = ability_component_get_stat( ability, "mana_charge_speed" ),
            mana_max                    = ability_component_get_stat( ability, "mana_max" ),
        };
        local dynamic_wand = GetWand( gun );
        SetWandSprite( wand, ability, dynamic_wand.file, dynamic_wand.grip_x, dynamic_wand.grip_y, ( dynamic_wand.tip_x - dynamic_wand.grip_x ), ( dynamic_wand.tip_y - dynamic_wand.grip_y ) );
        EntityRefreshSprite( wand, EntityGetFirstComponent( wand, "SpriteComponent", "item" ) );
    end

    if wand_data.callback ~= nil then
        wand_data.callback( wand, ability );
    end
end



function handle_loadout( player_entity, loadout_data )
    local x, y = EntityGetTransform( player_entity );
    -- find the quick inventory, player cape and arm
    local inventory = nil;
    local full_inventory = nil;
    local cape = nil;
    local player_arm = nil;
    local player_child_entities = EntityGetAllChildren( player_entity );
    if player_child_entities ~= nil then
        for i,child_entity in ipairs( player_child_entities ) do
            local child_entity_name = EntityGetName( child_entity );
            
            if child_entity_name == "inventory_quick" then
                inventory = child_entity;
            elseif child_entity_name == "inventory_full" then
                full_inventory = child_entity;
            elseif child_entity_name == "cape" then
                cape = child_entity;
            elseif child_entity_name == "arm_r" then
                player_arm = child_entity;
            end
        end
    end

    -- set cape colour
    if HasSettingFlag( FLAGS.Loadouts.CustomCapeColor ) then
        local verlet = EntityGetFirstComponent( cape, "VerletPhysicsComponent" );
        if verlet ~= nil then
            if loadout_data.cape_color ~= nil then
                ComponentSetValue2( verlet, "cloth_color", loadout_data.cape_color );
            end
            if loadout_data.cape_color_edge ~= nil then
                ComponentSetValue2( verlet, "cloth_color_edge", loadout_data.cape_color_edge );
            end
        end
    end

    local removed_items = {};
    -- set inventory contents
    if inventory ~= nil then
        local inventory_items = EntityGetAllChildren( inventory );
        local default_wands = {};
        local other_items = {};
        -- remove default items
        if inventory_items ~= nil then
            for i,item_entity in ipairs( inventory_items ) do
                if EntityHasTag( item_entity, "wand" ) then
                    table.insert( default_wands, item_entity );
                else
                    table.insert( other_items, item_entity );
                end
            end
        end

        if loadout_data.items ~= nil then
            for _,item in pairs( other_items ) do
                GameKillInventoryItem( player_entity, item );
                -- this prevents potion breaking sounds
                EntitySetTransform( item, -9999, -9999 );
                EntityRemoveFromParent( item );
                table.insert( removed_items, item );
            end
            other_items = {};
        end

        if loadout_data.wands ~= nil then
            for _,wand in pairs( default_wands ) do
                GameKillInventoryItem( player_entity, wand );
                -- this prevents potion breaking sounds
                EntitySetTransform( item, -9999, -9999 );
                EntityRemoveFromParent( wand );
                table.insert( removed_items, wand );
            end
            default_wands = {};
        end

        if loadout_data.potions ~= nil then
            for _,item in pairs( other_items ) do
                GameKillInventoryItem( player_entity, item );
                -- this prevents potion breaking sounds
                EntitySetTransform( item, -9999, -9999 );
                EntityRemoveFromParent( item );
                table.insert( removed_items, item );
            end
            other_items = {};
        end

        if loadout_data.items ~= nil then
            for _,item_choice in pairs( loadout_data.items or {} ) do
                local random_item = item_choice[ Random( 1, #item_choice ) ];
                if type( random_item ) == "string" then
                    local item = EntityLoad( random_item, x, y );
                    --GamePickUpInventoryItem( player_entity, item, false );
                    add_to_inventory( item, inventory );
                elseif type( random_item ) == "table" then
                    local item = EntityLoad( random_item.filepath, x, y );
                    if item ~= nil then
                        if random_item.initialize ~= nil then
                            random_item.initialize( item );
                        end
                        --GamePickUpInventoryItem( player_entity, item, false );
                        add_to_inventory( item, inventory );
                    end
                end
            end
        end

        if loadout_data.wands ~= nil then
            for wand_index,wand_data in pairs( loadout_data.wands ) do
                if type( wand_data ) == "table" then
                    local wand = EntityLoad( wand_data.custom_file or "mods/twitch_extended/files/entities/wands/wand_"..( ( wand_index - 1 ) % 4 + 1 )..".xml", x, y );
                    SetRandomSeed( x, y );

                    EntitySetVariable( wand, "goki_loadout_wand", "int", 1 );
                    initialize_wand( wand, wand_data );
                    --GamePickUpInventoryItem( player_entity, wand, false );
                    add_to_inventory( wand, inventory );
                    EntitySetComponentsWithTagEnabled( wand, "enabled_in_world", false );
                elseif type( wand_data ) == "string" then
                    local item = EntityLoad( wand_data, x, y );
                    --GamePickUpInventoryItem( player_entity, item, false );
                    add_to_inventory( item, inventory );
                end
            end
        end

        if loadout_data.potions ~= nil then
            -- add loadout items
            for _,potion_data in pairs( loadout_data.potions or {} ) do
                local choice = potion_data[ Random( 1, #potion_data ) ];
                if choice ~= nil then
                    local potion = EntityLoad( "mods/twitch_extended/files/entities/misc/potion_base.xml", x, y );
                    local material_inventory = EntityGetFirstComponent( potion, "MaterialInventoryComponent" );
                    for _,material_data in pairs( choice ) do
                        if material_data ~= nil then
                            local material = material_data[1];
                            local amount = material_data[2];
                            AddMaterialInventoryMaterial( potion, material, amount );
                        end
                    end
                    --GamePickUpInventoryItem( player_entity, potion, false );
                    add_to_inventory( potion, inventory );
                end
            end
        end
    end

    if full_inventory ~= nil then
        if loadout_data.actions ~= nil then
            for _,actions in pairs( loadout_data.actions ) do
                local action = actions[ Random( 1, #actions ) ];
                local action_card = CreateItemActionEntity( action, x, y );
                EntitySetComponentsWithTagEnabled( action_card, "enabled_in_world", false );
                --GamePickUpInventoryItem( player_entity, action_card, false );
                add_to_inventory( action_card, full_inventory );
            end
        end
    end

    local inventory2 = EntityGetFirstComponent( player_entity, "Inventory2Component" );
    if inventory2 ~= nil then
        ComponentSetValue2( inventory2, "mInitialized", false );
        ComponentSetValue2( inventory2, "mForceRefresh", true );
    end

    -- spawn perks
    if loadout_data.perks ~= nil then
        for _,perk_choices in pairs( loadout_data.perks ) do
            local perk = perk_choices[ Random( 1, #perk_choices ) ];
            if perk ~= nil then
                local perk_entity = perk_spawn( x, y, perk );
                if perk_entity ~= nil then
                    perk_pickup( perk_entity, player_entity, EntityGetName( perk_entity ), false, false );
                end
            end
        end	
    end

    if HasSettingFlag( FLAGS.Loadouts.CustomSprites ) and loadout_data.sprites ~= nil then
        if loadout_data.sprites.player_sprite_filepath ~= nil then
            local player_sprite_component = EntityGetFirstComponent( player_entity, "SpriteComponent" );
            local player_sprite_file = loadout_data.sprites.player_sprite_filepath;
            ComponentSetValue2( player_sprite_component, "image_file", player_sprite_file );
        end

        if loadout_data.sprites.player_arm_sprite_filepath ~= nil then
            local player_arm_sprite_component = EntityGetFirstComponent( player_arm, "SpriteComponent" );
            local player_arm_sprite_file = loadout_data.sprites.player_arm_sprite_filepath;
            ComponentSetValue2( player_arm_sprite_component, "image_file", player_arm_sprite_file );
        end

        if loadout_data.sprites.player_ragdoll_filepath ~= nil then
            local player_ragdoll_component = EntityGetFirstComponent( player_entity, "DamageModelComponent" );
            local player_ragdoll_file = loadout_data.sprites.player_ragdoll_filepath;
            ComponentSetValue2( player_ragdoll_component, "ragdoll_filenames_file", player_ragdoll_file );
        end
    end

    if loadout_data.callback ~= nil then
        loadout_data.callback( player_entity, inventory, cape );
    end
end