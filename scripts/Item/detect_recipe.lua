local math = math
local setmetatable = setmetatable
local cj = require 'jass.common'
local AddRecipe = require 'add_recipe'
local Object = require 'object'

local DetectRecipe = {}
setmetatable(DetectRecipe, DetectRecipe)
math.randomseed(tostring(os.time()):reverse():sub(1, 6))

local _CollectUnitItemInSlot, _CheckRecipe, _SearchRecipes, _DecreaseItemChargesOrRemoveItem, _UnitAddItem

function DetectRecipe:__call(unit)
    local recipe = _CollectUnitItemInSlot(unit)
    local productCollection = _CheckRecipe(recipe)
    if productCollection and (productCollection.product > 0) then
        _DecreaseItemChargesOrRemoveItem(productCollection)
        _UnitAddItem(unit, productCollection.product)
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

_CheckRecipe = function(recipe)
    if AddRecipe.IsRecipeAmountLimit(recipe) then
        recipe:Sort()
        return _SearchRecipes(recipe)
    end
    return nil
end

_SearchRecipes = function(recipe)
    local productCollection, recipeIndex = Object{product = 0}
    local node = AddRecipe.root
    for i = 1, #recipe do
        recipeIndex = Base.Id2String(cj.GetItemTypeId(recipe[i]))
        if node[recipeIndex] then
            -- 有值代表可以繼續找
            productCollection:Insert(recipe[i])
        else
            -- 無值代表配方讀取完畢，讀取產品
            productCollection.product = node.products[math.random(#node.products)]
            break
        end
        node = node[recipeIndex]
    end
    return productCollection
end

_DecreaseItemChargesOrRemoveItem = function(recipe)
    for i = 1, #recipe do
        if cj.GetItemChages(recipe[i] > 1) then
            cj.SetItemChages(recipe[i], cj.GetItemCharges(recipe[i]) - 1)
        else
            cj.RemoveItem(unit, recipe[i])
        end
    end
end

_UnitAddItem = function(unit, product)
    local item = cj.CreateItem(product, cj.GetUnitX(unit), cj.GetUnitY(unit))
    cj.UnitAddItem(unit, item)
end

return DetectRecipe