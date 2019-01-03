local table_concat = table.concat
local mt = require 'quest.core' "學習附魔"
{
    detail_ = table_concat({"從踏入赫斯米爾開始，你必須要忘記過去的一切，快速學會我教給你的技能，沒有本事的人，",
                            "就得離開這裡，因為你們承擔不了我們的使命。首先，你要學會怎麼使用你的武器。"}),
    required_ = {"使用從豺狼人身上獲得的符文，將之附魔於攻擊之爪上", "回報庫拉特"},
    demands_ = {'n005', true},
    talk_ = "很好，看來你已經進入狀況了。",
    rewards_ = {"100金幣"}, 
}

function mt:on_reward()
    self.receiver_.owner_:add("黃金", 100)
    -- self:GiveItem('ratc')
    -- self:GiveItem('rhe3')
end

function mt:on_timer(callback)
    -- 檢查有沒有附魔
    local Item = require 'item.core'
    local UnitItemInSlot = require 'jass.common'.UnitItemInSlot

    local is_enchanted = false
    local item
    for i = 0, 5 do
        item = Item(UnitItemInSlot(self.receiver_.object_, i))

        if item.id_ == 'ratf' then
            for j = 1, #item.attribute_ do
                if item.attribute_[j][1] == "法術攻擊力" then
                    is_enchanted = true
                    
                    break
                end
            end

            -- 減少迴圈執行次數
            if is_enchanted then
                break
            end
        end
    end

    if is_enchanted and self:Near(-1793, -2991) then
        self:Update('n005')
        callback:Break()
    end
end