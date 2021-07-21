local old_item_pickup = item_pickup
item_pickup = function( entity_item, entity_who_picked, item_name )
    if(GameHasFlagRun( "gold_hurts" ))then
        x, y = EntityGetTransform(entity_who_picked)

        local components = EntityGetComponent( entity_item, "VariableStorageComponent" )
        
        local money = 0
        local value = 10
        local hp_value = 0

        if ( components ~= nil ) then
            for key,comp_id in pairs(components) do 
                local var_name = ComponentGetValue( comp_id, "name" )
                if( var_name == "gold_value") then
                    value = ComponentGetValueInt( comp_id, "value_int" )
                end
                if( var_name == "hp_value" ) then
                    hp_value = ComponentGetValueFloat( comp_id, "value_float" )
                end
            end
        end

        max_damage = 20 / 25
        min_damage = 1 / 25

        current_damage = math.min(math.max((value / 2) / 25, min_damage), max_damage)
        
        EntityInflictDamage( entity_who_picked, current_damage, "DAMAGE_PROJECTILE", "Gold", "NORMAL", 0, 0, entity_who_picked, x, y, 0)
    end
    old_item_pickup(entity_item, entity_who_picked, item_name)
end 