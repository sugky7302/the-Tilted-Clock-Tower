local cj = require 'jass.common'
local setmetatable = setmetatable
local timer = require 'timerutils'
local texttag = require 'texttag'
local list = require 'list'

local shield = {}
local mt = {}
setmetatble(shield,shield)
shield.__index = mt
shield.timer = timer()
shield.execute = list()
shield.timer_status = false -- true:正在運作，false:未運作

function shield:__call(o) -- 成員有object, dur, val, type, icon
  setmetatable(o,self)
  o.__index = o
  self.execute:push_back(o)
  o.tt = cj.CreateTextTag()
  cj.SetTextTagPermanent(o.tt,true) -- 永久顯示
  if self.timer_status == false then
    self.timer_status = true
    cj.TimerStart(self.timer, 0.03125, true, function()
      local a = self.execute:front()
      while a do 
        a.val.dur = a.val.dur - 0.03125
        if a.val.dur <= 0 then
          local o = a
          a = a.next
          cj.DestroyTextTag(o.tt) -- 刪除漂浮文字
          o.tt = nil
          o.prev.next = o.next
          o.next.prev = o.prev
          o = nil
          self.execute.size = self.execute.size - 1
        else a = a.next end
      end
    end)
  end
  return o
end

return shield