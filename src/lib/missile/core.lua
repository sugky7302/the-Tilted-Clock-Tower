-- 高擴展性的投射物，可自定義軌跡

local setmetatable = setmetatable

local Missile, mt = {}, {trace_lib = require 'missile.trace'}
setmetatable(Missile, Missile)
Missile.__index = mt

-- constants
local MOTIVATION= 30

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

--     angle(可選，trace_mode_ = surround使用)
--     radius(可選，trace_mode_ = surround使用)
--     starting_height_(可選，trace_mode_ = surround使用)
--     max_distance_

--     TraceMode
--     Execute(為group的loop函數，因此格式一定要遵照 function(group, i) 動作 end)
-- }
function Missile:__call(instance)
    setmetatable(instance, self)

    instance.starting_height_ = instance.starting_height_ or GetStartingHeight(instance.starting_point_)
    
    local Point = require 'point'
    instance.angle_ = instance.angle_ or Point.Rad(instance.starting_point_, instance.target_point_)

    instance.missile_ = GetMissile(instance)
    local Group = require 'group.core'
    instance.units_ = Group(instance.missile_.object_)

    local Util = require 'missile.util'
    instance.SetHeight = instance.SetHeight or Util.SetHeight
    instance:SetHeight(0)

    -- TraceMode可以用trace_lib的內建函數或自己寫
    -- 自己寫，請遵照 function(self) 動作 end 的格式
    instance.TraceMode = (type(instance.TraceMode) == "string") and mt.trace_lib[instance.TraceMode] or instance.TraceMode
    Move(instance)

    return instance
end

GetStartingHeight = function(starting_point)
    local  STANDARD_HEIGHT = 50

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
    local PERIOD, MOTIVATION, ENUM_RANGE = 0.03, 30, 50
    self.timer_ = Timer(PERIOD, true, function()
        -- 儲存當前移動距離
        current_distance = current_distance + MOTIVATION

        -- 設定投射物軌跡
        self:TraceMode()

        -- 根據地形起伏設定當前高度
        self:SetHeight(current_distance)

        self.units_:EnumUnitsInRange(cj.GetUnitX(self.missile_.object_), cj.GetUnitY(self.missile_.object_), ENUM_RANGE, "IsEnemy")
        if not self.units_:IsEmpty() then
            hit = hit + 1

            if self.Execute and type(self.Execute) == 'function' then
                self.units_:Loop(self.Execute)
            end
        end

        if IsEnd(self, current_distance, hit) then
print "end"
            self:Remove()
        end

        -- 清空單位組，不然先前保存的單位會一直存留，導致判定會失準
        self.units_:Clear()
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
