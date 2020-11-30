table.insert(sub_rewards, {
	reward_id = "black_holes", -- Reference ID for the reward
	reward_name = "Black Holes", -- The name that shows up in game when the reward gets redeemed
	reward_description = "Spawn a black hole near the player", -- The discription of the reward
	reward_image = "mods/twitch_extended_example/files/gfx/reward_images/black_hole.png", -- The background image of the reward message
	required_flag = "", -- A flag that is required for the reward to show up in the settings menu. (For example if it requires a specific mod to work this might be useful)
	func = function(reward, userdata)
		-- userdata is a table containing data about the message/user
		--[[
			userdata.username 			- 	The username of the person that submitted the reward
			userdata.user_id 			- 	A reference ID to the user
			userdata.broadcaster		- 	A boolean that is true if the user is the broadcaster
			userdata.mod				-	A boolean that is true if the user is a moderator
			userdata.subscriber			-	A boolean that is true if the user is a subscriber
			userdata.msg_id				-	The type of messages (sub or resub)
			userdata.message			-	The content of the message that was send
			userdata.total_months		-	The amount of months the user has been subscribed for
			userdata.streak				-	The amount of months the user has subscribed in a row
		]]

		-- spawn_item() is a function that is available in Twitch Extended that lets you spawn a entity in a min and max radius from the player
		-- entity_file			-  the entity that you want to spawn
		-- min_distance         -  minimum distance from player
		-- max_distance			-  maximum distance from player
		-- create_hole			-  makes the function create a hole where the entity is spawned
		-- allow_bad_spawns 	-  if this value is true it will allow entities to spawn in walls
		-- hole_size			-  Lets you set the size of the hole that is created, 12 by default if you do not set it
		-- spawn_item( entity_file:string, min_distance:number, max_distance:number, create_hole:bool, allow_bad_spawns:bool, [optional]hole_size:number)



		spawn_item("data/entities/projectiles/deck/black_hole_big.xml", 100, 150, true, true)	

	end
})