dofile( "data/scripts/lib/utilities.lua" )

local theEntity = GetUpdatedEntityID()

local x, y, r, s1, s2 = EntityGetTransform(theEntity)

local children = EntityGetAllChildren( theEntity )
for i,child in ipairs( children ) do
    --print("ent " .. EntityGetName(child))
    if EntityGetName( child ) == "inventory_quick" then
        EntitySetTransform(child, x, y)
        local inv = EntityGetAllChildren(child)
        if(inv ~= nil)then
            for j,item in ipairs( inv ) do
                local item_x, item_y, item_r, item_s1, item_s2 = EntityGetTransform(theEntity)
                

                local components = EntityGetAllComponents(item)--all components in wand
                if components ~= nil then
                    for i, component_id in ipairs(components) do
                        local members = ComponentGetMembers(component_id)
                        for k, v in pairs(members) do
                            if(k == "mItemRecoil") then
                                ComponentObjectSetValue(component_id, "gun_config", "reload_time", -10)
                            end
                        end
                        ComponentSetValue(component_id, "drop_as_item_on_death", 0)
                        ComponentSetValue(component_id, "charge_wait_frames", 0)
                        ComponentSetValue(component_id, "reload_time_frames", 0)
                    end
                end
            
            end
        end
    end
end
