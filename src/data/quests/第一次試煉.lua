local table_concat = table.concat
local mt = require 'quest.core' "第一次試煉"
{
    detail_ = table_concat({"很高興能在第一次試煉見到你，$NAME。赫斯米爾外頭的|cffffcc00金礦森林|r有一隻豺狼守望者，",
                            "是森林中僅存的精英生物，你必須擊敗牠來證明自己有能力繼續之後的考驗。赫斯米爾不收無法通過試煉的戍時人",
                            "。|cffffcc00完成時間越慢，你的獎勵就越少|r，所以好好加油吧！"}),
    required_ = {"擊敗豺狼守望者", "回報庫拉特"},
    demands_ = {'ngnw', 1, 'n005', true},
    talk_ = "不錯，你有成為戍時人的候選資格。但這不過只是開胃菜，訓練從現在起才是真正的開始。",
    rewards_ = {"戍時人候選者勳章", "訓練衣", "200金幣"}, 
}

local dur = 0
local award_time, punish_time = 60, 120

function mt:on_reward()
    local max = math.max
    local reward

    if dur > punish_time then
        -- self:GiveItem ''
        -- self:GiveItem ''
        reward = max(200 - 2 * (dur - punish_time), 100)
    elseif dur > award_time then
        -- self:GiveItem ''
        -- self:GiveItem ''
        reward = 200
    else
        -- self:GiveItem ''
        -- self:GiveItem ''
        reward = 250 + 5 * (award_time - dur)
        
    end

    self.receiver_.owner_:add("黃金", reward)
    
    -- 把副本跟正本分離，這樣改動敘述才不會動到正本
    self.rewards_ = mt.rewards_
    self.rewards_[3] = table_concat({reward, "金幣"})

    -- 下個任務：
    -- self:GiveItem ''
end

-- TODO: 把執行時間顯示在排行榜上
function mt:on_timer(callback)
    -- 計算完成時間
    dur = dur + callback.timeout_ * callback.PERIOD

    if self.demands_['ngnw'] == false and self:Near(-1793, -2991) then
        -- 根據完成時間不同，給予不同的對話
        if dur > punish_time then
            self.talk_ = table_concat({"你完成的有點久，超時了|cffffcc00", dur - punish_time, "|r秒，不過還是勉強讓你通過吧！",
                                       "這不過是開胃菜，你完成起來就這麼困難，之後的訓練你得更努力才行。"})
        elseif dur < award_time then
            self.talk = table_concat({"非常好的表現，你比一般人快上|cffffcc00", award_time - dur, "|r秒，歷年來能達到如此成績之人，"
                                     ,"其後來的成就無不斐然，希望你能繼續保持。"})
        end
        
        self:Update('n005')
        callback:Break()
    end
end