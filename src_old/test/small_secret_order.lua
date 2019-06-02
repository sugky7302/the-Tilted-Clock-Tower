function SSOTest()
    local Item = require 'item.core'
    local Point = require 'point'

    local test_item = Item.Create('rde4', Point(15009, 9869))

    -- 設定SSO的配方
    local AddRecipe = require 'item.add_recipe'
    local test_sso = {"物理護甲", 1, "精神", 1, "精通", 1, "物理攻擊力"}
    AddRecipe(test_sso)

    -- 設定裝備屬性
    local Equipment = require 'item.equipment'
    local equip = Equipment(test_item)
    equip.attribute_count_limit_ = equip.attribute_count_limit_ + 2
    equip.attribute_[#equip.attribute_ + 1] = {"精通", 2, "", false}
    equip.attribute_[#equip.attribute_ + 1] = {"精神", 3, "", false}
    equip.attribute_count_ = equip.attribute_count_ + 2

    -- 記得要更新，不然屬性排序不正確
    equip:Update()

    local SSO = require 'item.small_secret_order'
    SSO(equip)

    print(equip.small_secret_order_[1])
    print(equip.small_secret_order_[2])
    print(equip.small_secret_order_[3])
end

return SSOTest