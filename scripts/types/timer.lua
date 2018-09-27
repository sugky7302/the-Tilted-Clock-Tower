local setmetatable = setmetatable
local stack = require 'stack'
local cj = require 'jass.common'

local Timer = {}
local mt = {}
setmetatable(Timer, Timer)
Timer.__index = mt

Timer.recycleTimer = stack("timer")

local Run = nil

function Timer:__call(timeout, isPeriod, execution)
    newObject = {
        timeout = timeout,
        isPeriod = isPeriod,
        execution = execution
    }
    setmetatable(newObject, self)
    newObject.__index = newObject

    if self.recycleTimer.IsEmpty() then
        newObject.object = cj.CreateTimer()
    else
        newObject.object = self.recycleTimer.Top()
        self.recycleTimer.Pop()
    end
    Run(newObject)

    return newObject
end

local function Run(newObject)
    cj.TimerStart(newObject.object, newObject.timeout, newObject.isPeriod, newObject.execution)
end

function Timer:Remove()
    self.timeout = nil
    self.isPeriod = nil
    self.execution = nil
    Timer.recycleTimer.Push(self.object)
    self.object = nil
    self = nil
end