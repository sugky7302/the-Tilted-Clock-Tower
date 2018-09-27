local cj = require 'jass.common'
local queue = require 'stl.queue'
local setmetatable = setmetatable

local timer = {} -- 全域變量
setmetatable(timer,timer) -- 讓timer能夠當作函數調用，變成像c++一樣

-- 本地變量
timer.quantity = 64
timer.recycle = queue()

function timer.erase(t)
  cj.PauseTimer(t)
  if timer.recycle:size() >= timer.quantity then
    cj.DestroyTimer(t)
  else
    timer.recycle:push(t)
  end
  t = nil
end

function timer:__call()
  local t
  if self.recycle:size() == 0 then
    t = cj.CreateTimer()
    return t
  else
    t = self.recycle:front()
    self.recycle:pop()
    return t
  end
end

return timer
