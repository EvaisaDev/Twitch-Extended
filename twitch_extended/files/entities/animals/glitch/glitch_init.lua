dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utils.lua")
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local types =
{
	{
		name = "healer",
		func = function()
			local effect_id = EntityLoad( "mods/twitch_extended/files/entities/animals/glitch/healer_effect.xml", x, y )
			EntityAddChild( entity_id, effect_id )
			EntityAddComponent2( entity_id, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/entities/animals/glitch/glitch_move.lua",
				execute_on_added=true,
				execute_every_n_frame=1
			})
		end
	},
	{
		name = "twitchy",
		func = function()
			local effect_id = EntityLoad( "mods/twitch_extended/files/entities/animals/glitch/twitchy_effect.xml", x, y )
			EntityAddChild( entity_id, effect_id )
			EntityAddComponent2( entity_id, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/entities/animals/glitch/glitch_move.lua",
				execute_on_added=true,
				execute_every_n_frame=1
			})
		end
	},
	{
		name = "damaging",
		func = function()
			local effect_id = EntityLoad( "mods/twitch_extended/files/entities/animals/glitch/damage_effect.xml", x, y )
			EntityAddChild( entity_id, effect_id )
			EntityAddComponent2( entity_id, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/entities/animals/glitch/glitch_move_enemy.lua",
				execute_on_added=true,
				execute_every_n_frame=1
			})
		end
	},
	{
		name = "support",
		func = function()
			local effect_id = EntityLoad( "mods/twitch_extended/files/entities/animals/glitch/support_effect.xml", x, y )
			EntityAddChild( entity_id, effect_id )
			EntityAddComponent2( entity_id, "LuaComponent", {
				script_source_file="mods/twitch_extended/files/entities/animals/glitch/glitch_move.lua",
				execute_on_added=true,
				execute_every_n_frame=1
			})
		end
	},
}

local storages = EntityGetComponent( entity_id, "VariableStorageComponent" )
local style = ""
local data = nil

if ( storages ~= nil ) then
	for i,comp in ipairs( storages ) do
		local name = ComponentGetValue2( comp, "name" )
		if ( name == "type" ) then
			style = ComponentGetValue2( comp, "value_string" )
			break
		end
	end
end

if ( style ~= "" ) then
	for i,v in ipairs(types) do
		if ( v.name == style ) then
			data = types[i]
		end
	end
end

if ( data == nil ) then
	SetRandomSeed( x, y * entity_id )
	local rnd = Random( 1, #types )
	data = types[rnd]
end


data.func()

if EntityHasTag( entity_id, "homing_target" ) then
	EntityRemoveTag( entity_id, "homing_target" )
end