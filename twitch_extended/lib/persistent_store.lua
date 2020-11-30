local hex_digits = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" }

function store_reward_id(name, id)
    hex_id = id:gsub( "-", "")
    substrings = splitByChunk(hex_id, 2)
    for k, v in pairs(substrings)do
      local integer = from_hex(v)
      store_int(name..k, 16, integer)
    end
end

function remove_reward_id(name)
  for i = 1, 16 do
    remove_int(name..i, 16)
  end
end


function retrieve_reward_id(name)
  local reward_id = ""
  for i = 1, 16 do
    integer = retrieve_int(name..i, 16)
    if(integer == 0)then
      return nil
    end
    hex = string.format("%02X", integer)
    if(i == 5 or i == 7 or i == 9 or i == 11)then
      reward_id = reward_id .. "-"
    end
    reward_id = reward_id .. hex
  end
  return string.lower(reward_id)
end

function from_hex(str)
  return tonumber(str, 16)
end

function splitByChunk(text, chunkSize)
  local s = {}
  for i=1, #text, chunkSize do
      s[#s+1] = text:sub(i,i+chunkSize - 1)
  end
  return s
end

function store_int(name, num_bits, val)
  if type(val) ~= "number" then
    error("value must be a number")
  end

  for i=1, num_bits do
    if bit.band(val, 1) == 1 then
      AddFlagPersistent(name .. "_" .. i)
    else
      RemoveFlagPersistent(name .. "_" .. i)
    end
    val = bit.rshift(val, 1)
  end
end

function remove_int(name, num_bits)
  for i=1, num_bits do
    local bit = HasFlagPersistent(name .. "_" .. i) and 1 or 0
    if bit > 0 then
        RemoveFlagPersistent(name .. "_" .. i)
    end
  end
end


function retrieve_int(name, num_bits)
  local value = 0
  for i=1, num_bits do
    local bit = HasFlagPersistent(name .. "_" .. i) and 1 or 0
    if bit > 0 then
      value = value + 2 ^ (i - 1)
    end
  end
  return value
end

