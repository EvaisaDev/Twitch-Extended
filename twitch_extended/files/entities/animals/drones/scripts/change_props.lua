local propPool = {
    {2, "data/entities/items/pickup/thunderstone.xml", false},
    {4, "data/entities/items/pickup/egg_monster.xml", true},
    {4, "data/entities/items/pickup/egg_slime.xml", true},
}

local replacementChance = 30 -- Percentage chance that a prop will be replaced by one of our custom items

local old_spawn_props = spawn_props
function spawn_props(x, y)

 
    SetRandomSeed( x, y )

    if((Random( 1, 100 ) > (100 - replacementChance)) and propPool[1] ~= nil)then
        local poolsize = 0
        for k,v in pairs(propPool) do
           poolsize = poolsize + v[1]
        end
        local selection = Random(1,poolsize)
        local options = {}
        local optionsOnce = {}
        local optionsIndex = {}
        for k,v in pairs(propPool) do
           selection = selection - v[1] 
           if (selection <= 0) then
              table.insert(options, v[2])
              table.insert(optionsOnce, v[3])
              table.insert(optionsIndex, k)
           end
        end
        
        local ourIndex = Random( 1, #options )
        EntityLoad( options[ ourIndex ], x, y )
        if(optionsOnce[ourIndex] == true)then 
            table.remove(propPool, optionsIndex[ourIndex])
        end
        return
    end
    old_spawn_props(x, y)

end
