local mt = require 'talent' "冰霜長矛"
{
    cost_ = 2,
    tip_ = "寒冰箭擊中受到冰冷效果影響的目標後，下一次的冷卻時間縮短|cffffcc002|r秒。",
    skill_ = "寒冰箭",
}

function mt:on_add(target)
    -- 調整物編數據(105:冷卻時間)
    local japi = require 'jass.japi'
    japi.EXSetAbilityDataReal(japi.EXGetUnitAbility(target.object_, Base.String2Id('A000')), 1, 105, self.data_ or 4)

    -- 重置冷卻
    self.data_ = 4
end

function mt:on_call(_, target)
    if not target:FindBuff "霜寒刺骨debuff" then
        return false
    end

    -- 縮短下一次冷卻
    self.data_ = 2
end