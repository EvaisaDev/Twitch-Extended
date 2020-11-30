dofile_once( "data/scripts/lib/utilities.lua" )

local player = get_players()[1]

local theEntity = GetUpdatedEntityID()

local x, y = EntityGetTransform( player )

EntitySetTransform(theEntity, x, y - 10)

