dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local duck = EntityLoad("mods/twitch_extended/files/entities/animals/ducks/duck_boss/duck_minion.xml", x, y)
--[[local dx, dy = EntityGetTransform(duck)
local duckbomb = EntityLoad("data/entities/duckbomb.xml", dx, dy)
EntityAddChild( duck, duckbomb )]]