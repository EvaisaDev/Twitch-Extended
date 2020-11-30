dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local targets = EntityGetInRadiusWithTag( x, y, 500, "homing_target" )

if ( #targets > 0 ) then
	for i,target_id in ipairs( targets ) do
		local variablestorages = EntityGetComponent( target_id, "VariableStorageComponent" )
		local plague_found = false
		
		if ( variablestorages ~= nil ) then
			for j,storage_id in ipairs( variablestorages ) do
				local var_name = ComponentGetValue( storage_id, "name" )
				if ( var_name == "infestation_rats" ) then
					plague_found = true
					break
				end
			end
		end

		if ( plague_found == false and ( EntityHasTag( target_id, "polymorphed") == false) ) then
			EntityAddComponent( target_id, "VariableStorageComponent", 
			{ 
				name = "infestation_rats",
			} )
			
			EntityAddComponent( target_id, "LuaComponent", 
			{ 
				script_death = "mods/twitch_extended/files/scripts/artifacts/infestation_death.lua",
				execute_every_n_frame = "-1",
			} )
		end
	end
end