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
-- hitMode有OneHit、DoubleHit、Pass
function Missile:__call(obj)
    obj = Object(obj) -- 轉成Object
    setmetatable(obj, self)
    obj.__index = obj
    obj.missile = _GetMissile(obj)
    obj.unitDetermined = Group(obj.missile)
    obj.startingHeight = _GetStartingHeight(obj.startingPoint)
    obj.traceMode = (type(obj.traceMode) == 'string') and mt.traceLib[obj.traceMode] or obj.traceMode
    obj.angle = Point.Angle(obj.startingPoint, obj.targetPoint)
    MissileTool.SetHeight(obj, 0)
    _SetTrace(obj)
    return obj
end

_GetMissile = function(obj)
    --local missile = cj.CreateUnit(cj.GetOwningPlayer(obj.owner), Base.String2Id(_MISSILE_ID), obj.startingPoint.x, obj.startingPoint.y, cj.GetUnitFacing(obj.owner))
    local missile = cj.CreateUnit(cj.Player(0), Base.String2Id(_MISSILE_ID), obj.startingPoint.x, obj.startingPoint.y, 0)
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
        self.unitDetermined:EnumUnitsInRange(cj.GetUnitX(self.missile), cj.GetUnitY(self.missile), 50., Group.IsEnemy)
        if not self.unitDetermined:IsEmpty() then
            hit = hit + 1
            self.unitDetermined:Loop(self.execution)
        end
        if _At_EndCondition(self, currentDistance, hit) then
            self:Remove()
        end
    end)
end

_At_EndCondition = function(self, currentDistance, hit)
    local oneHit = (self.hitMode == "OneHit") and (hit > 0)
    local arriveEndPoint = currentDistance >= self.maxDistance
    local doubleHit = (self.hitMode == "DoubleHit") and (hit > 1)
    return oneHit or arriveEndPoint or doubleHit
end

function mt:Remove()
    self.timer:Remove()
    js.RemoveUnit(self.missile)
    self.missile = nil
    self.targetPoint:Remove()
    self.unitDetermined:Remove()
    self = nil
end

return Missile