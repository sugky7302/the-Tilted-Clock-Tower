local cj = require 'jass.common'
local setmetatable = setmetatable

local Prefix = {}
local prefixLibrary = {}

function Prefix.Set(item)
    item.prefix = ""

    -- 只有一個孔能鑲嵌秘物
    if #item.holes == 1 then
        item.prefix = prefixLibrary[item.holes[1].index] .. "的"
        return
    else -- 多個孔能鑲嵌秘物
        local maxIndex = (item.holes[1].value >= item.holes[2].value) and 1 or 2
        local subMaxIndex = (item.holes[1].value >= item.holes[2].value) and 2 or 1
        
        -- 找最大值、次大值
        for i = 3, #item.holes do
            if item.holes[i].value > item.holes[maxIndex].value then
                subMaxIndex = maxIndex
                maxIndex = i
            elseif item.holes[i].value > item.holes[subMaxIndex].value then
                subMaxIndex = i 
            end
        end

        -- 設定新詞綴
        item.prefix = prefixLibrary[item.holes[subMaxIndex]].index] .. "之" .. prefixLibrary[item.holes[maxIndex]].index .. "的"
    end
end

return Prefix