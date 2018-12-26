-- LuaExpat wrapper

local xml = {}
local lxp = require "lxp"

-- Fetches text data from XML string
function xml.text(data, callback)
  local parser = lxp.new({
    CharacterData = function(parser, str)
      for s in str:gmatch("[^\r\n]+") do
        callback(s)
      end
    end
  }, nil, false)
  parser:parse(data)
  parser:parse()
  parser:close()
end

return xml