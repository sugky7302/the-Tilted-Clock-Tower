local mt = require 'talent' "冰雪襲境"
{
    cost_ = 1,
    tip_ = "暴風雪的施放距離提高|cffffcc0040%|r。",
    skill_ = "暴風雪",
}

function mt:on_init(target)
    -- 調整技能數據
    local skill = require 'skill.core'[self.skill_]
    skill.range_ = skill.range_ * 1.4

    -- 調整物編數據(107:施放距離)
    local japi = require 'jass.japi'
    japi.EXSetAbilityDataReal(japi.EXGetUnitAbility(target.object_, Base.String2Id('A00H')), 1, 107, skill.range_)
end