local function TalentTest(self)
    require 'heros.冰霜秘術師.talents.冰晶裂片'
    require 'heros.冰霜秘術師.skills.寒冰箭'
    require 'unit.event'

    self.Player():set("天賦點", 10)

    local Game = require 'game'
    Game:EventDispatch("單位-創建", self.EnumUnit())
end

return TalentTest