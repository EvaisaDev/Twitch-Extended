local entity_id = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )

local root = EntityGetParent(entity_id) or nil

if(root ~= nil)then

	TextComponent = EntityGetFirstComponent(entity_id, "SpriteComponent")

	offset_base = 0
	offset_extra = 0

	local comps = EntityGetComponent( entity_id, "VariableStorageComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			local n = ComponentGetValue2( v, "name" )
			if ( n == "offset_base" ) then
				offset_base = ComponentGetValue2( v, "value_int" )
			elseif( n == "offset_extra")then
				offset_extra = ComponentGetValue2( v, "value_int" )
			end
		end
	end


	if(TextComponent ~= nil)then
		local offset_enabled = false
		local ui_icons = EntityGetComponent(root, "UIIconComponent") or {}

		for k, v in pairs(ui_icons)do
			local display_above_head = ComponentGetValue2(v, "display_above_head")

			if(display_above_head)then
				offset_enabled = true
			end
		end

		local children = EntityGetAllChildren( root ) or {}

		if(offset_enabled == false)then
			for k, v in pairs(children)do
				local ui_icons = EntityGetComponent(v, "UIIconComponent") or {}
				for k2, v2 in pairs(ui_icons)do
					local display_above_head = ComponentGetValue2(v2, "display_above_head")
			
					if(display_above_head)then
						offset_enabled = true
					end
				end
			end
		end

		effects_list = {
			"WET",
			"OILED",
			"BLOODY",
			"SLIMY",
			"RADIOACTIVE",
			"DRUNK",
			"POISON",
			"TELEPORTATION",
			"UNSTABLE_TELEPORTATION",
			"REGENERATION",
			"BERSERK",
			"CHARM",
			"INVISIBILITY",
			"CONFUSION",
			"MOVEMENT_FASTER_2X",
			"FASTER_LEVITATION",
			"WORM_ATTRACTOR",
			"PROTECTION_ALL",
			"MANA_REGENERATION",
			"JARATE",
		}

		for k, v in pairs(effects_list)do
			if(GameGetGameEffectCount( root, v ) > 0)then
				offset_enabled = true
			end
		end

		if(offset_enabled)then
			ComponentSetValue2(TextComponent, "offset_y", offset_base + offset_extra + 20)
		else
			ComponentSetValue2(TextComponent, "offset_y", offset_base + offset_extra)
		end
	end
end