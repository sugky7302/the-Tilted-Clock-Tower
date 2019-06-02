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
    equip.attribute_count_limit_ = equip.attribute_count_limit_ + 2
    equip.attribute_[#equip.attribute_ + 1] = {"精通", 2, "", false}
    equip.attribute_[#equip.attribute_ + 1] = {"精神", 3, "", false}
    equip.attribute_count_ = equip.attribute_count_ + 2

    -- 記得要更新，不然屬性排序不正確
    equip:Update()
    Test.PrintAttribute(equip)

    Test.PickItemEvent(Test.EnumUnit(), function()
        local Intensify = require 'item.intensify'
        Intensify(equip)
        Test.PrintAttribute(equip)
    end)
end

return IntensifyTest