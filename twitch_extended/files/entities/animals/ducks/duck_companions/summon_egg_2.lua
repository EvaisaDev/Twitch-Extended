dofile( "data/scripts/lib/utilities.lua" )

local theEntity = GetUpdatedEntityID()

local x, y = EntityGetTransform( theEntity )

EntityLoad("data/entities/items/pickup/goldnugget_10.xml", x, y)
