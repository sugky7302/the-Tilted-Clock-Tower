local function IntelligenceTest(self)
    local Hero = require 'unit.hero'
    local Intelligence = require 'intelligence'
    local Point = require 'point'

    local test_unit = Hero(self.EnumUnit())
    Intelligence.Save(test_unit, Point(-1793, -2991))
    Intelligence.Load(test_unit)
    Intelligence.Save(test_unit, Point(-1793, -2991))
end

return IntelligenceTest