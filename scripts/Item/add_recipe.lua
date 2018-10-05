local cj = require 'jass.common'
local setmetatable = setmetatable

local AddRecipe = {}
setmetatable(AddRecipe, AddRecipe)

-- variable
AddRecipe.root = {}
AddRecipe.IsRecipeAmountLimit = nil
local IncreaseRecipe, RegisterRecipe

function AddRecipe:__call(recipe)
    IncreaseRecipe(recipe)
end

IncreaseRecipe = function(recipe)
    if IsRecipeAmountLimit(recipe) then
        recipe.sort(1, #recipe)
        RegisterRecipe(recipe)
    end
end

function AddRecipe.IsRecipeAmountLimit(recipe)
    return #recipe > 1 and #recipe < 6
end

RegisterRecipe = function(recipe)
    local node = AddRecipe.root

    for i = 1, #recipe do
        local newNode = node[recipe[i]]
        if not newNode then
            newNode = {}
            node[recipe[i]] = newNode
        end
        if i == #recipe then
            newNode.product = recipe[i]
        end
        node = newNode
    end
end

return AddRecipe