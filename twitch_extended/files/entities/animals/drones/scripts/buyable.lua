dofile( "data/scripts/lib/utilities.lua" )
dofile( "mods/twitch_extended/files/entities/animals/drones/scripts/customutilities.lua" )

local theEntity = GetUpdatedEntityID()

local thePlayer = get_players()[1]

local x, y, r, s1, s2 = EntityGetTransform( theEntity )

local playerX, playerY = EntityGetTransform( thePlayer )

local headingX = x - playerX
local headingY = y - playerY

local len = math.sqrt((headingX*headingX) + (headingY*headingY))

local components = EntityGetComponent( entity_id, "VariableStorageComponent" )

if( components ~= nil ) then
	for key,comp_id in pairs(components) do 
	--	print("VariableStorageComponent")
		local var_name = ComponentGetValue( comp_id, "name" )
		if( var_name == "buyablePrice") then
			local price = tonumber( ComponentGetValue( comp_id, "value_int" ) )
			if(len < 20)then
				local isAffordable = is_affordable( price )
				if(isAffordable)then
					
					camX, camY = GameGetCameraPos()
					textX = camX + x 
					textY = camY + y
					
					for key2,comp_id2 in pairs(components) do 

						local var_name2 = ComponentGetValue( comp_id2, "name" )
						if( var_name2 == "showText") then
							local oldGUI = tonumber( ComponentGetValue( comp_id2, "value_int" ) )
							if(oldGUI == 0)then
								local GUI = GuiCreate()
								GuiText( GUI, textX, textY, tostring(price) )
							else
								GuiDestroy( oldGUI )
								local GUI = GuiCreate()
								GuiText( GUI, textX, textY, tostring(price) )
							end
						end
					end
				end
			else
				for key2,comp_id2 in pairs(components) do 

					local var_name2 = ComponentGetValue( comp_id2, "name" )
					if( var_name2 == "showText") then
						local oldGUI = tonumber( ComponentGetValue( comp_id2, "value_int" ) )
						if(oldGUI ~= 0)then
							GuiDestroy( oldGUI )
						end
					end
				end
			end

		end
	end
end

