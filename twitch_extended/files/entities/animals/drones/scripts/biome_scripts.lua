
itemPool = {
    { probability = 15/127, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_attack.xml" },
    { probability = 35/127, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_basic.xml" },
    { probability = 10/127, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_missile.xml" },
    { probability = 10/127, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_flame.xml" },
    { probability = 30/127, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_heal.xml" },
    { probability = 5/127, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_equipment.xml" }, 
    { probability = 10/127, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_laser.xml" },   
    { probability = 12/127, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_heal2.xml" },        
}

itemPoolCoal = {
    { probability = 35/65, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_basic.xml" },
    { probability = 30/65, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_heal.xml" },
}

itemPoolIce = {
    { probability = 15/112, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_attack.xml" },
    { probability = 35/112, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_basic.xml" },
    { probability = 10/112, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_missile.xml" },
    { probability = 10/112, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_flame.xml" },
    { probability = 30/112, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_heal.xml" },
    { probability = 12/112, file = "mods/twitch_extended/files/entities/animals/drones/entities/summon/summon_heal2.xml" },     
}

function spawn_drones(x, y, biome)

    local Rand = Random()
    local cumulativeProbability = 0
    if(biome == "coal")then
        for name, item in pairs(itemPoolCoal) do
            cumulativeProbability = cumulativeProbability + item.probability
            if Rand <= cumulativeProbability then
                EntityLoad(item.file, x, y-2 )
                return
            end
        end
    elseif(biome == "ice")then
        for name, item in pairs(itemPoolIce) do
            cumulativeProbability = cumulativeProbability + item.probability
            if Rand <= cumulativeProbability then
                EntityLoad(item.file, x, y-2 )
                return
            end
        end
    else
        for name, item in pairs(itemPool) do
            cumulativeProbability = cumulativeProbability + item.probability
            if Rand <= cumulativeProbability then
                EntityLoad(item.file, x, y-2 )
                return
            end
        end
    end
end

