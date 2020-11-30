dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utils.lua")

local lerp_amount = 0.985
local bob_h = 20
local bob_w = 40
local bob_speed_y = 0.065
local bob_speed_x = 0.01

local max_distance = 200

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )



if pos_x == 0 and pos_y == 0 then
	-- get position from wand when starting
	pos_x, pos_y = EntityGetTransform(EntityGetParent(entity_id))
end

-- ghost continously lerps towards a target that floats around the parent
local target_x, target_y = EntityGetTransform(EntityGetParent(entity_id))

closest_enemy = EntityGetClosestWithTag( pos_x, pos_y, "homing_target" ) 
closest_target_x, closest_target_y = EntityGetTransform(closest_enemy)


current_enemy = EntityGetVariable(entity_id, "current_target", "number")

if(current_enemy == nil)then
	if(closest_enemy ~= nil and get_distance( target_x, target_y, closest_target_x, closest_target_y ) <= max_distance)then
		current_enemy = closest_enemy
		EntitySetVariable(entity_id, "current_target", current_enemy)
	else
		current_enemy = nil
		EntitySetVariable(entity_id, "current_target", nil)
	end
else
	if(not EntityGetIsAlive( current_enemy ))then
		--GamePrint("Target is dead.")
		if(closest_enemy ~= nil and get_distance( target_x, target_y, closest_target_x, closest_target_y ) <= max_distance)then
			current_enemy = closest_enemy
			EntitySetVariable(entity_id, "current_target", current_enemy)
		else
			current_enemy = nil
			EntitySetVariable(entity_id, "current_target", nil)
		end
	else
		current_target_x, current_target_y = EntityGetTransform(current_enemy)
		if(get_distance( target_x, target_y, current_target_x, current_target_y ) > max_distance)then
			--GamePrint("Target is too far.")
			current_enemy = nil
			EntitySetVariable(entity_id, "current_target", nil)
		end
	end
end

if(current_enemy ~= nil)then
	target_x, target_y = EntityGetTransform(current_enemy)
--	GamePrint("Attacking target")
end

if target_x == nil then return end
target_y = target_y - 10

local time = GameGetFrameNum()
local r = ProceduralRandomf(entity_id, 0, -1, 1)

-- randomize times and speeds slightly so that multiple ghosts don't fly identically
time = time + r * 10000
bob_speed_y = bob_speed_y + (r * bob_speed_y * 0.1)
bob_speed_x = bob_speed_x + (r * bob_speed_x * 0.1)
lerp_amount = lerp_amount - (r * lerp_amount * 0.01)

-- bob
target_y = target_y + math.sin(time * bob_speed_y) * bob_h
target_x = target_x + math.sin(time * bob_speed_x) * bob_w

local dist_x = pos_x - target_x

local scale = 1

if(dist_x >= 0)then
	scale = -1
end

-- move towards target
pos_x,pos_y = vec_lerp(pos_x, pos_y, target_x, target_y, lerp_amount)
EntitySetTransform( entity_id, pos_x, pos_y, 0, scale, 1)
