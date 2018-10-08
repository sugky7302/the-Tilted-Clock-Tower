local setmetatable = setmetatable
local Stack = require 'stack'
local cj = require 'jass.common'
local Object = require 'object'

local Timer = {}
local mt = {}
setmetatable(Timer, Timer)
Timer.__index = mt

-- variables
local _recycleTimer, _GetTimer, _Run = Stack("timer")

function Timer:__call(timeout, isPeriod, execution)
    local obj = Object{
        timeout = timeout,
        isPeriod = isPeriod,
        execution = execution
    }
    setmetatable(obj, self)
    obj.__index = obj
    obj.timer = _GetTimer()
    _Run(obj)
    return obj
end

_GetTimer = function()
    if _recycleTimer:IsEmpty() then
        return cj.CreateTimer()
    else
        local timer = _recycleTimer.Top()
        _recycleTimer.Pop()
        return timer
    end
end

_Run = function(obj)
    cj.TimerStart(obj.timer, obj.timeout, obj.isPeriod, obj.execution)
end

function mt:Pause()
    cj.PauseTimer(self.timer)
end

function mt:Remove()
    self:Pause()
    _recycleTimer:Push(self.timer)
    self.timer = nil
    self = nil
end

return Timer