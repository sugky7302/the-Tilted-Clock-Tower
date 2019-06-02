local function BuffTest(self)
    self.InitTimer()
    require 'buff.attribute.init'
    require 'unit.attribute.init'

    require 'buffs.init'
    local Buff = require 'buff.core'
    local Unit = require 'unit.core'

    local test_unit = Unit(self.EnumTestUnit())
    require 'buff.unit'
    test_unit:AddBuff "冰凍" {dur_ = 5}
    test_unit:AddBuff "束縛" {dur_ = 5}
    test_unit:AddBuff "減攻速" {val_ = 50, dur_ = 10}
    test_unit:AddBuff "減速" {val_ = 50, dur_ = 10}
end

return BuffTest