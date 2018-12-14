local function SkillTest(self)
    -- 初始化技能事件
    require 'skill.event'
    self.InitAttribute()
    self.InitTimer()

    -- 因為Hero.Create會調用Skill[寒冰箭]，所以要先註冊寒冰箭
    require 'heros.冰霜秘術師.skills.寒冰箭'
    require 'heros.冰霜秘術師.init'
    
    local Hero = require 'unit.hero'
    Hero(self.EnumUnit())

    local Game = require 'game'
    Game:EventDispatch("單位-創建", self.EnumUnit())
end

return SkillTest