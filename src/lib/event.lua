-- 創建一個事件列表。在事件觸發時，會調用同一事件名的所有觸發器
-- 依賴
--   stl.array
--   trigger

local require = require
local Array = require 'util.stl.array'


local Event = {}
setmetatable(Event, Event)


local GetEvents, GetEvent

-- NOTE: 使用 .__call 會無法讀取event_name
-- callback第一個參數是trigger的實例，後面的參數才是自己加的
function Event:__call(object, event_name)
    if not object then
        return 
    end
    
    local Trigger = require 'lib.trigger'
    
    local events = GetEvents(object)
    local event = GetEvent(events, event_name)

    -- 直接幫對象添加事件調用函數，這樣就不用另外寫，除非要重載
    function object:eventDispatch(event_name, ...)
        return Event.dispatch(object, event_name, ...)
    end

    return function(callback)
        return Trigger(event, callback)
    end
end

-- 保證一定要回傳事件列表
GetEvents = function(object)
    local events = object.events
    if not events then
        events = Array()
        object.events = events
    end

    return events
end

-- 保證一定要回傳事件，而且可以直接操作事件把它從列表中刪除，不用特別去搜尋事件列表
GetEvent = function(events, event_name)
    local event = events[event_name]
    if not event then
        event = Array()
        events[event_name] = event

        function event:dispose()
            events:erase(self)
            self:remove()
        end
    end

    return event
end

-- 有回傳值
function Event.dispatch(object, event_name, ...)
    local events = object.events
    if not events then
        return
    end

    local event = events[event_name]
    if not event then
        return
    end

    for i = #event, 1, -1 do
        -- 不直接return是因為想要讓沒回傳值的觸發也能回傳nil，而不是空白
        local callback = event[i]:run(...)
        return callback
    end
end

return Event