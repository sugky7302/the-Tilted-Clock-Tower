function ShieldTest()
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

    local Shield = require 'bar.shield'
    local shield = Shield(group.units_[1], 500, 10)
end

return ShieldTest