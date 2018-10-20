local setmetatable = setmetatable
local cj = require 'jass.common'
local japi = require 'jass.japi'
local War3 = require 'api'
local Game = require 'game'
local Hero = require 'hero'
local Damage = require 'damage'

local Combat = {}
local mt = {}
setmetatable(Combat, Combat)
Combat.__index = mt

function Combat:Init()
    local unitIsAttacked = War3.CreateTrigger(function()
        local source, target = cj.GetEventDamageSource(), cj.GetTriggerUnit()
        Game:EventDispatch("單位-顯示傷害", source, target)
        return true
    end)
    Game:Event "單位-顯示傷害" (function(self, source, target)
        japi.EXSetEventDamage(0)
        Damage{
            source = Hero(source),
            target = Hero(target),
            type = "物理",
            name = "普通攻擊",
            elementType = "無",
        }
    end)
    Game:Event "單位-創建" (function(self, target)
        cj.TriggerRegisterUnitEvent(unitIsAttacked, target, cj.EVENT_UNIT_DAMAGED)
    end)
end

return Combat