local mt = require 'quest.core' "領取物資-3"
{
    detail_ = "回去找|cffffcc00庫拉特|r吧！接下來的日子可沒有這麼好過了。",
    required_ = {"回去找庫拉特"},
    demands_ = {'n005', true},
    talk_ = "菜鳥，還記得回來啊！",
    rewards_ = {"300金幣"}, 
}

function mt:on_reward()
    self.receiver_.owner_:add("黃金", 300)
end

function mt:on_timer(callback)
    if self:Near(-1793, -2991) then
        self:Update('n005')
        callback:Break()
    end
end