-- 此module為檢測英雄的物品欄能不能合成出物品
-- 依賴
--   jass.common
--   item.core
--   item.add_recipe
--   jass.japi
--   unit.hero


-- package
local require = require
local cj = require 'jass.common'


-- assert
local last_enum_product = 1
local CollectMaterial, CheckRecipe, Exist
local CostMaterial, UnitAddItem

local function ProduceRecipe(unit)
    local materials = CollectMaterial(unit) -- 存Item instance
    local recipe = CheckRecipe(materials)   -- 存Item instance, [0]存products(table)

    if Exist(recipe) then
        CostMaterial(unit, recipe)

        UnitAddItem(unit, Base.String2Id(recipe.products[last_enum_product][0]))

        cj.DestroyEffect(cj.AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIam\\AIamTarget.mdl", unit, "origin"))

        return true
    end

    return false
end

CollectMaterial = function(unit)
    local Item = require 'item.core'

    local materials = {}
    for i = 0, 5 do 
        local item = cj.UnitItemInSlot(unit, i)

        -- 先檢測有沒有物品再檢測是不是材料
        if item and Item.IsMaterial(item) then
            materials[#materials + 1] = Item(item)
        end
    end

    return materials
end

CheckRecipe = function(materials)
    -- 按照第一個字符的ANSII碼排
    local table_sort = table.sort
    table_sort(materials, function(a, b)
        return a.id_ < b.id_
    end)

    local recipe = {}
    local node = require 'item.add_recipe'.root

    for i = 1, #materials do
        if node[materials[i].id_] then
            -- 有值代表可以繼續找
            recipe[#recipe + 1] = materials[i]
            -- 跳到下一個節點
            node = node[materials[i].id_]
        else
            -- 無值代表配方讀取完畢
            break
        end
    end
    
    if node.products then
        recipe.products = node.products

        return recipe
    end

    return false
end

Exist = function(recipe)
    if not recipe then
        return false
    end

    if not recipe.products then
        return false
    end

    return true
end

CostMaterial = function(unit, recipe)
    local product_demands = GetDemands(recipe)

    -- 有多個產品時，選取想要的產品
    PickProduct(unit, product_demands)

    if #product_demands > 0 then
        -- 根據配方扣除材料
        local demands = product_demands[last_enum_product]
        for i = 1, #demands do
            if recipe[i]:get "數量" > demands[i] then
                recipe[i]:add("數量", - demands[i])
            else
                recipe[i]:Remove()
            end
        end
    else
        cj.DisplayTimedTextToPlayer(cj.GetOwningPlayer(unit), 0., 0., 6., "|cff00ff00提示|r - 材料不足。")
    end
end

GetDemands = function(recipe)
    local product_demands = {}

    -- 搜尋有多少個產品
    for i = 1, #recipe.products do
        local product_length = #recipe.products[i]

        -- 檢查產品數量
        -- #只計算從1開始的連續索引，索引0不會計入
        for j = 1, product_length do
            if recipe[i]:get "數量" < recipe.products[i][j] then
                break
            end

            -- 全部數量確認OK就納入可製作的產品清單
            if j == product_length then
                product_demands[#product_demands + 1] = recipe.products[i]
            end
        end
    end

    return product_demands
end

-- 檢測產品數量是否超過1個，如果有就給玩家選
PickProduct = function(unit, products)
    if #products > 1 then
        local Hero = require 'unit.hero'
        local japi = require 'jass.japi'
        local S2Id = Base.String2Id

        local dialog = Hero(unit).owner_.dialog_

        for i = 1, #products do
            dialog:Insert(japi.EXGetItemDataString(S2Id(products[i][0]), 4), i)
        end
        dialog:Insert("關閉")
        
        dialog:SetTitle("請玩家選取產品：")

        dialog:Show(true)
    end
end

UnitAddItem = function(unit, product)
    local item = cj.CreateItem(product, cj.GetUnitX(unit), cj.GetUnitY(unit))
    cj.UnitAddItem(unit, item)
end

return ProduceRecipe