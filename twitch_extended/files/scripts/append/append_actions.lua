actions_to_append = {
    {
        id          = "TWITCH_DUCK",
        name 		= "Duck",
        description = "Helps your spells fly, reducing their mana costs slightly",
        sprite 		= "data/ui_gfx/gun_actions/duck.png",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "0",
        spawn_probability                 = "0.0001", 
        price = 100,
        mana = -10,
        action 		= function()
            c.sprite = "data/enemies_gfx/duck.xml"
            --c.extra_entities = c.extra_entities .. "mods/spellbound_bundle/files/entities/modifiers/duck.xml,"
            draw_actions( 1, true )
        end,
    }
}

for k, event in pairs(actions_to_append)do
    table.insert(actions, event)
end