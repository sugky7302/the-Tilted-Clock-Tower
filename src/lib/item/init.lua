-- assert
local GetCombineCost

local function Combine()
    local slk_item = require 'jass.slk'.item

    -- 解析資料庫
    local ipairs = ipairs
    local COMBINATIONS = require 'combinations'
    for _, tb in ipairs(COMBINATIONS) do 
        for i = 1, #tb - 1 do 
            -- 使用鏈表的方式串住材料
            COMBINATIONS[tb[i]] = tb[i+1]
            COMBINATIONS[tb[i] .. "_cost"] = GetCombineCost(slk_item[tb[i]].HP)
        end
    end
end

-- NOTE: 合成物品的生命值為材料等級
GetCombineCost = function(lv)
    return 50 * math.exp(lv - 1)
end

-- call
Combine()