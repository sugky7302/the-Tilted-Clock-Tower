-- 高擴展性的投射物，可自定義軌跡

local setmetatable = setmetatable

-- package
local Point = require 'point'
local Util = require 'missile.util'

local Missile, mt = {}, {trace_lib = require 'missile.trace'}
setmetatable(Missile, Missile)
Missile.__index = mt

-- constant
mt.PERIOD = 0.03

-- assert
local type = type
local GetMissile, GetStartingHeight
local Move, IsEnd

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
--     max_distance_

--     SetHeight(可選，trace_mode_ = surround使用)
--     TraceMode
--     Execute(可選，為group的loop函數，格式一定要遵照 function(group, i, ...) 動作 end)
-- }
function Missile:__call(instance)
    setmetatable(instance, self)

    -- 設定位移量
    instance.velocity_max_ = instance.velocity_max_ or instance.velocity_
    instance.acceleration_ = instance.acceleration_ or 0

    -- 設定拋體運動
    instance._dur_ = 0
    instance.height_ = instance.height_ or 0

    instance.angle_ = instance.angle_ or Point.Rad(instance.starting_point_, instance.target_point_)

    instance.missile_ = GetMissile(instance)
    
    local Group = require 'group.core'
    instance.units_ = Group(instance.missile_.object_)

    instance.starting_height_ = instance.starting_height_ or GetStartingHeight(instance.starting_point_)
    
    -- 添加烏鴉技能，使觸發可以更改投射物高度
    local SetUnitFlyHeight = require 'jass.common'.SetUnitFlyHeight
    Util.Fly(instance.missile_)
    SetUnitFlyHeight(instance.missile_.object_, instance.starting_height_, 0.)

    if not instance.SetHeight then
        instance.SetHeight = Util.SetHeight
    elseif type(instance.SetHeight) == 'string' then
        instance.SetHeight = Util[instance.SetHeight]
    end

    instance:SetHeight(0)

    -- TraceMode可以用trace_lib的內建函數或自己寫
    -- 自己寫，請遵照 function(self) 動作 end 的格式
    instance.TraceMode = (type(instance.TraceMode) == "string") and mt.trace_lib[instance.TraceMode] or instance.TraceMode
    Move(instance)

    return instance
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

Move = function(self)
    local current_distance, hit = 0, 0

    local Timer = require 'timer.core'
    local cj    = require 'jass.common'

    local PERIOD, ENUM_RANGE = 0.03, 50
    self.timer_ = Timer(PERIOD, true, function()
        -- 計算速度會用到
        self._dur_ = self._dur_ + PERIOD

        -- 計算速度、加速度、位移
        Util.ComputeMotivation(self, PERIOD)

        -- 儲存當前移動距離
        current_distance = current_distance + self.motivation_

        -- 設定投射物軌跡
        self:TraceMode()

        -- 根據地形起伏設定當前高度
        self:SetHeight(current_distance)

        -- Remove後計時器還會動作，但group裡的units_已經被清除了，因此要防止它調用units_
        if self.units_.units_ then
            self.units_:EnumUnitsInRange(cj.GetUnitX(self.missile_.object_), cj.GetUnitY(self.missile_.object_), ENUM_RANGE, "IsEnemy")

            -- 計算投射物在z軸會不會撞到單位
            self.units_:Loop(function(instance, i)
                local p_missile = Point.GetUnitLoc(self.missile_.object_)
                local p_u = Point.GetUnitLoc(instance.units_[i])
            
                p_missile:UpdateZ()
                p_u:UpdateZ()
            
                if p_missile.z_ + cj.GetUnitFlyHeight(self.missile_.object_)
                   - p_u.z_ - cj.GetUnitFlyHeight(instance.units_[i]) - STANDARD_HEIGHT
                   > ENUM_RANGE then
                    instance:RemoveUnit(instance.units_[i])
                end
            end)

            if not self.units_:IsEmpty() then
                hit = hit + 1

                if self.Execute then
                    self.units_:Loop(self.Execute)
                end
            end

            -- 清空單位組，不然先前保存的單位會一直存留，導致判定會失準
            self.units_:Clear()
        end

        if IsEnd(self, current_distance, hit) then
            self:Remove()
        end
    end)
end

IsEnd = function(self, current_distance, hit)
    if current_distance >= self.max_distance_ then
        return true
    end

    -- 擊中超過目標值就停止
    if type(self.hit_mode_) == 'number' and hit >= self.hit_mode_ then
        return true
    end

    return false
end

function mt:Remove()
    -- 回傳任務完成
    if self.handle_ then
        local TaskTracker = require 'task_tracker'
        TaskTracker.finish(self.handle_)
    end

    self.missile_:Remove()
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

return Missile
