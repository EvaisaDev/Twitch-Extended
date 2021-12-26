dofile_once("mods/config_lib/files/utilities.lua")
local function split(str, delim)
    local ret = {}
    if not str then
      return ret
    end
    if not delim or delim == '' then
      for c in string.gmatch(str, '.') do
        table.insert(ret, c)
      end
      return ret
    end
    local n = 1
    while true do
      local i, j = string.find(str, delim, n)
      if not i then break end
      table.insert(ret, string.sub(str, n, i - 1))
      n = j + 1
    end
    table.insert(ret, string.sub(str, n))
    return ret
  end
  
  
local function parseComplexTag(tags, tagKey, splitterA, splitterB, splitterC)
    splitterA = splitterA or ','
    splitterB = splitterB or '/'
  
    local raw = tags[tagKey]
    if not raw then
      return tags
    end
  
    tags[tagKey .. '-raw'] = (type(raw) == 'string') and raw or nil
  
    if raw == true then
      tags[tagKey] = nil
      return tags
    end
  
    tags[tagKey] = {}
  
    if type(raw) == 'string' then
      local spl = split(raw, splitterA)
      for _, part in pairs(spl) do
        local parts = split(part, splitterB)
        local val = parts[2]
        if splitterC and val then
          val = split(val, splitterC)
        end
        tags[tagKey][parts[1]] = val or nil
      end
    end
    return tags
end

return {
split = split,

trim = function(str)
    return string.match(str, '^%s*(.-)%s*$')
end,

username = function(username)
    if not username then return nil end
    username = username:lower()
    if username:sub(1, 1) == '#' then username = username:sub(2) end
    return username
end,

channel = function(channel)
    if not channel then return nil end
    channel = channel:lower()
    if channel:sub(1, 1) ~= '#' then channel = '#' .. channel end
    return channel
end,

actionMessage = function(message)
    return message:match('^\\u0001ACTION (.+)\\u0001$')
end,

unescapeIRC = function(message)
    return (not message or message:find('\\')) and message or message:gsub('\\([sn:r\\])', function(val) 
    local tbl = { ['s'] = ' ', ['n'] = '', [':'] = ';', ['r'] = ''}
    return tbl[val]
    end)
end,

badges = function(tags)
    return parseComplexTag(tags, 'badges')
end,

badgeInfo = function(tags)
    return parseComplexTag(tags, 'badge-info')
end,

emotes = function(tags)
    return parseComplexTag(tags, 'emotes', '/', ':', ',')
end,

websocketMessage = function(data)
    local message = {
    raw = data,
    tags = {},
    prefix = nil,
    command = nil,
    params = {}
    }

    local position, nextspace = 1, 0

    -- Check for IRCv3.2 Message Tags http://ircv3.atheme.org/specification/message-tags-3.2
    if data:sub(1, 1) == '@' then
    nextspace = data:find(' ')
    if not nextspace then return nil end -- Malformed IRC Message

    local rawTags = split(data:sub(2, nextspace - 1), ';') -- Tags split by ;
    for _, tag in pairs(rawTags) do
        -- Tags delimited by = are key-value tags
        -- No = means we assign the tag a value of true
        local pair = split(tag, '=')
        message.tags[pair[1]] = (pair[2] or true)
    end

    position = nextspace + 1
    end

    -- Skip trailing white space
    while data:sub(position, position) == ' ' do
    position = position + 1
    end

    -- Extract a prefix (They start with :)
    if data:sub(position, position) == ':' then
    nextspace = data:find(' ', position)
    if not nextspace then return nil end -- Malformed

    message.prefix = data:sub(position + 1, nextspace - 1)
    position = nextspace + 1
	
	-- Use Twitch username as fallback when the display name consists entirely of special characters
	-- E.g. when display name is Japanese, Chinese or Korean
	if message.tags["display-name"] == '' then
		message.tags["display-name"] = message.prefix:sub(0, message.prefix:find("!") - 1)
	end

    while data:sub(position, position) == ' ' do
        position = position + 1
    end
    end

    nextspace = data:find(' ', position)

    -- If no more whitespace left, extract everything from current position as a command
    if not nextspace then
    if data:len() > position then
        message.command = data:sub(position)
        return message
    end
    return nil
    end

    -- Else, command is current position up to next space
    -- After command = parameters
    message.command = data:sub(position, nextspace - 1)
    position = nextspace + 1

    -- Skip trailing white space
    while data:sub(position, position) == ' ' do
    position = position + 1
    end

    while position < data:len() do
    nextspace = data:find(' ', position)
    -- If character is a colon, we have got a trailing parameter
    -- At this point, there are no extra parameters, so push everything
    -- remaining to the params array and break

    if data:sub(position, position) == ':' then
        table.insert(message.params, data:sub(position + 1))
        break
    end

    if nextspace then
        -- Push whatever is in between to params
        table.insert(message.params, data:sub(position, nextspace - 1))
        position = nextspace + 1

        while data:sub(position, position) == ' ' do
        position = position + 1
        end
    end

    if not nextspace then
        table.insert(message.params, data:sub(position))
        break
    end
    end

    return message
end
}