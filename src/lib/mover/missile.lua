-- 高擴展性的投射物，可自定義軌跡
-- 依賴
--   point
--   mover.util
--   jass.common
--   mover.core
--   group.core
--   unit.core
--   task_tracker
-- 必選
--   owner_
--   model_name_
--   starting_point_
--   velocity_
--   TraceMode
--   hit_mode_ = 1 2 3 or inf:數字表示擊中數達此值即停止，inf表示到最大距離才停止
-- 可選
--   target_point_:目標點，trace_mode_ = surround不使用
--   velocity_max_:最大速度，trace_mode_ ~= surround使用
--   acceleration_:加速度
--   max_height_:拋體運動最大高度
--   angle_:角度，trace_mode_ = surround使用
--   radius_:半徑，trace_mode_ = surround使用
--   starting_height_:，trace_mode_ = surround使用
--   max_dist_:最遠距離
--   SetHeight(可選，trace_mode_ = surround使用)
--   GroupExecute(可選，為group的loop函數，格式一定要遵照 function(group, i, ...) 動作 end)


-- package
local require = require
local Point = require 'point'
local Util = require 'mover.util'
local cj = require 'jass.common'


-- assert
local type = type
local GetMissile, GetStartingHeight
local InitFuncs, InitParams

local function Missile(instance)
    InitParams(instance)
    InitFuncs(instance)
    
    -- 添加烏鴉技能，使觸發可以更改投射物高度
    Util.Fly(instance.mover_)
    cj.SetUnitFlyHeight(instance.mover_.object_, instance.starting_height_, 0.)

    local Mover = require 'mover.core'
    return Mover(instance)
end

InitParams = function(self)
    -- 設定位移量
    self.velocity_max_ = self.velocity_max_ or self.velocity_
    self.acceleration_ = self.acceleration_ or 0

    -- 投射物的選取範圍
    self.enum_range_ = self.enum_range_ or 50

    -- 設定拋體運動
    self.height_ = self.height_ or 0 -- 最高高度

    self.angle_ = self.angle_ or Point.Deg(self.starting_point_, self.target_point_)

    self.mover_ = GetMissile(self)
    
    local Group = require 'group.core'
    self.units_ = Group(self.mover_.object_)

    self.starting_height_ = GetStartingHeight(self.starting_point_) -- 從地面開始計算的高度
end

-- assert
local STANDARD_HEIGHT = 50

GetStartingHeight = function(starting_point)
    starting_point:UpdateZ()
    return starting_point.z_ + STANDARD_HEIGHT
end

GetMissile = function(self)
    local Unit = require 'unit.core'
    local MISSILE_ID = 'u007'
    local missile = Unit(Unit.Create(cj.GetOwningPlayer(self.owner_.object_), MISSILE_ID, self.starting_point_,
                                cj.GetUnitFacing(self.owner_.object_)))

    -- 投射物本身沒有模型，必須添加以 球體 為模板的技能，其綁定模型
    missile:AddAbility(self.model_name_)
    
    return missile
end

InitFuncs = function(instance)
    local hit = 0

    instance.Execute = function(self)
        -- NOTE: Remove後計時器還會動作，但group裡的units_已經被清除了，因此要防止它調用units_
        if self.units_.units_ then
            self.units_:EnumUnitsInRange(cj.GetUnitX(self.mover_.object_), cj.GetUnitY(self.mover_.object_),
                                         self.enum_range_, "IsEnemy")
    
            -- 計算投射物在z軸會不會撞到單位
            self.units_:Loop(function(instance, i)
                local p_missile = Point.GetUnitLoc(self.mover_.object_)
                local p_u = Point.GetUnitLoc(instance.units_[i])
                
                p_missile:UpdateZ()
                p_u:UpdateZ()
                
                local mover_height = p_missile.z_ + cj.GetUnitFlyHeight(self.mover_.object_) -- 投射物的高度(從地面計算)
                local unit_height = p_u.z_ + cj.GetUnitFlyHeight(instance.units_[i]) -- 目標單位的高度(從地面計算)
                local height = mover_height - unit_height - STANDARD_HEIGHT -- 
                if height > self.enum_range_ then
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
