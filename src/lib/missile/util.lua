-- 投射物會用到的工具

local cj = require 'jass.common'
local Point = require 'point'

local MissileUtil = {}

-- assert
local GetSlope

function MissileUtil.Move(self)
    local missile_point = Point(cj.GetUnitX(self.missile_.object_), cj.GetUnitY(self.missile_.object_))
    
    -- 讓投射物位移
    local sin, cos = math.sin, math.cos
    local MOTIVATION = 30
    local x, y = missile_point.x_ + MOTIVATION * cos(self.angle_), missile_point.y_ + MOTIVATION * sin(self.angle_)
    cj.SetUnitPosition(self.missile_.object_, x, y)
    
    missile_point:Remove()
end

-- missile_z用於修正預計高度，使視覺效果會是直線
function MissileUtil.SetHeight(self, current_distance)
    local slope, missile_z = GetSlope(self)

    -- 添加烏鴉技能，使觸發可以更改投射物高度
    local FLYSKILL_ID = 'Arav'
    self.missile:AddAbility(FLYSKILL_ID)
    self.missile:RemoveAbility(FLYSKILL_ID)
    
    -- 實際高度 = 預估高度 - 當前投射物所在地面高度
    local height = self.starting_height_ + current_distance * slope - missile_z

    if height >= 0 then
        cj.SetUnitFlyHeight(self.missile_.object_, height, 0.)
    else
        -- 撞牆或山坡之類的障礙物則消失
        self:Remove()
    end
end

GetSlope = function(self)
    local missile_point = Point(cj.GetUnitX(self.missile_.object_), cj.GetUnitY(self.missile_.object_))

    -- 獲取高度
    missile_point:UpdateZ()
    self.target_point_:UpdateZ()
    
    local z_difference = self.target_point_.z_ - missile_point.z_
    local distance = Point.Distance(missile_point, self.target_point_)

    -- 暫存投射物當前地面高度
    local missile_z = missile_point.z_

    missile_point:Remove()

    return z_difference / distance, missile_z
end

return MissileUtil