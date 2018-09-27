local Point = require 'point'
local Timer = require 'timer'
local Group = require 'group'
local cj = require 'jass.common'
local MissileTrace = require 'missile_trace'
local sin, cos = math.sin, math.cos
local setmetatable = setmetatable

local Missile = {}
local mt = {}
setmetatable(Missile, Missile)
Missile.__index = mt 

Missile.MOTIVATION = 30.
Missile.STANDARD_HEIGHT = 75.
Missile.MISSILE_ID = ""
local GetMissile, GetStartingHeight, At_EndCondtion = nil, nil, nil

-- object 包含 owner, modelName, targetPoint, maxDistance, traceMode, hitMode, execution
function Missile:__call(object) 
    setmetatable(object, self)
    object.__index = object
    object.startingPoint = Point{cj.GetUnitX(object.owner), cj.GetUnitY(object.owner)}
    object.missile = GetMissile(object)
    object.unitDetermined = Group(object.missile)
    object.startingHeight = GetStartingHeight(object.startingPoint)
    object.timer = object:SetTrace()
    return object
end

local function GetMissile(object)
    local missile = cj.CreateUnit(cj.GetOwnPlayer(object.owner), base.strin2id(mt.MISSILE_ID), object.startingPoint.x, object.startingPoint.y, cj.GetUnitFacing(object.owner))
    cj.UnitAddSkill(missile, object.modelName)
    return missile
end

-- 獲得投射物初始高度
local function GetStartingHeight(startingPoint)
    return startingPoint.z + mt.STANDARD_HEIGHT
end

-- 設定軌跡
function mt:SetTrace()
    local currentDistance = 0
    local hit = 0
    return Timer(0.03, true, function(){
        currentDistance += 30
        mt.trace[self.traceMode]
        self.unitDetermined:EnumUnitsInRange(cj.GetUnitX(self.missile), cj.GetUnitY(self.missile), 50., Group.IsEnemy)
        if not self.unitDetermined:IsEmpty() then
            hit += 1
            self.unitDetermined:Loop(self.execution)
            if At_EndCondition(self, currentDistance, hit) then
                self:Remove()
            end
        end
    })
end

local function At_EndCondtion(self, currentDistance,, hit)
    local oneHit = self.hitMode == "OneHit"
    local arriveEndpoint = currentDistance >= self.maxDistance
    local doubleHit = (self.hitMode == "DoubleHit") and (hit > 1)
    return oneHit or arriveEndpoint or doubleHit
end

function mt:Remove()
    self.timer:Remove()
    self.timer = nil
    cj.RemoveUnit(self.missile)
    self.missile = nil
    self.targetPoint:Remove()
    self.targetPoint = nil
    self.unitDetermined:Remove()
    self.unitDetermined = nil
    self = nil
end

function mt:SetUnitPosition()
    local missilePoint = Point{cj.GetUnitX(self.missile), cj.GetUnitY(self.missile)}
    local angle = Point.Angle(missilePoint, self.targetPoint)
    cj.SetUnitX(missilePoint.x + Missile.MOTIVATION * cos(angle))
    cj.SetUnitY(missilePoint.y + Missile.MOTIVATION * sin(angle))
end

local function SetUnitHeight(self, currentDistance)
    local slope, Z_missile = GetSlope(self)
    cj.UnitAddSkill(self.missile, base.string2id(''))
    cj.UnitRemoveSkill(self.missile, base.string2id(''))
    local height = self.initialHeight + currentDistance * slope - Z_missile
    if height > 0 then
        cj.SetUnitFlyHeight(self.missile, height, 0.)
    else -- 如果投射物撞到牆，就把投射物刪除
        self:Remove()
    end
end

local function GetSlope(self)
    local missileLoc = cj.GetUnitLocation(object.missile)
    local targetLoc = cj.Location(object.targetPoint.x, object.targetPoint.y)
    local missilePoint = Point{cj.GetLocationX(missileLoc), cj.GetLocationY(missileLoc)}
    local altitudeDifference = cj.GetLocationZ(targetLoc) - cj.GetLocationZ(missileLoc)
    local distance = Point.Distance(missilePoint, object.targetPoint)
    local Z_missile = GetLocationZ(missileLoc)
    cj.RemoveLocation(missileLoc)
    cj.RemoveLocation(targetLoc)
    return altitudeDifference / distance, Z_missile
end

return Missile