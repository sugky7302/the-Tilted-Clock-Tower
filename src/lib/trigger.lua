-- 此module為創建自定義觸發器，打破we_trigger的侷限

local setmetatable = setmetatable

local Trigger, mt = {}, {}
setmetatable(Trigger, Trigger)
Trigger.__index = mt

-- assert
local _FlushMemberVar

function Trigger:__call(event, callback)
    local instance = {
        _enable_flag_ = true,
        
        event_ = event or nil,
        callback_ = callback,
    }

    -- 把trigger放入事件列表裡，在事件被調用時，統一執行
    if event then
        event[#event + 1] = instance
    end

    setmetatable(instance, self)

    return instance
end

function mt:Remove()
    --
    if not self.event then
        _FlushMemberVar(self)
        return 
    end

    -- 清除且暫存給0秒計時器使用
    local event = self.event
    self.event = nil

    local Timer = require 'timer.core'
    Timer(0, false, function()
        local ipairs = ipairs

        for i, trg in ipairs(event) do
            if trg == self then
                event[i] = nil
                _FlushMemberVar(self)
                return 
            end
        end
    end)
end

_FlushMemberVar = function(self)
    self._enable_flag_ = nil
    self.event_ = nil
    self.callback_ = nil
    self = nil
end

function mt:disable()
    self._enable_flag_ = false
end

function mt:enable()
    self._enable_flag_ = true
end

function mt:IsEnable()
    return self._enable_flag_
end

function mt:Run(...)
    if self._enable_flag_ then
        -- 這樣設計是因為怕有返回值
        return self:callback_(...)
    end

    return false
end

return Trigger