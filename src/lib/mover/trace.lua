-- 提供常用的軌跡函數
-- 依賴
--   mover.util
--   point


-- package
local require = require
local Util = require 'mover.util'


local mod = {}

-- assert
local GetUnitLoc = require 'point'.GetUnitLoc

function mod.StraightLine(self)
    -- 計算速度、加速度、位移
    self.motivation_ = Util.getMotivation(self.velocity_, self.acceleration_,
                                          self.velocity_max_, self.PERIOD, self.dur_)

    local missile_point = GetUnitLoc(self.mover_.object_)
    Util.Move(self.mover_, missile_point, self.motivation_, self.angle_)

    -- 有拋體運動才執行
    if self.height_ then
        Util.Projectile(self)
    end

    missile_point:Remove()
end

function mod.Parabola()
end

function mod.Surround(self)
    if not self.angle_ then
        local Rand = require 'math_lib'.Random
        self.angle_ = Rand(0, 359)
    end

    -- 這裡的angle_是角度不是弧度
    self.angle_ = self.angle_ + Util.getMotivation(self.velocity_, self.acceleration_,
                                                   self.velocity_max_, self.PERIOD, self.dur_)
    self.angle_ = self.angle_ % 360
    
    -- 移動投射物
    Util.Move(self.mover_, self.starting_loc_, self.radius_, self.angle_)
end

return mod