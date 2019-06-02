local function QuestTest(self)
    -- 初始化
    self.InitTimer()
    require 'quests.init'
    require 'quest.unit'
    require 'unit.event'

    local Item = require 'item.core'
    local cj = require 'jass.common'
    local Unit = require 'unit.core'
    local Hero = require 'unit.hero'
    local Point = require 'point'
    local MathLib = require 'math_lib'
    local Game = require 'game'

    Hero(self.EnumUnit())
    Game:EventDispatch("單位-創建", self.EnumUnit())

    local p = Point(-3267.3, -3314.3)
    local item = Item.Create('tstr', p)
    -- for i = 1, 6 do 
    --     local u = Unit.Create(cj.Player(cj.PLAYER_NEUTRAL_AGGRESSIVE), 'nbrg', p + Point(MathLib.Random(500), MathLib.Random(500)), 0)
    -- end

    p:Remove()
end

return QuestTest