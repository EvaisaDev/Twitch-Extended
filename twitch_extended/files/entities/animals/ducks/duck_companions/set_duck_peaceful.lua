
function get_player()
    return EntityGetWithTag( "player_unit" )[1]
end

local entity_id = GetUpdatedEntityID()

if(get_player() ~= nil)then
   -- GamePrint("Player found")
   -- if(get_player() ~= 0)then
    AnimalAIComponent = EntityGetFirstComponent(entity_id, "AnimalAIComponent")
    if(GameGetGameEffectCount( get_player(), "BERSERK" ) ~= 0)then
      --  GamePrint("Stay back duck, you are now under arrest.")
        ComponentSetValue2(AnimalAIComponent, "attack_melee_enabled", false)
        ComponentSetValue2(AnimalAIComponent, "attack_dash_enabled", false)

        local models = EntityGetComponent( entity_id, "VariableStorageComponent" )
        for i,v in ipairs( models ) do
            local name = ComponentGetValue2( v, "name" )
            if ( name == "duck_pacifist_timer" ) then
                ComponentSetValue2( v, "value_int", 60 )
            end
        end
    else
       -- GamePrint("Everything is fine.")

        allow_return = false

        local models = EntityGetComponent( entity_id, "VariableStorageComponent" )
        for i,v in ipairs( models ) do
           -- GamePrint("you hoe")
            local name = ComponentGetValue2( v, "name" )
          --  GamePrint(name)
            if ( name == "duck_pacifist_timer" ) then
                timer = ComponentGetValue2( v, "value_int" )
                if(timer == 0)then
                   -- GamePrint("return.")
                    allow_return = true
                else
                    timer = timer - 1
                    --GamePrint("timer: "..timer)
                    ComponentSetValue2( v, "value_int", timer )
                end
            end
        end
        
        if(allow_return)then
           -- GamePrint("Duck can attack again.")
            ComponentSetValue2(AnimalAIComponent, "attack_melee_enabled", true)
            ComponentSetValue2(AnimalAIComponent, "attack_dash_enabled", true)
        end
    end
  --  end
end