local function QuestProgress(self)
    local cj = require 'jass.common'
    local Point = require 'point'
    local CreateItem = require 'item.core'.Create

    -- 觸發任務：報到
    local p = Point(-3267.3, -3314.3)
    local item = CreateItem('tstr', p)
    cj.UnitAddItem(self.EnumQuestUnit(), item)

    -- 讓玩家一進去就選取單位
    if cj.GetLocalPlayer() == cj.Player(0) then
        cj.ClearSelection()
        cj.SelectUnit(self.EnumQuestUnit(), true)
    end

    p:Remove()
end

return QuestProgress