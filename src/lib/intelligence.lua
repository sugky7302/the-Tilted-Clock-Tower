-- 情報處理

local mod = {}

-- 儲存情報於單位資料庫內
function mod.Save(finder, scout_position, label)
    local INFO_IN_POSITION = require 'info_in_position'
    local Point = require 'point'
    local table_concat = table.concat

    -- (x, y, 資訊) 三個一組
    local ERROR_RANGE = 50
    for i = 1, #INFO_IN_POSITION, 3 then
        local info_position = Point(INFO_IN_POSITION[i], INFO_IN_POSITION[i+1])

        if Point.Distance(scout_position, info_position) < ERROR_RANGE then
            if not finder.intelligence_ then
                finder.intelligence_ = {}
            end

            finder.intelligence_[#finder.intelligence_ + 1] = table_concat({INFO_IN_POSITION[i+2], "-", label})
        end

        info_position:Remove()
    end
end

-- 讀取相同標籤的所有情報
function mod.Load(finder, label)
    if not finder.intelligence_ then
        return false
    end

    local return_list = {}
    local string_find, string_sub, string_len = string.find, string.sub, string.len
    local index, len
    for i = 1, #finder.intelligence_ do 
        index = string_find(finder.intelligence_[i], "-")
        len = string_len(finder.intelligence_[i])
        if strint_sub(finder.intelligence_[i], index + 1, len) = label then
            return_list[#return_list + 1] = string_sub(finder.intelligence_[i], 1, index - 1)
        end
    end

    if #return_list == 0 then
        return false
    end
    
    local table_concat = table.concat
    return table_concat(return _list, "\n")
end

return mod