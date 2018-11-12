local mt = require 'quest' "報到"
{
    detail = "向訓練營教官|cffffcc00庫拉特|r報到。",
    required = {"找到庫拉特"},
    demands = {'n005'},
    talk = "唉呦！又有一個菜鳥來啦！看大爺怎麼樣好好調教你！",
    rewards = {"50金幣"}, 
}

function mt:on_reward()
    self.receiver.owner:add("黃金", 50)
end

function mt:on_timer(callback)
    if self:Near(-1793, -2991) then
        self:Update('n005')
        callback:Break()
    end
end