local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local Point = require 'point'
local Timer = require 'timer'
local Group = require 'group'
local Object = require 'object'
local MissileTool = require 'missile_tool'

local Missile = {}
local mt = {traceLib = require 'trace_lib'}
setmetatable(Missile, Missile)
Missile.__index = mt 

-- constants
local _MOTIVATION, _STANDARD_HEIGHT, _MISSILE_ID  = 30, 50, 'u007'

-- variables
local _GetMissile, _GetStartingHeight, _At_EndCondition, _SetTrace

-- object 包含 owner, modelName, startingPoint, targetPoint, maxDistance, traceMode, hitMode, execution
-- traceMode可以調用trace_lib的函數或自己寫
-- 如果是要用trace_lib的函數，只要寫上函數名即可，不用寫結構名
-- 如果要自己寫，請遵照此格式 function(self) 動作 end
-- hitMode有1.2.3...或infinity
-- 數字表示擊中數達預設目標即停止
-- infinity表示投射物達最大距離才會停止
-- execution為group的loop函數，因此格式一定要遵照 function(group, i) 動作 end
function Missile:__call(obj)
    obj = Object(obj) -- 轉成Object
    setmetatable(obj, self)
    obj.__index = obj
    obj.missile = _GetMissile(obj)
    obj.unitDetermined = Group(obj.missile)
    obj.startingHeight = obj.startingHeight or _GetStartingHeight(obj.startingPoint)
    obj.traceMode = (type(obj.traceMode) == 'string') and mt.traceLib[obj.traceMode] or obj.traceMode
    obj.angle = obj.angle or Point.Rad(obj.startingPoint, obj.targetPoint)
    obj.SetHeight = obj.SetHeight or MissileTool.SetHeight
    obj:SetHeight(0)
    _SetTrace(obj)
    return obj
end

_GetMissile = function(obj)
    local missile = cj.CreateUnit(obj.owner.owner.object, Base.String2Id(_MISSILE_ID), obj.startingPoint.x, obj.startingPoint.y, cj.GetUnitFacing(obj.owner.object))
    cj.UnitAddAbility(missile, Base.String2Id(obj.modelName))
    return missile
end

-- 獲得投射物初始高度
_GetStartingHeight = function(startingPoint)
    startingPoint:GetZ()
    return startingPoint.z + _STANDARD_HEIGHT
end

-- 設定軌跡
_SetTrace = function(self)
    local currentDistance, hit = 0, 0
    self.timer = Timer(0.03, true, function()
        currentDistance = currentDistance + _MOTIVATION
        self:traceMode() -- 調用軌跡函數，設定投射物軌跡
        self:SetHeight(currentDistance)
        self.unitDetermined:EnumUnitsInRange(cj.GetUnitX(self.missile), cj.GetUnitY(self.missile), 50., Group.IsEnemy)
        if not self.unitDetermined:IsEmpty() then
            hit = hit + 1
            self.unitDetermined:Loop(self.execution)
        end
        if _At_EndCondition(self, currentDistance, hit) then
            self:Remove()
        end
        self.unitDetermined:Clear() -- 清空單位組，不然先前保存的單位會一直存留，導致判定會失準
    end)
end

_At_EndCondition = function(self, currentDistance, hit)
    if currentDistance >= self.maxDistance then
        return true
    elseif type(self.hitMode) == "number" and hit >= self.hitMode then
        return true
    end
    return false
end

function mt:Remove()
    self.timer:Break()
    js.RemoveUnit(self.missile)
    self.missile = nil
    if self.startingPoint then
        self.startingPoint:Remove()
    end
    if self.targetPoint then
        self.targetPoint:Remove()
    end
    self.unitDetermined:Remove()
    self = nil
end

return Missile