local mt = require 'quest' "領取物資-1"
{
    detail = "菜鳥，今天真是你的幸運之日。總部剛好送來一批指定給新手的貨，快滾去|cffffcc00李維特|r那兒吧！",
    required = {"找到李維特"},
    demands = {'n007'},
    talk = "來的真是時候，新人。",
    rewards = {"學徒權杖"}, 
}

function mt:on_reward()
    self:GiveItem('ratc')
    self:GiveItem('rhe3')
end

function mt:on_timer(callback)
    if self:Near(-2151.8, -3703) then
        self:Update('n007')
        callback:Break()
    end
end