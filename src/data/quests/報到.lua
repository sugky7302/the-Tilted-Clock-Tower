local table_concat = table.concat
local mt = require 'quest.core' "報到"
{
    detail_ = "向訓練營教官|cffffcc00庫拉特|r報到。",
    required_ = {"找到庫拉特"},
    demands_ = {'n005', true},
    talk_ = table_concat({"又是一個可憐的孤兒，赫斯米爾的殘酷可不是你們這些小傢伙能夠承受的，也不曉得是哪個天殺的把你們送來這裡。",
                          "既然算了，既然是時鐘塔的倖存者，你們在未來還是會遇到那些該死的傢伙，早點接受訓練也是好事。$NAME，",
                          "你準備好接受入營試煉了嗎？"}),
    -- rewards_ = nil,
}

function mt:on_reward()
    -- 任務：入營試煉
    self:GiveItem 'manh'
end

function mt:on_timer(callback)
    if self:Near(-1793, -2991) then
        self:Update('n005')
        callback:Break()
    end
end