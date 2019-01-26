-- 創建自定義觸發器，打破we_trigger的侷限

local Trigger = require 'class'("Trigger")

-- default
Trigger._enable_flag_ = true 

function Trigger:_new(event, callback)
    self.event_ = event or nil
    self.callback_ = callback

    -- 把trigger放入事件列表裡，在事件被調用時，統一執行
    if self.event_ then
        self.event_[#self.event_ + 1] = self
    end
end

function Trigger:_delete()
    if not self.event_ then
        return true
    end

    -- 清除且暫存給0秒計時器使用
    -- 把event的引用複製一份，在做刪除的時候才不會報錯
    local event = self.event_
    self.event_ = nil

    local Timer = require 'timer.core'
    Timer(0, false, function()
        for i, trg in ipairs(event) do
            if trg == self then
                event[i] = nil
                return true
            end
        end
    end)
end

function Trigger:Run(...)
    if self._enable_flag_ then
        -- 這樣設計是因為怕有返回值
        return self:callback_(...)
    end

    return false
end

-- 操作私有成員變量
function Trigger:disable()
    self._enable_flag_ = false
end

function Trigger:enable()
    self._enable_flag_ = true
end

function Trigger:isEnable()
    return self._enable_flag_
end

return Trigger