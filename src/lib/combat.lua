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
        local source, target = Unit(cj.GetEventDamageSource()), Unit(cj.GetTriggerUnit())
        japi.EXSetEventDamage(0)
        if Unit(source).isSpellDamaged == false then
            source:EventDispatch("單位-造成傷害", target)
            source:EventDispatch("單位-傷害完成", target)
        end
        return true
    end)
    Unit:Event "單位-造成傷害" (function(trigger, source, target)
        Damage{
            source = source,
            target = target,
            type = "物理",
            name = "普通攻擊",
            elementType = "無",
        }
    end)
    Game:Event "單位-創建" (function(trigger, target)
        cj.TriggerRegisterUnitEvent(unitIsAttacked, target, cj.EVENT_UNIT_DAMAGED)
    end)
end

return Combat