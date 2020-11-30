dofile_once( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")

function item_pickup( entity_item, entity_who_picked, item_name )
    local x, y, r = EntityGetTransform(entity_who_picked)

    local filename = "mods/twitch_extended/files/entities/animals/ducks/duck_companions/heal_egg.xml"


    local ourProjectile = EntityLoad(filename, x, y - 5)
    EntityKill( entity_item )
end