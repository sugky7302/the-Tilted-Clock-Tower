-- 此module是讀取小秘物序列效果，
-- 把秘物序列填成配方
-- 依賴
--   jass.common
--   item.equipment.core
--   jass_tool
--   item.add_recipe


-- assert
local require = require
local CollectSSO, FindBSO, SetBSO

local function BigSecretOrder(hero)
    local ssoes = CollectSSO(hero)

    if #ssoes == 0 then
        return false
    end
    
    local bso = FindBSO(ssoes)
    
    if bso then
        SetBSO(ssoes, bso)
    end
end

CollectSSO = function(hero)
    local UnitItemInSlot = require 'jass.common'.UnitItemInSlot
    local Equipment = require 'item.equipment.core'
    local H2I = require 'jass_tool'.H2I

    local ssoes = {}

    for i = 0, 5 do
        local item = UnitItemInSlot(hero, i)

        -- 初始值=nil，只有執行過SSO的裝備才有值
        -- item = 空在Lua不是nil，因此要用handle判定
        if H2I(item) > 0 and Equipment(item).small_secret_order_ then
            ssoes[#ssoes + 1] = Equipment(item)
        end
    end

    return ssoes
end

local ipairs = ipairs

FindBSO = function(ssoes)
    local node = require 'item.add_recipe'.root

    -- 搜尋節點
    for _, sso in ipairs(ssoes) do
        node = node[sso.small_secret_order_[1]]
    end

    -- 沒對應的BSO就跳出
    if not node.products then
        return false
    end

    if #node.products > 0 then
        return node.products[1][0]
    end
end

SetBSO = function(ssoes, bso)
    local _, ATTRIBUTE_INDEX, ATTRIBUTE_STATE, _ = require 'attributes'()
    local PREFIX_LIB = require 'prefix_lib'

    for _, sso in ipairs(ssoes) do
        sso.big_secret_order_ = {bso, PREFIX_LIB[bso], ATTRIBUTE_STATE[ATTRIBUTE_INDEX[bso]]}
    end
end

return BigSecretOrder