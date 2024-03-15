-- This file has complete access to anything within the utilities.lua file of this mod.
commands = {
    {
        reward_id = "ping",
        reward_name = "Ping",
        reward_description = "Pong!",
        reward_image = nil,
        required_flag = "",
        custom_options = {},
        no_display_message = true,
        func = function(reward, userdata)
            print("Pong!")
            GamePrint("Pong!")
        end,
    }
}

bit_rewards = {
    {
        reward_id = "local_shift",
        reward_name = "$twitch_extended_channel_rewards_local_shift",
        reward_description = "$twitch_extended_channel_rewards_local_shift_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/fungal_shift.png",
        required_flag = "",
        custom_options = {
            {
                type = "slider",
                flag = "shift_distance",
                name = "Shift Distance",
                description = "How far away from the player will materials get shifted.",
                default_number = 250,
                min_number = 10,
                max_number = 800,
                format = "$0",
            },
            {
                type = "toggle",
                flag = "shift_random",
                name = "Random if unknown material",
                description = "If any of the materials do not exist pick random",
                default = false
            },
            {
                type = "toggle",
                flag = "random_pool",
                name = "Random Pool",
                description = "For the random pick, pool materials with the same name together.",
                default = false
            },
            {
                type = "toggle",
                flag = "convert_flasks",
                name = "Convert flasks",
                description = "Convert vessels containing the material as well.",
                default = false
            },
        },
        no_display_message = true, 
        func = function(reward, userdata)
            local shift_distance = ModSettingGet("twitch_extended_bit_rewards_local_shift_shift_distance") or 250
            local allow_random = HasSettingFlag("twitch_extended_bit_rewards_local_shift_shift_random")
            local random_pool =  HasSettingFlag("twitch_extended_bit_rewards_local_shift_random_pool")
            local convert_flasks = HasSettingFlag("twitch_extended_bit_rewards_local_shift_convert_flasks")
            fungal_shift_local(reward, userdata, allow_random, shift_distance, convert_flasks, random_pool)
        end,
    },
    {
        reward_id = "fungal_shift",
        reward_name = "$twitch_extended_channel_rewards_fungal_shift",
        reward_description = "$twitch_extended_channel_rewards_fungal_shift_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/fungal_funny.png",
        required_flag = "",
        custom_options = {
            {
                type = "toggle",
                flag = "shift_random",
                name = "Random if unknown material",
                description = "If any of the materials do not exist pick random",
                default = false
            },
            {
                type = "toggle",
                flag = "random_pool",
                name = "Random Pool",
                description = "For the random pick, pool materials with the same name together.",
                default = false
            },
        },
        no_display_message = true, 
        func = function(reward, userdata)
            local allow_random = HasSettingFlag("twitch_extended_bit_rewards_fungal_shift_shift_random")
            local random_pool =  HasSettingFlag("twitch_extended_bit_rewards_fungal_shift_random_pool")
            fungal_shift_everywhere(reward, userdata, allow_random, random_pool)
        end,
    },
    {
        reward_id = "emerald_tablet",
        reward_name = "$twitch_extended_sub_rewards_emerald_tablet",
        reward_description = "$twitch_extended_sub_rewards_emerald_tablet_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/emerald_tablet.png",
        required_flag = "",
        func = function(reward, userdata)
            generate_emerald_tablet(userdata.username, userdata.message)
        end,
    },
    {
        reward_id = "lots_of_gold",
        reward_name = "$twitch_extended_sub_rewards_lots_of_gold",
        reward_description = "$twitch_extended_sub_rewards_lots_of_gold_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/lots_of_gold.png",
        required_flag = "",
        func = function(reward, userdata)
            local player = get_player()
            local wallet = EntityGetFirstComponent(player, "WalletComponent")
            if(wallet ~= nil)then
                local money_player = tonumber(ComponentGetValueInt(wallet, "money"))
                -- APP: This is setting wallet to 0 so is basically scatter gold? Removed this and now is just giving 500 gold by deault
                --ComponentSetValue(wallet, "money", 0)
                local money = math.max(math.floor(money_player / 25), 40) + ((userdata.total_months or 1) * 10)
                        
                nugget_count = 100
				nugget_value = math.floor(money / 100)
				

				if(money < 100)then
					nugget_count = money
					nugget_value = 1
				end
				


				for i = 1, nugget_count do
					nugget = spawn_item("data/entities/items/pickup/goldnugget.xml", 50, 100)
					storage_comps = EntityGetComponent(nugget, "VariableStorageComponent")
					for k, v in pairs(storage_comps)do
						if(ComponentGetValue2(v, "name") == "gold_value")then
							ComponentSetValue2(v, "value_int", nugget_value) 
						end
					end
				end

            end
        end,
    },
    {
        reward_id = "gold_aura",
        reward_name = "$twitch_extended_sub_rewards_gold_aura",
        reward_description = "$twitch_extended_sub_rewards_gold_aura_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/gold_aura.png",
        required_flag = "",
        func = function(reward, userdata)
            for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
                
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/enemies_to_gold.xml", x, y )
                set_lifetime( effect_id )
                EntityAddChild( entity_id, effect_id )
                
                add_status_effect( effect_id, "mods/twitch_extended/files/gfx/status_effects/enemies_to_gold.png", "Gold Aura", "You turn nearby enemies to gold.", false )
            end
        end,
    },
    {
        reward_id = "charm_enemies",
        reward_name = "$twitch_extended_sub_rewards_charm_enemies",
        reward_description = "$twitch_extended_sub_rewards_charm_enemies_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/charm_enemies.png",
        required_flag = "",
        func = function(reward, userdata)
            for i,entity_id in pairs( get_players() ) do
                local x, y, rot = EntityGetTransform( entity_id )
                
                for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 1024, "enemy" ) or {} ) do
                    local effect_id = EntityLoad( "data/entities/misc/effect_charm.xml", x, y )

                    EntityAddChild( entity, effect_id )
                end
            end
        end,
    },
    {
        reward_id = "random_perk",
        reward_name = "$twitch_extended_sub_rewards_random_perk",
        reward_description = "$twitch_extended_sub_rewards_random_perk_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_perk.png",
        required_flag = "",
        func = function(reward, userdata)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
				local x,y = EntityGetTransform( entity_id )
				local pid = perk_spawn_random( x, y )
				perk_pickup( pid, entity_id, "", true, false )
			end
        end,
    },
    {
        reward_id = "healing_glitch",
        reward_name = "$twitch_extended_sub_rewards_healing_glitch",
        reward_description = "$twitch_extended_sub_rewards_healing_glitch_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/glitch.png",
        required_flag = "",
        func = function(reward, userdata)
            --spawn_item("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", 10, 10)
            for i,entity_id in ipairs( get_players() ) do
                local x,y = EntityGetTransform( entity_id )
                local ghost = EntityLoad("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", x, y)

                text_above_entity(ghost, userdata.username, 0)

                EntityAddComponent2(ghost, "VariableStorageComponent", {
                    name="type",
                    value_string="healer"
                })
                EntityAddChild(entity_id, ghost)
			end
        end,
    },
    {
        reward_id = "twitchy_glitch",
        reward_name = "$twitch_extended_sub_rewards_twitchy_glitch",
        reward_description = "$twitch_extended_sub_rewards_twitchy_glitch_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/glitch.png",
        required_flag = "",
        func = function(reward, userdata)
            --spawn_item("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", 10, 10)
            for i,entity_id in ipairs( get_players() ) do
                local x,y = EntityGetTransform( entity_id )
                local ghost = EntityLoad("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", x, y)

                text_above_entity(ghost, userdata.username, 0)

                EntityAddComponent2(ghost, "VariableStorageComponent", {
                    name="type",
                    value_string="twitchy"
                })
                EntityAddChild(entity_id, ghost)
			end
        end,
    },
    {
        reward_id = "damaging_glitch",
        reward_name = "$twitch_extended_sub_rewards_fighter_glitch",
        reward_description = "$twitch_extended_sub_rewards_fighter_glitch_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/glitch.png",
        required_flag = "",
        func = function(reward, userdata)
            --spawn_item("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", 10, 10)
            for i,entity_id in ipairs( get_players() ) do
                local x,y = EntityGetTransform( entity_id )
                local ghost = EntityLoad("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", x, y)

                text_above_entity(ghost, userdata.username, 0)


                EntityAddComponent2(ghost, "VariableStorageComponent", {
                    name="type",
                    value_string="damaging"
                })
                EntityAddChild(entity_id, ghost)
			end
        end,
    },
    {
        reward_id = "support_glitch",
        reward_name = "$twitch_extended_sub_rewards_support_glitch",
        reward_description = "$twitch_extended_sub_rewards_fighter_support_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/glitch.png",
        required_flag = "",
        func = function(reward, userdata)
            --spawn_item("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", 10, 10)
            for i,entity_id in ipairs( get_players() ) do
                local x,y = EntityGetTransform( entity_id )
                local ghost = EntityLoad("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", x, y)

                text_above_entity(ghost, userdata.username, 0)


                EntityAddComponent2(ghost, "VariableStorageComponent", {
                    name="type",
                    value_string="support"
                })
                EntityAddChild(entity_id, ghost)
			end
        end,
    },
    {
        reward_id = "spawn_perk",
        reward_name = "$twitch_extended_channel_rewards_spawn_perk",
        reward_description = "$twitch_extended_channel_rewards_spawn_perk_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_perk.png",
        required_flag = "",
        func = function(reward, userdata)
            give_perk()
        end,
    },
    {
        reward_id = "spawn_spell",
        reward_name = "$twitch_extended_channel_rewards_spawn_spell",
        reward_description = "$twitch_extended_channel_rewards_spawn_spell_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_spell.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_spell()
        end,
    },
    {
        reward_id = "spawn_wand",
        reward_name = "$twitch_extended_channel_rewards_spawn_wand",
        reward_description = "$twitch_extended_channel_rewards_spawn_wand_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_wand.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_biome_wand()
        end,
    },
    {
        reward_id = "spawn_enemy",
        reward_name = "$twitch_extended_channel_rewards_spawn_enemy",
        reward_description = "$twitch_extended_channel_rewards_spawn_enemy_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_enemy.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_enemy_biome(userdata.username)
        end,
    },
    {
        reward_id = "spawn_bomb",
        reward_name = "$twitch_extended_channel_rewards_spawn_bomb",
        reward_description = "$twitch_extended_channel_rewards_spawn_bomb_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/spawn_bomb.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_bomb()
        end,
    },
    {
        reward_id = "spawn_potion",
        reward_name = "$twitch_extended_channel_rewards_spawn_potion",
        reward_description = "$twitch_extended_channel_rewards_spawn_potion_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_potion.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_item("data/entities/items/pickup/potion.xml", 30, 50)
        end,
    },
    {
        reward_id = "spawn_chest",
        reward_name = "$twitch_extended_channel_rewards_spawn_chest",
        reward_description = "$twitch_extended_channel_rewards_spawn_chest_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/spawn_chest.png",
        required_flag = "",
        func = function(reward, userdata)
           -- spawn_chest()
           local player = get_player()
           if(player ~= nil)then
               local x,y = EntityGetTransform(player)
               local chance = Random(1,100)
               if(chance < 5)then
                   spawn_item("data/entities/animals/chest_leggy.xml",30, 50)
               elseif(chance < 30)then
                   spawn_item("data/entities/animals/chest_mimic.xml",30, 50)
               elseif(chance < 70)then
                   spawn_item("data/entities/items/pickup/chest_random.xml", 30, 50)
               else
                   spawn_item("data/entities/items/pickup/chest_random_super.xml", 30, 50)
               end
           end
        end,
    },
    {
        reward_id = "spawn_random_homunculus",
        reward_name = "$twitch_extended_channel_rewards_random_homunculus",
        reward_description = "$twitch_extended_channel_rewards_random_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username)
        end,
    },
    {
        reward_id = "spawn_normal_homunculus",
        reward_name = "$twitch_extended_channel_rewards_normal_homunculus",
        reward_description = "$twitch_extended_channel_rewards_normal_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/normal_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "normal")
        end,
    },
    {
        reward_id = "spawn_healer_homunculus",
        reward_name = "$twitch_extended_channel_rewards_healer_homunculus",
        reward_description = "$twitch_extended_channel_rewards_healer_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/healer_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "healer")
        end,
    },
    {
        reward_id = "spawn_slow_homunculus",
        reward_name = "$twitch_extended_channel_rewards_slow_homunculus",
        reward_description = "$twitch_extended_channel_rewards_slow_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/slow_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "slow")
        end,
    },
    {
        reward_id = "spawn_fireball_homunculus",
        reward_name = "$twitch_extended_channel_rewards_fireball_homunculus",
        reward_description = "$twitch_extended_channel_rewards_fireball_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/fireball_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "fireball")
        end,
    },
    {
        reward_id = "spawn_laser_homunculus",
        reward_name = "$twitch_extended_channel_rewards_laser_homunculus",
        reward_description = "$twitch_extended_channel_rewards_laser_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/laser_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "laser")
        end,
    },
    {
        reward_id = "spawn_punch_homunculus",
        reward_name = "$twitch_extended_channel_rewards_punch_homunculus",
        reward_description = "$twitch_extended_channel_rewards_punch_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/punch_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "punch")
        end,
    },
}

-- Emerald tablet with username and message
-- Charm all nearby enemies
-- turn enemies to gold
-- random perk
sub_rewards = {
    {
        reward_id = "emerald_tablet",
        reward_name = "$twitch_extended_sub_rewards_emerald_tablet",
        reward_description = "$twitch_extended_sub_rewards_emerald_tablet_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/emerald_tablet.png",
        required_flag = "",
        func = function(reward, userdata)
            generate_emerald_tablet(userdata.username, userdata.message)
        end,
    },
    {
        reward_id = "lots_of_gold",
        reward_name = "$twitch_extended_sub_rewards_lots_of_gold",
        reward_description = "$twitch_extended_sub_rewards_lots_of_gold_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/lots_of_gold.png",
        required_flag = "",
        func = function(reward, userdata)
            local player = get_player()
            local wallet = EntityGetFirstComponent(player, "WalletComponent")
            if(wallet ~= nil)then
                local money = tonumber(ComponentGetValueInt(wallet, "money"))
                -- APP: This is setting wallet to 0 so is basically scatter gold? Removed this and now is just giving 500 gold by deault
                --ComponentSetValue(wallet, "money", 0)
                local count = math.max(math.floor(money / 25), 40) + ((userdata.total_months or 1) * 10)
                        
                for i = 1, count do
                    spawn_item("data/entities/items/pickup/goldnugget.xml", 50, 100)
                end
            end
        end,
    },
    {
        reward_id = "gold_aura",
        reward_name = "$twitch_extended_sub_rewards_gold_aura",
        reward_description = "$twitch_extended_sub_rewards_gold_aura_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/gold_aura.png",
        required_flag = "",
        func = function(reward, userdata)
            for i,entity_id in pairs( get_players() ) do
                local x, y = EntityGetTransform( entity_id )
                
                local effect_id = EntityLoad( "mods/twitch_extended/files/entities/misc/enemies_to_gold.xml", x, y )
                set_lifetime( effect_id )
                EntityAddChild( entity_id, effect_id )
                
                add_status_effect( effect_id, "mods/twitch_extended/files/gfx/status_effects/enemies_to_gold.png", "Gold Aura", "You turn nearby enemies to gold.", false )
            end
        end,
    },
    {
        reward_id = "charm_enemies",
        reward_name = "$twitch_extended_sub_rewards_charm_enemies",
        reward_description = "$twitch_extended_sub_rewards_charm_enemies_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/charm_enemies.png",
        required_flag = "",
        func = function(reward, userdata)
            for i,entity_id in pairs( get_players() ) do
                local x, y, rot = EntityGetTransform( entity_id )
                
                for _,entity in pairs( EntityGetInRadiusWithTag( x, y, 1024, "enemy" ) or {} ) do
                    local effect_id = EntityLoad( "data/entities/misc/effect_charm.xml", x, y )

                    EntityAddChild( entity, effect_id )
                end
            end
        end,
    },
    {
        reward_id = "random_perk",
        reward_name = "$twitch_extended_sub_rewards_random_perk",
        reward_description = "$twitch_extended_sub_rewards_random_perk_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_perk.png",
        required_flag = "",
        func = function(reward, userdata)
			local players = get_players()
			
			for i,entity_id in ipairs( players ) do
				local x,y = EntityGetTransform( entity_id )
				local pid = perk_spawn_random( x, y )
				perk_pickup( pid, entity_id, "", true, false )
			end
        end,
    },
    {
        reward_id = "healing_glitch",
        reward_name = "$twitch_extended_sub_rewards_healing_glitch",
        reward_description = "$twitch_extended_sub_rewards_healing_glitch_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/glitch.png",
        required_flag = "",
        func = function(reward, userdata)
            --spawn_item("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", 10, 10)
            for i,entity_id in ipairs( get_players() ) do
                local x,y = EntityGetTransform( entity_id )
                local ghost = EntityLoad("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", x, y)

                text_above_entity(ghost, userdata.username, 0)

                EntityAddComponent2(ghost, "VariableStorageComponent", {
                    name="type",
                    value_string="healer"
                })
                EntityAddChild(entity_id, ghost)
			end
        end,
    },
    {
        reward_id = "twitchy_glitch",
        reward_name = "$twitch_extended_sub_rewards_twitchy_glitch",
        reward_description = "$twitch_extended_sub_rewards_twitchy_glitch_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/glitch.png",
        required_flag = "",
        func = function(reward, userdata)
            --spawn_item("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", 10, 10)
            for i,entity_id in ipairs( get_players() ) do
                local x,y = EntityGetTransform( entity_id )
                local ghost = EntityLoad("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", x, y)

                text_above_entity(ghost, userdata.username, 0)

                EntityAddComponent2(ghost, "VariableStorageComponent", {
                    name="type",
                    value_string="twitchy"
                })
                EntityAddChild(entity_id, ghost)
			end
        end,
    },
    {
        reward_id = "damaging_glitch",
        reward_name = "$twitch_extended_sub_rewards_fighter_glitch",
        reward_description = "$twitch_extended_sub_rewards_fighter_glitch_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/glitch.png",
        required_flag = "",
        func = function(reward, userdata)
            --spawn_item("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", 10, 10)
            for i,entity_id in ipairs( get_players() ) do
                local x,y = EntityGetTransform( entity_id )
                local ghost = EntityLoad("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", x, y)

                text_above_entity(ghost, userdata.username, 0)


                EntityAddComponent2(ghost, "VariableStorageComponent", {
                    name="type",
                    value_string="damaging"
                })
                EntityAddChild(entity_id, ghost)
			end
        end,
    },
    {
        reward_id = "support_glitch",
        reward_name = "$twitch_extended_sub_rewards_support_glitch",
        reward_description = "$twitch_extended_sub_rewards_fighter_support_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/glitch.png",
        required_flag = "",
        func = function(reward, userdata)
            --spawn_item("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", 10, 10)
            for i,entity_id in ipairs( get_players() ) do
                local x,y = EntityGetTransform( entity_id )
                local ghost = EntityLoad("mods/twitch_extended/files/entities/animals/glitch/glitch.xml", x, y)

                text_above_entity(ghost, userdata.username, 0)


                EntityAddComponent2(ghost, "VariableStorageComponent", {
                    name="type",
                    value_string="support"
                })
                EntityAddChild(entity_id, ghost)
			end
        end,
    },
}

channel_rewards = {
    {
        reward_id = "local_shift",
        reward_name = "$twitch_extended_channel_rewards_local_shift",
        reward_description = "$twitch_extended_channel_rewards_local_shift_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/fungal_shift.png",
        required_flag = "",
        custom_options = {
            {
                type = "slider",
                flag = "shift_distance",
                name = "Shift Distance",
                description = "How far away from the player will materials get shifted.",
                default_number = 250,
                min_number = 10,
                max_number = 800,
                format = "$0",
            },
            {
                type = "toggle",
                flag = "shift_random",
                name = "Random if unknown material",
                description = "If any of the materials do not exist pick random",
                default = false
            },
            {
                type = "toggle",
                flag = "random_pool",
                name = "Random Pool",
                description = "For the random pick, pool materials with the same name together.",
                default = false
            },
            {
                type = "toggle",
                flag = "convert_flasks",
                name = "Convert flasks",
                description = "Convert vessels containing the material as well.",
                default = false
            },
        },
        no_display_message = true, 
        func = function(reward, userdata)
            local shift_distance = ModSettingGet("twitch_extended_link_rewards_local_shift_shift_distance") or 250
            local allow_random = HasSettingFlag("twitch_extended_link_rewards_local_shift_shift_random")
            local random_pool =  HasSettingFlag("twitch_extended_link_rewards_local_shift_random_pool")
            local convert_flasks = HasSettingFlag("twitch_extended_link_rewards_local_shift_convert_flasks")
            fungal_shift_local(reward, userdata, allow_random, shift_distance, convert_flasks, random_pool)
        end,
    },
    {
        reward_id = "fungal_shift",
        reward_name = "$twitch_extended_channel_rewards_fungal_shift",
        reward_description = "$twitch_extended_channel_rewards_fungal_shift_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/fungal_funny.png",
        required_flag = "",
        custom_options = {
            {
                type = "toggle",
                flag = "shift_random",
                name = "Random if unknown material",
                description = "If any of the materials do not exist pick random",
                default = false
            },
            {
                type = "toggle",
                flag = "random_pool",
                name = "Random Pool",
                description = "For the random pick, pool materials with the same name together.",
                default = false
            },
        },
        no_display_message = true, 
        func = function(reward, userdata)
            local allow_random = HasSettingFlag("twitch_extended_link_rewards_fungal_shift_shift_random")
            local random_pool =  HasSettingFlag("twitch_extended_link_rewards_fungal_shift_random_pool")
            fungal_shift_everywhere(reward, userdata, allow_random, random_pool)
        end,
    },
    {
        reward_id = "spawn_perk",
        reward_name = "$twitch_extended_channel_rewards_spawn_perk",
        reward_description = "$twitch_extended_channel_rewards_spawn_perk_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_perk.png",
        required_flag = "",
        func = function(reward, userdata)
            give_perk()
        end,
    },
    {
        reward_id = "spawn_spell",
        reward_name = "$twitch_extended_channel_rewards_spawn_spell",
        reward_description = "$twitch_extended_channel_rewards_spawn_spell_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_spell.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_spell()
        end,
    },
    {
        reward_id = "spawn_wand",
        reward_name = "$twitch_extended_channel_rewards_spawn_wand",
        reward_description = "$twitch_extended_channel_rewards_spawn_wand_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_wand.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_biome_wand()
        end,
    },
    {
        reward_id = "spawn_enemy",
        reward_name = "$twitch_extended_channel_rewards_spawn_enemy",
        reward_description = "$twitch_extended_channel_rewards_spawn_enemy_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_enemy.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_enemy_biome(userdata.username)
        end,
    },
    {
        reward_id = "spawn_bomb",
        reward_name = "$twitch_extended_channel_rewards_spawn_bomb",
        reward_description = "$twitch_extended_channel_rewards_spawn_bomb_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/spawn_bomb.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_bomb()
        end,
    },
    {
        reward_id = "spawn_potion",
        reward_name = "$twitch_extended_channel_rewards_spawn_potion",
        reward_description = "$twitch_extended_channel_rewards_spawn_potion_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_potion.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_item("data/entities/items/pickup/potion.xml", 30, 50)
        end,
    },
    {
        reward_id = "spawn_chest",
        reward_name = "$twitch_extended_channel_rewards_spawn_chest",
        reward_description = "$twitch_extended_channel_rewards_spawn_chest_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/spawn_chest.png",
        required_flag = "",
        func = function(reward, userdata)
           -- spawn_chest()
           local player = get_player()
           if(player ~= nil)then
               local x,y = EntityGetTransform(player)
               local chance = Random(1,100)
               if(chance < 5)then
                   spawn_item("data/entities/animals/chest_leggy.xml",30, 50)
               elseif(chance < 30)then
                   spawn_item("data/entities/animals/chest_mimic.xml",30, 50)
               elseif(chance < 70)then
                   spawn_item("data/entities/items/pickup/chest_random.xml", 30, 50)
               else
                   spawn_item("data/entities/items/pickup/chest_random_super.xml", 30, 50)
               end
           end
        end,
    },
    {
        reward_id = "spawn_random_homunculus",
        reward_name = "$twitch_extended_channel_rewards_random_homunculus",
        reward_description = "$twitch_extended_channel_rewards_random_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username)
        end,
    },
    {
        reward_id = "spawn_normal_homunculus",
        reward_name = "$twitch_extended_channel_rewards_normal_homunculus",
        reward_description = "$twitch_extended_channel_rewards_normal_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/normal_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "normal")
        end,
    },
    {
        reward_id = "spawn_healer_homunculus",
        reward_name = "$twitch_extended_channel_rewards_healer_homunculus",
        reward_description = "$twitch_extended_channel_rewards_healer_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/healer_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "healer")
        end,
    },
    {
        reward_id = "spawn_slow_homunculus",
        reward_name = "$twitch_extended_channel_rewards_slow_homunculus",
        reward_description = "$twitch_extended_channel_rewards_slow_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/slow_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "slow")
        end,
    },
    {
        reward_id = "spawn_fireball_homunculus",
        reward_name = "$twitch_extended_channel_rewards_fireball_homunculus",
        reward_description = "$twitch_extended_channel_rewards_fireball_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/fireball_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "fireball")
        end,
    },
    {
        reward_id = "spawn_laser_homunculus",
        reward_name = "$twitch_extended_channel_rewards_laser_homunculus",
        reward_description = "$twitch_extended_channel_rewards_laser_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/laser_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "laser")
        end,
    },
    {
        reward_id = "spawn_punch_homunculus",
        reward_name = "$twitch_extended_channel_rewards_punch_homunculus",
        reward_description = "$twitch_extended_channel_rewards_punch_homunculus_description",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/punch_homunculus.png",
        required_flag = "",
        func = function(reward, userdata)
            spawn_homunculus(userdata.username, "punch")
        end,
    },
	{
		reward_id = "spawn_boss",
        reward_name = "Spawn Boss",
        reward_description = "Spawn Boss",
        reward_image = "mods/twitch_extended/files/gfx/reward_images/random_boss.png",
        required_flag = "",
		func = function(reward, userdata)
			
			bosses = {
				"data/entities/animals/boss_dragon.xml",
				"data/entities/animals/boss_limbs/boss_limbs.xml",
				"data/entities/animals/boss_alchemist/boss_alchemist.xml",
				"data/entities/animals/boss_pit/boss_pit.xml",
				"data/entities/buildings/wizardcave_gate_monster_spawner.xml",
				"data/entities/animals/boss_wizard/boss_wizard.xml",
				"data/entities/animals/boss_ghost/boss_ghost.xml",
				"data/entities/animals/boss_robot/boss_robot.xml",
			}
			spawn_item(bosses[Random(1, #bosses)], 50, 150, true, false, 100)
		end
	}
}
