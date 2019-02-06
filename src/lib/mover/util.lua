-- 移動器會使用的常用工具
-- 依賴
--   point
--   jass.common


-- package
local require = require
local cj = require 'jass.common'
local math = math


local Util = {}

function Util.Move(target, p, dist, angle)
    -- 讓投射物位移
    local x_new, y_new = p.x_ + dist * math.cos(math.rad(angle)), p.y_ + dist * math.sin(math.rad(angle))
    cj.SetUnitPosition(target.object_, x_new, y_new)
end

-- 拋體運動
function Util.Projectile(self)
    local Point = require 'point'

    self.slope_ = self.slope_ or Point.SlopeInSpace(self.starting_loc_, self.target_loc_)
    
    -- 獲取投射物高度
    local missile_point = Point.GetUnitLoc(self.mover_.object_)
    missile_point:UpdateZ()

    -- 拋體運動，純粹計算拋物線
    local projectile_height = -4 * self.height_ / self.max_dist_^ 2
                              * (self.current_dist_ - self.max_dist_ / 2) ^ 2
                              + self.height_

    -- 實際高度 = 高度誤差值 + 預估高度 - 當前投射物所在地面高度
    local height = self.starting_height_ + self.current_dist_ * self.slope_
                   + projectile_height - missile_point.z_

    Util.SetHeight(self, self.mover_, height)

    missile_point:Remove()
end

function Util.SetHeight(self, unit, height)
    local ERROR_HEIGHT = 0.11
    height = height + ERROR_HEIGHT

    Util.Fly(unit)

    if height > 0 then
        cj.SetUnitFlyHeight(unit.object_, height, 0.)
    else
        -- 撞牆或山坡之類的障礙物則消失
        self:Remove()
    end
end

function Util.Fly(unit)
    local FLYSKILL_ID = 'Arav'

    unit:AddAbility(FLYSKILL_ID)
    unit:RemoveAbility(FLYSKILL_ID)
end

function Util.getMotivation(v, a, v_max, period, t)
    local v_now = math.min(v_max, v + a * t)
    
    -- 達到最大速度等同沒有加速度，因此可以直接計算位移
    -- 未達最大速度，加速度會影響位移量
    if v_now == v_max then
        return v_max * period
    else
        return v * period + 0.5 * a * (t^2 - (t - period)^2)
    end    
end

return Util