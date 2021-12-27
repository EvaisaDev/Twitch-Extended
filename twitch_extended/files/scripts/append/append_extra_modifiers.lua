extra_modifiers["twitch_super_damage"] = function()
    c.extra_entities = c.extra_entities .. "mods/twitch_extended/files/entities/misc/super_damage.xml,"
end

extra_modifiers["twitch_double_damage"] = function()
    c.extra_entities = c.extra_entities .. "mods/twitch_extended/files/entities/misc/double_damage.xml,"
end

extra_modifiers["twitch_more_explosions"] = function()
    c.extra_entities = c.extra_entities .. "mods/twitch_extended/files/entities/misc/more_explosions.xml,"
end

extra_modifiers["twitch_squirt_gun"] = function()
    c.extra_entities = c.extra_entities .. "mods/twitch_extended/files/entities/misc/squirt_gun.xml,"
end

extra_modifiers["twitch_weightless"] = function()
    c.extra_entities = c.extra_entities .. "mods/twitch_extended/files/entities/misc/weightless_bullets.xml,"
end

dofile_once("data/scripts/gun/gun_actions.lua")
dofile_once("data/scripts/gun/gun_enums.lua")

for k, v in pairs(actions)do
    if(v.type == ACTION_TYPE_MODIFIER)then
        extra_modifiers["base_modifier_"..v.id] = function( recursion_level, iteration ) 
            dont_draw_actions = true
            
            v.action( recursion_level, iteration )

            dont_draw_actions = false
        end
    end
end


extra_modifiers["twitch_projectile_tau"] = function( recursion_level, iteration )
    c.fire_rate_wait = c.fire_rate_wait + 35
			
    local data1 = {}
    local data2 = {}
    
    if ( #hand > 1 ) then
        data1 = hand[2]
    elseif ( #deck > 0 ) then
        data1 = deck[1]
    else
        data1 = nil
    end
    
    if ( #hand > 2 ) then
        data2 = hand[3]
    elseif ( #hand > 1 ) and ( #deck > 0 ) then
        data2 = deck[1]
    elseif ( #deck > 0 ) then
        data2 = deck[2]
    else
        data2 = nil
    end
    
    local rec1 = check_recursion( data1, recursion_level )
    local rec2 = check_recursion( data2, recursion_level )
    
    if ( data1 ~= nil ) and ( rec1 > -1 ) then
        --print("1: " .. tostring(data1.id))
        data1.action( rec1 )
    end
    
    if ( data2 ~= nil ) and ( rec2 > -1 ) then
        --print("2: " .. tostring(data2.id))
        data2.action( rec2 )
    end
    
end

extra_modifiers["twitch_projectile_tau"] = function( recursion_level, iteration )
    c.fire_rate_wait = c.fire_rate_wait + 35
			
    local data1 = {}
    local data2 = {}
    
    if ( #hand > 1 ) then
        data1 = hand[2]
    elseif ( #deck > 0 ) then
        data1 = deck[1]
    else
        data1 = nil
    end
    
    if ( #hand > 2 ) then
        data2 = hand[3]
    elseif ( #hand > 1 ) and ( #deck > 0 ) then
        data2 = deck[1]
    elseif ( #deck > 0 ) then
        data2 = deck[2]
    else
        data2 = nil
    end
    
    local rec1 = check_recursion( data1, recursion_level )
    local rec2 = check_recursion( data2, recursion_level )
    
    if ( data1 ~= nil ) and ( rec1 > -1 ) then
        --print("1: " .. tostring(data1.id))
        data1.action( rec1 )
    end
    
    if ( data2 ~= nil ) and ( rec2 > -1 ) then
        --print("2: " .. tostring(data2.id))
        data2.action( rec2 )
    end
end

extra_modifiers["twitch_projectile_alpha"] = function( recursion_level, iteration )
    c.fire_rate_wait = c.fire_rate_wait + 15
			
    local data = {}
    
    if ( #discarded > 0 ) then
        data = discarded[1]
    elseif ( #hand > 0 ) then
        data = hand[1]
    elseif ( #deck > 0 ) then
        data = deck[1]
    else
        data = nil
    end
    
    local rec = check_recursion( data, recursion_level )
    
    if ( data ~= nil ) and ( rec > -1 ) then
        data.action( rec )
    end
end

extra_modifiers["twitch_projectile_gamma"] = function( recursion_level, iteration )
    c.fire_rate_wait = c.fire_rate_wait + 15
			
    local data = {}
    
    if ( #deck > 0 ) then
        data = deck[#deck]
    elseif ( #hand > 0 ) then
        data = hand[#hand]
    else
        data = nil
    end
    
    local rec = check_recursion( data, recursion_level )
    
    if ( data ~= nil ) and ( rec > -1 ) then
        data.action( rec )
    end
    
end

extra_modifiers["twitch_projectile_omega"] = function( recursion_level, iteration )
    c.fire_rate_wait = c.fire_rate_wait + 50
			
    if ( discarded ~= nil ) then
        for i,data in ipairs( discarded ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( rec > -1 ) and ( data.id ~= "RESET" ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    if ( hand ~= nil ) then
        for i,data in ipairs( hand ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( ( data.recursive == nil ) or ( data.recursive == false ) ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    if ( deck ~= nil ) then
        for i,data in ipairs( deck ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( rec > -1 ) and ( data.id ~= "RESET" ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
end


extra_modifiers["twitch_projectile_mu"] = function( recursion_level, iteration )
    c.fire_rate_wait = c.fire_rate_wait + 50
			
    local firerate = c.fire_rate_wait
    local reload = current_reload_time
    local mana_ = mana
    
    if ( discarded ~= nil ) then
        for i,data in ipairs( discarded ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( data.type == 2 ) and ( rec > -1 ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    if ( hand ~= nil ) then
        for i,data in ipairs( hand ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( data.type == 2 ) and ( rec > -1 ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    if ( deck ~= nil ) then
        for i,data in ipairs( deck ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( data.type == 2 ) and ( rec > -1 ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    c.fire_rate_wait = firerate
    current_reload_time = reload
    mana = mana_
end

extra_modifiers["twitch_projectile_phi"] = function( recursion_level, iteration )
    c.fire_rate_wait = c.fire_rate_wait + 50
			
    local firerate = c.fire_rate_wait
    local reload = current_reload_time
    local mana_ = mana
    
    if ( discarded ~= nil ) then
        for i,data in ipairs( discarded ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( data.type == 0 ) and ( rec > -1 ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    if ( hand ~= nil ) then
        for i,data in ipairs( hand ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( data.type == 0 ) and ( rec > -1 ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    if ( deck ~= nil ) then
        for i,data in ipairs( deck ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( data.type == 0 ) and ( rec > -1 ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    c.fire_rate_wait = firerate
    current_reload_time = reload
    mana = mana_
end

extra_modifiers["twitch_projectile_sigma"] = function( recursion_level, iteration )
    c.fire_rate_wait = c.fire_rate_wait + 30
			
    local firerate = c.fire_rate_wait
    local reload = current_reload_time
    local mana_ = mana
    
    if ( discarded ~= nil ) then
        for i,data in ipairs( discarded ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( data.type == 1 ) and ( rec > -1 ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    if ( hand ~= nil ) then
        for i,data in ipairs( hand ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( data.type == 1 ) and ( rec > -1 ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    if ( deck ~= nil ) then
        for i,data in ipairs( deck ) do
            local rec = check_recursion( data, recursion_level )
            if ( data ~= nil ) and ( data.type == 1 ) and ( rec > -1 ) then
                dont_draw_actions = true
                data.action( rec )
                dont_draw_actions = false
            end
        end
    end
    
    c.fire_rate_wait = firerate
    current_reload_time = reload
    mana = mana_
end

extra_modifiers["twitch_projectile_zeta"] = function( recursion_level, iteration )
    local entity_id = GetUpdatedEntityID()
    local x, y = EntityGetTransform( entity_id )
    local options = {}
    
    local children = EntityGetAllChildren( entity_id )
    local inventory = EntityGetFirstComponent( entity_id, "Inventory2Component" )
    
    if ( children ~= nil ) and ( inventory ~= nil ) then
        local active_wand = ComponentGetValue2( inventory, "mActiveItem" )
        
        for i,child_id in ipairs( children ) do
            if ( EntityGetName( child_id ) == "inventory_quick" ) then
                local wands = EntityGetAllChildren( child_id )
                
                if ( wands ~= nil ) then
                    for k,wand_id in ipairs( wands ) do
                        if ( wand_id ~= active_wand ) and EntityHasTag( wand_id, "wand" ) then
                            local spells = EntityGetAllChildren( wand_id )
                            
                            if ( spells ~= nil ) then
                                for j,spell_id in ipairs( spells ) do
                                    local comp = EntityGetFirstComponentIncludingDisabled( spell_id, "ItemActionComponent" )
                                    
                                    if ( comp ~= nil ) then
                                        local action_id = ComponentGetValue2( comp, "action_id" )
                                        
                                        table.insert( options, action_id )
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    if ( #options > 0 ) then
        SetRandomSeed( x + GameGetFrameNum(), y + 251 )
        
        local rnd = Random( 1, #options )
        local action_id = options[rnd]
        
        for i,data in ipairs( actions ) do
            if ( data.id == action_id ) then
                local rec = check_recursion( data, recursion_level )
                if ( rec > -1 ) then
                    dont_draw_actions = true
                    data.action( rec )
                    dont_draw_actions = false
                end
                break
            end
        end
    end
end
