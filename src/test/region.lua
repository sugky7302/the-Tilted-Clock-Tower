function RegionTest()
    local Region = require 'region'
    Region.Init()

    local region = Region("test", {0, 0, 1, 0, 1, 1, 0, 1, 0.5, 0.5})

    local Point = require 'point'
    if region:In(Point(0.4, 0.6)) then
        print "1"
    else
        print "0"
    end
end

return RegionTest