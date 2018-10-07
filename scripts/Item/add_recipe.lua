local cj = require 'jass.common'
local Object = require 'object'
local setmetatable = setmetatable
local table = table

local AddRecipe = {}
setmetatable(AddRecipe, AddRecipe)

-- variable
AddRecipe.root = {}
local _IncreaseRecipe, _RegisterRecipe

function AddRecipe:__call(recipe)
    _IncreaseRecipe(recipe)
end

_IncreaseRecipe = function(recipe)
    if AddRecipe.IsRecipeAmountLimit(recipe) then
        table.sort(recipe)
        _RegisterRecipe(recipe)
    end
end

function AddRecipe.IsRecipeAmountLimit(recipe)
    return #recipe > 1 and #recipe < 6
end

_RegisterRecipe = function(self, recipe)
    local node = AddRecipe.root

    for i = 1, #recipe do
        local newNode = node[recipe[i]]
        if not newNode then
            newNode = Object()
            node[recipe[i]] = newNode
        end
        if i == #recipe then
            newNode.productId = recipe[i]
        end
        node = newNode
    end
end

return AddRecipe