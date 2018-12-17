local function SkillTest(self)
    -- 初始化
    require 'skill.event'
    require 'buff.unit'
    self.InitAttribute()
    self.InitTimer()

    require 'heros.hero_list'
    
    local Hero = require 'unit.hero'
    Hero(self.EnumUnit())

    local Game = require 'game'
    Game:EventDispatch("單位-創建", self.EnumUnit())
end

return SkillTest