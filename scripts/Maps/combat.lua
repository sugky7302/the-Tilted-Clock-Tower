local setmetatable = setmetatable
local cj = require 'jass.common'
local japi = require 'jass.japi'
local War3 = require 'api'
local Game = require 'game'
local Unit = require 'unit'
local Damage = require 'damage'

local Combat = {}
local mt = {}
setmetatable(Combat, Combat)
Combat.__index = mt

function Combat:Init()
    local unitIsAttacked = War3.CreateTrigger(function()
        local source, target = cj.GetEventDamageSource(), cj.GetTriggerUnit()
        japi.EXSetEventDamage(0)
        if Unit(source).isSpellDamaged == false then
            Game:EventDispatch("單位-造成傷害", source, target)
            Game:EventDispatch("天賦-傷害完成", source, target)
        end
        return true
    end)
    Game:Event "單位-造成傷害" (function(self, source, target)
        Damage{
            source = Unit(source),
            target = Unit(target),
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