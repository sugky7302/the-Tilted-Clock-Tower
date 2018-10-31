local MissileTool = require 'missile_tool'

local TraceLib = {}

function TraceLib.StraightLine(self)
    MissileTool.Move(self)
end

function TraceLib.ArcLine()
end

function TraceLib.Parabola()
end

function TraceLib.Surround(self)
    local math = math
    local Point = require 'point'
    local cj = require 'jass.common'

    self.maxDistance = self.maxDistance + 31 -- 防止終止條件成立
    self.angle = self.angle + 5
    local unitPoint = Point:GetUnitLoc(self.owner.object)
    local x, y = unitPoint.x + self.radius * math.cos(math.rad(self.angle)), unitPoint.y + self.radius * math.sin(math.rad(self.angle))
    cj.SetUnitPosition(self.missile, x, y)
    unitPoint:Remove()
end

return TraceLib