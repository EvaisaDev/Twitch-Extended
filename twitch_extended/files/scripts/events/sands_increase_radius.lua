local entity_id = GetUpdatedEntityID()

local x, y, rad = EntityGetTransform(entity_id)

local components = EntityGetComponent(entity_id, "MagicConvertMaterialComponent")
for k, component in pairs(components)do
    local old_radius = ComponentGetValue2(component, "radius")
    if(old_radius < 300)then
        ComponentSetValue2(component, "radius", old_radius + 1)
    end
end
