-- 提供常用的軌跡函數

-- package
local Util = require 'mover.util'

local mod = {}

-- assert
local GetUnitLoc = require 'point'.GetUnitLoc

function mod.Line(self)
    -- 計算速度、加速度、位移
    self.motivation_ = Util.getMotivation(self.velocity_, self.acceleration_,
                                          self.velocity_max_, self.PERIOD, self.dur_)

    local missile_point = GetUnitLoc(self.mover_.object_)
    Util.Move(self.mover_, missile_point, self.motivation_, self.angle_)

    Util.Projectile(self)

    missile_point:Remove()
end

function mod.Parabola()
end

function mod.Surround(self)
    -- 這裡的angle_是角度不是弧度
    self.angle_ = self.angle_ + Util.getMotivation(self.velocity_, self.acceleration_,
                                                   self.velocity_max_, self.PERIOD, self.dur_)
    self.angle_ = self.angle_ % 360

    -- 移動投射物
    local unit_point = GetUnitLoc(self.owner_.object_)
    Util.Move(self.mover_, unit_point, self.radius_, self.angle_)

    Util.SetHeight(self, self.mover_, self.starting_height_)

    unit_point:Remove()
end

return mod