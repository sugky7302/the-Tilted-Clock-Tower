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
    local node, demands = AddRecipe.root, {}
    for i = 1, #recipe do
        if i == #recipe then
            if not node.products then
                node.products = Object()
            end
            demands[0] = recipe[i]
            node.products:Insert(demands)
            break
        end
        -- 獲取需求量
        local name
        if type(recipe[i]) == 'table' then
            name = recipe[i][1]
            table.insert(demands, recipe[i][2])
        else
            name = recipe[i]
            table.insert(demands, 1)
        end
        local newNode = node[name]
        if not newNode then
            newNode = Object()
            node[name] = newNode
        end
        node = newNode
    end
end

return AddRecipe