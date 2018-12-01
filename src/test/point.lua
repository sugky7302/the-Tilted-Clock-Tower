function PointTest()
    local Point = require 'point'

    local p1 = Point(123, 456)
    local p2 = Point(28, -137, 948)
    print(p1 + p2)
    print(p1 - p2)
    print(p1 * 13)
    print(p2 / 6)
    p1:Rotate(30)
    print(Point.Deg(p1, p2))
    print(Point.Rad(p1, p2))
    print(Point.Distance(p1, p2))
end

return PointTest