-- 提供常用的軌跡函數

-- package
local Util = require 'missile.util'

local TraceLib = {}

function TraceLib.StraightLine(self)
    Util.Move(self)
end

function TraceLib.ArcLine()
end

function TraceLib.Parabola()
end

function TraceLib.Surround(self)
    local cos, sin, rad = math.cos, math.sin, math.rad
    local GetUnitLoc = require 'point'.GetUnitLoc
    local SetUnitPosition = require 'jass.common'.SetUnitPosition

    -- 防止終止條件成立
    self.max_distance_ = self.max_distance_ + self.motivation_ + 1

    -- 這裡的angle_是角度不是弧度
    self.angle_ = self.angle_ + self.velocity_

    -- 移動投射物
    local unit_point = GetUnitLoc(self.owner_.object_)
    local x = unit_point.x_ + self.radius_ * cos(rad(self.angle_))
    local y = unit_point.y_ + self.radius_ * sin(rad(self.angle_))
    SetUnitPosition(self.missile_.object_, x, y)

    unit_point:Remove()
end

return TraceLib