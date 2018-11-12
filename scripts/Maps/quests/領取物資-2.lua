local mt = require 'quest' "領取物資-2"
{
    detail = "希望你能好好使用這把武器，趕緊去找|cffffcc00拉菲-欺詐|r領取物資吧！有了那些物資，在戰場上才能更好地生存下來。",
    required = {"找到拉菲-欺詐"},
    demands = {'n000'},
    talk = "新人，你走大運了。",
    rewards = {"3瓶生命藥水"}, 
}

function mt:on_reward()
    self:GiveItem('phea', 3)
    self:GiveItem('rma2')
end

function mt:on_timer(callback)
    if self:Near(-2536.7, -3699.1) then
        self:Update('n000')
        callback:Break()
    end
end