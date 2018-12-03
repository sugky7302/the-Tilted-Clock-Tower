function BarTest()
    require 'timer.init'.Init()
    local Point = require 'point'
    local Group = require 'group.core'

    local group = Group()
    group:EnumUnitsInRange(15009, 9869, 200, "IsHero")
    if group:IsEmpty() then
        print "0"
    else
        local cj = require 'jass.common'
        print(cj.GetUnitName(group.units_[1]))
    end

    local Bar = require 'bar.core'
    local bar = Bar(group.units_[1], nil, 10, "red", true)
end

return BarTest