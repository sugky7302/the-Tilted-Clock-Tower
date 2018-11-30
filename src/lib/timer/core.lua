-- 此module為註冊計時器動作

local setmetatable = setmetatable

local Timer, mt = {}, require 'timer.init'
setmetatable(Timer, Timer)
Timer.__index = mt

-- assert
-- 創建計時器動作
local _Loop, _Wait, _Count, _RegisterTimerAction

-- 換算
local _getFrame

-- 獲取剩餘幀數
local _GetRemainingFrame

function Timer:__call(timeout, is_period, execution)
    local instance = {
        timeout_ = _getFrame(timeout),
        is_period_ = is_period,
        execution_ = execution,
        invalid_ = false,
        pause_remaining_ = false,
    }

    setmetatable(instance, self)

    _RegisterTimerAction(instance)

    return instance
end

_RegisterTimerAction = function(self)
    if self.is_period_ == false then
        _Wait(self)
        return true
    end
    
    local type = type
    if (type(self.is_period_) == "number") and (self.is_period_ > 0) then
        _Count(self)
        return true
    end
    
    -- 如果週期設定成true或0，都視為循環觸發
    _Loop(self)
    return true
end

-- 單次計時器，因此不儲存timeout，讓_Wakeup能夠判斷是否循環
_Wait = function(self)
    local timeout = self.timeout_
    self.timeout_ = nil
    mt.SetTimeout(self, timeout)
end

_Count = function(self)
    local execution = self.execution_

    self.execution_ = function(self)
        self.is_period_ = self.is_period_ - 1

        execution(self)

        if self.is_period_ < 1 then
            self:Remove()
        end
    end

    mt.SetTimeout(self, self.timeout_)
end

_Loop = function(self)
    mt.SetTimeout(self, self.timeout_)
end

function mt:Remove()
    self:Pause()
    self.timeout_ = nil
    self.is_period_ = nil
    self.execution_ = nil
    self.invalid_ = nil
    self.pause_remaining_ = nil
    self = nil
end

function mt:SetRemaining(timeout)
    if self.invalid_ == false then
        self:Pause()
    end

    local frame = _getFrame(timeout)
    mt.SetTimeout(self, frame)
end

-- 把時間(秒)轉成時間(幀)
_getFrame = function(timeout)
    local max, floor = math.max, math.floor
    
    local frame = max(floor(timeout / mt.PERIOD) or 1, 1)
    return frame
end

function mt:Pause()
    self.pause_remaining_ = _GetRemainingFrame(self)

    local queue = mt[self.end_frame_]
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
    local secs = _GetRemainingFrame(self) * mt.PERIOD
    return secs
end

_GetRemainingFrame = function(self)
    if self.invalid_ then
        return 0
    end
    
    -- 在暫停的話，就回傳暫停幀數
    if self.pause_remaining_ then
        return self.pause_remaining_
    end
    
    -- 如果正在執行動作，考慮是不是循環，給出時間
    if self.end_frame_ == mt.frame() then
        return self.timeout_ or 0
    end

    return self.end_frame_ - mt.frame()
end

function mt:Resume()
    if self.pause_remaining_ then
        mt.SetTimeout(self, self.pause_remaining_)
        
        self.pause_remaining_ = false
    end
end

function mt:Break()
    self.invalid_ = true
end

return Timer