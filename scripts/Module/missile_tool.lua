local sin, cos = math.sin, math.cos
local cj = require 'jass.common'
local Point = require 'point'

local MissileTool = {}

-- variables
local _MOTIVATION, _FLYSKILL_ID, _GetSlope = 30, 'Arav'

function MissileTool.Move(self)
    local missilePoint = Point(cj.GetUnitX(self.missile), cj.GetUnitY(self.missile))
    local x, y = missilePoint.x + _MOTIVATION * cos(self.angle), missilePoint.y + _MOTIVATION * sin(self.angle)
    cj.SetUnitPosition(self.missile, x, y)
    missilePoint:Remove()
end

-- missile_z用於修正預計高度，使視覺效果會是直線
function MissileTool.SetHeight(self, currentDistance)
    local slope, missile_z = _GetSlope(self)
    cj.UnitAddAbility(self.missile, Base.String2Id(_FLYSKILL_ID))
    cj.UnitRemoveAbility(self.missile, Base.String2Id(_FLYSKILL_ID))
    local height = self.startingHeight + currentDistance * slope - missile_z
    if height > 0 then
        cj.SetUnitFlyHeight(self.missile, height, 0.)
    else -- 如果投射物撞到牆，就把投射物刪除
        self:Remove()
    end
end

_GetSlope = function(self)
    local missileLoc, targetLoc = cj.GetUnitLoc(self.missile), cj.Location(self.targetPoint.x, self.targetPoint.y)
    local missilePoint = Point(cj.GetLocationX(missileLoc), cj.GetLocationY(missileLoc))
    local altitudeDifference = cj.GetLocationZ(targetLoc) - cj.GetLocationZ(missileLoc)
    local distance = Point.Distance(missilePoint, self.targetPoint)
    local missile_z = cj.GetLocationZ(missileLoc)
    cj.RemoveLocation(missileLoc)
    cj.RemoveLocation(targetLoc)
    missilePoint:Remove()
    return altitudeDifference / distance, missile_z
end

return MissileTool