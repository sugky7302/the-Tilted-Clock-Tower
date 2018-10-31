local mt = require 'talent' "冰霜長矛"
{
    cost = 2,
    tip = "寒冰箭擊中受到冰冷效果影響的目標後，下一次的冷卻時間縮短|cffffcc002|r秒。",
    skill = "寒冰箭",
}

function mt:on_add(target)
    local japi = require 'jass.japi'
    japi.EXSetAbilityDataReal(japi.EXGetUnitAbility(target.object, Base.String2Id('A000')), 1, 105, self.data or 4)
    self.data = 4
end

function mt:on_call()
    if not target:FindBuff("霜寒刺骨debuff") then
        return 
    end
    self.data = 2
end