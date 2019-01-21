local function KnockTest(self)
    local Hero = require 'unit.hero'
    local test_unit = Hero(self.EnumUnit())

    local Knock = require 'mover.knock'
    Knock{
        mover_ = test_unit,
        velocity_ = 400,
        max_dist_ = 600,
        angle_ = 180,
    }
end

return KnockTest