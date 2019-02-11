-- 可以操作任意單位進行固定軌跡的移動器，資料所需如下:
-- 依賴
--   timer.core
--   mover.trace
--   point
-- 必選
--   mover_:單位
--   starting_loc_:起始點
--   TraceMode:軌跡
-- 可選
--   Execute:移動中執行的函數(不一定要用)
--   End_Cnd:中止條件(不一定要用)
--   target_point_:終點，trace_mode_ = surround不使用
--   max_dist_:最遠距離。trace_mode_ = surround不使用
--   velocity_:初速度
--   velocity_max_:最高速度
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
local Move, InitParams, SaveMoverInQueue

function Mover:_new(data)
    self:_copy(data)

    SaveMoverInQueue(self)

    -- TraceMode可以用內建軌跡函數或自己寫
    -- 自己寫，請遵照 function(self) 動作 end 的格式
    self.TraceMode = (type(self.TraceMode) == "string") and Mover[self.TraceMode] or self.TraceMode
    
    -- 輪到當前移動器才執行，不然不理
    -- 初始化要等到真正執行時才做，如果先做會導致存到聲明時的值，跟實際會有點出入
    if self.mover_.mover_queue_:front() == self then
        InitParams(self)
        Move(self)
    end
end

SaveMoverInQueue = function(self)
    if not self.mover_.mover_queue_ then
        local Queue = require 'stl.queue'
        self.mover_.mover_queue_ = Queue()
    end

    self.mover_.mover_queue_:PushBack(self)
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

        if self.timeout_ and self.dur_ >= self.timeout_ then
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

    self.starting_loc_:Remove()

    if self.target_loc_ then
        self.target_loc_:Remove()
    end

    -- 執行下一個移動器
    self.mover_.mover_queue_:PopFront()
    local next = self.mover_.mover_queue_:front()

    -- 初始化要等到真正執行時才做，如果先做會導致存到聲明時的值，跟實際會有點出入
    if next then
        InitParams(next)
        Move(next)
    end
end

InitParams = function(self)
    self.dur_ = 0
    self.current_dist_ = 0

    -- 移動速度，單位:距離/秒
    self.velocity_ = self.velocity_ or 300
    self.velocity_max_ = self.velocity_max_ or self.velocity_
    self.acceleration_ = self.acceleration_ or 0

    local Point = require 'point'
    self.starting_loc_ = Point.GetUnitLoc(self.mover_.object_)

    -- 對只設定地點的移動器解析成距離和角度，比較好判定
    if self.target_loc_ then
        self.max_dist_ = Point.Distance(self.starting_loc_, self.target_loc_)
        self.angle_ = Point.Deg(self.starting_loc_, self.target_loc_)
    end
end

return Mover