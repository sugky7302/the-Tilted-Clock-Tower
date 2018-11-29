-- 此module為註冊計時器動作

local setmetatable = setmetatable

local Timer, mt = {}, require 'timer.init'
setmetatable(Timer, Timer)
Timer.__index = mt

-- assert
local _Loop, _Wait, _Count, _RegisterTimerAction

function Timer:__call(timeout, is_period, execution)
    local max, floor = math.max, math.floor

    local instance = {
        timeout = max(floor(timeout / mt.PERIOD) or 1, 1), -- 這裡要把時間(秒)改成時間(幀)
        is_period = is_period,
        execution = execution,
        invalid = false,
        is_exec_registered = false
    }

    setmetatable(instance, self)

    _RegisterTimerAction(instance)

    return instance
end

_RegisterTimerAction = function(self)
    if self.is_period == false then
        _Wait(self)
        return true
    end
    
    local type = type
    if (type(self.is_period) == "number") and (self.is_period > 0) then
        _Count(self)
        return true
    end
    
    -- 如果週期設定成true或0，都視為循環觸發
    _Loop(self)
end

-- 單次計時器，因此不儲存timeout，讓_Wakeup能夠判斷是否循環
_Wait = function(self)
    local timeout = self.timeout
    self.timeout = nil
    mt.SetTimeout(self, timeout)
end

_Count = function(self)
    local execution = self.execution

    self.execution = function(self)
        self.is_period = self.is_period - 1

        execution(self)

        if self.is_period < 1 then
            self:Remove()
        end
    end

    mt.SetTimeout(self, self.timeout)
end

_Loop = function(self)
    mt.SetTimeout(self, self.timeout)
end

function mt:Remove()
    self:Pause()
    self.timeout = nil
    self.is_period = nil
    self.execution = nil
    self.invalid = nil
    self.is_exec_registered = nil
    self = nil
end

function mt:SetRemaining(timeout)
    if self.invalid == false then
        self:Pause()
    end

    mt.SetTimeout(self, timeout)
end

function mt:Pause()
    self.pause_remaining = self:GetRemaining()

    local queue = mt[self.end_frame]
    if queue then
        for i = #queue, 1, -1 do
            if queue[i] == self then -- 清除回調
                queue[i] = nil
                return 
            end
        end
    end
end

function mt:GetRemaining()
    if self.invalid then
        return 0
    end
    
    -- 在暫停的話，就回傳暫停秒數
    if self.pause_remaining then
        return self.pause_remaining
    end
    
    -- 如果正在執行動作，考慮是不是循環，給出時間
    if self.end_frame == mt.current_frame then
        return self.timeout or 0
    end
    
    return self.end_frame - mt.current_frame
end

function mt:Resume()
    if self.pause_remaining then
        mt.SetTimeout(self, self.pause_remaining)
        
        self.pause_remaining = false
    end
end

function mt:Break()
    self.invalid = true
end

return Timer