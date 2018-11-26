local setmetatable = setmetatable
local table_insert = table.insert
local cj = require 'jass.common'
require 'prefix_database'

local Prefix = {}
setmetatable(Prefix, Prefix)

function Prefix:__call(item)
    item.prefix = ""
    local nonFixedAttributes = {}
    for _, tb in ipairs(item.attribute) do
        if tb[4] == false then
            table_insert(nonFixedAttributes, tb)
        end
    end

    if #nonFixedAttributes == 0 then
        return
    elseif #nonFixedAttributes == 1 then -- 只有一個孔能鑲嵌秘物
        item.prefix = PREFIX_LIB[nonFixedAttributes[1][1]] .. "的"
        return
    else -- 多個孔能鑲嵌秘物
        local maxIndex = (nonFixedAttributes[1][2] >= nonFixedAttributes[2][2]) and 1 or 2
        local subMaxIndex = (nonFixedAttributes[1][2] >= nonFixedAttributes[2][2]) and 2 or 1
        
        -- 找最大值、次大值
        for i = 3, #nonFixedAttributes do
            if nonFixedAttributes[i][2] > nonFixedAttributes[maxIndex][2] then
                subMaxIndex = maxIndex
                maxIndex = i
            elseif nonFixedAttributes[i][2] > nonFixedAttributes[subMaxIndex][2] then
                subMaxIndex = i 
            end
        end

        -- 設定新詞綴
        item.prefix = PREFIX_LIB[nonFixedAttributes[subMaxIndex][1]] .. "之" .. PREFIX_LIB[nonFixedAttributes[maxIndex][1]].index .. "的"
    end
end

return Prefix