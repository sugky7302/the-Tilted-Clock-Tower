function ItemTest()
    local Item = require 'item.core'
    local Point = require 'point'

    local test_item = Item.Create('sbch', Point(15009, 9869))
    local item = Item(test_item)

    if Item.IsEquipment(test_item) then
        print "1"
    else
        print "0"
    end

    if Item.IsSecrets(test_item) then
        print "3"
    else
        print "2"
    end

    item:set("數量", 10)
    -- item:Remove()
end

return ItemTest