dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

function bullet_circle( which, count, speed, animal_ )
	local theta = rot
	local length = speed or 200
    local name = which
    
    local rotation = math.rad(Random(0, 360))
	
	local animal = animal_ or false

	for i=1,count do
		local vel_x = math.cos( rotation ) * length
		local vel_y = 0 - math.sin( rotation ) * length

		local bid = shoot_projectile( entity_id, name, pos_x + math.cos( rotation ) * 12, pos_y - math.sin( rotation ) * 12, vel_x, vel_y )
		
		if animal then
			EntityAddComponent( bid, "VariableStorageComponent", 
            { 
                _tags="no_gold_drop",
            } )
		end
		
	end
end

local result = Random(1,6)

if(Random(1, 100) > 70)then
	if ( result == 1 ) then
		bullet_circle( "data/entities/projectiles/deck/light_bullet.xml", 1, 600 )
	elseif ( result == 2 ) then
		bullet_circle( "data/entities/projectiles/deck/tentacle.xml", 1, 600 )
	elseif ( result == 3 ) then
		bullet_circle( "data/entities/projectiles/deck/arrow.xml", 1, 600 )
	elseif ( result == 4 ) then
		bullet_circle( "data/entities/projectiles/deck/bullet.xml", 1, 600 )
	elseif ( result == 5 ) then
		bullet_circle( "data/entities/projectiles/deck/bubbleshot.xml", 3, 600 )
	elseif ( result == 6 ) then
		bullet_circle( "data/entities/projectiles/deck/disc_bullet.xml", 1, 600 )
	end
end