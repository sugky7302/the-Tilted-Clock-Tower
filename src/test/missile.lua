local function MissileTest(self)
    self.InitTimer()
    
    local Hero = require 'unit.hero'
    local enum_unit = self.EnumUnit()
    Hero(enum_unit)

    local Point = require 'point'
    local Missile = require 'mover.missile'
    local Rand = require 'math_lib'.Random
    local cj = require 'jass.common'

    local p = Point.GetUnitLoc(enum_unit)
    p:UpdateZ()

    local missile = Missile{
        owner_ = Hero(enum_unit),
        model_name_ = 'A046',
        hit_mode_ = "inf",

        starting_point_ = p,

        velocity_ = 20,
        radius_ = 50,
        angle_ = Rand(0, 360),
        starting_height_ = p.z_ + 50,
        
        TraceMode = "Surround",
    }
end

return MissileTest