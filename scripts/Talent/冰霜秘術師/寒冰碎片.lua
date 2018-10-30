local mt = require 'talent' "寒冰碎片"
{
    cost = 1,
    tip = "寒冰箭現在會穿透擊中的第一名敵人並對其身後的額外一名敵人造成傷害。",
    skill = "寒冰箭",
}

function mt:on_call()
    return 2
end