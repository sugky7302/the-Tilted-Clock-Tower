--[[<?
<?import('test.lua')[[
 local jass = require 'jass.common'
local message = require 'jass.message'

function message.hook(msg)
   local x, y = message.mouse()
   if(msg.type=='mouse_down' and msg.code==1)then
	  jass.DisplayTextToPlayer( jass.Player(0), 0, 0,'按下,x:'..jass.I2S(x)..',y:'..jass.I2S(y))
   elseif(msg.type=='mouse_up')then
	  jass.DisplayTextToPlayer( jass.Player(0), 0, 0,'松开,x:'..jass.I2S(x)..',y:'..jass.I2S(y))
   end
   return true--让玩家可以选择单位
end
function mousemove()
   local x, y = message.mouse()
   jass.DisplayTextToPlayer( jass.Player(0), 0, 0,'鼠标移动,x:'..jass.I2S(x)..',y:'..jass.I2S(y))
end
jass.TimerStart(jass.CreateTimer(), 0.1, true, mousemove)
]]
--?>
--[[<?import('blizzard.lua')[[
local CJ=require 'jass.common'
local BJ={}
BJ.bj_MAX_PLAYER_SLOTS=16
function BJ.TriggerRegisterAnyUnitEventBJ(trig,event)
   for i=0,BJ.bj_MAX_PLAYER_SLOTS-1 do
      CJ.TriggerRegisterAnyUnitEventBJ(trig,CJ.Player(i),event,nil)
    end
end
function BJ.TriggerRegisterEnterRectSimple(trig,rect)
    local rectRegion = CJ.CreateRegion()
    CJ.RegionAddRect(rectRegion, rect)
    return CJ.TriggerRegisterEnterRegion(trig, rectRegion, nil)
end
return BJ
]]
--?>]]
--[[<?import('maox.lua')[[
local CJ=require 'jass.common'
local BJ=require 'blizzard'
local temp=require 'jass.globals'
local trig=CJ.CreateTrigger()
BJ.TriggerRegisterEnterRectSimple(trig,temp.udg_juxingquyu)
CJ.TriggerAddAction(trig,
function()
   CJ.KillUnit( CJ.GetTriggerUnit() )
end
)
]]
--?>]]
--在YDWE才有用 lua多行注释--[[xxxxx]]，单行--
 