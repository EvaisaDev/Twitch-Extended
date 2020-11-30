dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
gui = gui or GuiCreate()
run_modifier_name = run_modifier_name or nil
run_modifier_description = run_modifier_description or nil


GuiStartFrame(gui)




local world_entity_id = GameGetWorldStateEntity()
if world_entity_id then 
	--print("reeeee")

	if(run_modifier_name ~= nil and run_modifier_name ~= "" and run_modifier_description ~= nil and run_modifier_description ~= "")then
		--GamePrint("weeee")
		
		GuiLayoutBeginHorizontal(gui, 50, 97)
		--GuiOptionsAddForNextWidget( gui, 16 ) --.." "..run_modifier_description

		--GuiText( gui, 0, 0, "something - text" ) -- works
		--print(run_modifier_description)
		GuiOptionsAddForNextWidget( gui, 16 )
		GuiText( gui, 0, 0, GameTextGetTranslatedOrNot(run_modifier_name) .. " - " ..GameTextGetTranslatedOrNot(run_modifier_description) ) -- works


		GuiLayoutEnd(gui)
	else
		run_modifier_name = EntityGetVariable(world_entity_id, "run_modifier_name", "string")
		run_modifier_description = EntityGetVariable(world_entity_id, "run_modifier_description", "string")
	end

end