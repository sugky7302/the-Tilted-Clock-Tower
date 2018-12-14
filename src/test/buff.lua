local function BuffTest(self)
    self.InitTimer()
    require 'buff.attribute.init'

    require 'buffs.定身'
    local Buff = require 'buff.core'
    local Unit = require 'unit.core'

    local test_unit = Unit(self.EnumTestUnit())
    require 'buff.unit'
    test_unit:AddBuff "定身" { dur_ = 20, }
end

return BuffTest