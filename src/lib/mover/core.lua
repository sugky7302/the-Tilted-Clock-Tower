-- 可以操作任意單位進行固定軌跡的移動器

local setmetatable = setmetatable

local mod, mt = {}, {}
setmetatable(mod, mod)
mod.__index = mt

-- constant
mt.PERIOD = 0.03125

-- assert
local Move

-- instance = {
--     mover_:單位, 

--     starting_point_:起始點,
--     max_dist_:最遠距離。環繞軌跡不適用,

--     TraceMode:軌跡,
--     Execute:移動中執行的函數,
--     End_Cnd:中止條件,

--     可選
--     target_point_:終點，trace_mode_ = surround不使用,

--     velocity_:初速度，trace_mode_ ~= surround使用,
--     velocity_max_:最高速度，trace_mode_ ~= surround使用,
--     acceleration_:加速度,
--     height_:拋體運動最大高度,
--     angle_:射角。trace_mode_ = surround使用,
--     radius_:半徑。trace_mode_ = surround使用,
--     starting_height_:初始高度。trace_mode_ = surround使用,
-- }
function mod:__call(instance)
    setmetatable(instance, self)
    instance.__index = instance

    instance.dur_ = 0
    instance.current_dist_ = 0

    -- TraceMode可以用trace_lib的內建函數或自己寫
    -- 自己寫，請遵照 function(self) 動作 end 的格式
    local type = type
    local Trace = require 'mover.trace'
    instance.TraceMode = (type(instance.TraceMode) == "string") and Trace[instance.TraceMode] or instance.TraceMode
    
    Move(instance)    

    return instance
end

Move = function(self)
    local Timer = require 'timer.core'
    self.timer_ = Timer(mt.PERIOD, true ,function()
        -- 計算速度會用到
        self.dur_ = self.dur_ + mt.PERIOD

        self:TraceMode()

        if self.max_dist_ then
            self.current_dist_ = self.current_dist_ + self.motivation_
        end

        if self.Execute then
            self:Execute()
        end

        if self.max_dist_ and self.current_dist_ >= self.max_dist_ then
            self:Remove()
            return true
        end

        if self.End_Cnd and self:End_Cnd() then
            self:Remove()
            return true
        end
    end)
end

function mt:Remove()
    self.timer_:Break()

    if self.starting_point_ then
        self.starting_point_:Remove()
    end

    if self.target_point_ then
        self.target_point_:Remove()
    end

    local pairs = pairs
    for key in pairs(self) do 
        self[key] = nil
    end

    self = nil
end

return mod