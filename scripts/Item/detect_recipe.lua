local setmetatable = setmetatable
local table_insert = table.insert
local cj = require 'jass.common'
local AddRecipe = require 'add_recipe'
local Object = require 'object'
local MathLib = require 'math_lib'

local DetectRecipe = {}
setmetatable(DetectRecipe, DetectRecipe)

-- variables
local _CollectUnitItemInSlot, _GetRecipe, _SearchRecipes, _DecreaseItemChargesOrRemoveItem
local _PickProduct, _UnitAddItem, _GetDemands, _IsExist
local _lastClickedProductIndex

function DetectRecipe.Init()
    local Game = require 'game'

    Game:Event "玩家-對話框被點擊" (function(self, player, button)
        -- 查詢最後點擊的產品
        for index, b in pairs(player.dialog.buttons) do
            if b == button then
                _lastClickedProductIndex = index
                break
            end
        end
        -- 關閉對話框
        player.dialog:Show(false)
        player.dialog:Clear()
    end)
end

function DetectRecipe:__call(unit)
    local recipe = _CollectUnitItemInSlot(unit)
    local productCollection = _CheckRecipe(recipe)
    if _IsExist(productCollection) then
        _DecreaseItemChargesOrRemoveItem(unit, recipe, productCollection.product)
        _UnitAddItem(unit, productCollection.product[_lastClickedProductIndex][0])
        cj.DestroyEffect(cj.AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIam\\AIamTarget.mdl", unit, "origin"))
    end
end

_CollectUnitItemInSlot = function(unit)
    local recipe = Object()
    for i = 0, 5 do 
        local item = cj.UnitItemInSlot(unit, i)
        if item then
            recipe:Insert(item)
        end
    end
    return recipe
end

_CheckRecipe = function(ecipe)
    if AddRecipe.IsRecipeAmountLimit(recipe) then
        recipe:Sort()
        return _SearchRecipes(recipe)
    end
    return nil
end

_SearchRecipes = function(recipe)
    local productCollection = Object{product = 0}
    local node = AddRecipe.root
    for i = 1, #recipe do
        local index = Base.Id2String(cj.GetItemTypeId(recipe[i]))
        if node[index] then
            -- 有值代表可以繼續找
            productCollection:Insert(index)
            node = node[index]
        else
            -- 無值代表配方讀取完畢，讀取產品
            productCollection.product = node.products
            return productCollection
        end
    end
end

_IsExist = function(productCollection)
    if productCollection then
        if type(productCollection.product) == 'table' then
            return #productCollection.product > 0
        else
            return productCollection.product > 0
        end
    end
    return false
end

_DecreaseItemChargesOrRemoveItem = function(unit, recipe, products)
    local collection = _GetDemands(recipe, products)
    _PickProduct(unit, collection)
    local demands = collection[_lastClickedProductIndex]
    for i = 1, #demands - 1 do
        if cj.GetItemCharges(recipe[i]) > demands[i] then
            cj.SetItemChages(recipe[i], cj.GetItemCharges(recipe[i]) - demands[i])
        else
            recipe[i]:Remove()
            cj.RemoveItem(unit, recipe[i])
        end
    end
end

_GetDemands = function(recipe, products)
    local collection, success = {}, true
    for i = 1, #products do
        for j = 1, #products[i] - 1 do
            if cj.SetItemCharges(recipe[i]) ~= products[i][j] then
                success = false
                break
            end
        end
        -- 判斷有無成功，成功則把產品放進收集
        if success then
            table_insert(collection, products[i])
        end
        success = true
    end
    return collection
end

-- 檢測產品數量是否超過1個，如果有就給玩家選
_PickProduct = function(unit, product)
    local Hero = require 'hero'
    local japi = require 'jass.japi'

    if #product > 1 then
        local dialog = Hero(unit).owner.dialog
        for i = 1, #product do
            dialog:Insert(japi.EXGetItemDataString(Base.String2Id(product[i][0]), 4), i)
        end
        dialog:SetTitle("請玩家選取產品：")
        dialog:Show(true)
    end
end

_UnitAddItem = function(unit, product)
    local item = cj.CreateItem(product, cj.GetUnitX(unit), cj.GetUnitY(unit))
    cj.UnitAddItem(unit, item)
end

return DetectRecipe