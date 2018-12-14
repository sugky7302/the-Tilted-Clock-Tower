local mt = require 'talent' "冰晶裂片"
{
    cost_ = 1,
    tip_ = "寒冰箭現在會穿透擊中的第一名敵人並對其身後的額外|cffffcc001|R名敵人造成傷害。",
    skill_ = "寒冰箭",
}

function mt:on_call()
    return 2
end