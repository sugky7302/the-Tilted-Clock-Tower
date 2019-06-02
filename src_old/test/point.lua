local function PointTest()
    local Point = require 'point'

    local p1 = Point{x_ = 123, y_ = 456}
    local p2 = Point{x_ = 28, y_ = -137, z_ = 948}
    print(p1 + p2)
    print(p1 - p2)
    print(p1 * 13)
    print(p2 / 6)
    p1:Rotate(30)
    print(Point.Deg(p1, p2))
    print(Point.Rad(p1, p2))
    print(Point.Distance(p1, p2))

    local Rand = require 'math_lib'.Random 
    local p
    for i = 1, 3000000 do 
        p = Point{x_ = Rand(-10000, 10000), y_ = Rand(-10000, 10000)}
        p:Remove()
    end
end

return PointTest