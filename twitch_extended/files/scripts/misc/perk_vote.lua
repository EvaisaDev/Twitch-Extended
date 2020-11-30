local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)
if(#EntityGetInRadiusWithTag( x, y, 300, "player_unit" ) > 0)then
	print("fuck off")
	GlobalsSetValue("current_vote_type", "perk")
	StreamingForceNewVoting() 
	EntityKill(entity)
end