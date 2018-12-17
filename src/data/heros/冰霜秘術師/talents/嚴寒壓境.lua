local mt = require 'talent' "嚴寒壓境"
{
    cost_ = 1,
    tip_ = "寒冰箭的施放距離提高|cffffcc0030%|r。",
    skill_ = "寒冰箭",
}

function mt:on_init(target)
    -- 修改技能數據
    local skill = require 'skill.core'[self.skill_]
    skill.range_ = skill.range_ * 1.3

    -- 修改物編數據
    local japi = require 'jass.japi'
    japi.EXSetAbilityDataReal(japi.EXGetUnitAbility(target.object_, Base.String2Id('A000')), 1, 107, skill.range_)
end