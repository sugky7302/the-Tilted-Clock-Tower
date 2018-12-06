-- 此module是讀取裝備屬性，賦予裝備小秘物序列效果
-- 把秘物序列填成配方

local _, ATTRIBUTE_INDEX, ATTRIBUTE_STATE, _ = require 'attributes'() -- 記得要加括弧，因為它是一個函數

-- assert
local ObtainProduct, SetSSO

local function SmallSecretOrder(equipment)
    local ipairs = ipairs

    -- 裝備屬性通常都排序好了，所以不用特意排序
    local orders = {}
    for _, tb in ipairs(equipment.attribute_) do
        orders[#orders + 1] = tb[1]
    end

    local sso = ObtainProduct(orders)
    if sso then
        SetSSO(equipment, sso)
    end
end

ObtainProduct = function(orders)
    local ipairs = ipairs

    -- 搜索產品
    local node = require 'item.add_recipe'.root
    for _, attribute_name in ipairs(orders) do
        node = node[attribute_name]
    end

    if #node.products > 0 then
        return node.products[1][0]
    end

    return false
end

-- 和秘物相同，用名稱儲存詞綴、描述及調用函數
SetSSO = function(item, sso)
    local PREFIX_LIB = require 'prefix_lib'

    -- SSO = {效果id, 物品前綴, 效果描述}
    item.small_secret_order_ = {sso, PREFIX_LIB[sso], ATTRIBUTE_STATE[ATTRIBUTE_INDEX[sso]]}
end

return SmallSecretOrder