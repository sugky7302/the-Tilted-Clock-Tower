-- 高擴展性的投射物，可自定義軌跡

-- package
local Point = require 'point'
local Util = require 'mover.util'

-- assert
local type = type
local GetMissile, GetStartingHeight
local InitFuncs, InitParams

-- instance = {
--     owner_
--     model_name_
--     hit_mode_ = 1 2 3 or inf:數字表示擊中數達此值即停止，inf表示到最大距離才停止

--     starting_point_
--     target_point_(trace_mode_ = surround不使用)

--     velocity_(可選，trace_mode_ ~= surround使用)
--     velocity_max_(可選，trace_mode_ ~= surround使用)
--     acceleration_
--     theta_(拋體與直線彈道的夾角)
--     angle_(可選，trace_mode_ = surround使用)
--     radius_(可選，trace_mode_ = surround使用)
--     starting_height_(可選，trace_mode_ = surround使用)
--     max_dist_

--     SetHeight(可選，trace_mode_ = surround使用)
--     TraceMode
--     GroupExecute(可選，為group的loop函數，格式一定要遵照 function(group, i, ...) 動作 end)
-- }
local function Missile(instance)
    InitParams(instance)
    InitFuncs(instance)
    
    -- 添加烏鴉技能，使觸發可以更改投射物高度
    local SetUnitFlyHeight = require 'jass.common'.SetUnitFlyHeight
    Util.Fly(instance.mover_)
    SetUnitFlyHeight(instance.mover_.object_, instance.starting_height_, 0.)

    local Mover = require 'mover.core'
    return Mover(instance)
end

InitParams = function(self)
    -- 設定位移量
    self.velocity_max_ = self.velocity_max_ or self.velocity_
    self.acceleration_ = self.acceleration_ or 0

    -- 設定拋體運動
    self.height_ = self.height_ or 0 -- 最高高度

    self.angle_ = self.angle_ or Point.Deg(self.starting_point_, self.target_point_)

    self.mover_ = GetMissile(self)
    
    local Group = require 'group.core'
    self.units_ = Group(self.mover_.object_)

    self.starting_height_ = self.starting_height_ or GetStartingHeight(self.starting_point_)
end

-- assert
local STANDARD_HEIGHT = 50

GetStartingHeight = function(starting_point)
    starting_point:UpdateZ()
    return starting_point.z_ + STANDARD_HEIGHT
end

GetMissile = function(self)
    local Pet = require 'unit.pet'
    local MISSILE_ID = 'u007'
    local missile = Pet.Create(MISSILE_ID, self.owner_, self.starting_point_)
    
    -- 投射物本身沒有模型，必須添加以 球體 為模板的技能，其綁定模型
    missile:AddAbility(self.model_name_)
    
    return missile
end

InitFuncs = function(instance)
    local cj = require 'jass.common'
    local hit = 0
    local ENUM_RANGE = 50
    instance.Execute = function(self)
        -- Remove後計時器還會動作，但group裡的units_已經被清除了，因此要防止它調用units_
        if self.units_.units_ then
            self.units_:EnumUnitsInRange(cj.GetUnitX(self.mover_.object_), cj.GetUnitY(self.mover_.object_), ENUM_RANGE, "IsEnemy")
    
            -- 計算投射物在z軸會不會撞到單位
            self.units_:Loop(function(instance, i)
                local p_missile = Point.GetUnitLoc(self.mover_.object_)
                local p_u = Point.GetUnitLoc(instance.units_[i])
                
                p_missile:UpdateZ()
                p_u:UpdateZ()
                
                if p_missile.z_ + cj.GetUnitFlyHeight(self.mover_.object_)
                    - p_u.z_ - cj.GetUnitFlyHeight(instance.units_[i]) - STANDARD_HEIGHT
                    > ENUM_RANGE then
                    instance:RemoveUnit(instance.units_[i])
                end

                p_missile:Remove()
                p_u:Remove()
            end)   

            if not self.units_:IsEmpty() then
                hit = hit + 1
    
                if self.GroupExecute then
                    self.units_:Loop(self.GroupExecute)
                end
            end
    
            -- 清空單位組，不然先前保存的單位會一直存留，導致判定會失準
            self.units_:Clear()
        end
    end
    
    instance.End_Cnd = function(self)
        -- 擊中超過目標值就停止
        if type(self.hit_mode_) == 'number' and hit >= self.hit_mode_ then
            print "1"
            return true
        end
    
        return false
    end
    
    instance.Remove = function(self)
        -- 回傳任務完成
        if self.handle_ then
            local TaskTracker = require 'task_tracker'
            TaskTracker.finish(self.handle_)
        end
    
        self.mover_:Remove()
        self.timer_:Break()
    
        if self.starting_point_ then
            self.starting_point_:Remove()
        end
    
        if self.target_point_ then
            self.target_point_:Remove()
        end
    
        self.units_:Remove()
    
        self = nil
    end
end

return Missile
