local setmetatable = setmetatable
local cj = require 'jass.common'
local Equipment = require 'equipment'
local AddRecipe = require 'add_recipe'
local table_insert = table.insert

local mt = {}
local BigSecretOrder = {}
BigSecretOrder.__index = mt
setmetatable(BigSecretOrder, BigSecretOrder)

function BigSecretOrder:__call(hero)
    local items = _SearchSSO(hero)
    if #items > 0 then
        local bso = _FindBSO(items)
        _SetBSO(items, bso)
    end
end

_SearchSSO = function(hero)
    local items = {}
    for i = 0, 5 do
        local item = cj.UnitItemInSlot(hero, i)
        if Equipment(item).smallSecretOrder.name then
            table_insert(items, Equipment(item))
        end
    end
    return items
end

_FindBSO = function(sso)
    local node = AddRecipe.root
    for _, item in ipairs(sso) do
        node = node[item.smallSecretOrder.name]
    end
    if #node.products > 0 then
        return node.products[1]
    end
end

_SetBSO = function(items, bso)
    for _, item in ipairs(items) do
        item.smallSecretOrder.name = bso
        item.smallSecretOrder.prefix = PREFIX_LIB[bso]
        item.smallSecretOrder.state = ATTRIBUTE_STATE[bso]
    end
end

return BigSecretOrder