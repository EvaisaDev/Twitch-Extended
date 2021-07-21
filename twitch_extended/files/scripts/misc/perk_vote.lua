local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)
if(ModIsEnabled("twitch_lib"))then
	dofile_once("mods/twitch_lib/files/twitch_overwrites.lua")
end

if(#EntityGetInRadiusWithTag( x, y, 300, "player_unit" ) > 0)then
	--print("fuck off")
	GlobalsSetValue("current_vote_type", "perk")
	GlobalsSetValue("twitch_lib_force_outcome_type", "random")
	StreamingForceNewVoting() 
	EntityKill(entity)
end