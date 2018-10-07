local setmetatable = setmetatable
local Stack = require 'stack'
local cj = require 'jass.common'
local Object = require 'object'

local Timer = {}
local mt = {}
setmetatable(Timer, Timer)
Timer.__index = mt

-- variables
local _recycleTimer, _Run = Stack("timer")

function Timer:__call(timeout, isPeriod, execution)
    local obj = Object{
        timeout = timeout,
        isPeriod = isPeriod,
        execution = execution
    }
    setmetatable(obj, self)
    obj.__index = obj
    if _recycleTimer:IsEmpty() then
        obj.object = cj.CreateTimer()
    else
        obj.object = _recycleTimer.Top()
        _recycleTimer.Pop()
    end
    _Run(obj)
    return obj
end

_Run = function(obj)
    cj.TimerStart(obj.object, obj.timeout, obj.isPeriod, obj.execution)
end

function mt:Pause()
    cj.PauseTimer(self.object)
end

function mt:Remove()
    self:Pause()
    self.timeout = nil
    self.isPeriod = nil
    self.execution = nil
    _recycleTimer.Push(self.object)
    self.object = nil
    self = nil
end

return Timer