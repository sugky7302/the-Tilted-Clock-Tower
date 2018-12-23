-- 裝備顯示

local Printer = {}

-- assert
local GetDisplayedInfo, DialogDisplay

function Printer.Display(self)
    local info = GetDisplayedInfo(self)
    DialogDisplay(self.own_player_, info)
end

GetDisplayedInfo = function(self)
    local display_strings = {Printer.name(self, true)}
    
    -- 基本資料
    display_strings[#display_strings + 1] = "|cff808080Lv "
    display_strings[#display_strings + 1] = self.level_ + self.intensify_level_
    display_strings[#display_strings + 1] = " / Gs "
    display_strings[#display_strings + 1] = Printer.GetGearScore(self)
    display_strings[#display_strings + 1] = "|r|n"
    
    -- 屬性
    local attributes = ""
    for i = 1, self.attribute_count_limit_ do
        -- 因為屬性最大數量是給定的，所以有可能會沒屬性
        if self.attribute_[i] then
            display_strings[#display_strings + 1] = "|cff3366ff◆|r|cff99ccff"
            display_strings[#display_strings + 1] = self.attribute_[i][3]
        else
            display_strings[#display_strings + 1] = "|cff3366ff◇"
        end

        display_strings[#display_strings + 1] = "|r|n"
    end

    -- 額外效果
    for i = 1, #self.additional_effect_ do
        display_strings[#display_strings + 1] = "|cff3366ff◆|r"
        display_strings[#display_strings + 1] = self.additional_effect_[i].state_
        display_strings[#display_strings + 1] = "|n"
    end

    -- 小型秘物序列敘述
    if self.small_secret_order_ then
        display_strings[#display_strings + 1] = "|cffff8d00"
        display_strings[#display_strings + 1] = self.small_secret_order_.state_
        display_strings[#display_strings + 1] = "|r|n"
    end

    -- 大型秘物序列敘述
    if self.big_secret_order_ then
        display_strings[#display_strings + 1] = "|cff804000"
        display_strings[#display_strings + 1] = self.big_secret_order_.state_
        display_strings[#display_strings + 1] = "|r|n"
    end

    local table_concat = table.concat
    return table_concat(display_strings)
end

-- 獲取完整的物品名字，可選擇要不要加換行符
function Printer.name(self, is_replace)
    local display_strings = {}

    -- 大型秘物序列詞綴
    if self.big_secret_order_ then
        display_strings[#display_strings + 1] = "|cff804000"
        display_strings[#display_strings + 1] = self.big_secret_order_prefix_
        display_strings[#display_strings + 1] = is_replace and "|r|n" or "|r"
    end

    -- 小型秘物序列詞綴
    if self.small_secret_order_ then
        display_strings[#display_strings + 1] = "|cffff8d00"
        display_strings[#display_strings + 1] = self.small_secret_order_prefix_
        display_strings[#display_strings + 1] = is_replace and "|r|n" or "|r"
    end

    -- 精鍊等級
    if self.intensify_level_ > 0 then
        display_strings[#display_strings + 1] = "|cff00ff00+"
        display_strings[#display_strings + 1] = self.intensify_level_
        display_strings[#display_strings + 1] = "|r "
    end

    -- 顏色
    display_strings[#display_strings + 1] = self.color_

    -- 秘物詞綴
    if self.prefix_ then
        display_strings[#display_strings + 1] = self.prefix_
    end
    
    -- 名字
    display_strings[#display_strings + 1] = self.name_
    display_strings[#display_strings + 1] = is_replace and "|r|n" or "|r"

    local table_concat = table.concat
    return table_concat(display_strings)
end

-- assert
local _, ATTRIBUTE_INDEX, ATTRIBUTE_STATE, ATTRIBUTE_WEIGHT = require 'attributes'() -- 這樣才能多個返回值

function Printer.GetGearScore(self)
    local sum = 0
    for i = 1, self.attribute_count_ do
        sum = sum + self.attribute_[i][2] * ATTRIBUTE_WEIGHT[ATTRIBUTE_INDEX[self.attribute_[i][1]]]
    end

    return sum
end

DialogDisplay = function(player, displayed_info)
    local dialog = player.dialog_

    dialog:AddButton("關閉")
    dialog:SetTitle(displayed_info)
    dialog:Show(true)
end

return Printer