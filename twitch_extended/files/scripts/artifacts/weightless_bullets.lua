dofile_once("data/scripts/lib/utilities.lua")

local projectile = GetUpdatedEntityID()

comp = EntityGetFirstComponent(projectile, "VelocityComponent")

if(comp ~= nil)then
    local velocityX, velocityY = ComponentGetValue2( comp, "mVelocity")

    ComponentSetValue2( comp, "gravity_x", 0 )
    ComponentSetValue2( comp, "gravity_y", 0 )
end