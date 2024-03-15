function table_shuffle(t) -- This same function seems to have a bug in data/scripts/gun/gun_procedural.lua
	local iterations = #t
	local j
	for i = iterations, 2, -1 do
		j = Random(1, i)
		t[i], t[j] = t[j], t[i]
	end
end

function file_exists(filename)
	local func, err = loadfile(filename)
	return not err or err:sub(1, 45) ~= "Error loading lua script - file doesn't exist"
end

function table_get_key_count(t)
	local count = 0
	for _ in pairs(t) do count = count + 1 end
	return count
end



function EntityGetVariable(entity, name, type)
	value = nil
	variable_storages = EntityGetComponent(entity, "VariableStorageComponent")
	if(variable_storages ~= nil)then
		for k, v in pairs(variable_storages)do
			name_out = ComponentGetValue2(v, "name")
			if(name_out == name)then
				value = ComponentGetValue2(v, "value_"..type)
			end
		end
	end
	return value
end

function EntitySetVariable(entity, name, type, value)
	variable_storages = EntityGetComponent(entity, "VariableStorageComponent")
	has_been_set = false
	if(variable_storages ~= nil)then
		for k, v in pairs(variable_storages)do
			name_out = ComponentGetValue2(v, "name")
			if(name_out == name)then
				ComponentSetValue2(v, "value_"..type, value)
				has_been_set = true
			end
		end
	end
	if(has_been_set == false)then
		comp = {}
		comp.name = name
		comp["value_"..type] = value
		EntityAddComponent2(entity, "VariableStorageComponent", comp)
	end
end

function EntityHasFlag(entity, name)
	value = false
	variable_storages = EntityGetComponent(entity, "VariableStorageComponent")
	if(variable_storages ~= nil)then
		for k, v in pairs(variable_storages)do
			name_out = ComponentGetValue2(v, "name")
			if(name_out == name)then
				value = ComponentGetValue2(v, "value_bool")
			end
		end
	end
	return value
end

function EntityAddFlag(entity, name)
	variable_storages = EntityGetComponent(entity, "VariableStorageComponent")
	has_been_set = false
	if(variable_storages ~= nil)then
		for k, v in pairs(variable_storages)do
			name_out = ComponentGetValue2(v, "name")
			if(name_out == name)then
				ComponentSetValue2(v, "value_bool", true)
				has_been_set = true
			end
		end
	end
	if(has_been_set == false)then
		comp = {}
		comp.name = name
		comp["value_bool"] = true
		EntityAddComponent2(entity, "VariableStorageComponent", comp)
	end
end

function EntityRemoveFlag(entity, name)
	variable_storages = EntityGetComponent(entity, "VariableStorageComponent")
	if(variable_storages ~= nil)then
		for k, v in pairs(variable_storages)do
			name_out = ComponentGetValue2(v, "name")
			if(name_out == name)then
				EntityRemoveComponent(entity, v)
			end
		end
	end
end


function string_split(inputstr, sep)
sep = sep or "%s"
local t = {}
for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
	table.insert(t, str)
end
return t
end

function math_average(t)
	local avg = 0
	for i,v in ipairs(t) do
		avg = avg + v
	end
	return avg / #t
end

-- Normalizes the values of a table so that they sum up to 1
function normalize_table(t)
local sum = 0
for i=1, #t do
	sum = sum + t[i]
end
if sum == 0 then
	for i=1, #t do
	t[i] = 1 / #t
	end
else
	for i=1, #t do
	t[i] = t[i] / sum
	end
end
end
-- Setting min higher than 0, close to 1 reduces the variance, for instance min=1 would result in {0.2, 0.2, 0.2, 0.2, 0.2}
function create_normalized_random_distribution(count, min)
min = min or 0
local out = {}
for i=1, count do
	local random_number = min + Random() * (1 - min)
	table.insert(out, random_number)
end
normalize_table(out)
return out
end

function get_sign(num)
	num = tonumber(num)
	if num >= 0 then
		return 1
	else
		return -1
	end
end

function get_component_with_member(entity_id, member_name)
	local components = EntityGetAllComponents(entity_id)
	for _, component_id in ipairs(components) do
		for k, v in pairs(ComponentGetMembers(component_id)) do
			if(k == member_name) then
				return component_id
			end
		end
	end
end

function generate_unique_id(len, x, y)
SetRandomSeed(x, y)
local chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
local char_count = string.len(chars)
local output = ""
for i=1,len do
	local randIndex = Random(char_count)
	output = output .. string.sub(chars, randIndex, randIndex)
end
return output
end
-- converts the subtables { min=2, max=5 } to a value using Random(min, max)
function config_populate_flat_buffs(flat_buff_amounts, rand_seed_x, rand_seed_y)
local o = {}
SetRandomSeed(rand_seed_x, rand_seed_y)
for k,v in pairs(flat_buff_amounts) do
	o[k] = Random(v.min, v.max)
end
return o
end

function set_random_seed_with_player_position()
local players = EntityGetWithTag("player_unit")
if #players > 0 then
	local x, y = EntityGetTransform(players[1])
	SetRandomSeed(x, y)
end
end

function table.imerge(t1, t2)
local out = {}
for i, v in ipairs(t1) do
	table.insert(out, v)
end
for i, v in ipairs(t2) do
	table.insert(out, v)
end
return out
end

string.trim = function(s)
   return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

-- Randomly either rounds up or down
function randround(val)
if Random() < 0.5 then
	return math.ceil(val)
else
	return math.floor(val)
end
end


function EntityGetVariable(entity, name, type)
	value = nil
	variable_storages = EntityGetComponent(entity, "VariableStorageComponent")
	if(variable_storages ~= nil)then
		for k, v in pairs(variable_storages)do
			name_out = ComponentGetValue2(v, "name")
			if(name_out == name)then
				value = ComponentGetValue2(v, "value_"..type)
			end
		end
	end
	return value
end

function EntitySetVariable(entity, name, type, value)
	variable_storages = EntityGetComponent(entity, "VariableStorageComponent")
	has_been_set = false
	if(variable_storages ~= nil)then
		for k, v in pairs(variable_storages)do
			name_out = ComponentGetValue2(v, "name")
			if(name_out == name)then
				ComponentSetValue2(v, "value_"..type, value)
				has_been_set = true
			end
		end
	end
	if(has_been_set == false)then
		comp = {}
		comp.name = name
		comp["value_"..type] = value
		EntityAddComponent2(entity, "VariableStorageComponent", comp)
	end
end

function clamp(val, lower, upper)
if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
return math.max(lower, math.min(upper, val))
end

function get_stored_entity_type(entity_id)
local variable_storage_components = EntityGetComponent(entity_id, "VariableStorageComponent")
if variable_storage_components ~= nil then
	for i, component in ipairs(variable_storage_components) do
	local name = ComponentGetValue(component, "name")
	local value_string = ComponentGetValue(component, "value_string")
	if name == "entity_type" then
		return value_string
	end
	end
end
end

function table.dump(o)
    if type(o) == 'table' then
        local s = '{ '..string.char(10)
        for k,v in pairs(o) do
           if type(k) ~= 'number' then k = '"'..k..'"' end
           s = s .. '['..k..'] = ' .. table.dump(v) .. ',' ..string.char(10)
        end
        return s .. '} '..string.char(10)
     else
        if(type(o) == "string")then
            return '"'..o..'"'
        else
            return tostring(o)
        end
     end
end