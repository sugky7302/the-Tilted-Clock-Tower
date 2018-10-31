local mt = require 'talent' "嚴寒壓境"
{
    cost = 1,
    tip = "寒冰箭的施放距離提高|cffffcc0030%|r。",
    skill = "寒冰箭",
}


function mt:on_init(target)
    local skill = require 'skill'["寒冰箭"]
    skill.range = skill.range * 1.3
    local japi = require 'jass.japi'
    japi.EXSetAbilityDataReal(japi.EXGetUnitAbility(target.object, Base.String2Id('A000')), 1, 107, skill.range)
end