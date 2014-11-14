local xml = require "xml"
local math = require "math"
local utf8 = require "utf8"
local challenges = ngx.shared.challenges

local CHALLENGE_CACHE_SIZE = 2048

local pool = {}

-- Getters and setters
setmetatable(pool, {
  __index = function (table, index)
    if tonumber(index) ~= nil or index == "current" or index == "last" then
      return challenges:get(index)
    else
      return rawget(pool, index)
    end
  end,
  __newindex = function (table, index, value)
    if tonumber(index) ~= nil or index == "current" or index == "last" then
      challenges:set(index, value)
    else
      rawset(pool, index, value)
    end
  end
})

function pool.update()
  ngx.log(ngx.NOTICE, "Fetching challenges")
  xml.text(ngx.location.capture("/yandex").body, function(str)
    if utf8.len(str) > 16 and utf8.len(str) < 32 then
      pool[pool.last] = utf8.upper(utf8.gsub(str, "[^%w%s-]", ""))
      -- Round-robin storage
      pool.last = math.fmod(pool.last + 1, CHALLENGE_CACHE_SIZE)
    end
  end)
end

function pool.fetch()
  -- Get current challenge or something before last
  local challenge = pool[pool.current] or pool[math.fmod(pool.current + 1, pool.last)]
  
  if not challenge then
    pool.update()
  elseif pool.current == pool.last then
    -- Trigger delayed pool update
    ngx.thread.spawn(pool.update)
  end

  challenge = pool[pool.current]

  pool.current = math.fmod(pool.current + 1, CHALLENGE_CACHE_SIZE)

  return challenge
end

pool.current, pool.last = 0, 0

return pool