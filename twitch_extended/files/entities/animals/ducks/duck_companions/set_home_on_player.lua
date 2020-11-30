dofile( "data/scripts/lib/utilities.lua" )

local ourEntity = GetUpdatedEntityID()

local player = get_players()[1]

local playerX, playerY = EntityGetTransform(player)

local aiComponent = EntityGetFirstComponent( ourEntity, "AnimalAIComponent" )

ComponentSetValueVector2( aiComponent, "mHomePosition", playerX, playerY )