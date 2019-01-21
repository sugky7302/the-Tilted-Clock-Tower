-- 移動器會使用的常用工具

-- package
local cj = require 'jass.common'

local mod = {}

function mod.Move(target, p, dist, angle)
    -- 讓投射物位移
    local sin, cos, rad = math.sin, math.cos, math.rad
    local x_new, y_new = p.x_ + dist * cos(rad(angle)), p.y_ + dist * sin(rad(angle))
    cj.SetUnitPosition(target.object_, x_new, y_new)
end

-- 拋體運動
function mod.Projectile(self)
    local Point = require 'point'

    self.slope_ = self.slope_ or Point.SlopeInSpace(self.starting_point_, self.target_point_)
    
    -- 獲取投射物高度
    local missile_point = Point.GetUnitLoc(self.mover_.object_)
    missile_point:UpdateZ()

    -- 拋體運動，純粹計算拋物線
    local projectile_height = -4 * self.height_ / self.max_dist_^ 2
                              * (self.current_dist_ - self.max_dist_ / 2) ^ 2
                              + self.height_

    -- 實際高度 = 高度誤差值 + 預估高度 - 當前投射物所在地面高度
    local ERROR_HEIGHT = 0.11
    local height = self.starting_height_ + self.current_dist_ * self.slope_
                   + projectile_height - missile_point.z_ + ERROR_HEIGHT

    mod.SetHeight(self, self.mover_, height)

    missile_point:Remove()
end

function mod.SetHeight(self, unit, height)
    mod.Fly(unit)

    if height > 0 then
        cj.SetUnitFlyHeight(unit.object_, height, 0.)
    else
        -- 撞牆或山坡之類的障礙物則消失
        self:Remove()
    end
end

function mod.Fly(unit)
    local FLYSKILL_ID = 'Arav'

    unit:AddAbility(FLYSKILL_ID)
    unit:RemoveAbility(FLYSKILL_ID)
end

function mod.getMotivation(v, a, v_max, period, t)
    local min = math.min
    local v_now = min(v_max, v + a * t)
    
    -- 達到最大速度等同沒有加速度，因此可以直接計算位移
    -- 未達最大速度，加速度會影響位移量
    if v_now == v_max then
        return v_max * period
    else
        return v * period + 0.5 * a * (t^2 - (t - period)^2)
    end    
end

return mod