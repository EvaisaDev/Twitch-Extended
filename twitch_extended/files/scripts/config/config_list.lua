dofile("mods/twitch_extended/config/rewards.lua")
dofile("mods/twitch_extended/config/run_modifiers.lua")
dofile("mods/twitch_extended/config/loadouts.lua")
dofile("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once( "data/scripts/perks/perk_list.lua" )

VERSION = "v2.7.2"
DATE = "March 20 2022"

twitch_config_options = {
    mod_id = "twitch_extended",
    mod_name = "Twitch Extended",
    categories = {
        {
            category_id = "options",
            category = "$twitch_extended_config_category_options",
            items_per_page = 45,
            items_per_row = 15,
            items = {
           --[[     {
                    flag = "text_slider",
                    required_flag = "",
                    name = "Text Slider",
                    description = "e",
                    default_number = 1,
                    max_number = 10000,
                    min_number = -10000,
                    format = "$0%",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, ]]
                {
                    name = "$twitch_extended_config_category_options_description",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    offset_x = -4,
                    offset_y = 0,
                    name = "Reset All Settings",
                    item_id = "reset_settings",
                    required_flag = "",
                    description = "Reset all settings to default",
                    type = "button",
                    callback = function(item)

                        for k, v in pairs(channel_rewards)do
                            ModSettingRemove("twitch_reward_"..v.reward_id)
                            RemoveSettingFlag("twitch_extended_link_rewards_"..v.reward_id)
                        end

                        for k, v in pairs(twitch_config_options.categories)do
                            for k2, item in pairs(v.items)do
                                if(item.type == "toggle")then
                                    if(item.default)then
                                        AddSettingFlag(get_flag(twitch_config_options.mod_id, v.category_id, item.flag))
                                    else
                                        if(HasSettingFlag(get_flag(twitch_config_options.mod_id, v.category_id, item.flag)))then
                                            RemoveSettingFlag(get_flag(twitch_config_options.mod_id, v.category_id, item.flag))
                                        end
                                    end
                                elseif(item.type == "slider")then
                                    ModSettingSet( get_flag(twitch_config_options.mod_id, v.category_id, item.flag), item.default_number )
                                    item.current_number = item.default_number
                                elseif(item.type == "enum")then
                                    ModSettingSet( get_flag(twitch_config_options.mod_id, v.category_id, item.flag), item.default )
                                    item.current_key = item.default
                                elseif(item.type == "input")then
                                    ModSettingSet( get_flag(twitch_config_options.mod_id, v.category_id, item.flag), item.default_text )
                                    item.current_text = item.default_text
                                end
                            end
                        end
                    end
                },
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    name = "$twitch_extended_voting_system",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "ffb5b5b5",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    flag = "events",
                    required_flag = "",
                    name = "$twitch_extended_config_events",
                    description = "$twitch_extended_config_events_description",
                    default = true,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)

                    end
                },  
                {
                    flag = "loadouts",
                    required_flag = "",
                    name = "$twitch_extended_config_loadouts",
                    description = "$twitch_extended_config_loadouts_description",
                    default = false,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)

                    end
                },  
				{
                    flag = "custom_cape_color",
                    required_flag = "",
                    name = "$twitch_extended_config_custom_cape_color",
                    description = "$twitch_extended_config_custom_cape_color_description",
                    default = true,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)

                    end
                },  
				{
                    flag = "unlock_spells",
                    required_flag = "",
                    name = "$twitch_extended_config_unlock_spells",
                    description = "$twitch_extended_config_unlock_spells_description",
                    default = false,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)

                    end
                },  
				{
                    flag = "custom_sprites",
                    required_flag = "",
                    name = "$twitch_extended_config_custom_sprites",
                    description = "$twitch_extended_config_custom_sprites_description",
                    default = true,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)

                    end
                },  
                {
                    flag = "loadout_vote_length",
                    required_flag = "",
                    name = "$twitch_extended_config_loadout_vote_length",
                    description = "$twitch_extended_config_loadout_vote_length_description",
                    default_number = 30,
                    max_number = 120,
                    min_number = 0,
                    format = "$0",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "artifacts",
                    required_flag = "",
                    name = "$twitch_extended_config_artifacts",
                    description = "$twitch_extended_config_artifacts_description",
                    default = false,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)

                    end
                },  
                {
                    flag = "artifact_vote_length",
                    required_flag = "",
                    name = "$twitch_extended_config_artifact_vote_length",
                    description = "$twitch_extended_config_artifact_vote_length_description",
                    default_number = 30,
                    max_number = 120,
                    min_number = 0,
                    format = "$0",
                    increments = {
                    1,
                    5
                    },
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "perks",
                    required_flag = "",
                    name = "$twitch_extended_config_perks",
                    description = "$twitch_extended_config_perks_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)

                    end
                },  
                {
                    flag = "perk_vote_length",
                    required_flag = "",
                    name = "$twitch_extended_config_perk_vote_length",
                    description = "$twitch_extended_config_perk_vote_length_description",
                    default_number = 30,
                    max_number = 120,
                    min_number = 0,
                    format = "$0",
                    increments = {
                    1,
                    5
                    },
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "delay_perk",
                    required_flag = "",
                    name = "$twitch_extended_config_delay_perk",
                    description = "$twitch_extended_config_delay_perk_description",
                    default = false,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)

                    end
                },  
                {
                    flag = "no_vote_delay",
                    required_flag = "",
                    name = "$twitch_extended_config_no_vote_delay",
                    description = "$twitch_extended_config_no_vote_delay_description",
                    default = false,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)

                    end
                },  
                {
                    flag = "disable_voting_system",
                    required_flag = "",
                    name = "$twitch_extended_config_disable_voting_system",
                    description = "$twitch_extended_config_disable_voting_system_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                        --StreamingSetVotingEnabled(not enabled)
                        if(enabled == true)then
                            GamePrint("Voting system disabled.")
                            
                        else
                            GamePrint("Voting system enabled.")
                        end
                    end
                },  
                {
                    flag = "pause_in_mountain",
                    required_flag = "",
                    name = "$twitch_extended_config_pause_in_mountain",
                    description = "$twitch_extended_config_pause_in_mountain_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },  
                {
                    flag = "pause_in_boss",
                    required_flag = "",
                    name = "$twitch_extended_config_pause_in_boss",
                    description = "$twitch_extended_config_pause_in_boss_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },  
                {
                    flag = "left_side_votes",
                    required_flag = "",
                    name = "$twitch_extended_config_left_side_votes",
                    description = "$twitch_extended_config_left_side_votes_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },  
                {
                    flag = "no_event_timers",
                    required_flag = "",
                    name = "$twitch_extended_config_no_event_timers_name",
                    description = "$twitch_extended_config_no_event_timers_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },  
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    name = "$twitch_extended_in_game_chat",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "ffb5b5b5",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    flag = "show_chat",
                    required_flag = "",
                    name = "$twitch_extended_config_show_chat",
                    description = "$twitch_extended_config_show_chat_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },  
                {
                    flag = "chat_timeout",
                    required_flag = "",
                    name = "$twitch_extended_config_chat_timeout",
                    description = "$twitch_extended_config_chat_timeout_description",
                    default_number = 10,
                    max_number = 120,
                    min_number = 1,
                    format = "$0",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "chat_count",
                    required_flag = "",
                    name = "$twitch_extended_config_chat_count",
                    description = "$twitch_extended_config_chat_count_description",
                    default_number = 7,
                    max_number = 20,
                    min_number = 1,
                    format = "$0",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "chat_position_x",
                    required_flag = "",
                    name = "$twitch_extended_config_chat_x",
                    description = "$twitch_extended_config_chat_x_description",
                    default_number = 1,
                    max_number = 100,
                    min_number = 0,
                    format = "$0%",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "chat_position_y",
                    required_flag = "",
                    name = "$twitch_extended_config_chat_y",
                    description = "$twitch_extended_config_chat_y_description",
                    default_number = 15,
                    max_number = 100,
                    min_number = 0,
                    format = "$0%",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "chat_line_split",
                    required_flag = "",
                    name = "$twitch_extended_config_chat_line_split",
                    description = "$twitch_extended_config_chat_line_split_description",
                    default_number = 50,
                    max_number = 500,
                    min_number = 0,
                    format = "$0",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "chat_line_cut_limit",
                    required_flag = "",
                    name = "$twitch_extended_config_chat_char_limit",
                    description = "$twitch_extended_config_chat_char_limit_description",
                    default_number = 500,
                    max_number = 500,
                    min_number = 0,
                    format = "$0",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "show_chat_badges",
                    required_flag = "",
                    name = "$twitch_extended_config_show_chat_badges",
                    description = "$twitch_extended_config_show_chat_badges_description",
                    default = true,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },  
                {
                    flag = "chat_background",
                    required_flag = "",
                    name = "$twitch_extended_config_show_chat_background",
                    description = "$twitch_extended_config_show_chat_background_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },  
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    name = "$twitch_extended_nametags",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "ffb5b5b5",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    flag = "champion_naming",
                    required_flag = "gokis_things_enabled",
                    name = "$twitch_extended_config_champion_naming",
                    description = "$twitch_extended_config_champion_naming_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)

                    end
                },  
                {
                    flag = "champion_percentage",
                    required_flag = "gokis_things_enabled",
                    name = "$twitch_extended_config_champion_percentage",
                    description = "$twitch_extended_config_champion_percentage_description",
                    default_number = 20,
                    max_number = 100,
                    min_number = 1,
                    format = "$0%",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
				{
                    flag = "blessed_beast_naming",
                    required_flag = "blessed_beasts_enabled",
                    name = "$twitch_extended_config_blessed_beast_naming",
                    description = "$twitch_extended_config_blessed_beast_naming_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)

                    end
                },  
                {
                    flag = "blessed_beast_percentage",
                    required_flag = "blessed_beasts_enabled",
                    name = "$twitch_extended_config_blessed_beast_percentage",
                    description = "$twitch_extended_config_blessed_beast_percentage_description",
                    default_number = 20,
                    max_number = 100,
                    min_number = 1,
                    format = "$0%",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "miniboss_naming",
                    required_flag = "gokis_things_enabled",
                    name = "$twitch_extended_config_miniboss_naming",
                    description = "$twitch_extended_config_miniboss_naming_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)

                    end
                },
                {
                    flag = "miniboss_percentage",
                    required_flag = "gokis_things_enabled",
                    name = "$twitch_extended_config_miniboss_percentage",
                    description = "$twitch_extended_config_miniboss_percentage_description",
                    default_number = 20,
                    max_number = 100,
                    min_number = 1,
                    format = "$0%",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                },
				{
                    flag = "blessed_miniboss_naming",
                    required_flag = "blessed_beasts_enabled",
                    name = "$twitch_extended_config_blessed_miniboss_naming",
                    description = "$twitch_extended_config_blessed_miniboss_naming_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)

                    end
                },
                {
                    flag = "blessed_miniboss_percentage",
                    required_flag = "blessed_beasts_enabled",
                    name = "$twitch_extended_config_blessed_miniboss_percentage",
                    description = "$twitch_extended_config_blessed_miniboss_percentage_description",
                    default_number = 20,
                    max_number = 100,
                    min_number = 1,
                    format = "$0%",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "remove_user_minutes",
                    required_flag = "",
                    name = "$twitch_extended_config_remove_user_minutes",
                    description = "$twitch_extended_config_remove_user_minutes_description",
                    default_number = 10,
                    max_number = 120,
                    min_number = 1,
                    format = "$0",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "remove_after_used",
                    required_flag = "",
                    name = "$twitch_extended_config_remove_after_used",
                    description = "$twitch_extended_config_remove_after_used_description",
                    default = true,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },  
                {
                    flag = "include_broadcaster",
                    required_flag = "",
                    name = "$twitch_extended_config_include_broadcaster",
                    description = "$twitch_extended_config_include_broadcaster_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },  
                {
                    flag = "include_moderators",
                    required_flag = "",
                    name = "$twitch_extended_config_include_moderators",
                    description = "$twitch_extended_config_include_moderators_description",
                    default = true,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },
                {
                    flag = "only_subscribers",
                    required_flag = "",
                    name = "$twitch_extended_config_only_subscribers",
                    description = "$twitch_extended_config_only_subscribers_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end
                },
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    name = "$twitch_extended_death_counter",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "ffb5b5b5",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    flag = "enable_death_counter",
                    required_flag = "",
                    name = "$twitch_extended_config_enable_death_counter",
                    description = "$twitch_extended_config_enable_death_counter_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)

                    end
                },  
                {
                    flag = "death_counter_position_x",
                    required_flag = "",
                    name = "$twitch_extended_config_death_counter_x",
                    description = "$twitch_extended_config_death_counter_x_description",
                    default_number = 1,
                    max_number = 100,
                    min_number = 0,
                    format = "$0%",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    flag = "death_counter_position_y",
                    required_flag = "",
                    name = "$twitch_extended_config_death_counter_y",
                    description = "$twitch_extended_config_death_counter_y_description",
                    default_number = 1,
                    max_number = 100,
                    min_number = 0,
                    format = "$0%",
                    type = "slider",
                    requires_restart = false,
                    callback = function(number)

                    end
                }, 
                {
                    name = "$twitch_extended_config_reset_death_counter",
                    item_id = "reset_deathcounter",
                    required_flag = "",
                    description = "$twitch_extended_config_reset_death_counter_description",
                    type = "button",
                    callback = function(item)
                        ModSettingSet("twitch_extended_death_counter", 0) 
                    end
                },
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    name = "$twitch_extended_misc",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "ffb5b5b5",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                },  
                {
                    flag = "reward_message",
                    required_flag = "",
                    name = "$twitch_extended_config_reward_message",
                    description = "$twitch_extended_config_reward_message_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)

                    end
                },    
               --[[ {
                    flag = "channel_point_rewards",
                    required_flag = "",
                    name = "$twitch_extended_config_channel_point_rewards",
                    description = "$twitch_extended_config_channel_point_rewards_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)

                    end
                }, ]]  
                {
                    flag = "subscription_rewards",
                    required_flag = "",
                    name = "$twitch_extended_config_sub_rewards",
                    description = "$twitch_extended_config_sub_rewards_description",
                    default = false,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)

                    end
                },      
                {
                    flag = "noita_together_shifts",
                    required_flag = "noita_together_enabled",
                    name = "[Noita Together] Shifts",
                    description = "Synchronize fungal/local shifts with Noita Together",
                    default = true,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)

                    end
                },      


                
                --[[{
                    flag = "bit_rewards",
                    required_flag = "",
                    name = "$twitch_extended_config_bit_rewards",
                    description = "$twitch_extended_config_bit_rewards_description",
                    default = false,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)

                    end
                },   ]]
                --[[{
                    flag = "input_test",
                    required_flag = "",
                    name = "Some text input",
                    description = "Write something here",
                    default_text = "Input text here",
                    allowed_chars = "",
                    text_max_length = 10,
                    type = "input",
                    requires_restart = true,
                    callback = function(number)

                    end
                },]]               
            }
        },
		{
            category_id = "loadouts",
            category = "$twitch_extended_config_category_loadouts",
            items_per_page = 45,
            items_per_row = 15,
            items = {
                {
                    name = "$twitch_extended_config_category_loadouts_description",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },    
                {
                    required_flag = "",
                    type = "spacer"
                },    
            }
        },
        {
            category_id = "perk_list",
            category = "$twitch_extended_config_category_perk_list",
            items_per_page = 45,
            items_per_row = 15,
            items = {
                {
                    name = "$twitch_extended_config_category_perk_list_description",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                },  
            }
        },
        {
            category_id = "run_modifiers",
            category = "$twitch_extended_config_category_run_modifiers",
            items_per_page = 45,
            items_per_row = 15,
            items = {
                {
                    name = "$twitch_extended_config_category_run_modifiers_description",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                }, 
            }
        },
        {
            category_id = "shift_blacklist_input",
            category = "$twitch_extended_config_category_shift_blacklist_input",
            items_per_page = 45,
            items_per_row = 15,
            items = {
                {
                    name = "$twitch_extended_config_category_shift_blacklist_input_description",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },    
                {
                    required_flag = "",
                    type = "spacer"
                },    
            }
        },
        {
            category_id = "shift_blacklist_output",
            category = "$twitch_extended_config_category_shift_blacklist_output",
            items_per_page = 45,
            items_per_row = 15,
            items = {
                {
                    name = "$twitch_extended_config_category_shift_blacklist_output_description",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },    
                {
                    required_flag = "",
                    type = "spacer"
                },    
            }
        },
        {
            category_id = "commands",
            category = "$twitch_extended_config_category_commands",
            items_per_page = 45,
            items_per_row = 15,
            items = {
                {
                    name = "$twitch_extended_config_category_commands_description",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                },  
            }
        },
        {
            category_id = "link_rewards",
            category = "$twitch_extended_config_category_link_rewards",
            items_per_page = 20,
            items_per_row = 20,
            items = {
                {
                    name = "$twitch_extended_config_rewards_1",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },      
                {
                    name = "$twitch_extended_config_rewards_2",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                },  
            }
        },
        {
            category_id = "sub_rewards",
            category = "$twitch_extended_config_category_sub_rewards",
            items_per_page = 45,
            items_per_row = 15,
            items = {
                {
                    name = "$twitch_extended_config_category_sub_rewards_description",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },      
                {
                    required_flag = "",
                    type = "spacer"
                },  
            }
        },
        {
            category_id = "bit_rewards",
            category = "$twitch_extended_config_category_bit_rewards",
            items_per_page = 45,
            items_per_row = 15,
            items = {
                {
                    name = "$twitch_extended_config_category_bit_rewards_description",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "fff5ce42",
                    type = "text"
                },    
                {
                    required_flag = "",
                    type = "spacer"
                },    
            }
        },
        {
            category_id = "info",
            category = "$twitch_extended_info",
            items_per_page = 45,
            items_per_row = 15,
            items = {
                {
                    name = "$twitch_extended_author",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "ff97a2a8",
                    type = "text"
                },    
                {
                    name = "Evaisa",
                    required_flag = "",
                    description = "",
                    offset_x = 0,
                    offset_y = 0,
                    color = "ffffffff",
                    type = "text"
                },    
                {
                    name = "$twitch_extended_version",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "ff97a2a8",
                    type = "text"
                },    
                {
                    name = VERSION,
                    required_flag = "",
                    description = "",
                    offset_x = 0,
                    offset_y = 0,
                    color = "ffffffff",
                    type = "text"
                },    
                {
                    name = "$twitch_extended_date",
                    required_flag = "",
                    description = "",
                    offset_x = -4,
                    offset_y = 0,
                    color = "ff97a2a8",
                    type = "text"
                },    
                {
                    name = DATE,
                    required_flag = "",
                    description = "",
                    offset_x = 0,
                    offset_y = 0,
                    color = "ffffffff",
                    type = "text"
                }, 
            }
        },
    }
}

local mats = {}

for k, v in ipairs(CellFactory_GetAllLiquids( true, false ))do
    table.insert(mats, v)
end
for k, v in ipairs(CellFactory_GetAllSands( true, false ))do
    table.insert(mats, v)
end
for k, v in ipairs(CellFactory_GetAllGases( true, false ))do
    table.insert(mats, v)
end
for k, v in ipairs(CellFactory_GetAllFires( true, false ))do
    table.insert(mats, v)
end
for k, v in ipairs(CellFactory_GetAllSolids( true, false ))do
    table.insert(mats, v)
end

function abc_go_brrr( a,b )  
	return a < b
end

table.sort(mats, abc_go_brrr)

shift_material_blacklist_inputs = {
    templerock_static = true,
    templebrick_static = true,
    templebrick_static_broken = true,
    templebrick_static_soft = true,
    templebrick_noedge_static = true,
    templerock_soft = true,
    templebrick_thick_static = true,
    templebrick_thick_static_noedge = true,
    templeslab_static = true,
    templeslab_crumbling_static = true,
    templebrickdark_static = true,
    templebrick_golden_static = true,
    templebrick_diamond_static = true,
    templebrick_static_ruined = true,
}


shift_material_blacklist_outputs  = {
    plastic = true,
    air = true,
    killer_goo = true,
    poly_goo = true,
    hot_goo = true,
    alt_killer_goo = true,
    alt_corruption = true,
    corruption = true,
    killer_goo_solid = true,
    AA_MAT_BLOOM_ROOF_DEAD = true,
    AA_MAT_BLOOM_ROOF_PLANT = true,
    AA_MAT_BLOOM_MAGIC = true,
    AA_MAT_BLOOM_ROOF = true,
    AA_MAT_BLOOM = true,
    monster_powder_test = true,
    AA_MAT_DECAY = true,
    AA_MAT_CONVERTED_SANDSTONE = true,
    AA_MAT_CONVERTED_SAND = true,
    AA_MAT_WORLD_DECAY = true,
    aluminium = true,
    aluminium_oxide = true,
    aluminium_robot = true,
    bloodgold_box2d = true,
    bone_box2d = true,
    brick = true,
    cactus = true,
    cloud_blood = true,
    cloud_radioactive = true,
    cloud_slime = true,
    cocoon_box2d = true,
    concrete_collapsed = true,
    creepy_liquid = true,
    creepy_liquid_emitter = true,
    crystal = true,
    crystal_magic = true,
    crystal_purple = true,
    fuse = true,
    fuse_bright = true,
    fuse_holy = true,
    fuse_tnt = true,
    gem_box2d = true,
    gem_box2d_green = true,
    gem_box2d_orange = true,
    gem_box2d_pink = true,
    gem_box2d_red = true,
    glass = true,
    glass_box2d = true,
    glass_brittle = true,
    glass_liquidcave = true,
    gold_b2 = true,
    gold_box2d = true,
    grass_loose = true,
    ice_b2 = true,
    ice_blood_glass = true,
    ice_ceiling = true,
    ice_cold_glass = true,
    ice_glass = true,
    ice_glass_b2 = true,
    ice_melting_perf_killer = true,
    ice_radioactive_glass = true,
    item_box2d = true,
    item_box2d_glass = true,
    magic_crystal = true,
    magic_crystal_green = true,
    meat = true,
    meat_confusion = true,
    meat_cursed = true,
    meat_cursed_dry = true,
    meat_fast = true,
    meat_frog = true,
    meat_fruit = true,
    meat_helpless = true,
    meat_polymorph = true,
    meat_polymorph_protection = true,
    meat_pumpkin = true,
    meat_slime = true,
    meat_slime_cursed = true,
    meat_slime_green = true,
    meat_slime_orange = true,
    meat_teleport = true,
    meat_trippy = true,
    meat_worm = true,
    metal = true,
    metal_chain_nohit = true,
    metal_nohit = true,
    metal_prop = true,
    metal_prop_loose = true,
    metal_rust = true,
    metal_rust_barrel = true,
    metal_rust_barrel_rust = true,
    metal_rust_rust = true,
    metal_wire_nohit = true,
    meteorite = true,
    meteorite_crackable = true,
    meteorite_green = true,
    meteorite_test = true,
    neon_tube_blood_red = true,
    neon_tube_cyan = true,
    neon_tube_purple = true,
    nest_box2d = true,
    physics_throw_material_part2 = true,
    plasma_fading = true,
    plasma_fading_bright = true,
    plasma_fading_green = true,
    plastic_molten = true,
    plastic_prop = true,
    plastic_prop_molten = true,
    potion_glass_box2d = true,
    radioactive_liquid_fading = true,
    rock_box2d = true,
    rock_box2d_hard = true,
    rock_box2d_nohit = true,
    rock_box2d_nohit_hard = true,
    rock_eroding = true,
    rock_loose = true,
    rock_static_box2d = true,
    rocket_particles = true,
    snow_b2 = true,
    steel = true,
    steel_rust = true,
    sulphur_box2d = true,
    templebrick_box2d = true,
    tnt = true,
    tnt_static = true,
    tube_physics = true,
    waterrock = true,
    wax_b2 = true,
    wood = true,
    wood_loose = true,
    wood_player = true,
    wood_player_b2 = true,
    wood_player_b2_vertical = true,
    wood_prop = true,
    wood_prop_durable = true,
    wood_prop_noplayerhit = true,
    wood_trailer = true,
    wood_wall = true,
    rat_powder = true,
	orb_powder = true,
	gunpowder_unstable_boss_limbs = true,
}

for k, v in ipairs(mats)do
    local allowed = true
    for _, tag in ipairs(CellFactory_GetTags( CellFactory_GetType(v) ))do
        if(tag == "[box2d]")then
            allowed = false
        end
    end
    
    for k2, v2 in pairs(twitch_config_options.categories)do
        if(v2.category_id == "shift_blacklist_input")then
            table.insert(v2.items, {
                flag = v,
                required_flag = "",
                name = v,
                description = "[ "..GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(v))).." ]",
                default = shift_material_blacklist_inputs[v] ~= nil,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                end               
            })
        end
        if(v2.category_id == "shift_blacklist_output")then
            if(allowed)then
                table.insert(v2.items, {
                    flag = v,
                    required_flag = "",
                    name = v,
                    description = "[ "..GameTextGetTranslatedOrNot(CellFactory_GetUIName(CellFactory_GetType(v))).." ]",
                    default = shift_material_blacklist_outputs[v] ~= nil,
                    type = "toggle",
                    requires_restart = false,
                    callback = function(item, enabled)
                    end               
                })
            else
                AddSettingFlag("twitch_extended_shift_blacklist_output_"..v)
            end
        end
    end

end



is_links_disabled = is_links_disabled or false

for k, v in pairs(channel_rewards)do
    for k2, v2 in pairs(twitch_config_options.categories)do
        if(v2.category_id == "link_rewards")then
            if(is_links_disabled == false)then
                GlobalsSetValue("linking_"..v.reward_id, "false")
            end
            prefix = GameTextGetTranslatedOrNot("$twitch_extended_config_reward_link")
            if(HasSettingFlag("twitch_extended_link_rewards_link_"..v.reward_id))then
                prefix = GameTextGetTranslatedOrNot("$twitch_extended_config_reward_unlink")
            end

            new_item1 = {
                name = v.reward_name,
                required_flag = "",
                description = v.reward_description,
                offset_x = -4,
                offset_y = 0,
                color = "ffb0bfeb",
                type = "text"
            }  


            new_item2 = {
                flag = "link_"..v.reward_id,
                required_flag = "",
                name = prefix..' "'..GameTextGetTranslatedOrNot(v.reward_name)..'"',
                description = v.reward_description,
                default = false,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                    if(enabled == false)then
                        --GamePrint("Event voting disabled.")
                        --remove_reward_id(v.reward_id)
                        GlobalsSetValue("unlinking_"..item.flag:gsub("link_", ""), "true")
                        item.name = item.name:gsub(GameTextGetTranslatedOrNot("$twitch_extended_config_reward_unlink"), GameTextGetTranslatedOrNot("$twitch_extended_config_reward_link"))
                      --  GamePrint(GameTextGetTranslatedOrNot("$twitch_extended_config_reward_unlinked")..' "'..item.reward_name..'"')
                    else
                        RemoveSettingFlag("twitch_extended_link_rewards_"..item.flag)
                        GamePrint(GameTextGetTranslatedOrNot("$twitch_extended_config_reward_redeem"))
                        --print(gui_options[getModIndex("twitch_extended")].categories[getCategoryIndex("twitch_extended", "link_rewards")].items[getItemIndex("twitch_extended", "link_rewards", item.flag)].name) --= item.name .. " - Awaiting redemption.."
                        if(not string.match(item.name, "Awaiting redemption"))then
                            item.name = item.name .. "- Awaiting redemption"
                        end
                        if(GlobalsGetValue("linking_"..item.flag:gsub("link_", ""), "false") == "true")then
                            GlobalsSetValue("linking_"..item.flag:gsub("link_", ""), "false")
                            if(string.match(item.name, "Awaiting redemption"))then
                                item.name = item.name:gsub("- Awaiting redemption", "")
                            end
                        else
                            GlobalsSetValue("linking_"..item.flag:gsub("link_", ""), "true")
                        end

                        --GamePrint("Event voting enabled.")
                    end
                end               
            }

            table.insert(v2.items, new_item1)
            table.insert(v2.items, {
                type = "spacer"
            })
            table.insert(v2.items, new_item2)
            table.insert(v2.items, {
                flag = v.reward_id.."_no_message",
                required_flag = "",
                name = "$twitch_extended_no_redeem_message_name",
                description = "$twitch_extended_no_redeem_message_description",
                default = false,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                end               
            })
            if(v.custom_options ~= nil)then
                for k3, option in pairs(v.custom_options)do
                    if(option.type == "toggle")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default = option.default,
                            type = "toggle",
                            requires_restart = false,
                            callback = function(item, enabled)
                            end               
                        })
                    elseif(option.type == "slider")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default_number = option.default_number,
                            max_number = option.max_number,
                            min_number = option.min_number,
                            format = option.format,
                            type = "slider",
                            requires_restart = false,
                            callback = function(number)
        
                            end
                        })
                    elseif(option.type == "input")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default_text = option.default_text,
                            allowed_chars = option.allowed_chars,
                            text_max_length = option.text_max_length,
                            type = "input",
                            requires_restart = false,
                            callback = function(number)
            
                            end
                        })
                    elseif(option.type == "enum")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default = option.default_enum,
                            values = option.values,
                            type = "enum",
                            requires_restart = false,
                            callback = function(item, value)
        
                            end
                        })
                    end
                end
            end
			table.insert(v2.items, {
				name = "Run Reward",
				item_id = "run_reward_"..v.reward_id,
				required_flag = "",
				description = "Run the reward for testing purposes.",
				type = "button",
				callback = function(item)
					v.func(v, {
						username = "test",
						user_id = "NaN",
						broadcaster = false,
						mod = false,
						subscriber = false,
						turbo = false,
						custom_reward = "NaN",
						message = "This is a test.",
						bits = 0,
						total_months = 0,
						streak = 0
					})

					GamePrintImportant(GameTextGetTranslatedOrNot(v.reward_name), GameTextGetTranslatedOrNot(v.reward_description))

				end
			})
			table.insert(v2.items, {
                type = "spacer"
            })
        end
    end
end

for k, v in pairs(sub_rewards)do
    for k2, v2 in pairs(twitch_config_options.categories)do
        if(v2.category_id == "sub_rewards")then
            new_item1 = {
                name = v.reward_name,
                required_flag = "",
                description = v.reward_description,
                offset_x = -4,
                offset_y = 0,
                color = "ffb0bfeb",
                type = "text"
            }  
            new_item2 = {
                flag = v.reward_id,
                required_flag = "",
                name = "$twitch_extended_enable",
                description = v.reward_description,
                default = true,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                end               
            }
            table.insert(v2.items, new_item1)
            table.insert(v2.items, {
                type = "spacer"
            })
            table.insert(v2.items, new_item2)
            table.insert(v2.items, {
                flag = v.reward_id.."_no_message",
                required_flag = "",
                name = "$twitch_extended_no_redeem_message_name",
                description = "$twitch_extended_no_redeem_message_description",
                default = false,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                end               
            })
            if(v.custom_options ~= nil)then
                for k3, option in pairs(v.custom_options)do
                    if(option.type == "toggle")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default = option.default,
                            type = "toggle",
                            requires_restart = false,
                            callback = function(item, enabled)
                            end               
                        })
                    elseif(option.type == "slider")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default_number = option.default_number,
                            max_number = option.max_number,
                            min_number = option.min_number,
                            format = option.format,
                            type = "slider",
                            requires_restart = false,
                            callback = function(number)
        
                            end
                        })
                    elseif(option.type == "input")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default_text = option.default_text,
                            allowed_chars = option.allowed_chars,
                            text_max_length = option.text_max_length,
                            type = "input",
                            requires_restart = false,
                            callback = function(number)
            
                            end
                        })
                    elseif(option.type == "enum")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default = option.default_enum,
                            values = option.values,
                            type = "enum",
                            requires_restart = false,
                            callback = function(item, value)
        
                            end
                        })
                    end
                end
            end
			table.insert(v2.items, {
				name = "Run Reward",
				item_id = "run_reward_"..v.reward_id,
				required_flag = "",
				description = "Run the reward for testing purposes.",
				type = "button",
				callback = function(item)
					v.func(v, {
						username = "test",
						user_id = "NaN",
						broadcaster = false,
						mod = false,
						subscriber = false,
						turbo = false,
						custom_reward = "NaN",
						message = "This is a test.",
						bits = 0,
						total_months = 0,
						streak = 0
					})
					GamePrintImportant(GameTextGetTranslatedOrNot(v.reward_name), GameTextGetTranslatedOrNot(v.reward_description))
				end
			})
			table.insert(v2.items, {
                type = "spacer"
            })
        end
    end
end

for k, v in pairs(commands)do
    for k2, v2 in pairs(twitch_config_options.categories)do
        if(v2.category_id == "commands")then
            new_item1 = {
                name = v.reward_name,
                required_flag = "",
                description = v.reward_description,
                offset_x = -4,
                offset_y = 0,
                color = "ffb0bfeb",
                type = "text"
            }  
            new_item2 = {
                flag = v.reward_id,
                required_flag = "",
                name = "$twitch_extended_enable",
                description = v.reward_description,
                default = false,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                end               
            }
            table.insert(v2.items, new_item1)
            table.insert(v2.items, {
                type = "spacer"
            })
            table.insert(v2.items, new_item2)
            table.insert(v2.items, {
                flag = v.reward_id.."_command",
                required_flag = "",
                name = "Chat command",
                description = "What to type in chat to run this command.",
                default_text = "!"..v.reward_id,
                allowed_chars = "",
                text_max_length = 50,
                type = "input",
                requires_restart = false,
                callback = function(number)

                end
            })
            table.insert(v2.items, {
                flag = v.reward_id.."_permission",
                required_flag = "",
                name = "$twitch_extended_permission_name",
                description = "$twitch_extended_permission_description",
                default = "everyone",
                values = {{"everyone", "Everyone"}, {"sub", "Subscribers"}, {"mod", "Moderators"}, {"broadcaster", "Broadcaster"}},
                type = "enum",
                requires_restart = false,
                callback = function(item, value)

                end
            })
            table.insert(v2.items, {
                flag = v.reward_id.."_cooldown",
                required_flag = "",
                name = "$twitch_extended_cooldown_name",
                description = "$twitch_extended_cooldown_description",
                default_number = 0,
                max_number = 300,
                min_number = 0,
                format = "$0s",
                type = "slider",
                requires_restart = false,
                callback = function(number)

                end
            })
            table.insert(v2.items, {
                flag = v.reward_id.."_cooldown_type",
                required_flag = "",
                name = "$twitch_extended_cooldown_type_name",
                description = "$twitch_extended_cooldown_type_description",
                default = "global",
                values = {{"global", "Global"}, {"user", "Per User"}},
                type = "enum",
                requires_restart = false,
                callback = function(item, value)

                end
            })
            table.insert(v2.items, {
                flag = v.reward_id.."_no_message",
                required_flag = "",
                name = "$twitch_extended_no_redeem_message_name",
                description = "$twitch_extended_no_redeem_message_description",
                default = false,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                end               
            })
            if(v.custom_options ~= nil)then
                for k3, option in pairs(v.custom_options)do
                    if(option.type == "toggle")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default = option.default,
                            type = "toggle",
                            requires_restart = false,
                            callback = function(item, enabled)
                            end               
                        })
                    elseif(option.type == "slider")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default_number = option.default_number,
                            max_number = option.max_number,
                            min_number = option.min_number,
                            format = option.format,
                            type = "slider",
                            requires_restart = false,
                            callback = function(number)
        
                            end
                        })
                    elseif(option.type == "input")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default_text = option.default_text,
                            allowed_chars = option.allowed_chars,
                            text_max_length = option.text_max_length,
                            type = "input",
                            requires_restart = false,
                            callback = function(number)
            
                            end
                        })
                    elseif(option.type == "enum")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default = option.default_enum,
                            values = option.values,
                            type = "enum",
                            requires_restart = false,
                            callback = function(item, value)
        
                            end
                        })
                    end
                end
            end
			table.insert(v2.items, {
				name = "Run Command",
				item_id = "run_command_"..v.reward_id,
				required_flag = "",
				description = "Run the command for testing purposes.",
				type = "button",
				callback = function(item)
					v.func(v, {
						username = "test",
						user_id = "NaN",
						broadcaster = false,
						mod = false,
						subscriber = false,
						turbo = false,
						custom_reward = "NaN",
						message = "This is a test.",
						bits = 0,
						total_months = 0,
						streak = 0
					})
					GamePrintImportant(GameTextGetTranslatedOrNot(v.reward_name), GameTextGetTranslatedOrNot(v.reward_description))
				end
			})
			table.insert(v2.items, {
                type = "spacer"
            })
        end
    end
end


for k, v in pairs(bit_rewards)do
    for k2, v2 in pairs(twitch_config_options.categories)do
        if(v2.category_id == "bit_rewards")then
            new_item1 = {
                name = v.reward_name,
                required_flag = "",
                description = v.reward_description,
                offset_x = -4,
                offset_y = 0,
                color = "ffb0bfeb",
                type = "text"
            }  
            new_item2 = {
                flag = v.reward_id,
                required_flag = "",
                name = "$twitch_extended_enable",
                description = v.reward_description,
                default = false,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                end               
            }
            new_item3 = {
                flag = v.reward_id.."_exact_amount",
                required_flag = "",
                name = "$twitch_extended_bit_exact_amount_name",
                description = "$twitch_extended_bit_exact_amount_description",
                default = false,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                end               
            }
            new_item4 = {
                flag = v.reward_id.."_bit_amount",
                required_flag = "",
                name = "$twitch_extended_bit_amount_amount_name",
                description = "$twitch_extended_bit_amount_amount_description",
                default_text = "100",
                allowed_chars = "1234567890",
                text_max_length = 10,
                type = "input",
                requires_restart = false,
                callback = function(number)

                end
            }
            table.insert(v2.items, new_item1)
            table.insert(v2.items, {
                type = "spacer"
            })
            table.insert(v2.items, new_item2)
            table.insert(v2.items, new_item3)
            table.insert(v2.items, new_item4)
            table.insert(v2.items, {
                flag = v.reward_id.."_no_message",
                required_flag = "",
                name = "$twitch_extended_no_redeem_message_name",
                description = "$twitch_extended_no_redeem_message_description",
                default = false,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                end               
            })
            if(v.custom_options ~= nil)then
                for k3, option in pairs(v.custom_options)do
                    if(option.type == "toggle")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default = option.default,
                            type = "toggle",
                            requires_restart = false,
                            callback = function(item, enabled)
                            end               
                        })
                    elseif(option.type == "slider")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default_number = option.default_number,
                            max_number = option.max_number,
                            min_number = option.min_number,
                            format = option.format,
                            type = "slider",
                            requires_restart = false,
                            callback = function(number)
        
                            end
                        })
                    elseif(option.type == "input")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default_text = option.default_text,
                            allowed_chars = option.allowed_chars,
                            text_max_length = option.text_max_length,
                            type = "input",
                            requires_restart = false,
                            callback = function(number)
            
                            end
                        })
                    elseif(option.type == "enum")then
                        table.insert(v2.items, {
                            flag = v.reward_id.."_"..option.flag,
                            required_flag = "",
                            name = option.name,
                            description = option.description,
                            default = option.default_enum,
                            values = option.values,
                            type = "enum",
                            requires_restart = false,
                            callback = function(item, value)
        
                            end
                        })
                    end
                end
            end
			table.insert(v2.items, {
				name = "Run Reward",
				item_id = "run_reward_"..v.reward_id,
				required_flag = "",
				description = "Run the reward for testing purposes.",
				type = "button",
				callback = function(item)
					v.func(v, {
						username = "test",
						user_id = "NaN",
						broadcaster = false,
						mod = false,
						subscriber = false,
						turbo = false,
						custom_reward = "NaN",
						message = "This is a test.",
						bits = 0,
						total_months = 0,
						streak = 0
					})
					GamePrintImportant(GameTextGetTranslatedOrNot(v.reward_name), GameTextGetTranslatedOrNot(v.reward_description))
				end
			})
			table.insert(v2.items, {
                type = "spacer"
            })
        end
    end
end

function sorting( a,b )  
	return GameTextGetTranslatedOrNot(a.name) < GameTextGetTranslatedOrNot(b.name) 
end

--cloned_perk_list = table.clone(perk_list)

available_perks = {}

for k, v in pairs(perk_list)do
    if(v.id ~= "EXTRA_PERK" and v.id ~= "PERKS_LOTTERY")then
       -- for k2, v2 in pairs(twitch_config_options.categories)do
           -- if(v2.category_id == "perk_list")then
                new_item = {
                    flag = v.id,
                    required_flag = "",
                    name = v.ui_name,
                    description = v.ui_description,
                    default = true,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)
                    end               
                }
                table.insert(available_perks, new_item)
          --  end
      --  end
    end
end

table.sort(available_perks, sorting)

for k, v in pairs(twitch_config_options.categories)do
    if(v.category_id == "perk_list")then
       -- v2.items = cached_items
        for k2, v2 in pairs(available_perks)do
            table.insert(v.items, v2)
        end
    end
end

for k, v in pairs(run_modifiers)do
    for k2, v2 in pairs(twitch_config_options.categories)do
        if(v2.category_id == "run_modifiers")then
            new_item = {
                flag = v.id,
                required_flag = v.required_flag,
                name = v.ui_name,
                description = v.ui_description,
                default = true,
                type = "toggle",
                requires_restart = true,
                callback = function(item, enabled)
                end               
            }
            table.insert(v2.items, new_item)
        end
    end
end

for k, v in pairs(twitch_loadouts)do
    for k2, v2 in pairs(twitch_config_options.categories)do
        if(v2.category_id == "loadouts")then
			local append_requires = ""
			if(v.required_flag == "spellbound_enabled")then
				append_requires = ", Requires Spellbound Bundle"
			end
            new_item = {
                flag = v.id,
                required_flag = "",
                name = v.name:gsub( " TYPE", "" ),
                description = --[[v.description .. ]]"by "..v.author..append_requires,
                default = true,
                type = "toggle",
                requires_restart = true,
                callback = function(item, enabled)
                end               
            }
            table.insert(v2.items, new_item)
        end
    end
end

is_links_disabled = true

table.insert(config_list, twitch_config_options)