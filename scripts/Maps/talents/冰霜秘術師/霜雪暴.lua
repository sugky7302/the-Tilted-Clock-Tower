local mt = require 'talent' "霜雪暴"
{
    cost = 1,
    tip = "暴風雪的傷害半徑提高|cffffcc0030%|r。",
    skill = "暴風雪",
}

function mt:on_init(target)
    local skill = require 'skill'[self.skill]
    skill.area = skill.area * 1.3
    local japi = require 'jass.japi'
    japi.EXSetAbilityDataReal(japi.EXGetUnitAbility(target.object, Base.String2Id('A00H')), 1, 106, skill.area)
end