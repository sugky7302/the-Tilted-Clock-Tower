local mt = require 'talent' "霜雪暴"
{
    cost_ = 1,
    tip_ = "暴風雪的傷害半徑提高|cffffcc0030%|r。",
    skill_ = "暴風雪",
}

function mt:on_init(target)
    -- 修改技能數據
    local skill = require 'skill.core'[self.skill_]
    skill.area_ = skill.area_ * 1.3

    -- 修改物編數據(106:影響範圍)
    local japi = require 'jass.japi'
    japi.EXSetAbilityDataReal(japi.EXGetUnitAbility(target.object_, Base.String2Id('A00H')), 1, 106, skill.area_)
end