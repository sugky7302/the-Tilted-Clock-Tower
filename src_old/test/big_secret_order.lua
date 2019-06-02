function SSOTest()
    -- 設定SSO的配方
    local AddRecipe = require 'item.add_recipe'
    local test_sso = {"物理護甲", 1, "精神", 1, "精通", 1, "物理攻擊力"}
    local test_bso = {"物理攻擊力", 1, "物理攻擊力", 1, "法術攻擊力"}
    AddRecipe(test_sso)
    AddRecipe(test_bso)

    local Point = require 'point'
    local Item = require 'item.core'
    local Equipment = require 'item.equipment'
    local SSO = require 'item.small_secret_order'

    local tb = {}
    for i = 1, 2 do
        local test_item = Item.Create('rde4', Point(15009, 9869))

        -- 設定裝備屬性
        local equip = Equipment(test_item)

        equip.attribute_count_limit_ = equip.attribute_count_limit_ + 2
        equip.attribute_[#equip.attribute_ + 1] = {"精通", 2, "", false}
        equip.attribute_[#equip.attribute_ + 1] = {"精神", 3, "", false}
        equip.attribute_count_ = equip.attribute_count_ + 2

        -- 記得要更新，不然屬性排序不正確
        equip:Update()

        if equip.small_secret_order_ then
            print "a"
        else
            print "b"
        end

        SSO(equip)
        tb[#tb + 1] = equip
    end

    -- 選取英雄
    local Group = require 'group.core'
    local group = Group()
    group:EnumUnitsInRange(15009, 9869, 200, "IsHero")

    -- 藉由獲取物品事件觸發BSO
    local Api = require 'api'
    local cj = require 'jass.common'
    local trg = Api.CreateTrigger(function()
        local BSO = require 'item.big_secret_order'
        BSO(cj.GetTriggerUnit())

        if tb[1].big_secret_order_ then
            print(tb[1].big_secret_order_[1])
            print(tb[1].big_secret_order_[2])
            print(tb[1].big_secret_order_[3])
        end
        
        return true
    end)
    cj.TriggerRegisterUnitEvent(trg, group.units_[1], cj.EVENT_UNIT_PICKUP_ITEM)
end

return SSOTest