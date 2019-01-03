local function QuestProgress()
    local Point = require 'point'
    local CreateItem = require 'item.core'.Create
    local p = Point(-3267.3, -3314.3)
    local item = CreateItem('tstr', p)
    p:Remove()
end

return QuestProgress