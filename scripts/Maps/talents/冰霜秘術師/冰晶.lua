local Missile = require 'missile'
local Pet = require 'pet'
local Point = require 'point'
local cj = require 'jass.common'
local js = require 'jass_tool'
local Game = require 'game'
local Timer = require 'timer'
local Unit = require 'unit'
local TraceLib = require 'trace_lib'
local MathLib = require 'math_lib'

-- variables
local _CreateMissile
local mt = require 'talent' "冰晶"
{
    cost = 5,
    tip = "當水元素攻擊受到冰冷效果影響的目標時，其傷害量會化為冰晶儲存，持續|Cffffcc0060|r秒。" ..
    "同一時間內最多可儲存|Cffffcc005|r顆冰晶。施放寒冰箭會釋放所有儲存的冰晶，造成額外傷害。",
    skill = "寒冰箭",
}
mt.dmg = 0
mt.max = 5

Game:Event "天賦-傷害完成" (function(self, source, target)
    if Pet(source).name == '水元素' and Unit(target):FindBuff('霜寒刺骨debuff') then
        local water = Pet(source)
        water.owner:TalentDispatch("冰晶", "添加", water:get "最後造成的傷害")
    end
end)

Game:Event "天賦-傷害結算" (function(self, obj)
    if obj.name == "寒冰箭" then
        obj.source:TalentDispatch("冰晶", "刪除")
    end
end)

function mt:on_add(target, dmg)
    _CreateMissile(target)
    if #target.iceCrystals < mt.max then
        local p = Point:GetUnitLoc(target.object)
        p:GetZ()
        local missile = Missile{
            owner = target,
            modelName = 'A046',
            startingPoint = p,
            radius = 50,
            maxDistance = 0,
            angle = MathLib.Random(0, 360),
            traceMode = "Surround",
            hitMode = "infinity",
            execution = function(group, i) end,
            startingHeight = p.z + 75, 
            SetHeight = function(self)
                cj.UnitAddAbility(self.missile, Base.String2Id('Arav'))
                cj.UnitRemoveAbility(self.missile, Base.String2Id('Arav'))
                cj.SetUnitFlyHeight(self.missile, self.startingHeight, 0.)
            end
        }
        local timer = Timer(60, false, function()
            target:add("額外法術傷害", -dmg)
            self.dmg = self.dmg - dmg
            for i, member in ipairs(target.iceCrystals) do 
                if member == missile then
                    table.remove(target.iceCrystals, i)
                    missile:Remove()
                    break
                end
            end
        end)
        table.insert(target.iceCrystals, {missile, timer})
        target:add("額外法術傷害", dmg)
        self.dmg = self.dmg + dmg
    end
end

function mt:on_call(target, targetPoint, range)
    for _, tb in ipairs(target.iceCrystals) do
        local missilePoint = Point:GetUnitLoc(tb[1].missile)
        tb[1].targetPoint = targetPoint
        tb[1].maxDistance = tb[1].maxDistance + range
        tb[1].traceMode = TraceLib.StraightLine
        tb[1].hitMode = 1
        tb[1].angle = Point.Rad(missilePoint, targetPoint)
        missilePoint:Remove()
    end
end

function mt:on_remove(target)
    _CreateMissile(target)
    for i, tb in ipairs(target.iceCrystals) do
        tb[2]:Break()
        table.remove(target.iceCrystals, i)
    end
    target:add("額外法術傷害", -self.dmg)
    self.dmg = 0
end

_CreateMissile = function(self)
    if not self.iceCrystals then
        self.iceCrystals = {}
    end
end
