function IntensifyTest(Test)
    -- 設定玩家
    local player = Test.Player()
    player:add("黃金", 1000000)

    -- 創建物品
    local test_item = Test.CreateItem('rde4')

    -- 設定裝備屬性
    local Equipment = require 'item.equipment'
    local equip = Equipment(test_item)
    equip.own_player_ = player

    -- 記得要更新，不然屬性排序不正確
    equip:Update()
    print(equip.attribute_count_limit_)

    Test.PickItemEvent(Test.EnumUnit(), function()
        local ExtendHole = require 'item.extend_hole'
        ExtendHole(equip)
        print(equip.attribute_count_limit_)
    end)
end

return IntensifyTest