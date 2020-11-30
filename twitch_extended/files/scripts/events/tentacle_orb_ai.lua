dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local float_range = 50
local float_force = 3
local float_sensor_sector = math.pi * 0.3

SetRandomSeed(GameGetFrameNum() + x + y + entity_id, GameGetFrameNum() + x + y + entity_id)

local player = get_players()[1]

if(GlobalsGetValue("tentacle_"..entity_id.."_feralframe", "no") ~= "no")then
    local frame_diff = GameGetFrameNum() - tonumber(GlobalsGetValue("tentacle_"..entity_id.."_feralframe", "no"))

    GamePrint("Tentacle going feral in "..(30 - frame_diff).." seconds!")

    --[[
    if(frame_diff > 60 and EntityHasTag(entity_id, "feral") == false)then

        EntityAddTag(entity_id, "feral")
        --EntityInflictDamage(entity_id, 99999,"DAMAGE_PHYSICS_BODY_DAMAGED", "killed", "BLOOD_EXPLOSION", 0, 0, entity_id, x, y, 0)
        EntityKill(entity_id)
        EntityLoad("mods/testing_objects/files/entities/tentacle_orb_feral/tentacle_orb.xml", x, y)
        EntityLoad("mods/testing_objects/files/entities/tentacle_orb/tentacle_effect.xml", x, y)
        --GlobalsSetValue("tentacle_"..entity_id.."_feralframe", "no")
    end
    ]]
end


if(GlobalsGetValue("tentacle_"..entity_id.."_armedframe", "no") == "no")then
    GlobalsSetValue("tentacle_"..entity_id.."_armedframe", GameGetFrameNum())
else
    local frame_diff = GameGetFrameNum() - tonumber(GlobalsGetValue("tentacle_"..entity_id.."_armedframe", "no"))
   -- GamePrint(frame_diff)
    if(frame_diff > 30)then
     
        local vel_x = 0
        local vel_y = 0

        local length = Random( 600, 800 )

        local dir_x = 0
        local dir_y = 0

        local ground_check = RaytracePlatforms( x, y + 5, x + dir_x, y + float_range )

        local ground_check2 = RaytracePlatforms( x, y + -5, x + dir_x, y + -float_range )

        local ground_check3 = RaytracePlatforms( x + 5, y, x + float_range, y + dir_y )

        local ground_check4 = RaytracePlatforms( x - 5, y, x + -float_range, y + dir_y )

        local angle = nil  

        local TEXT = {
            font="data/fonts/font_pixel_white.xml",
            string="IDLING",
            offset_x="0",
            offset_y="26",
            alpha="0.80",
            scale_x="0.7",
            scale_y="0.7"
        }

        if ground_check or ground_check2 or ground_check3 or ground_check4 then

            local ray_length = 50

            local iterations = 50

            local hit_positions = {}

            local old_markers = EntityGetWithTag("tentacle_debug")

            for k, v in pairs(old_markers)do
                EntityKill(v)
            end

            for i = 1, iterations do 
                local angle = math.rad( Random( 1, 360 ) )   

                local vel_x = math.cos( angle )
                local vel_y = 0 - math.sin( angle )



                TEXT.string = "MOVING"

                local didHit, hit_x, hit_y = RaytracePlatforms( x + vel_x * 5, y + vel_y * 5, x + vel_x * ray_length, y + vel_y * ray_length )  


            -- local debug_marker = EntityLoad("data/entities/misc/debug_marker.xml", hit_x, hit_y)

            --  EntityAddTag(debug_marker, "tentacle_debug")

                local hit_position = {x = hit_x, y = hit_y}

                table.insert(hit_positions, hit_position)
            end

            local current_hitpos = {x = 0, y = 0}

            local len_list = {}
            

            for k, hit_pos in pairs(hit_positions)do
local hit_dir_x = hit_pos.x - x
local hit_dir_y = hit_pos.y - y
                local len = math.sqrt((hit_dir_x*hit_dir_x) + (hit_dir_y*hit_dir_y))



                table.insert(len_list, len)

                
            end

            local max_len = 0

            for k, v in pairs(len_list)do
                if(v > max_len)then
                    max_len = v

                end
            end

            local valid_positions = {}

            for k, hit_pos in pairs(hit_positions)do
                local hit_dir_x = hit_pos.x - x
                local hit_dir_y = hit_pos.y - y
                local len = math.sqrt((hit_dir_x*hit_dir_x) + (hit_dir_y*hit_dir_y))


            -- GamePrint("current len = "..len)

            --  GamePrint("highest len = "..highest_value)
--[[
            local debug_marker = EntityLoad("mods/testing_objects/files/entities/misc/debug_point.xml", hit_pos.x, hit_pos.y)

            EntityAddTag(debug_marker, "tentacle_debug")]]

                if(len > max_len - 5)then
--[[
                    local debug_marker = EntityLoad("mods/testing_objects/files/entities/misc/debug_point3.xml", hit_pos.x, hit_pos.y)

                    EntityAddTag(debug_marker, "tentacle_debug")
]]
                    table.insert(valid_positions, hit_pos)
                end
            end       

            
            current_hitpos = valid_positions[Random(1, #valid_positions)]
--[[
            local debug_marker = EntityLoad("mods/testing_objects/files/entities/misc/debug_point2.xml", current_hitpos.x, current_hitpos.y)
]]
            EntityAddTag(debug_marker, "tentacle_debug")

            if(Random(1,4) > 1)then
                --GamePrint("Change Course")
                angle = 0 - math.atan2( current_hitpos.y - y, current_hitpos.x - x )
            else
                if(GlobalsGetValue(entity_id.."previous_direction", "") ~= "")then
                 --   GamePrint("Keep Going")
                   angle = tonumber(GlobalsGetValue(entity_id.."previous_direction", 0))
                   --angle = 0 - math.atan2( current_hitpos.y - y, current_hitpos.x - x )
                else
                  --  GamePrint("Change Course")
                    angle = 0 - math.atan2( current_hitpos.y - y, current_hitpos.x - x )
                end
            end

        end
        if ( Random( 1, 4 ) > 1 ) then
            local targets = EntityGetInRadius( x, y, 250 )
            local target_id = 0
            
            if ( #targets > 0 ) then
                local valid_targets = {}
                

                for i,target in ipairs(targets) do
                    local tx, ty = EntityGetTransform( target )
                    
                    local distance = math.abs( ty - y ) + math.abs( tx - x )
                    

                    if ( EntityHasTag(target, "player_unit") or EntityHasTag(target, "enemy")) then

                        local direction_x = tx - x

                        local direction_y = ty - y
            
                        local len = math.sqrt((direction_x*direction_x) + (direction_y*direction_y))

                        local vel_x = direction_x / len
                        local vel_y = direction_y / len


                        local didHit, hit_x, hit_y = RaytracePlatforms( x + vel_x * 5, y + vel_y * 5, tx, ty )
                        
                    --    GamePrint("Finding Prey")

--[[
                        local verlet = EntityLoad("data/entities/verlet_chains/vines/verlet_vine_pixelscene.xml",x,y)
                        EntityAddTag(verlet, "tentacle_debug")
]]
                        if is_valid_entity( verlet ) then
                            EntityAddComponent( verlet, "VerletWorldJointComponent" )
                            EntityAddComponent( verlet, "VerletWorldJointComponent" )
                        end
                        
                        local verletphysics_comp_found = false
                        local last_point_index = 0
                        edit_component( verlet, "VerletPhysicsComponent", function(comp,vars)
                            verletphysics_comp_found = true
                            last_point_index = ComponentGetValue( comp, "num_points" )
                        end)
                        
                        if verletphysics_comp_found then
                
                            local index = 0
                        
                            edit_all_components( verlet, "VerletWorldJointComponent", function(comp,vars)
                                
                                if index == 0 then
                                    ComponentSetValueVector2( comp, "world_position", x + vel_x * 5, y + vel_y * 5 )
                                else
                                    ComponentSetValueVector2( comp, "world_position", hit_x, hit_y )
                                    vars.verlet_point_index = last_point_index
                                end
                        
                                index = index + 1
                            end)
                    
                        end                     
--[[
                        local debug_marker = EntityLoad("data/entities/misc/debug_marker.xml", hit_x, hit_y)
                        EntityAddTag(debug_marker, "tentacle_debug")
]]
                        local heading_hit_x = x - hit_x
                        local heading_hit_y = y - hit_y
                        
                        local hit_distance = math.sqrt((heading_hit_x*heading_hit_x) + (heading_hit_y*heading_hit_y))

                        if(didHit ~= true)then
                            table.insert( valid_targets, target )
                        end
                    end
                end
                
                if ( #valid_targets > 0 ) then
                    local rnd = Random( 1, #valid_targets )
                    
                    target_id = valid_targets[rnd]
                    
                    if ( target_id ~= 0) then
                        local tx, ty = EntityGetTransform( target_id )
                        angle = 0 - math.atan2( ty - y, tx - x )

                        --GamePrint("Stalking Prey")

                        old_markers = EntityGetWithTag("tentacle_debug")

                        for k, v in pairs(old_markers)do
                            EntityKill(v)
                        end
            
                        --[[
                        local debug_marker = EntityLoad("mods/testing_objects/files/entities/misc/debug_point2.xml", tx, ty)

                        EntityAddTag(debug_marker, "tentacle_debug")
]]
                        vel_x = math.cos( angle ) * length
                        vel_y = 0- math.sin( angle ) * length
                        TEXT.string = "ATTACKING PREY"
                        
                    end
                end
            end
        end
        
        local player_distance = 1000

        if(player ~= nil)then
            local px, py = EntityGetTransform(player)
            local hit_dir_x = px - x
            local hit_dir_y = py - y
            player_distance = math.sqrt((hit_dir_x*hit_dir_x) + (hit_dir_y*hit_dir_y))
        end

        if(angle ~= nil and player_distance < 500)then

            GlobalsSetValue(entity_id.."previous_direction", angle)

            -- Debug Text
--[[
            if(GlobalsGetValue(entity_id.."_debug_tag", "") == "")then
                nametag = append_text(entity_id, TEXT)
                GlobalsSetValue(entity_id.."_debug_tag", nametag)
            else
                nametag = tonumber(GlobalsGetValue(entity_id.."_debug_tag", ""))
                ComponentSetValue2(nametag, "text", TEXT.string)
            end]]

            vel_x = math.cos( angle ) * length
            vel_y = 0- math.sin( angle ) * length
            shoot_projectile( EntityGetRootEntity( entity_id ), "mods/twitch_extended/files/entities/misc/tentacle_projectile.xml", x, y, vel_x, vel_y )
            
            local velocity_component = EntityGetComponent(entity_id, "VelocityComponent")
            if(velocity_component ~= nil)then
                local velocity_x, velocity_y = ComponentGetValue2( velocity_component, "mVelocity")

                if(velocity_x ~= nil)then
                    PhysicsApplyForce(entity_id, -velocity_x, -velocity_y)
                end
            end

            PhysicsApplyForce(entity_id, vel_x, vel_y)
        elseif(player_distance > 200)then
            local velocity_component = EntityGetComponent(entity_id, "VelocityComponent")
            if(velocity_component ~= nil)then
                local velocity_x, velocity_y = ComponentGetValue2( velocity_component, "mVelocity")

                if(velocity_x ~= nil)then
                    PhysicsApplyForce(entity_id, -velocity_x, -velocity_y)
                end
            end
        end
        
    end
end 

