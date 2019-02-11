local function MissileTest(self)
    self.InitTimer()
    
    local Hero = require 'unit.hero'
    local enum_unit = self.EnumUnit()
    Hero(enum_unit)

    local Missile = require 'mover.missile'

    local missile = Missile{
        owner_ = Hero(enum_unit),
        model_name_ = 'A046',
        hit_mode_ = "inf",

        velocity_ = 20,
        radius_ = 50,

        TraceMode = "Surround",
    }
end

return MissileTest