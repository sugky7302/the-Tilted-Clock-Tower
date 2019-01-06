local function CallFuncInTable()
    local Point = require 'point'
    local p1 = Point(123, 456)
    local p2 = Point(28, -137, 948)
    local times = 100000000

    -- 次之
    local a
    local start = os.clock()
    for i = 1, times do 
        a = Point.Distance(p1, p2)
    end
    print(os.clock() - start)

    -- 最快
    start = os.clock()
    local Dist = require 'point'.Distance
    for i = 1, times do 
        a = Dist(p1, p2)
    end
    print(os.clock() - start)

    -- 最慢
    start = os.clock()
    Dist = Point.Distance
    for i = 1, times do 
        a = Dist(p1, p2)
    end
    print(os.clock() - start)
end

return CallFuncInTable