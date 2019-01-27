-- 創建一個事件列表。在事件觸發時，會調用同一事件名的所有觸發器

-- package
local require = require
local Array = require 'stl.array'

local Event = {}
setmetatable(Event, Event)

-- assert
local GetEvents, GetEvent

-- NOTE: 使用 .__call 會無法讀取eventName
-- callback第一個參數是trigger的實例，後面的參數才是自己加的
function Event:__call(class, event_name) 
    local Trigger = require 'trigger'
    
    local events = GetEvents(class)
    local event = GetEvent(events, event_name)

    return function(callback)
        return Trigger(event, callback)
    end
end

GetEvents = function(class)
    local events = class.events
    if not events then
        events = Array()
        class.events = events
    end

    return events
end

GetEvent = function(events, event_name)
    local event = events[event_name]
    if not event then
        event = Array()
        events[event_name] = event

        function event:Remove()
            events:Delete(event)
        end
    end

    return event
end

-- 有回傳值
function Event.Dispatch(class, event_name, ...)
    local events = class.events
    if not events then
        return false
    end

    local event = events[event_name]
    if not event then
        return false
    end

    for i = #event, 1, -1 do
        local callback = event[i]:Run(...)

        -- 如果寫"if callback then"的話會沒辦法回傳"false"
        if callback ~= nil then
            return callback
        end
    end
end

-- NOTE: 預留不用
-- 沒有回傳值
function Event.Notify(class, event_name, ...)
    local events = class.events
    if not events then
        return
    end

    local event = events[event_name]
    if not event then
        return
    end

    for i = #event, 1, -1 do
        event[i]:Run(...)
    end
end

return Event