local function HeroTest(self)
    local require, print = require, print
    local Hero = require 'unit.hero'

    require 'unit.attribute.init'

    local test_unit = Hero(self.EnumUnit())
    
    print(test_unit.proper_name_)
    print(test_unit.id_)
    print(test_unit.handle_)
    print(test_unit.name_)
end

return HeroTest