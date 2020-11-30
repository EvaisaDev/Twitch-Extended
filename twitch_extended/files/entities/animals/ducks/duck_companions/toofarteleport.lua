dofile( "data/scripts/lib/utilities.lua" )

local theEntity = GetUpdatedEntityID()

local thePlayer = get_players()[1]

local x, y, r, s1, s2 = EntityGetTransform( theEntity )

local playerX, playerY = EntityGetTransform( thePlayer )

local headingX = x - playerX
local headingY = y - playerY

local len = math.sqrt((headingX*headingX) + (headingY*headingY))

if(len > 420)then
	EntitySetTransform( theEntity, playerX, playerY, r, s1, s2 )
end