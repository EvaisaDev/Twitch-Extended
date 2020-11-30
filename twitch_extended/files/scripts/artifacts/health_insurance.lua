dofile_once("data/scripts/lib/utilities.lua")

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	if ( entity_who_caused == entity_id ) or ( ( EntityGetParent( entity_id ) ~= NULL_ENTITY ) and ( entity_who_caused == EntityGetParent( entity_id ) ) ) then return end

	if(damage > (1/25))then
		local wallet = EntityGetFirstComponent(entity_id, "WalletComponent")
		if(wallet ~= nil)then
			local money = ComponentGetValue2(wallet, "money")
			local multiplier = (money / 150)
			local price = math.floor(((damage * 25 ) * multiplier))
			if(money > price)then
				ComponentSetValue2(wallet, "money", money - price)

				EntityLoad( "data/entities/particles/gold_pickup_large.xml", pos_x, pos_y )
				
			else
				ComponentSetValue2(wallet, "money", 0)
			end
		end
	end
end
