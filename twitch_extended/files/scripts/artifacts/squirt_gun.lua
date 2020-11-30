dofile_once("data/scripts/lib/utilities.lua")

local projectile = GetUpdatedEntityID()

comp = EntityGetFirstComponent(projectile, "VelocityComponent")

if(comp ~= nil)then
    --GamePrint("Modified velocity")
    local velocityX, velocityY = ComponentGetValue2( comp, "mVelocity")

    ComponentSetValue2( comp, "mVelocity", velocityX / 2, velocityY / 2 )
end