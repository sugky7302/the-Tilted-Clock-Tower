-- 此module是根據裝備屬性設定前綴，前綴的選取由屬性最大值跟次大值決定
-- 結構為 次大值的屬性的前綴 "之" 最大值的屬性的前綴 "的"

local function Prefix(equipment)
    -- 先清空，不讓之前的前綴影響這次的前綴
    equipment.prefix_ = ""

    -- 先分離固定屬性和非固定屬性
    -- 非固定屬性是由附魔獲得，這種屬性才能設定前綴
    local ipairs = ipairs
    local nonfixed_attributes = {}
    for _, tb in ipairs(equipment.attribute_) do
        -- tb = {屬性索引, 屬性值, 屬性說明, 是否為固定屬性}
        if tb[4] == false then
            nonfixed_attributes[#nonfixed_attributes + 1] = tb
        end
    end

    local nonfixed_amount = #nonfixed_attributes

    -- 只有非固定屬性 = 沒有前綴
    if nonfixed_amount == 0 then
        return false
    end

    local PREFIX_LIB = require 'prefix_lib'

    -- 只有一個非固定屬性 = 只有一個前綴
    if nonfixed_amount == 1 then
        equipment.prefix_ = PREFIX_LIB[nonfixed_attributes[1][1]] .. "的"
        
        return true
    end

    -- 有二個以上非固定屬性 = 完整前綴
    -- 初始值直接抓前兩個元素
    local max_value_index    = (nonfixed_attributes[1][2] >= nonfixed_attributes[2][2]) and 1 or 2
    local submax_value_index = (nonfixed_attributes[1][2] >= nonfixed_attributes[2][2]) and 2 or 1
    
    -- 找最大值、次大值
    for i = 3, nonfixed_amount do
        if nonfixed_attributes[i][2] > nonfixed_attributes[submax_value_index][2] then
            submax_value_index = i
        end

        -- 直接設定新的最大值會讓次大值丟失
        if nonfixed_attributes[i][2] > nonfixed_attributes[max_value_index][2] then
            submax_value_index = max_value_index
            max_value_index = i
        end
    end

    -- 設定新前綴
    local max_prefix = PREFIX_LIB[nonfixed_attributes[max_value_index][1]]
    local submax_prefix = PREFIX_LIB[nonfixed_attributes[submax_value_index][1]]

    local table_concat = table.concat
    equipment.prefix_ = table_concat({submax_prefix, "之", max_prefix, "的"})
end

return Prefix