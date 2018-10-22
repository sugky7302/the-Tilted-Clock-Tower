local setmetatable = setmetatable
local table = table
local AddRecipe = require 'add_recipe'
require 'attribute_database'
require 'prefix_lib'

local SmallSecretOrder = {}
setmetatable(SmallSecretOrder, SmallSecretOrder)

-- variables
local _Detect, _SetSSO

function SmallSecretOrder:__call(item)
    local orders = {}
    for _, tb in ipairs(item.attribute) do
        table.insert(orders, ATTRIBUTE_INDEX[tb[i]])
    end
    table.sort(orders)
    local sso = _Detect(orders)
    if sso then
        _SetSSO(item, sso)
    end
end

_Detect = function(orders)
    local node = AddRecipe.root
    for _, v in ipairs(orders) do
        node = node[v]
    end
    if #node.products > 0 then
        return node.products[1]
    end
    return nil
end

-- TODO:和秘物相同，用名稱儲存詞綴、描述及調用函數
_SetSSO = function(item, sso)
    item.smallSecretOrder.name = sso
    item.smallSecretOrder.prefix = PREFIX_LIB[sso]
    item.smallSecretOrder.state = ATTRIBUTE_STATE[sso]
end

return SmallSecretOrder