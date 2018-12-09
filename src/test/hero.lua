function HeroTest(self)
    local Hero = require 'unit.hero'

    require 'unit.attribute.init'

    local test_unit = Hero(self.EnumUnit())
end

return HeroTest