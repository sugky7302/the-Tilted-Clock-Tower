-- 此module為註冊計時器動作

local setmetatable = setmetatable

local Timer, mt = {}, require 'timer.init'
setmetatable(Timer, Timer)
Timer.__index = mt

-- assert
-- 創建計時器動作
local Loop, Wait, Count, RegisterTimerAction

-- 換算
local getFrame

-- 獲取剩餘幀數
local GetRemainingFrame

function Timer:__call(timeout, is_period, execution)
    local instance = {
        timeout_ = getFrame(timeout),
        is_period_ = is_period,
        
        invalid_ = false,
        pause_remaining_ = false,
        
        Execute = execution,
    }

    setmetatable(instance, self)

    RegisterTimerAction(instance)

    return instance
end

RegisterTimerAction = function(self)
    if self.is_period_ == false then
        Wait(self)
        return true
    end
    
    local type = type
    if (type(self.is_period_) == "number") and (self.is_period_ > 0) then
        Count(self)
        return true
    end
    
    -- 如果週期設定成true或0，都視為循環觸發
    Loop(self)
    return true
end

-- 單次計時器，因此不儲存timeout，讓_Wakeup能夠判斷是否循環
Wait = function(self)
    local timeout = self.timeout_
    self.timeout_ = nil
    mt.SetTimeout(self, timeout)
end

Count = function(self)
    local execute = self.Execute

    self.Execute = function(self)
        self.is_period_ = self.is_period_ - 1

        execute(self)

        if self.is_period_ < 1 then
            self:Remove()
        end
    end

    mt.SetTimeout(self, self.timeout_)
end

Loop = function(self)
    mt.SetTimeout(self, self.timeout_)
end

function mt:Remove()
    self:Pause()
    self.timeout_ = nil
    self.is_period_ = nil
    self.Execute = nil
    self.invalid_ = nil
    self.pause_remaining_ = nil
    self = nil
end

function mt:SetRemaining(timeout)
    if self.invalid_ == false then
        self:Pause()
    end

    local frame = getFrame(timeout)
    mt.SetTimeout(self, frame)
end

-- 把時間(秒)轉成時間(幀)
getFrame = function(timeout)
    local max, floor = math.max, math.floor
    
    local frame = max(floor(timeout / mt.PERIOD) or 1, 1)
    return frame
end

function mt:Pause()
    self.pause_remaining_ = GetRemainingFrame(self)

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
    local secs = GetRemainingFrame(self) * mt.PERIOD
    return secs
end

GetRemainingFrame = function(self)
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