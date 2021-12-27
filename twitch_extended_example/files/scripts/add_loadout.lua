table.insert(twitch_loadouts, { 
	id = "example_loadout", -- unique identifier
	name = "Example TYPE", -- displayed loadout name (TYPE is replaced with a random string)
	description = "A default loadout description",
	author = "evaisa", -- author of the loadout
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
	actions = { -- Spells added to spell inventory
		{ "TELEPORT_PROJECTILE" },
	},
	sprites = {
		player_sprite_filepath = nil,
		player_arm_sprite_filepath = nil,
		player_ragdoll_filepath = nil
	},
	callback = function( player_entity )
		local wallet = EntityGetFirstComponent( player_entity, "WalletComponent" );
		if wallet ~= nil then
			local money = ComponentGetValue2( wallet, "money" );
			ComponentSetValue2( wallet, "money", ComponentGetValue2( wallet, "money" ) + 500 );
		end
	end
})