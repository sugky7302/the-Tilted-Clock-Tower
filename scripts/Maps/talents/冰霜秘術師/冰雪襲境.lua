local mt = require 'talent' "冰雪襲境"
{
    cost = 1,
    tip = "暴風雪的施放距離提高|cffffcc0040%|r。",
    skill = "暴風雪",
}

function mt:on_init(target)
    local skill = require 'skill'[self.skill]
    skill.range = skill.range * 1.4
    local japi = require 'jass.japi'
    japi.EXSetAbilityDataReal(japi.EXGetUnitAbility(target.object, Base.String2Id('A00H')), 1, 107, skill.range)
end