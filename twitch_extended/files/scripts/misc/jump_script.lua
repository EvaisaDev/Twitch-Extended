dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/misc/jump_variables.lua")
dofile("data/scripts/lib/utilities.lua")

--print("stonks")

local player = GetUpdatedEntityID()
local x, y = EntityGetTransform(player)

local controlsComponent = EntityGetFirstComponent(player, "ControlsComponent")
local dataComp = EntityGetFirstComponent(player, "CharacterDataComponent")

local is_grounded = ComponentGetValue2(dataComp, "is_on_ground")
local is_on_wall = ComponentGetValue2(dataComp, "mCollidedHorizontally")

local player_vel_x, player_vel_y = ComponentGetValue2(dataComp, "mVelocity")
local aim_x, aim_y = ComponentGetValue2(controlsComponent, "mAimingVectorNormalized")

local currentFrame = GameGetFrameNum()
local jumpFrame = ComponentGetValue2( controlsComponent, "mButtonFrameFly")
local jumpDown = ComponentGetValue2( controlsComponent, "mButtonDownFly")
local leftDown = ComponentGetValue2( controlsComponent, "mButtonDownLeft")
local rightDown = ComponentGetValue2( controlsComponent, "mButtonDownRight")


if is_grounded then
	JUMP_BUFFER = currentFrame
end

if currentFrame >= JUMP_BUFFER + 10 and IS_JUMPING == false then
	if currentFrame >= jumpFrame + 30 then
		ComponentSetValue2(dataComp, "mFlyingTimeLeft", 0.1)
		IS_JUMPING = true
	end
end


if not jumpDown then
	JUMP_PRESS = false
end

if is_grounded and IS_JUMPING == true then
	IS_JUMPING = false
	IS_WALL_JUMPING = false
end