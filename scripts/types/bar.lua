local cj = require 'jass.common'
local texttag = require 'texttag'
local unit = require 'unit'
local color = require 'color'
local timer = require 'timerutils'
local queue = require 'queue'
local setmetatable = setmetatable
local math = math

local bar = {}
local mt = {}
setmetatable(bar,bar)
bar.__index = mt
bar.timer = timer()
bar.execute = queue()

function mt:model(bar_type,leng)
  local s = ''
  local strip = 'l' -- 血量模型，每格50血
  for i = 1,leng do s = s .. strip .. (i%5 == 0) and ' ' or '' end
  if bar_type == '生命' then
    return color('red') + s + '|r'
  elseif bar_type == '魔力' then
    return color('mediumblue') + s + '|r'
  end
end

function bar:__call(o) -- 成員有object, bar_type
  o.tt = cj.CreateTextTag() -- 創建bar實例
  local a = unit(o.object)
  cj.SetTextTagPos(o.tt, cj.GetUnitX(o.object), cj.GetUnitY(o.object), 40)
  cj.SetTextTagText(o.tt, self:model(o.bar_type, math.modf(a:get '生命' / 50)), 0.01)
  cj.TimerStart(self.timer, 0.03125, true, function()
    --update
  end)
  setmetatable(o,self)
  o.__index = o 
  return o
end

return bar