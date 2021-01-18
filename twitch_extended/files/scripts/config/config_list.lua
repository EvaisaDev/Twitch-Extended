dofile("mods/twitch_extended/config/rewards.lua")
dofile("mods/twitch_extended/config/run_modifiers.lua")
dofile("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once( "data/scripts/perks/perk_list.lua" )

VERSION = "v2.2.6"
DATE = "January 17 2020"

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
                    required_flag = "gokis_things_enabled",
                    name = "$twitch_extended_config_loadouts",
                    description = "$twitch_extended_config_loadouts_description",
                    default = false,
                    type = "toggle",
                    requires_restart = true,
                    callback = function(item, enabled)

                    end
                },  
                {
                    flag = "loadout_vote_length",
                    required_flag = "gokis_things_enabled",
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
                    required_flag = "",
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
                    required_flag = "",
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
                name = "No redeem message",
                description = "Do not show a redeem message.",
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
                name = "Require exact amount",
                description = "If this is unchecked any amount above it until the next reward also triggers it.",
                default = false,
                type = "toggle",
                requires_restart = false,
                callback = function(item, enabled)
                end               
            }
            new_item4 = {
                flag = v.reward_id.."_bit_amount",
                required_flag = "",
                name = "Amount of bits: ",
                description = "How many bits to trigger reward.",
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

is_links_disabled = true

table.insert(config_list, twitch_config_options)