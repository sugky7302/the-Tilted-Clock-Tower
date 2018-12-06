function ProduceRecipeTest()
    -- 選取英雄
    local Group = require 'group.core'
    local group = Group()
    group:EnumUnitsInRange(15009, 9869, 200, "IsHero")

    -- 設定配方
    local AddRecipe = require 'item.add_recipe'
    local test_recipe = {'dkfw', 5, 'crys'}
    AddRecipe(test_recipe)

    -- 創建材料
    local Point = require 'point'
    local Item = require 'item.core'
    local item = Item.Create("dkfw", Point(15009, 9869))
    Item(item):set("數量", 5)
    
    -- 藉由獲取物品事件觸發製造產品
    local Api = require 'api'
    local cj = require 'jass.common'
    local trg = Api.CreateTrigger(function()
        local ProduceRecipe = require 'item.produce_recipe'
        ProduceRecipe(cj.GetTriggerUnit())
        return true
    end)
    cj.TriggerRegisterUnitEvent(trg, group.units_[1], cj.EVENT_UNIT_PICKUP_ITEM)
end

return ProduceRecipeTest