local function MissileTest(self)
    self.InitTimer()
    
    local Hero = require 'unit.hero'
    local enum_unit = self.EnumUnit()
    Hero(enum_unit)

    local Point = require 'point'
    local Missile = require 'missile.core'
    local Rand = require 'math_lib'.Random
    local cj = require 'jass.common'

    local p = Point.GetUnitLoc(enum_unit)
    p:UpdateZ()

    local missile = Missile{
        owner_ = Hero(enum_unit),
        model_name_ = 'A046',
        hit_mode_ = "inf",

        starting_point_ = p,

        radius_ = 50,
        angle_ = Rand(0, 360),
        starting_height_ = p.z_ + 50, 
        max_distance_ = 0,
        
        TraceMode = "Surround",
        SetHeight = function(self)
            self.missile_:AddAbility 'Arav' 
            self.missile_:RemoveAbility 'Arav'
            cj.SetUnitFlyHeight(self.missile_.object_, self.starting_height_, 0.)
        end
    }
end

return MissileTest