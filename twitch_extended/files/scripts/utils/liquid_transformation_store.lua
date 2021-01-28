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
	"poly_goo",
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

	local xml2lua = dofile("mods/twitch_extended/lib/xml2lua/xml2lua.lua")
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
	end
end

add_materials_file("data/materials.xml")


local mod_ids = ModGetActiveModIDs()

for _, id in pairs(mod_ids)do
	if(id ~= "twitch_extended")then
		if(file_exists("mods/"..id.."/init.lua"))then
			local content = ModTextFileGetContent("mods/"..id.."/init.lua")
			if(content == nil)then
				return
			end
			content = string.gsub(content, "%-%-%[%[[^%[%]]*%]%]", "")

			lines = {}
			for s in content:gmatch("[^\r\n]+") do
				table.insert(lines, s)
			end
			
			content = ""

			for i, line in ipairs(lines) do
				--if string.match(line, "%s*%-%-") == nil then
				-- Not a commented out line
			--	end

				line = string.gsub(line, "%-%-(.*)", "")

				content = content..line..string.char(10)
			end

			local arguments = string.gmatch(content, "ModMaterialsFileAdd%(%s*\"([^()]+)\"%s*%)")

			for argument in arguments do

				if(not string.find(argument, "..") and not string.find(argument, "("))then
					add_materials_file(argument)
				end
			end
		end
	end
end

local barrel_script = "local materials = {"

for k, v in pairs(material_names)do
	
    barrel_script = barrel_script..'"'..v..'",'
end

barrel_script = barrel_script.."}"..string.char(10)..ModTextFileGetContent("mods/twitch_extended/files/scripts/events/liquid_transformation.lua")
--print(barrel_script)
ModTextFileSetContent("mods/twitch_extended/files/scripts/events/liquid_transformation.lua", barrel_script)