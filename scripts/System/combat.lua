local setmetatable = setmetatable
local math = math
local cj = require 'jass.common'
local js = require 'jass_tool'
local TexttagToAttachUnit = require 'text_to_attach_unit'
local Point = require 'point'
local War3 = require 'api'

local Combat = {}
local mt = {}
setmetatable(Combat, Combat)
Combat.__index = mt

function Combat:Init()
    self.unitIsAttacked = War3.CreateTrigger(function()
        local target, damageValue = cj.GetTriggerUnit(), cj.GetEventDamage()
        Combat.SetText(target, damageValue, "物理")
        return true
    end)
end

function Combat:RegisterEvent(target)
    cj.TriggerRegisterUnitEvent(self.unitIsAttacked, target, cj.EVENT_UNIT_ATTACKED)
end

function Combat.SetText(target, value, textType, scale)
    local text
    if textType == "治療" then
        text = "|cff00ff00" .. math.modf(value)
    elseif textType == "回魔" then
        text = "|cff3366ff" .. math.modf(value)
    else
        if value > 0 then
            text = (textType == "法術" and "|cffffff00" or "") .. math.modf(value)
        elseif value == 0 then
            text = "|cffff0000" .. "閃躲!"
        else
            text = "|cffff0000" .. "忽視!"
        end
    end
    TexttagToAttachUnit(text, Point(cj.GetUnitX(target), cj.GetUnitY(target)), scale)
end

return Combat