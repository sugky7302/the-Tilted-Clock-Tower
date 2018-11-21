local setmetatable = setmetatable
local Trigger = require 'trigger'
local Array = require 'array'

local Event = {}
setmetatable(Event, Event)

-- variables
local _RegisterEvent, _GetEvents, _GetEvent

function Event:__call(obj, eventName) -- 使用 .__call 會無法讀取eventName
    return _RegisterEvent(obj, eventName)
end

_RegisterEvent = function(obj, eventName)
    local events = _GetEvents(obj)
    local event = _GetEvent(events, eventName)
    return function(callback)
        return Trigger(event, callback)
    end
end

_GetEvents = function(obj)
    local events = obj.events
    if not events then
        events = Array("event")
        obj.events = events
    end
    return events
end

_GetEvent = function(events, eventName)
    local event = events[eventName]
    if not event then
        event = Array("callback")
        events[eventName] = event
        function event:Remove()
            events:Erase(event)
        end
    end
    return event
end

function Event.Dispatch(self, eventName, ...)
    local events = self.events
    if not events then
        return false
    end
    local event = events[eventName]
    if not event then
        return false
    end
    for i = #event, 1, -1 do
        local callback = event[i]:Run(...)
        if callback ~= nil then
            return callback
        end
    end
end

-- TODO: 預留不用
function Event.Notify(self, eventName, ...)
    local events = self.events
    if not events then
        return
    end
    local event = events[eventName]
    if not event then
        return
    end
    for i = #event, 1, -1 do
        event[i]:Run(...)
    end
end

return Event