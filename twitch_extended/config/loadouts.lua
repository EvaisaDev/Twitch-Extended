twitch_loadouts = {
    { -- Default
        id = "nolla_default", -- unique identifier
        name = "Default TYPE", -- displayed loadout name
        description = "The default loadout",
        author = "Nolla",
		required_flag = "",
        
        cape_color = nil,
        cape_color_edge = nil,
        wands = nil,
        potions = nil,
        items = nil,
        perks = nil,
        actions = nil,
        sprites = nil,
        
        callback = nil,
        
        
    },
    { -- Legacy
        id = "nolla_legacy", -- unique identifier
        name = "Nostalgia TYPE", -- displayed loadout name
        description = "The original loadout",
        author = "Nolla",
		required_flag = "",
        
        cape_color = nil,
        cape_color_edge = nil,
        wands = {},
        potions = {},
        items = {
            {"data/entities/items/starting_wand.xml"},
            {"data/entities/items/starting_bomb_wand.xml"},
            {"data/entities/items/pickup/potion_water.xml"}
        },
        perks = nil,
        actions = nil,
        sprites = nil,
        
        callback = nil,
        
        
    },
    { -- Speedrunner
        id = "goki_speedrunner", -- unique identifier
        name = "Speedrunner TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xffeeeeee, -- cape color (ABGR) *can be nil
        cape_color_edge = 0xffffffff, -- cape edge color (ABGR) *can be nil
        wands = { -- wands
            {
                name = "Speed Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.5 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {15,15}, -- recharge time in frames
                    fire_rate_wait = {15,15}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {50,50}, -- mana charge speed
                    mana_max = {130,130}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    { "DAMAGE" }
                },
                actions = {
                    { "TELEPORT_PROJECTILE" },
                }
            },
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"magic_liquid_teleportation", 1000} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            {"REPELLING_CAPE"},
            {"MOVEMENT_FASTER"},
        },
        actions = nil,
        sprites = nil,
        
        callback = nil,
        
        
    },
    { -- Hero
        id = "goki_heroic", -- unique identifier
        name = "Heroic TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff11bbff, -- cape color (ABGR)
        cape_color_edge = 0xff55eeff, -- cape edge color (ABGR)
        wands ={ -- wands
            {
                name = "Hero's Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {4,4}, -- capacity
                    reload_time = {15,15}, -- recharge time in frames
                    fire_rate_wait = {4,4}, -- cast delay in frames
                    spread_degrees = {5,5}, -- spread
                    mana_charge_speed = {120,120}, -- mana charge speed
                    mana_max = {50,50}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    { "ENERGY_SHIELD_SECTOR" }
                },
                actions = {
                    { "LUMINOUS_DRILL" }
                }
            }
        },
        potions ={ -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"alcohol", 1000} } },
        },
        items ={ -- items
        },
        perks ={ -- perks
            {"RISKY_CRITICAL"},
        }
    },
    { -- Unstable
        id = "goki_unstable", -- unique identifier
        name = "Unstable TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = bit.band( 0xFF000000, math.floor( math.random() * 0xFFFFFF ) ), -- cape color (ABGR)
        cape_color_edge = bit.band( 0xFF000000, math.floor( math.random() * 0xFFFFFF ) ), -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Unstable Wand",
                stats = {
                    shuffle_deck_when_empty = true, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {4,4}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {16,16}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {50,50}, -- mana charge speed
                    mana_max = {220,220}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "GOKI_CHAOTIC_BURST" }
                }
            },
            {
                name = "Unstable Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {24,24}, -- recharge time in frames
                    fire_rate_wait = {12,12}, -- cast delay in frames
                    spread_degrees = {3,3}, -- spread
                    mana_charge_speed = {60,60}, -- mana charge speed
                    mana_max = {140,140}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "UNSTABLE_GUNPOWDER" },
                    { "MINE" },
                }
            }
        },
        potions = { -- potions
            { { {"water", 500}, {"blood", 500} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            {"GAMBLE"},
        }
    },
    { -- Demolitionist
        id = "goki_demolitionist", -- unique identifier
        name = "Demolitionist TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFF103080, -- cape color (ABGR)
        cape_color_edge = 0xFF209090, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {2,2}, -- capacity
                    reload_time = {60,60}, -- recharge time in frames
                    fire_rate_wait = {60,60}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {10,10}, -- mana charge speed
                    mana_max = {100,100}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "PIPE_BOMB" },
                    { "PIPE_BOMB" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {1,1}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {100,100}, -- mana charge speed
                    mana_max = {100,100}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    {"PIPE_BOMB_DETONATOR"}
                }
            }
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"gunpowder_unstable", 1000} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            {"EXPLODING_CORPSES"},
        }
    },
    { -- Spark
        id = "goki_spark", -- unique identifier
        name = "Spark TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFFFFFF00, -- cape color (ABGR)
        cape_color_edge = 0xFFFFFFFF, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {6,6}, -- capacity
                    reload_time = {23,23}, -- recharge time in frames
                    fire_rate_wait = {2,2}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {60,60}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    {"ELECTRIC_CHARGE"},
                },
                actions = {
                    {"LIGHT_BULLET_TIMER"},
                    { "GOKI_ZAP" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {4,4}, -- capacity
                    reload_time = {20,20}, -- recharge time in frames
                    fire_rate_wait = {50,50}, -- cast delay in frames
                    spread_degrees = {1,1}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    {"THUNDERBALL"},
                    {"THUNDERBALL"},
                }
            }
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            {"ELECTRICITY"}
        }
    },
    {-- Bubble
        id = "goki_bubble", -- unique identifier
        name = "Bubble TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFFFF6600, -- cape color (ABGR)
        cape_color_edge = 0xFFFFAA66, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.5 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {22,22}, -- recharge time in frames
                    fire_rate_wait = {18,18}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {60,60}, -- mana charge speed
                    mana_max = {160,160}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "GRAVITY" },
                    { "SPREAD_REDUCE" },
                    { "BUBBLESHOT_TRIGGER" },
                    { "MATERIAL_WATER" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {4,4}, -- capacity
                    reload_time = {16,16}, -- recharge time in frames
                    fire_rate_wait = {40,40}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {50,50}, -- mana charge speed
                    mana_max = {160,160}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "GRAVITY" },
                    { "BUBBLESHOT_TRIGGER" },
                    { "EXPLOSION" },
                }
            }
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            { "BREATH_UNDERWATER" },
        }
    },
    { -- Charge
        id = "goki_charge", -- unique identifier
        name = "Charge TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "Evaisa",
		required_flag = "spellbound_enabled",
        
        cape_color = 0xFF333333, -- cape color (ABGR)
        cape_color_edge = 0xFF666666, -- cape edge color (ABGR)
        wands ={ -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {6,6}, -- capacity
                    reload_time = {16,16}, -- recharge time in frames
                    fire_rate_wait = {12,12}, -- cast delay in frames
                    spread_degrees = {4,4}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "SPELLBOUND_FORCE_MODULE" },
					{ "BURST_2" },
                    { "LIGHT_BULLET" },
                    { "LIGHT_BULLET" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {2,2}, -- capacity
                    reload_time = {12,12}, -- recharge time in frames
                    fire_rate_wait = {12,12}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {20,20}, -- mana charge speed
                    mana_max = {100,100}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    {"BOMB"},
                }
            }
        },
        potions ={ -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
        },
        items ={ -- items
        },
        perks ={ -- perks
            { "CRITICAL_HIT" }
        }
    },
    { -- Alchemist
        id = "goki_alchemist", -- unique identifier
        name = "Alchemist TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFF333333, -- cape color (ABGR)
        cape_color_edge = 0xFF666666, -- cape edge color (ABGR)
        wands ={ -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 2.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {16,16}, -- recharge time in frames
                    fire_rate_wait = {12,12}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    { "TRANSMUTATION" },
                    { "ACIDSHOT" },
                },
                actions = {
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 3, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {16,16}, -- recharge time in frames
                    fire_rate_wait = {12,12}, -- cast delay in frames
                    spread_degrees = {3,3}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { { action="MATERIAL_WATER", locked=true } },
                    { { action="MATERIAL_WATER", locked=true } },
                    { { action="MATERIAL_WATER", locked=true } },
                }
            },
        },
        potions ={ -- potions
            { { {"water", 2000} }, { { "oil", 2000 } }, { { "blood", 2000 } }, { { "alcohol", 2000 } }, { { "slime", 2000 } } }, -- a list of random choices of material amount pairs
            { { {"water", 2000} }, { { "oil", 2000 } }, { { "blood", 2000 } }, { { "alcohol", 2000 } }, { { "slime", 2000 } } },
            { { {"water", 2000} }, { { "oil", 2000 } }, { { "blood", 2000 } }, { { "alcohol", 2000 } }, { { "slime", 2000 } } },
            { { {"water", 2000} }, { { "oil", 2000 } }, { { "blood", 2000 } }, { { "alcohol", 2000 } }, { { "slime", 2000 } } },
        },
        items ={ -- items
        },
        perks ={ -- perks
            { "ATTRACT_ITEMS" },
        }
    },
    { -- Trickster
        id = "goki_trickster", -- unique identifier
        name = "Trickster TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFF333333, -- cape color (ABGR)
        cape_color_edge = 0xFF666666, -- cape edge color (ABGR)
        wands ={ -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {6,6}, -- capacity
                    reload_time = {31,31}, -- recharge time in frames
                    fire_rate_wait = {17,17}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {63,63}, -- mana charge speed
                    mana_max = {242,242}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { { action="LONG_DISTANCE_CAST", locked=true } },
                    { { action="I_SHAPE", locked=true } },
                    { { action="BULLET", locked=true } },
                    { { action="LIGHT_BULLET", locked=true } },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 2, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {8,8}, -- capacity
                    reload_time = {120,120}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {-1,-1}, -- spread
                    mana_charge_speed = {200,200}, -- mana charge speed
                    mana_max = {200,200}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { { action="LONG_DISTANCE_CAST", locked=true } },
                    { { action="LIFETIME_DOWN", locked=true } },
                    { { action="LIFETIME_DOWN", locked=true } },
                    { { action="TELEPORT_PROJECTILE", locked=true } },
                    { { action="DELAYED_SPELL", locked=true } },
                    { { action="LIFETIME_DOWN", locked=true } },
                    { { action="LIFETIME_DOWN", locked=true } },
                    { { action="TELEPORT_PROJECTILE", locked=true } },
                }
            },
        },
        potions ={ -- potions
            { { {"magic_liquid_teleportation", 200}, {"magic_liquid_charm", 200}, {"magic_liquid_movement_faster", 200}, {"magic_liquid_invisibility", 200}, {"water", 200} } }, -- a list of random choices of material amount pairs
        },
        items ={ -- items
        },
        perks ={ -- perks
            { "EXTRA_MONEY_TRICK_KILL" },
        }
    },
    { -- Treasure Hunter
        id = "goki_treasure_hunter", -- unique identifier
        name = "Treasure Hunter TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFF333333, -- cape color (ABGR)
        cape_color_edge = 0xFF666666, -- cape edge color (ABGR)
        wands ={ -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {4,4}, -- capacity
                    reload_time = {22,22}, -- recharge time in frames
                    fire_rate_wait = {15,15}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {150,150}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "MONEY_MAGIC" },
					{ "LIGHT_BULLET" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = true, -- shuffle
                    actions_per_round = 2, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {2,2}, -- capacity
                    reload_time = {3,3}, -- recharge time in frames
                    fire_rate_wait = {3,3}, -- cast delay in frames
                    spread_degrees = {30,30}, -- spread
                    mana_charge_speed = {6,6}, -- mana charge speed
                    mana_max = {15,15}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "DIGGER" },
                    { "POWERDIGGER" },
                }
            },
        },
        potions = { -- potions
            { { {"water", 1000}  } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            { "ATTRACT_ITEMS" },
            { "ITEM_RADAR" },
            { "WAND_RADAR" },
        },
        callback = function( player_entity )
            local wallet = EntityGetFirstComponent( player_entity, "WalletComponent" );
            if wallet ~= nil then
                local money = ComponentGetValue2( wallet, "money" );
                ComponentSetValue2( wallet, "money", ComponentGetValue2( wallet, "money" ) + 500 );
            end
        end
    },
    { -- Kamikaze
        id = "goki_kamikaze", -- unique identifier
        name = "Kamikaze TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFF333333, -- cape color (ABGR)
        cape_color_edge = 0xFF666666, -- cape edge color (ABGR)
        wands ={ -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {200,200}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "EXPLOSIVE_PROJECTILE" },
                    { "EXPLOSIVE_PROJECTILE" },
                    { "TELEPORT_PROJECTILE" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {45,45}, -- recharge time in frames
                    fire_rate_wait = {45,45}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {150,150}, -- mana charge speed
                    mana_max = {300,300}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "GOKI_PROTECTIVE_ENCHANTMENT" },
                    { "EXPLOSION" },
                }
            }
        },
        potions ={ -- potions
            { { {"water", 1000}  } }, -- a list of random choices of material amount pairs
        },
        items ={ -- items
        },
        perks ={ -- perks
            { "PROTECTION_FIRE" },
            { "BLEED_OIL" },
        }
    },
    { -- Glitter
        id = "goki_glitter", -- unique identifier
        name = "Glitter TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFFD755BE, -- cape color (ABGR)
        cape_color_edge = 0xFFF295E0, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {8,8}, -- capacity
                    reload_time = {20,20}, -- recharge time in frames
                    fire_rate_wait = {20,20}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {150,150}, -- mana charge speed
                    mana_max = {200,200}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "LIGHT_BULLET_TRIGGER" },
                    { "GOKI_CLINGING_SHOT" },
                    { "GOKI_GLITTERING_TRAIL" },
                    { "DELAYED_SPELL" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {4,4}, -- capacity
                    reload_time = {40,40}, -- recharge time in frames
                    fire_rate_wait = {20,20}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {90,90}, -- mana charge speed
                    mana_max = {200,200}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "GLITTER_BOMB" },
                }
            }
        },
        potions = { -- potions
            { { {"water", 1000}  } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
        }
    },
    { -- Zoning
        id = "goki_zoning", -- unique identifier
        name = "Zoning TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFF666666, -- cape color (ABGR)
        cape_color_edge = 0xFF333333, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {7,7}, -- capacity
                    reload_time = {17,17}, -- recharge time in frames
                    fire_rate_wait = {9,9}, -- cast delay in frames
                    spread_degrees = {2,2}, -- spread
                    mana_charge_speed = {150,150}, -- mana charge speed
                    mana_max = {500,500}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "LONG_DISTANCE_CAST" },
                    { "GOKI_PROTECTIVE_ENCHANTMENT" },
                    { "BURST_2" },
                    { "WALL_VERTICAL" },
                    { "WALL_HORIZONTAL" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {100,100}, -- mana charge speed
                    mana_max = {200,200}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "LIFETIME" },
                    { "DEATH_CROSS_BIG" },
                }
            }
        },
        potions = { -- potions
            { { {"water", 1000}  } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
        }
    },
    { -- Seeker
        id = "goki_seeker", -- unique identifier
        name = "Seeker TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFF666666, -- cape color (ABGR)
        cape_color_edge = 0xFF333333, -- cape edge color (ABGR)
        wands ={ -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {9,9}, -- capacity
                    reload_time = {13,13}, -- recharge time in frames
                    fire_rate_wait = {11,11}, -- cast delay in frames
                    spread_degrees = {4,4}, -- spread
                    mana_charge_speed = {50,50}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    { "LIFETIME" },
                },
                actions = {
                    { "GOKI_PERSISTENT_SHOT" },
                    { "HOMING_ROTATE" },
                    { "BOUNCE" },
                    { "AVOIDING_ARC" },
                    { "DIGGER" },
                    { "DIGGER" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {80,80}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "DYNAMITE" },
                }
            }
        },
        potions ={ -- potions
            { { {"water", 1000}  } }, -- a list of random choices of material amount pairs
        },
        items ={ -- items
        },
        perks ={ -- perks
        }
    },
    { -- Wandsmith
        id = "goki_wandsmith", -- unique identifier
        name = "Wandsmith TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFF666666, -- cape color (ABGR)
        cape_color_edge = 0xFF333333, -- cape edge color (ABGR)
        wands = { -- wands
        },
        potions = { -- potions
            { { {"water", 1000}  } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
            { "data/entities/items/starting_wand.xml" },
            { "data/entities/items/starting_bomb_wand.xml" },
        },
        perks = { -- perks
            { "EDIT_WANDS_EVERYWHERE" }
        },
        -- actions
        actions = nil,
        -- sprites
        sprites = nil,
        -- custom message
        
        -- callback
        callback = function( player_entity )
            local x, y = EntityGetTransform( player_entity );
            local full_inventory = nil;
            local player_child_entities = EntityGetAllChildren( player_entity );
            if player_child_entities ~= nil then
                for i,child_entity in ipairs( player_child_entities ) do
                    local child_entity_name = EntityGetName( child_entity );
                    
                    if child_entity_name == "inventory_full" then
                        full_inventory = child_entity;
                    end
                end
            end

            -- set inventory contents
            if full_inventory ~= nil then
                for i=1,8 do
                    local action = GetRandomAction( x, y, Random( 0, 6 ), Random( 1, 9999999 ) );
                    local action_card = CreateItemActionEntity( action, x, y );
                    EntitySetComponentsWithTagEnabled( action_card, "enabled_in_world", false );
                    EntityAddChild( full_inventory, action_card );
                end
            end
        end
    },
    { -- Duplicator
        id = "goki_duplicator", -- unique identifier
        name = "Duplicator TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFF333333, -- cape color (ABGR)
        cape_color_edge = 0xFF666666, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 2, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {6,6}, -- capacity
                    reload_time = {20,20}, -- recharge time in frames
                    fire_rate_wait = {20,20}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speead
                    mana_max = {160,160}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "LIGHT_BULLET" },
                    { { action="DIVIDE_2", permanent=true } },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 2, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {4,4}, -- capacity
                    reload_time = {60,60}, -- recharge time in frames
                    fire_rate_wait = {60,60}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {180,180}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "GRAVITY" },
                    { "SLOW_BULLET" },
                }
            },
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            { "DUPLICATE_PROJECTILE" },
        }
    },
    { -- Knockback
        id = "goki_knockback", -- unique identifier
        name = "Knockback TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xFF333333, -- cape color (ABGR)
        cape_color_edge = 0xFF666666, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {10,10}, -- capacity
                    reload_time = {10,10}, -- recharge time in frames
                    fire_rate_wait = {10,10}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {100,100}, -- mana charge speed
                    mana_max = {200,200}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { { action="RECOIL", locked=true } },
                    { { action="SPEED", locked=true } },
                    { { action="KNOCKBACK", locked=true } },
                    { { action="KNOCKBACK", locked=true } },
                    { { action="KNOCKBACK", locked=true } },
                    { { action="AIR_BULLET", locked=false } },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 2, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {15,15}, -- recharge time in frames
                    fire_rate_wait = {15,15}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {20,20}, -- mana charge speed
                    mana_max = {80,80}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "BOMB" },
                }
            },
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            { "NO_MORE_KNOCKBACK" }
        }
    },
    { -- Sniper
        id = "goki_sniper", -- unique identifier
        name = "Sniper TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "spellbound_enabled",
        
        cape_color = 0xFF333333, -- cape color (ABGR)
        cape_color_edge = 0xFF666666, -- cape edge color (ABGR)
        wands ={ -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {12,12}, -- capacity
                    reload_time = {120,120}, -- recharge time in frames
                    fire_rate_wait = {120,120}, -- cast delay in frames
                    spread_degrees = {-30,-30}, -- spread
                    mana_charge_speed = {100,100}, -- mana charge speed
                    mana_max = {240,240}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { { action="CRITICAL_HIT", locked=true } },
                    { { action="CRITICAL_HIT" } },
                    { { action="SPREAD_REDUCE", locked=true } },
                    { { action="GOKI_ZERO_GRAVITY", locked=true } },
                    { { action="RECOIL", locked=true } },
                    { { action="SPEED", permanent=true } },
                    { { action="SPEED", permanent=true } },
                    { { action="SPEED", permanent=true } },
					{ { action="FUNKY_SPELL" } },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {1,1}, -- capacity
                    reload_time = {3,3}, -- recharge time in frames
                    fire_rate_wait = {3,3}, -- cast delay in frames
                    spread_degrees = {60,60}, -- spread
                    mana_charge_speed = {60,60}, -- mana charge speed
                    mana_max = {600,600}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "LIGHT_BULLET" },
                }
            },
        },
        potions ={ -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"gunpowder_unstable", 1000} } }, -- a list of random choices of material amount pairs
        },
        items ={ -- items
        },
        perks ={ -- perks
            { "LASER_AIM" },
        }
    },
    { -- Plasma
        id = "goki_plasma", -- unique identifier
        name = "Plasma Cutter TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "spellbound_enabled",
        
        cape_color = 0xFF333333, -- cape color (ABGR)
        cape_color_edge = 0xFF666666, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0, -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {12,12}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {5,5}, -- spread
                    mana_charge_speed = {60,60}, -- mana charge speed
                    mana_max = {100,100}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { { action="LASER_EMITTER_WIDER" } },
                    { { action="GOKI_PERSISTENT_SHOT" } },
                    { { action="SPEED" } },
                    { { action="LIGHT_SHOT" } },
					{ { action="LASER_EMITTER_CUTTER" } },
					{ { action="LASER_EMITTER_CUTTER" } },
                }
            }
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            {"PERSONAL_LASER"}
        },
    },
    { -- Grease (More Loadouts Update)
        id = "goki_grease", -- unique identifier
        name = "Greasy TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff2c5e7b, -- cape color (ABGR)
        cape_color_edge = 0xff2b937a, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {10,10}, -- recharge time in frames
                    fire_rate_wait = {16,16}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {100,100}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "HITFX_CRITICAL_OIL" },
                    { "HITFX_BURNING_CRITICAL_HIT" },
                    { "LIGHT_BULLET" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.5 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {23,23}, -- recharge time in frames
                    fire_rate_wait = {25,25}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {180,180}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "FIRE_TRAIL" },
                    { "OIL_TRAIL" },
                    { "LONG_DISTANCE_CAST" },
                }
            },
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"oil", 500}, {"gunpowder_unstable", 500} } },
        },
        items = { -- items
        },
        perks = { -- perks
            { "BLEED_OIL" }
        }
    },
    { -- Toxic (More Loadouts Update)
        id = "goki_toxic", -- unique identifier
        name = "Toxic TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff27c28e, -- cape color (ABGR)
        cape_color_edge = 0xff11f2d4, -- cape edge color (ABGR)
        wands ={ -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = true, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {7,7}, -- capacity
                    reload_time = {12,12}, -- recharge time in frames
                    fire_rate_wait = {16,16}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {200,200}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "HITFX_TOXIC_CHARM" },
                    { "LIGHT_BULLET" },
                    { "LIGHT_BULLET" },
                    { "LIGHT_BULLET" },
                    { "LIGHT_BULLET" },
                    { "LIGHT_BULLET" },
                    --{ "TOXIC_TO_ACID" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.5 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {23,23}, -- recharge time in frames
                    fire_rate_wait = {25,25}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {180,180}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "ADD_TRIGGER" },
                    { "SLIMEBALL" },
                    { "MIST_RADIOACTIVE" },
                }
            },
        },
        potions ={ -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"radioactive_liquid", 1000} } },
        },
        items ={ -- items
        },
        perks ={ -- perks
            { "PROTECTION_RADIOACTIVITY" }
        }
    },
    { -- Vampire (More Loadouts Update)
        id = "goki_vampire", -- unique identifier
        name = "Vampire TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff3d3d3d, -- cape color (ABGR)
        cape_color_edge = 0xff00007a, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = true, -- shuffle
                    actions_per_round = 3, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {200,200}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "ARROW" },
                    { "ARROW" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = true, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.5 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {10,10}, -- recharge time in frames
                    fire_rate_wait = {10,10}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {220,220}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "NECROMANCY" },
                    { "ARROW" },
                }
            },
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"blood", 1000} } },
            { { {"acid", 1000} } },
        },
        items = { -- items
        },
        perks = { -- perks
            { "VAMPIRISM" },
            { "GLOBAL_GORE" },
        }
    },
    { -- Poison (More Loadouts Update; was Frost)
        id = "goki_poison", -- unique identifier
        name = "Poison TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff929292, -- cape color (ABGR)
        cape_color_edge = 0xfff0ea6d, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {180,180}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "POISON_TRAIL" },
                    { "LIGHT_BULLET_TRIGGER" },
                    { "POISON_BLAST" },
                }
            }
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"poison", 1000} } },
        },
        items = { -- items
        },
        perks = { -- perks
            { "FREEZE_FIELD" },
        }
    },
    { -- Bomb (More Loadouts Update)
        id = "goki_bomb", -- unique identifier
        name = "Bomb TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff727272, -- cape color (ABGR)
        cape_color_edge = 0xff4d8da8, -- cape edge color (ABGR)
        wands ={ -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {54,54}, -- recharge time in frames
                    fire_rate_wait = {15,15}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {180,180}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    { "DYNAMITE" },
                },
                actions = {
                    { "UNSTABLE_GUNPOWDER" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = true, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {2,2}, -- recharge time in frames
                    fire_rate_wait = {2,2}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {50,50}, -- mana charge speed
                    mana_max = {160,160}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "MINE" },
                    { "MINE" },
                }
            },
        },
        potions ={ -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
            { "data/entities/misc/custom_cards/bomb_holy.xml" },
        },
        perks = { -- perks
            { "ABILITY_ACTIONS_MATERIALIZED" },
        }
    },
    { -- Melting (More Loadouts Update)
        id = "goki_melting", -- unique identifier
        name = "Melting TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff2c7b50, -- cape color (ABGR)
        cape_color_edge = 0xff3f9b69, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {8,8}, -- capacity
                    reload_time = {54,54}, -- recharge time in frames
                    fire_rate_wait = {15,15}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {180,180}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "ACID_TRAIL" },
                    { "LIGHT_BULLET_TRIGGER" },
                    { "NOLLA" },
                    { "ACIDSHOT" },
                }
            },
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"acid", 1000} } },
            { { {"lava", 1000} } },
        },
        items = { -- items
        },
        perks = { -- perks
            {"UNLIMITED_SPELLS"}
        }
    },
    { -- Combustion (More Loadouts Update)
        id = "goki_combustion", -- unique identifier
        name = "Combustion TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff2154a9, -- cape color (ABGR)
        cape_color_edge = 0xff3570d3, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {7,7}, -- capacity
                    reload_time = {50,50}, -- recharge time in frames
                    fire_rate_wait = {24,24}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {50,50}, -- mana charge speed
                    mana_max = {150,150}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "BOUNCE" },
                    { "LASER" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0, -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {6,6}, -- capacity
                    reload_time = {14,14}, -- recharge time in frames
                    fire_rate_wait = {18,18}, -- cast delay in frames
                    spread_degrees = {3,3}, -- spread
                    mana_charge_speed = {50,50}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "BURN_TRAIL" },
                    { "GRAVITY" },
                    { "RUBBER_BALL" },
                }
            },
        },
        potions = { -- potions
            { { { "water", 1000 } } }, -- a list of random choices of material amount pairs
            { { { "fire", 500 }, { "gunpowder_unstable", 500 } } },
        },
        items = { -- items
        },
        perks = { -- perks
            { "REVENGE_EXPLOSION" }
        }
    },
    { -- Hydromancy (More Loadouts Update)
        id = "goki_hydromancy", -- unique identifier
        name = "Hydromancer TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff7b572c, -- cape color (ABGR)
        cape_color_edge = 0xff9b703f, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 0.5 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {7,7}, -- capacity
                    reload_time = {50,50}, -- recharge time in frames
                    fire_rate_wait = {24,24}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {50,50}, -- mana charge speed
                    mana_max = {150,150}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    { "LIGHT_SHOT" },
                },
                actions = {
                    { "HITFX_CRITICAL_WATER" },
                    { "LANCE" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0, -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {4,4}, -- capacity
                    reload_time = {5,5}, -- recharge time in frames
                    fire_rate_wait = {5,5}, -- cast delay in frames
                    spread_degrees = {7,7}, -- spread
                    mana_charge_speed = {50,50}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    { "WATER_TRAIL" },
                },
                actions = {
                    { "HEAVY_SPREAD" },
                    { "LONG_DISTANCE_CAST" },
                }
            },
        },
        potions = { -- potions
            { { { "water", 1000 } } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            { "BREATH_UNDERWATER" },
        }
    },
    { -- Critical (More Loadouts Update; was Blood)
        id = "goki_critical", -- unique identifier
        name = "Critical TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff1e1a87, -- cape color (ABGR)
        cape_color_edge = 0xff2f2aa9, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = true, -- shuffle
                    actions_per_round = 5, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {15,15}, -- recharge time in frames
                    fire_rate_wait = {18,18}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {60,60}, -- mana charge speed
                    mana_max = {140,140}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
					{ "HITFX_CRITICAL_BLOOD" }
                },
                actions = {
                    { "LIGHT_BULLET" },
                    { "LIGHT_BULLET" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0, -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {3,3}, -- capacity
                    reload_time = {1800,1800}, -- recharge time in frames
                    fire_rate_wait = {60,60}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {10,10}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    { "MIST_BLOOD" },
                },
                actions = {
                    { "HOMING_SHOOTER" },
                }
            },
        },
        potions = { -- potions
            { { { "water", 1000 } } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            { "GLOBAL_GORE" },
        }
    },
    { -- Geomancer (More Loadouts Update)
        id = "goki_geomancer", -- unique identifier
        name = "Geomancer TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff526e50, -- cape color (ABGR)
        cape_color_edge = 0xff3a4d39, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0, -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {8,8}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {40,40}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "SUMMON_HOLLOW_EGG" },
                    { "SOILBALL" },
                    { "AIR_BULLET" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {4,4}, -- capacity
                    reload_time = {16,16}, -- recharge time in frames
                    fire_rate_wait = {12,12}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {90,90}, -- mana charge speed
                    mana_max = {360,360}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { "SUMMON_HOLLOW_EGG" },
                    { "BOMB_HOLY" },
                }
            },
        },
        potions = { -- potions
            { { { "water", 1000 } } }, -- a list of random choices of material amount pairs
            { { { "void_liquid", 1000 } } },
        },
        items = { -- items
        },
        perks = { -- perks
            { "DISSOLVE_POWDERS" },
        }
    },
    { -- Speed (More Loadouts Update)
        id = "goki_speed", -- unique identifier
        name = "Speed TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff0c00d4, -- cape color (ABGR)
        cape_color_edge = 0xff6059e2, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 2.0, -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {18,18}, -- recharge time in frames
                    fire_rate_wait = {11,11}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {45,45}, -- mana charge speed
                    mana_max = {180,180}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    {"LIGHT_SHOT"},
                },
                actions = {
                    {"BOUNCY_ORB"}
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = true, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 2.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {4,4}, -- capacity
                    reload_time = {16,16}, -- recharge time in frames
                    fire_rate_wait = {12,12}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {60,60}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    {"ROCKET"},
                }
            },
        },
        potions = { -- potions
            { { { "water", 1000 } } }, -- a list of random choices of material amount pairs
            { { { "magic_liquid_movement_faster", 1000 } } },
            { { { "magic_liquid_faster_levitation", 1000 } } },
        },
        items = { -- items
        },
        perks = { -- perks
			{ "FASTER_LEVITATION" },
            { "MOVEMENT_FASTER" },
            { "BREATH_UNDERWATER" },
        }
    },
    { -- Eldritch (More Loadouts Update)
        id = "goki_eldritch", -- unique identifier
        name = "Eldritch TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "",
        
        cape_color = 0xff7d4e53, -- cape color (ABGR)
        cape_color_edge = 0xff6b4144, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0, -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {15,15}, -- recharge time in frames
                    fire_rate_wait = {15,15}, -- cast delay in frames
                    spread_degrees = {2,2}, -- spread
                    mana_charge_speed = {30,30}, -- mana charge speed
                    mana_max = {100,100}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                    {"TENTACLE_RAY"},
                },
                actions = {
                    {"TENTACLE"},
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {6,6}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {60,60}, -- mana charge speed
                    mana_max = {120,120}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    {"TENTACLE_TIMER"},
                    {"BURST_2"},
                    {"POISON_BLAST"},
                    {"FIRE_BLAST"},
                }
            },
        },
        potions = { -- potions
            { { { "water", 1000 } } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            {"REVENGE_TENTACLE"}
        }
    },
    { -- Bouncy (More Loadouts Update)
        id = "goki_bouncy", -- unique identifier
        name = "Bouncy TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "spellbound_enabled",
        
        cape_color = 0xff00FF00, -- cape color (ABGR)
        cape_color_edge = 0xff00FF00, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {8,8}, -- capacity
                    reload_time = {15,15}, -- recharge time in frames
                    fire_rate_wait = {15,15}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {180,180}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { { action="SPELLBOUND_RUBBER_COATING",locked=true} },
                    { { action="ACCELERATING_SHOT",locked=true} },
                    { { action="GOKI_ZERO_GRAVITY",locked=true} },
                    { "RUBBER_BALL" },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {180,180}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { { action="SPELLBOUND_RUBBER_COATING",locked=true} },
                    { "GRENADE_LARGE" },
                }
            },
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"unstable_gunpwder", 1000} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            {"BOUNCE"}
        }
    },
    { -- Lancer (More Loadouts Update)
        id = "goki_lancer", -- unique identifier
        name = "Lancer TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "spellbound_enabled",
        
        cape_color = 0xFFFFFFFF, -- cape color (ABGR)
        cape_color_edge = 0xFFFFFFFF, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 4, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {12,12}, -- capacity
                    reload_time = {23,23}, -- recharge time in frames
                    fire_rate_wait = {23,23}, -- cast delay in frames
                    spread_degrees = {1,1}, -- spread
                    mana_charge_speed = {80,80}, -- mana charge speed
                    mana_max = {180,180}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { { action="DAMAGE",locked=true } },
                    { { action="LONG_DISTANCE_CAST",locked=true } },
                    { { action="SPELLBOUND_SLOW_PROJECTILES",locked=true } },
                    { { action="HEAVY_SHOT",locked=true } },
                    { { action="LONG_DISTANCE_CAST",locked=true } },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 1, -- spells per cast
                    speed_multiplier = 1 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {2,2}, -- capacity
                    reload_time = {12,12}, -- recharge time in frames
                    fire_rate_wait = {12,12}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {20,20}, -- mana charge speed
                    mana_max = {100,100}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    {"BOMB"},
                }
            }
        },
        potions = { -- potions
            { { { "water", 1000 } } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
        }
    },
    { id = "goki_telekinetic", -- unique identifier
        name = "Telekinetic TYPE", -- displayed loadout name
        description = "A default loadout description",
        author = "goki_dev",
		required_flag = "spellbound_enabled",
        
        cape_color = 0xFF333333, -- cape color (ABGR)
        cape_color_edge = 0xFF666666, -- cape edge color (ABGR)
        wands = { -- wands
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 3, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {12,12}, -- capacity
                    reload_time = {30,30}, -- recharge time in frames
                    fire_rate_wait = {30,30}, -- cast delay in frames
                    spread_degrees = {10,10}, -- spread
                    mana_charge_speed = {50,50}, -- mana charge speed
                    mana_max = {200,200}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
                    { { action="SPELLBOUND_CONTROL" } },
                    { { action="GOKI_CHAOTIC_BURST" } },
                }
            },
            {
                name = "Wand",
                stats = {
                    shuffle_deck_when_empty = false, -- shuffle
                    actions_per_round = 2, -- spells per cast
                    speed_multiplier = 1.0 -- projectile speed multiplier (hidden)
                },
                stat_ranges = {
                    deck_capacity = {5,5}, -- capacity
                    reload_time = {15,15}, -- recharge time in frames
                    fire_rate_wait = {15,15}, -- cast delay in frames
                    spread_degrees = {0,0}, -- spread
                    mana_charge_speed = {20,20}, -- mana charge speed
                    mana_max = {80,80}, -- mana max
                },
                stat_randoms = {},
                permanent_actions = {
                },
                actions = {
					{ { action="SPELLBOUND_CONTROL" } },
                    { "BOMB" },
                }
            },
        },
        potions = { -- potions
            { { {"water", 1000} } }, -- a list of random choices of material amount pairs
            { { {"alcohol", 1000} } }, -- a list of random choices of material amount pairs
        },
        items = { -- items
        },
        perks = { -- perks
            {"TELEKINESIS"}
        }
    },
	{ 
		id = "twitch_extended_spore", -- unique identifier
		name = "Spore TYPE", -- displayed loadout name
		description = "A default loadout description",
		author = "Evaisa",
		required_flag = "",
		
		cape_color = 0xff62a084, -- cape color (ABGR) *can be nil
		cape_color_edge = 0xff62a084, -- cape edge color (ABGR) *can be nil
		wands = { -- wands
			{
				name = "Spore Wand",
				stats = {
					shuffle_deck_when_empty = false, -- shuffle
					actions_per_round = 3, -- spells per cast
					speed_multiplier = 1.0, -- projectile speed multiplier (hidden)
				},
				stat_ranges = {
					deck_capacity = {3,3}, -- capacity
					reload_time = {15,15}, -- recharge time in frames
					fire_rate_wait = {15,15}, -- cast delay in frames
					spread_degrees = {2,2}, -- spread
					mana_charge_speed = {30,30}, -- mana charge speed
					mana_max = {100,100}, -- mana max
				},
				stat_randoms = {},
				permanent_actions = {
				},
				actions = {
					{"SPORE_POD"},
					{"SPORE_POD"},
					{"SPORE_POD"},
				}
			},
		},
		potions = { -- potions
			{ { {"water", 1000} } }, -- a list of random choices of material amount pairs
			{ { {"fungi", 1000} } }, -- a list of random choices of material amount pairs
		},
		items = { -- items
		},
		perks = { -- perks
			{"CORDYCEPS"},
			{"MOLD"},
			{"FUNGAL_DISEASE"},
		},
		actions = nil,
		sprites = nil,
		
		callback = nil,
		
		
	},
	{ -- Speedrunner
		id = "twitch_extended_lukky", -- unique identifier
		name = "Lukky TYPE", -- displayed loadout name
		description = "A default loadout description",
		author = "Evaisa",
		required_flag = "",
		
		cape_color = 0xff9b6f9a, -- cape color (ABGR) *can be nil
		cape_color_edge = 0xff9b6f9a, -- cape edge color (ABGR) *can be nil
		wands = nil,
		potions = { -- potions
			{ { {"water", 1000} } }, -- a list of random choices of material amount pairs
		},
		items = { -- items
		},
		perks = { -- perks
			{"LUKKI_MINION"},
			{"ATTACK_FOOT"},
			{"ATTACK_FOOT"},
		},
		actions = nil,
		sprites = nil,
		
		callback = nil,
		
		
	},
}


if(ModIsEnabled("thematic_random_starts"))then
	dofile("mods/thematic_random_starts/files/loadouts.lua")
	for k, v in pairs(loadout_list)do
		table.insert(twitch_loadouts, {
			id = "wimples_"..v.class_id,
			special_id = k,
			name = v.name,
			description = v.description,
			extension_type = "thematic_random_starts",
			author = "Wimples", 
			required_flag = "",
		})
	end
end
