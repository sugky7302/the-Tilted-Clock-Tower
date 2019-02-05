-- 可以操作任意單位進行固定軌跡的移動器，資料所需如下:
-- 依賴
--   timer.core
--   mover.trace
-- 必選
--   mover_:單位
--   starting_point_:起始點
--   TraceMode:軌跡
-- 可選
--   Execute:移動中執行的函數(不一定要用)
--   End_Cnd:中止條件(不一定要用)
--   target_point_:終點，trace_mode_ = surround不使用
--   max_dist_:最遠距離。trace_mode_ = surround不使用
--   velocity_:初速度，trace_mode_ ~= surround使用
--   velocity_max_:最高速度，trace_mode_ ~= surround使用
--   acceleration_:加速度
--   height_:拋體運動最大高度
--   angle_:射角。trace_mode_ = surround使用
--   radius_:半徑。trace_mode_ = surround使用
--   starting_height_:初始飛行高度。trace_mode_ = surround使用


local require = require 


local Mover = require 'class'("Mover", require 'mover.trace', require 'mover.util')

-- constant
Mover._VERSION = "1.1.0"
Mover.PERIOD = 0.03125

-- assert
local Move, InitParams

function Mover:_new(data)
    self:_copy(data)

    InitParams(self)

    -- TraceMode可以用trace_lib的內建函數或自己寫
    -- 自己寫，請遵照 function(self) 動作 end 的格式
    local Trace = require 'mover.trace'
    self.TraceMode = (type(self.TraceMode) == "string") and Trace[self.TraceMode] or self.TraceMode
    
    Move(self)    
end

InitParams = function(self)
    self.dur_ = 0
    self.current_dist_ = 0
end

Move = function(self)
    local Timer = require 'timer.core'

    self.timer_ = Timer(self.PERIOD, true ,function()
        -- 計算速度會用到
        self.dur_ = self.dur_ + self.PERIOD

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

function Mover:_delete()
    self.timer_:Break()

    if self.starting_point_ then
        self.starting_point_:Remove()
    end

    if self.target_point_ then
        self.target_point_:Remove()
    end
end

return Mover