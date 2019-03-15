-- 此module為註冊計時器動作
-- 依賴
--   class
--   timer.init


local require = require

local Timer = require 'class'("Timer", require 'timer.init')

-- assert
-- 創建計時器動作
local Loop, Wait, Count, RegisterTimerAction

-- 換算
local getFrame

-- 獲取剩餘幀數
local GetRemainingFrame

function Timer:_new(timeout, is_period, execution)
    self.timeout_ = getFrame(timeout)
    self.is_period_ = is_period
        
    self.invalid_ = false
    self.pause_remaining_ = false
        
    self.Execute = execution

    RegisterTimerAction(self)
end

RegisterTimerAction = function(self)
    if self.is_period_ == false then
        Wait(self)
        return true
    end
    
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
    self:SetTimeout(timeout)
end

Count = function(self)
    local execute = self.Execute

    self.Execute = function(self)
        self.is_period_ = self.is_period_ - 1

        execute(self)

        if self.is_period_ < 1 then
            self:Break()
        end
    end

    self:SetTimeout(self.timeout_)
end

Loop = function(self)
    self:SetTimeout(self.timeout_)
end

function Timer:_delete()
    self:Pause()
end

function Timer:SetRemaining(timeout)
    if self.invalid_ == false then
        self:Pause()
    end

    local frame = getFrame(timeout)
    self:SetTimeout(frame)
end

-- 把時間(秒)轉成時間(幀)
getFrame = function(timeout)
    local math = math
    
    local frame = math.max(math.floor(timeout / Timer.PERIOD) or 1, 1)
    return frame
end

function Timer:Pause()
    self.pause_remaining_ = GetRemainingFrame(self)

    local queue = Timer[self.end_frame_]
    if queue then
        for i = #queue, 1, -1 do
            if queue[i] == self then -- 清除回調
                queue[i] = nil
                return true
            end
        end
    end
end

function Timer:GetRemaining()
    local secs = GetRemainingFrame(self) * Timer.PERIOD
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
    if self.end_frame_ == Timer.frame() then
        return self.timeout_ or 0
    end

    return self.end_frame_ - Timer.frame()
end

function Timer:Resume()
    if self.pause_remaining_ then
        self:SetTimeout(self.pause_remaining_)
        
        self.pause_remaining_ = false
    end
end

function Timer:Break()
    self.invalid_ = true
end

return Timer