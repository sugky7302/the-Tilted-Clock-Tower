-- 投射物會用到的工具

local cj = require 'jass.common'
local Point = require 'point'

local MissileUtil = {}

-- constants
local ERROR_HEIGHT = 0.11

-- assert
local GetSlope3D

function MissileUtil.Move(self)
    local missile_point = Point(cj.GetUnitX(self.missile_.object_), cj.GetUnitY(self.missile_.object_))
    
    -- 讓投射物位移
    local sin, cos = math.sin, math.cos
    local x, y = missile_point.x_ + self.motivation_ * cos(self.angle_), missile_point.y_ + self.motivation_ * sin(self.angle_)
    cj.SetUnitPosition(self.missile_.object_, x, y)
    
    missile_point:Remove()
end

function MissileUtil.ComputeMotivation(self, period)
    local min = math.min
    local v_now = min(self.velocity_max_, self.velocity_ + self.acceleration_ * self._dur_)
    
    -- 達到最大速度等同沒有加速度，因此可以直接計算位移
    -- 未達最大速度，加速度會影響位移量
    if v_now == self.velocity_max_ then
        self.motivation_ = self.velocity_max_ * period
    else
        self.motivation_ = self.velocity_ * period + 0.5 * self.acceleration_
                           * (self._dur_^2 - (self._dur_ - period)^2)
    end    
end

function MissileUtil.SetHeight(self, current_distance)
    self.slope_ = self.slope_ or GetSlope3D(self)

    -- 添加烏鴉技能，使觸發可以更改投射物高度
    MissileUtil.Fly(self.missile_)
    
    -- 獲取投射物高度
    local missile_point = Point.GetUnitLoc(self.missile_.object_)
    missile_point:UpdateZ()

    -- 拋體運動，純粹計算拋物線
    local projectile_height = -4 * self.height_ / self.max_distance_^2
                              * (current_distance - self.max_distance_ / 2)^2
                              + self.height_

    -- 實際高度 = 高度誤差值 + 預估高度 - 當前投射物所在地面高度
    local height = ERROR_HEIGHT + self.starting_height_ + current_distance * self.slope_
                   + projectile_height - missile_point.z_

    if height > 0 then
        cj.SetUnitFlyHeight(self.missile_.object_, height, 0.)
    else
        -- 撞牆或山坡之類的障礙物則消失
        self:Remove()
    end

    missile_point:Remove()
end

GetSlope3D = function(self)
    -- 獲取高度
    self.starting_point_:UpdateZ()
    self.target_point_:UpdateZ()
    
    local z_difference = self.target_point_.z_ - self.starting_point_.z_
    local distance = Point.Distance(self.starting_point_, self.target_point_)

    return z_difference / distance
end

function MissileUtil.SetSurroundHeight(self)
    MissileUtil.Fly(self.missile_)

    if self.starting_height_ > 0 then
        cj.SetUnitFlyHeight(self.missile_, self.starting_height_, 0.)
    end
end

function MissileUtil.Fly(unit)
    local FLYSKILL_ID = 'Arav'

    unit:AddAbility(FLYSKILL_ID)
    unit:RemoveAbility(FLYSKILL_ID)
end

return MissileUtil