function CombineTest(self)
    local item = self.CreateItem("sbch")
    
    local Item = require 'item.core'
    item = Item(item)
    item:set("數量", 4)

    local player = self.Player()
    player:set("黃金", 1000000)

    local unit = self.EnumUnit()
    
    item.own_player_ = player
    local Combine = require 'item.combine'
    Combine.Init()

    Combine(item)
end

return CombineTest