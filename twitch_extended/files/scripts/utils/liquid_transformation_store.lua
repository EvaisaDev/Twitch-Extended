dofile_once("mods/twitch_extended/files/scripts/utils/utilities.lua")
dofile_once("mods/twitch_extended/files/scripts/utils/utils.lua")

material_names = {}

function parse_tags(tags)
	local output = {}
	if tags == nil then
		return output
	end
	local a = string.gmatch(tags, "%[(%w+)%]")
	for i in a do
		output[i] = true
	end
	return output
end

blacklist = {
	"air",
	"creepy_liquid",
	"time_leak",
	"killer_goo",
	"e",
	"hot_goo",
	"alt_killer_goo",
	"alt_corruption",
	"corruption",
	"killer_goo_solid",
	"AA_MAT_BLOOM_ROOF_DEAD",
	"AA_MAT_BLOOM_ROOF_PLANT",
	"AA_MAT_BLOOM_GAS",
	"AA_MAT_BLOOM_MAGIC",
	"AA_MAT_BLOOM_ROOF",
    "AA_MAT_BLOOM",
    "magic_liquid_polymorph",
    "magic_liquid_random_polymorph",
    "magic_liquid_unstable_polymorph",
	"fire",
	"plasma_fading",
	"silver_molten",
	"copper_molten",
	"brass_molten",
	"glass_molten",
	"glass_broken_molten",
	"steel_molten",
	"wax_molten",
	"concrete_sand",
	"sodium_unstable",
	"gunpowder_unstable",
	"monster_powder_test",
	"rat_powder",
	"orb_powder",
	"gunpowder_unstable_boss_limbs",
}


function add_materials_file(materials_file)

	local nxml = dofile("mods/twitch_extended/lib/nxml.lua")

	--[[local xml2lua = dofile("mods/twitch_extended/lib/xml2lua/xml2lua.lua")
	local handler = dofile("mods/twitch_extended/lib/xml2lua/xmlhandler/tree.lua")


	local parser = xml2lua.parser(handler)

	local materials = ModTextFileGetContent(materials_file)

	parser:parse(materials)



	for i, p in pairs(handler.root.Materials) do
	  if i == "CellDataChild" or i == "CellData" then
		for i2, p2 in pairs(handler.root.Materials[i]) do
			if(p2._attr ~= nil)then


				local tags = parse_tags(p2._attr.tags)
				
				if tags.liquid then
					local name = p2._attr.name
					if(table.has(blacklist,name) == false and name ~= nil and name ~= "")then
					table.insert(material_names, name)
					end
				end
			end
		end
	  end
	end]]

	--[[ NXML EXAMPLE
		local data = nxml.parse(biomes)

		for elem in data:each_child() do
			if elem.name == "Topology" then
				if(elem.attr ~= nil)then
					local biome_name = elem.attr.name
					local lua_script = elem.attr.lua_script

					--print(biome_name)
					--print(lua_script)

					if(lua_script ~= nil and biome_name ~= nil)then
						if(biome_scripts[biome_name] == nil)then
							biome_scripts[biome_name] = {}
						end
						table.insert(biome_scripts[biome_name], lua_script)
					end
				end
			end
		end
	]]
	if(not ModDoesFileExist(materials_file))then
		return
	end
	
	local materials = ModTextFileGetContent(materials_file)

	local data = nxml.parse(materials)

	for elem in data:each_child() do
		-- if celldata or celldatachild
		if elem.name == "CellData" or elem.name == "CellDataChild" then
			if(elem.attr ~= nil)then
				local tags = parse_tags(elem.attr.tags)
				
				if tags.liquid then
					local name = elem.attr.name
					if(table.has(blacklist,name) == false and name ~= nil and name ~= "")then
						table.insert(material_names, name)
					end
				end
			end
		end
	end
end

for i, v in ipairs(ModMaterialFilesGet() or {})do
	add_materials_file(v)
end


local barrel_script = "local materials = {"

for k, v in pairs(material_names)do
	
    barrel_script = barrel_script..'"'..v..'",'
end

barrel_script = barrel_script.."}"..string.char(10)..ModTextFileGetContent("mods/twitch_extended/files/scripts/events/liquid_transformation.lua")

--print(barrel_script)
ModTextFileSetContent("mods/twitch_extended/files/scripts/events/liquid_transformation.lua", barrel_script)