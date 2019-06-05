-- 創建自定義觸發器，打破we_trigger的侷限
-- 依賴
--   class


local Trigger = require 'util.class'("Trigger")


Trigger._enable_flag_ = true 

function Trigger:_new(event, callback)
    local this = {
        event_ = event or nil,
        callback_ = callback
    }

    -- 把trigger放入事件列表裡，在事件被調用時，統一執行
    if this.event_ then
        this.event_[#this.event_ + 1] = this
    end

    return this
end

function Trigger:_delete()
    if not self.event_ then
        return
    end

    self.event_:erase(self)
end

function Trigger:run(...)
    if self._enable_flag_ then
        -- 這樣設計是因為怕有返回值
        return self:callback_(...)
    end
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