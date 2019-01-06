local table_concat = table.concat
local mt = require 'quest.core' "精煉裝備"
{
    detail_ = table_concat({"身為一名戰士，要了解如何尋找適合自己的裝備，提昇裝備更是基礎技能。既然你成功激發了血脈，",
                            "我就傳授給你時鐘塔提昇裝備的方法--精煉，這是時鐘塔的不傳之秘。\n",
                            "每樣裝備都能夠精煉，精煉值最高可達10。精煉值越高越容易失敗，失敗後必須多付|cffffcc0020%|r的費用",
                            "才能繼續精煉。精煉成功都會提昇屬性，精煉值越高，屬性提昇地越多。\n",
                            "營裡有一個精煉爐，你去邊上使用 精煉(|cffffcc00Q|r) 就能精煉你的裝備。",
                            "你先精煉|cffffcc00攻擊之爪|r給我看看吧！"}),
    required_ = {"前往精煉爐旁", "精煉出+1攻擊之爪", "回報庫拉特"},
    demands_ = {"前往精煉爐旁", true, "精煉", true, 'n005', true},
    talk_ = "很好，我想你已經知道怎麼精煉了。記得，一定要在精煉爐旁邊才能精煉。在這也恭喜你，第一階段你已經順利完成了。",
    rewards_ = {"233金幣"}, 
}

function mt:on_reward()
    self.receiver_.owner_:add("黃金", 233)
end

function mt:on_timer(callback)
    if self.demands_["前往精煉爐旁"] and self:Near(-2032, -4005) then
        self:Update "前往精煉爐旁" 
    end

    if self.demands_["精煉"] then
        local Item = require 'item.core'
        local UnitItemInSlot = require 'jass.common'.UnitItemInSlot

        local item
        for i = 0, 5 do
            item = Item(UnitItemInSlot(self.receiver_.object_, i))

            if item.id_ == 'ratf' and item.intensify_level_ > 0 then
                self:Update "精煉"
            end

            -- 減少迴圈執行次數
            if self.demands_["精煉"] == false then
                break
            end
        end
    end

    if self.demands_["精煉"] == false and self:Near(-1793, -2991) then
        self:Update('n005')
        callback:Break()
    end
end

function mt:on_prepare()
    self.receiver_:AddAbility 'A054'
end