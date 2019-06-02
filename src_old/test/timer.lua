-- 要進到遊戲內，計時器才會啟動

local function TimerTest()
    local _Init = require 'timer.init'.Init
    local Timer = require 'timer.core'

    _Init()

    local start_time = os.clock()
    local timer = Timer(5, false, function(callback)
        print "Hello world."
        local end_time = os.clock()
        print(end_time - start_time)
    end)

    timer:SetRemaining(15)

    local start_time1 = os.clock()
    local timer1 = Timer(1, 5, function(callback)
        local end_time = os.clock()
        print(end_time - start_time1)
    end)

    print(table.concat({"remaining = ", timer1:GetRemaining()}))

    local start_time2 = os.clock()
    local timer2 = Timer(1, true, function(callback)
        local end_time = os.clock()
        print(end_time - start_time2)
    end)

    timer2:Pause()
    timer2:Resume()
end

return TimerTest