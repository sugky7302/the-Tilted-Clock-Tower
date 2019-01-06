local table_concat = table.concat
local mt = require 'quest.core' "選擇天賦"
{
    detail_ = table_concat({"接下來，我會教你認識你身上的血脈的力量，那遠古部族傳承至今的偉力--天賦。針對不同的技能，",
                            "你可以從 選擇天賦(|cffffcc00O|r) 中挑選自己想要提昇的技能。每個天賦都要花費天賦點，1到5點不等，",
                            "越強大的天賦需要耗費的天賦點越多。\n今日，我將賜予你奎爾托的祝福，激發你的血脈，獲得選擇天賦的能力。"}),
    required_ = {"選擇一個1點天賦", "回報庫拉特"},
    demands_ = {"選擇天賦", true, 'n005', true},
    talk_ = "天賦將會是你未來的旅途中最好的夥伴，好好善用這個能力並深度開發它，你會走得更遠。",
    rewards_ = {"100金幣"}, 
}

function mt:on_reward()
    self.receiver_.owner_:add("黃金", 100)
    
    -- 下個任務：精煉裝備
    self:GiveItem('rma2')
end

function mt:on_timer(callback)
    -- 確保選擇天賦完不會一直觸發更新任務
    if self.demands_["選擇天賦"] and self.receiver_.owner_:get "天賦點" == 0 then
        self:Update("選擇天賦")
    end
    
    if self.demands_["選擇天賦"] == false and self:Near(-1793, -2991) then
        self:Update('n005')
        callback:Break()
    end
end

function mt:on_prepare()
    if self.receiver_.id_ == 'Hamg' then
        self.receiver_:AddAbility 'A001'
    end

    self.receiver_.owner_:add("天賦點", 1)
end