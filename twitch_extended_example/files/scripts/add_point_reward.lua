table.insert(channel_rewards, {
	reward_id = "flock_of_ducks", -- Reference ID for the reward
	reward_name = "Flock Of Ducks", -- The name that shows up in game when the reward gets redeemed
	reward_description = "Spawn a flock of ducks!", -- The discription of the reward
	reward_image = "mods/twitch_extended_example/files/gfx/reward_images/duck_flock.png", -- The background image of the reward message
	required_flag = "", -- A flag that is required for the reward to show up in the settings menu. (For example if it requires a specific mod to work this might be useful)
	custom_options = { -- Optional config options for this reward.
		{
			type = "toggle",
			flag = "special_flag_test_reward",
			name = "Test toggle",
			description = "A test toggle.",
			default = false
		},
		{
			type = "slider",
			flag = "special_flag_test_reward2",
			name = "Test slider",
			description = "A test slider.",
			default_number = 10,
			min_number = 0,
			max_number = 100,
			format = "$0%",
		},
		{
			type = "input",
			flag = "special_flag_test_reward3",
			name = "Test input",
			description = "A test input.",
			default_text = "100",
			allowed_chars = "1234567890", -- Leave empty to allow any character
			text_max_length = 50,
		},
		{
			type = "enum",
			flag = "special_flag_reward_4",
			name = "Test enum",
			description = "A test enum.",
			default_enum = "option1",
			values = {{"option1", "Option 1"},{"option2", "Option 2"},{"option3", "Option 3"}} 
		}
	},
	no_display_message = false, -- if you want to use your own custom display message you can enable this. 
	func = function(reward, userdata)

		config_option = ModSettingGet("twitch_extended_link_rewards_flock_of_ducks_special_flag_test_reward3") -- getting the custom config option, flag is a bit long. :p

		-- userdata is a table containing data about the message/user
		--[[
			userdata.username 			- 	The username of the person that submitted the reward
			userdata.user_id 			- 	A reference ID to the user
			userdata.broadcaster		- 	A boolean that is true if the user is the broadcaster
			userdata.mod				-	A boolean that is true if the user is a moderator
			userdata.subscriber			-	A boolean that is true if the user is a subscriber
			userdata.turbo				-	A boolean that is true if the user has twitch turbo
			userdata.custom_reward		-	The ID of the channel point reward
			userdata.message			-	The content of the message that was send
			
		]]

		-- spawn_item() is a function that is available in Twitch Extended that lets you spawn a entity in a min and max radius from the player
		-- entity_file			-  the entity that you want to spawn
		-- min_distance         -  minimum distance from player
		-- max_distance			-  maximum distance from player
		-- create_hole			-  makes the function create a hole where the entity is spawned
		-- allow_bad_spawns 	-  if this value is true it will allow entities to spawn in walls
		-- hole_size			-  Lets you set the size of the hole that is created, 12 by default if you do not set it
		-- spawn_item( entity_file:string, min_distance:number, max_distance:number, create_hole:bool, allow_bad_spawns:bool, [optional]hole_size:number)


		for i = 1, 10 do
			duck = spawn_item("data/entities/animals/duck.xml", 100, 150, true, false)	
			--	function that lets you add text above a entity which adjusts position if the enemy has a status effect. The third parameter is the extra Y offset.
			text_above_entity( duck, userdata.username, 0 )	
		end
	end
})