local table_concat = table.concat
local mt = require 'quest.core' "入營試煉"
{
    detail_ = table_concat({"還記得我剛進來這裡的時候，也和你一樣恐懼。但是請不要害怕，不要畏懼恐懼，我們生來就必須面對這些挑戰，",
                            "只因為我們屬於時鐘塔。好好享受人生唯一一次的入營試煉吧！相信它會帶給你很大的收穫，就像當年的我一樣。"}),
    required_ = {"擊殺1隻豺狼人", "回報庫拉特"},
    demands_ = {'ngno', 1, 'n005', true},
    talk_ = "很開心你能通過這個試煉，相信你獲得了很大的收穫，但是這只是開始，在未來的日子裡，我會給你更大的壓力，因為我們已經快沒有時間了...",
    rewards_ = {"100金幣"}, 
}

function mt:on_reward()
    self.receiver_.owner_:add("黃金", 100)

    -- 任務：學習附魔
    self:GiveItem 'tst2'
end

function mt:on_timer(callback)
    -- 完成任務後，再返回找庫拉特，任務才算結束
    -- 不這麼寫的話，可能會產生「回去找庫拉特」先解完的情況
    if self.demands_['ngno'] == false and self:Near(-1793, -2991) then
        self:Update('n005')
        callback:Break()
    end
end