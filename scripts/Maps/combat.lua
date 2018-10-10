local setmetatable = setmetatable
local math = math
local cj = require 'jass.common'
local slk = require 'jass.slk'
local js = require 'jass_tool'
local TexttagToAttachUnit = require 'text_to_attach_unit'
local Point = require 'point'
local War3 = require 'api'
local Game = require 'game'
local Timer = require 'timer'

local Combat = {}
local mt = {}
setmetatable(Combat, Combat)
Combat.__index = mt

function Combat:Init()
    local unitIsAttacked = War3.CreateTrigger(function()
        local source, target, dmg = cj.GetAttacker(), cj.GetTriggerUnit(), cj.GetEventDamage()
        Game:EventDispatch("單位-顯示傷害", source, target, dmg)
        return true
    end)
    Game:Event "單位-顯示傷害" (function(self, source, target, dmg)
        local point_source, point_target = Point:GetUnitLoc(source), Point:GetUnitLoc(target)
        local dist = Point.Distance(point_source, point_target)
        local sourceId = Base.Id2String(cj.GetUnitTypeId(source))
        local missileSpeed = slk.unit[sourceId].Missilespeed_1
        local attackAnimation = slk.unit[sourceId].dmgpt1
        local timeout = dist / missileSpeed + attackAnimation
        point_source:Remove()
        point_target:Remove()
        Timer(timeout, false, function()
            Combat.SetText(target, dmg, "物理")
        end)
    end)
    Game:Event "單位-創建" (function(self, target)
        cj.TriggerRegisterUnitEvent(unitIsAttacked, target, cj.EVENT_UNIT_ATTACKED)
    end)
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

function Combat:RegisterEvent(target)
    Game:Dispatch('單位創建', target)
end

return Combat