dofile( "data/scripts/lib/utilities.lua" )

function take_gold( cost )
    local player = get_players()[1]
    local walletComponent = EntityGetFirstComponent( player, "WalletComponent" )

	if( walletComponent ~= nil ) then 
        moneyCurrent = tonumber( ComponentGetValue( walletComponent, "money" ) )
        
        if(cost > moneyCurrent) then
            return false
        else
            local newMoney = (moneyCurrent - cost)
            ComponentSetValue(walletComponent, "money", newMoney)
        end
	end

    return true
end


function is_affordable( cost )
    local player = get_players()[1]
    local walletComponent = EntityGetFirstComponent( player, "WalletComponent" )

	if( walletComponent ~= nil ) then 
        moneyCurrent = tonumber( ComponentGetValue( walletComponent, "money" ) )
        
        if(cost > moneyCurrent) then
            return false
        end
	end

    return true
end

function get_closest_enemy_in_range(self_entity, x, y, range)
	local ourEntities = EntityGetWithTag("homing_target")

	local smallest, smallestIndex, smallestEntity
	for i, theEntity in ipairs(ourEntities) do
		local zX, zY = EntityGetTransform(theEntity)
		
		local dx = x - zX
		local dy = y - zY
		local distance = math.sqrt ( dx * dx + dy * dy )
		
		
		if not smallest or (distance < smallest) then
			
			smallest = distance
			smallestEntity = theEntity
			smallestIndex = i
		end
	end
	if(smallest ~= nil)then
		if(smallest < range)then
			return smallestEntity
		else	
			return nil
		end
	else
		return nil
	end
end

function shoot_at_entity(self_entity, target_entity, general_offset, x_offset, y_offset, speed, projectile, maxdistance)
	--print(tostring(closestEntity))
	local x, y = EntityGetTransform(self_entity)
	
	if(target_entity ~= nil)then
		local entityX, entityY = EntityGetTransform( target_entity )
		local headingX = entityX - x
		local headingY = (entityY-5) - y
		
		local len = math.sqrt((headingX*headingX) + (headingY*headingY))

		local directionX = headingX / len
		local directionY = headingY / len		
		
		local didHit, hitX, hitY = Raytrace( x, y, entityX, entityY )
		
		--
		
		--if(didHit == true)then
			local headingHitX = entityX - hitX
			local headingHitY = entityY - hitY
			
			local hitDistance = math.sqrt((headingHitX*headingHitX) + (headingHitY*headingHitY))

			--DEBUG_MARK( hitX, hitY, hitDistance, 1, 0, 0 )
			
			local pos_x, pos_y, currentRotation = EntityGetTransform( self_entity )

				
					
			if(directionX < 0)then
				EntitySetTransform(self_entity,pos_x,pos_y,currentRotation,-1,1)
			else
				EntitySetTransform(self_entity,pos_x,pos_y,currentRotation,1,1)
			end
			
			
			if(hitDistance < maxdistance)then
				local ourProjectile = shoot_projectile( self_entity, projectile, x + (directionX * general_offset) + x_offset, y + (directionY * general_offset) + y_offset, directionX * speed, directionY * speed )
				edit_component( ourProjectile, "ProjectileComponent", function(comp,vars)
					vars.mWhoShot       = self_entity
					vars.mShooterHerdId = "player"
				end)
			end
		--end
	end
end