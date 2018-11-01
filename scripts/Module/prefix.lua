local setmetatable = setmetatable
local cj = require 'jass.common'
require 'prefix_database'

local Prefix = {}
setmetatable(Prefix, Prefix)

function Prefix:__call(item)
    item.prefix = ""

    -- 只有一個孔能鑲嵌秘物
    if item.attributeCount == 1 then
        item.prefix = PREFIX_LIB[item.attribute[1][1]] .. "的"
        return
    else -- 多個孔能鑲嵌秘物
        local maxIndex = (item.attribute[1][2] >= item.attribute[2][2]) and 1 or 2
        local subMaxIndex = (item.attribute[1][2] >= item.attribute[2][2]) and 2 or 1
        
        -- 找最大值、次大值
        for i = 3, item.attributeCount do
            if item.attribute[i][2] > item.attribute[maxIndex][2] then
                subMaxIndex = maxIndex
                maxIndex = i
            elseif item.attribute[i][2] > item.attribute[subMaxIndex][2] then
                subMaxIndex = i 
            end
        end

        -- 設定新詞綴
        item.prefix = PREFIX_LIB[item.attribute[subMaxIndex][1]] .. "之" .. PREFIX_LIB[item.attribute[maxIndex][1]].index .. "的"
    end
end

return Prefix