--package
local Timer = require 'timer.core'

-- assert
local RemoveTimer, CreateTimer

require 'buff.core'.Register("剩餘時間", {
    set = function(self, timeout)
        if timeout < 0 then
            return false
        end

        self.timeout_ = timeout
        self.begin_timestep_ = Timer.clock()
    
        -- 重置計時器
        RemoveTimer(self.timer_)
        CreateTimer(self)
    end,

    get = function(self)
        if self.begin_timestep_ then 
            return self.timeout_ + self.begin_timestep_ - Timer.clock()
        end
    
        return 0
    end
})

RemoveTimer = function(timer)
    if timer then
        timer:Remove()
    end
end

CreateTimer = function(self)
    if self.pulse_ then
        self.timer_ = Timer(self.pulse_, self.timeout_ / self.pulse_, function(callback)
            if not self.target_ then
                self:Delete()
                return true
            end
            
            self:EventDispatch "狀態-週期"

            if callback.is_period_ < 1 then
                self:EventDispatch "狀態-結束"
                self:Delete()
            end
        end)
    else
        self.timer_ = Timer(self.timeout_, false, function()
            self:EventDispatch "狀態-結束"
            self:Delete()
        end)
    end
end