function PolygonTest()
    local Polygon = require 'polygon'

    local poly = Polygon{0, 0, 1, 0, 1, 1, 0, 1, 0.5, 0.5}

    local Point = require 'point'
    local p1 = Point(0.6, 0.7)
    if poly:In(p1) then
        print "1"
    else
        print '0'
    end

    local p2 = Point(1.2, 0.3)
    if poly:In(p2) then
        print "1"
    else
        print '0'
    end
end

return PolygonTest