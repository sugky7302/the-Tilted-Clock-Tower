local mt = require 'talent' "冰槍術"
{
    cost = 1,
    tip = "寒冰箭擊中冰凍目標後，下一次的冷卻時間縮短2秒。",
    skill = "寒冰箭",
}

function mt:on_add(target)
    local japi = require 'jass.japi'
    japi.EXSetAbilityDataReal(japi.EXGetUnitAbility(target.object, Base.String2Id('A000')), 1, 105, self.data or 4)
    self.data = 4
end

function mt:on_call()
    self.data = 2
end