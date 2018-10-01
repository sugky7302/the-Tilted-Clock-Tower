        local setmetatable = setmetatable
        local Stack = require 'stack'
        local cj = require 'jass.common'
        local Object = require 'object'
        local Timer = {}
        local mt = {}
        setmetatable(Timer, Timer)
        Timer.__index = mt
        Timer.recycleTimer = Stack("timer")
        local Run = nil
        function Timer:__call(timeout, isPeriod, execution)
            local obj = Object{
                timeout = timeout,
                isPeriod = isPeriod,
                execution = execution
            }
            setmetatable(obj, self)
            obj.__index = obj
            if Timer.recycleTimer:IsEmpty() then
                obj.object = cj.CreateTimer()
            else
                obj.object = Timer.recycleTimer.Top()
                Timer.recycleTimer.Pop()
            end
            Run(obj)
            return obj
        end
        Run = function(obj)
            cj.TimerStart(obj.object, obj.timeout, obj.isPeriod, obj.execution)
        end
        function mt:Pause()
            cj.PauseTimer(self.object)
        end
        function mt:Remove()
            self.timeout = nil
            self.isPeriod = nil
            self.execution = nil
            Timer.recycleTimer.Push(self.object)
            self.object = nil
            self = nil
        end
        return Timer
    