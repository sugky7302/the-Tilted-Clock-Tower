local function MissileTest(self)
    self.InitTimer()
    
    local Hero = require 'unit.hero'
    local enum_unit = self.EnumUnit()
    Hero(enum_unit)

    local Missile = require 'mover.missile'

    Missile{
        owner_ = Hero(enum_unit),
        model_name_ = 'A046',
        hit_mode_ = "inf",

        timeout_ = 10,
        velocity_ = 80,
        radius_ = 50,

        TraceMode = "Surround",
    }
end

return MissileTest