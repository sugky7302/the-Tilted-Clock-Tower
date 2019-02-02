-- 預設group的條件
-- 依賴
--   jass.common

-- package
local cj = require 'jass.common'


local GroupCondition = {}

function GroupCondition.IsEnemy(u, filter)
    return cj.GetUnitState(u, cj.UNIT_STATE_LIFE) > 0.3 and cj.IsUnitEnemy(u, cj.GetOwningPlayer(filter))
end

function GroupCondition.IsAlly(u,filter)
    return cj.GetUnitState(u, cj.UNIT_STATE_LIFE) > 0.3 and cj.IsUnitAlly(u, cj.GetOwningPlayer(filter))
end

function GroupCondition.IsHero(u, filter)
    return cj.IsUnitType(u, cj.UNIT_TYPE_HERO)
end

function GroupCondition.IsNonHero(u, filter)
    return not(cj.IsUnitType(u, cj.UNIT_TYPE_HERO))
end

function GroupCondition.Nil(u, filter)
    return true
end

return GroupCondition