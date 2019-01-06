local table_concat = table.concat
local mt = require 'quest.core' "學習附魔"
{
    detail_ = table_concat({"從踏入赫斯米爾開始，你必須要忘記過去的一切，快速學會我教給你的技能，沒有本事的人，",
                            "就得離開這裡，因為你們承擔不了我們的使命。首先，你要學會怎麼使用你的武器。"}),
    required_ = {"使用從豺狼人身上獲得的#3 秘奧，將之附魔於攻擊之爪上", "回報庫拉特"},
    demands_ = {'附魔', true, 'n005', true},
    talk_ = "很好，看來你已經進入狀況了。",
    rewards_ = {"100金幣"}, 
}

function mt:on_reward()
    self.receiver_.owner_:add("黃金", 100)
    
    -- 下個任務：選擇天賦
    self:GiveItem('rhe3')
end

function mt:on_timer(callback)
    -- 檢查有沒有附魔
    -- 確保附魔後，不會一直更新任務
    if self.demands_["附魔"] then
        local Item = require 'item.core'
        local UnitItemInSlot = require 'jass.common'.UnitItemInSlot

        local item
        for i = 0, 5 do
            item = Item(UnitItemInSlot(self.receiver_.object_, i))

            if item.id_ == 'ratf' then
                for j = 1, #item.attribute_ do
                    if item.attribute_[j][1] == "法術攻擊力" then
                        self:Update("附魔")
                        
                        break
                    end
                end

                -- 減少迴圈執行次數
                if self.demands_["附魔"] == false then
                    break
                end
            end
        end
    end

    if self.demands_["附魔"] == false and self:Near(-1793, -2991) then
        self:Update('n005')
        callback:Break()
    end
end

function mt:on_prepare()
    -- 攻擊之爪
    self:GiveItem 'ratf'
end