dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once("mods/config_lib/files/utilities.lua")

if(HasSettingFlag("twitch_extended_options_champion_naming"))then
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )

	local targets = EntityGetInRadiusWithTag( x, y, 500, "gkbrkn_champions" )

	if ( #targets > 0 ) then
		for i,target_id in ipairs( targets ) do
			
			if(not EntityHasTag(target_id, "twitch_name") and not EntityHasTag(target_id, "gkbrkn_mini_boss"))then
				--GamePrint("rrrrrrrrr")
				if(Random(1, 100) <= HasSettingFlag("twitch_extended_options_champion_percentage") or 20)then
					viewer = getRandomViewerName()


					--GamePrint("Viewer = "..viewer)
					if(viewer ~= "")then
						nametag = text_above_entity( target_id, viewer, 0 )
					end
				end
				EntityAddTag(target_id, "twitch_name")
			end
		end
	end
end

if(HasSettingFlag("twitch_extended_options_miniboss_naming"))then
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )

	local targets = EntityGetInRadiusWithTag( x, y, 500, "gkbrkn_mini_boss" )

	if ( #targets > 0 ) then
		for i,target_id in ipairs( targets ) do
			
			if(not EntityHasTag(target_id, "twitch_name"))then
				--GamePrint("rrrrrrrrr")
				

				if(Random(1, 100) <= HasSettingFlag("twitch_extended_options_miniboss_percentage") or 20)then
					viewer = getRandomViewerName()
					if(viewer ~= "")then
						nametag = text_above_entity( target_id, viewer, 0 )
					end
				end
				EntityAddTag(target_id, "twitch_name")
			end
		end
	end
end