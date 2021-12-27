dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")

local entity_id = GetUpdatedEntityID()

--[[
local components = EntityGetComponent( entity_id, "MagicConvertMaterialComponent")
for k, component in pairs(components)do
    --ComponentSetValue2(component, "to_material", CellFactory_GetType( convert_material ) )
    ComponentSetValue2(component, "to_material", materials)
end]]

for i = 1, 200, 40 do
    local convert_material = random_from_array( materials )
    --print("Added components")
    EntityAddComponent2(entity_id, "MagicConvertMaterialComponent", {
        kill_when_finished=true,
        from_material_tag="[liquid]",
        steps_per_frame=32,
        to_material=CellFactory_GetType( convert_material ),
        clean_stains=false,
        is_circle=true,
        min_radius=i,
        radius=i+39,
        loop=false
    })
    EntityAddComponent2(entity_id, "MagicConvertMaterialComponent", {
        kill_when_finished=true,
        from_material_tag="[gas]",
        steps_per_frame=32,
        to_material=CellFactory_GetType( convert_material ),
        clean_stains=false,
        is_circle=true,
        min_radius=i,
        radius=i+39,
        loop=false
    })
    EntityAddComponent2(entity_id, "MagicConvertMaterialComponent", {
        kill_when_finished=true,
        from_material_tag="[sand_other]",
        steps_per_frame=32,
        to_material=CellFactory_GetType( convert_material ),
        clean_stains=false,
        is_circle=true,
        min_radius=i,
        radius=i+39,
        loop=false
    })
    EntityAddComponent2(entity_id, "MagicConvertMaterialComponent", {
        kill_when_finished=true,
        from_material_tag="[sand_herb_vapour]",
        steps_per_frame=32,
        to_material=CellFactory_GetType( convert_material ),
        clean_stains=false,
        is_circle=true,
        min_radius=i,
        radius=i+39,
        loop=false
    })
    EntityAddComponent2(entity_id, "MagicConvertMaterialComponent", {
        kill_when_finished=true,
        from_material_tag="[sand_ground]",
        steps_per_frame=32,
        to_material=CellFactory_GetType( convert_material ),
        clean_stains=false,
        is_circle=true,
        min_radius=i,
        radius=i+39,
        loop=false
    })
    EntityAddComponent2(entity_id, "MagicConvertMaterialComponent", {
        kill_when_finished=true,
        from_material_tag="[sand_metal]",
        steps_per_frame=32,
        to_material=CellFactory_GetType( convert_material ),
        clean_stains=false,
        is_circle=true,
        min_radius=i,
        radius=i+39,
        loop=false
    })
    EntityAddComponent2(entity_id, "MagicConvertMaterialComponent", {
        kill_when_finished=true,
        from_material_tag="[box2d]",
        steps_per_frame=32,
        to_material=CellFactory_GetType( convert_material ),
        clean_stains=false,
        is_circle=true,
        min_radius=i,
        radius=i+39,
        loop=false
    })
end
