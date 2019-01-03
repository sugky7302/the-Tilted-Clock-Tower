-- 情報處理

local mod = {}

-- 儲存情報於單位資料庫內
function mod.Save(finder, scout_position)
    local INFO_IN_POSITION = require 'info_in_position'
    local Point = require 'point'
    local DisplayText = require 'jass.common'.DisplayTimedTextToPlayer
    local table_concat = table.concat

    -- (x, y, 資訊) 三個一組
    local ERROR_RANGE = 50
    for i = 1, #INFO_IN_POSITION, 3 do
        local info_position = Point(INFO_IN_POSITION[i], INFO_IN_POSITION[i+1])

        -- 一次只會獲得一個情報
        if Point.Distance(scout_position, info_position) < ERROR_RANGE then
            if not finder.intelligence_ then
                finder.intelligence_ = {}
            end

            -- 檢查是否有相同的情報
            for j = 1, #finder.intelligence_ do
                if INFO_IN_POSITION[i+2] == finder.intelligence_[j] then
                    DisplayText(finder.owner_.object_, 0, 0, 6, table_concat({"|cffff0000情報重複|r\n|cff999999- ",
                                                                              INFO_IN_POSITION[i+2]}))
                    
                    -- 因為return後，下面的程式不會執行，因此這邊再寫一次
                    info_position:Remove()

                    return false
                end
            end

            finder.intelligence_[#finder.intelligence_ + 1] = INFO_IN_POSITION[i+2]
            DisplayText(finder.owner_.object_, 0, 0, 6, table_concat({"|cff00ff00獲得情報|r\n- ",
                                                                      INFO_IN_POSITION[i+2]}))
            
            -- 因為break後，下面的程式不會執行，因此這邊再寫一次
            info_position:Remove()

            break
        end

        info_position:Remove()
    end
end

function mod.Label()
    -- body
end

-- 讀取所有情報
function mod.Load(finder)
    local next = next
    if next(finder.intelligence_) == 0 then
        return false
    end

    local return_list = {"|cffffcc00擁有的情報|r"}
    for i = 1, #finder.intelligence_ do 
            return_list[#return_list + 1] = finder.intelligence_[i]
    end
    
    local DisplayText = require 'jass.common'.DisplayTimedTextToPlayer
    local table_concat = table.concat
    DisplayText(finder.owner_.object_, 0, 0, 6, table_concat(return_list, "\n- "))
end

return mod