local SkillUtil = {}
-- 使用逆變身更換模型
function mt:ChangeModel(unit, model)
    local AEme = require 'jass.slk'.ability.AEme
    AEme.DataA1 = model
    AEme.UnitID1 = unit.id_
    AEme.DataE1 = 0

    unit:AddAbility('AEme')
    unit:RemoveAbility('AEme')
end

function mt:RootCast(timeout)
    local period, turnRate = 0.1, _ChangeTurnRate(self.owner)
    local dummy = _CreateDummy(self.owner)
    self.rootCastTimer = Timer(period, timeout / period, function(callback)
        _ZoomDummy(dummy, timeout - callback.isPeriod * period)
        if (self.castbar and self.castbar.invalid) or (callback.isPeriod < 1) then
            _ReductTurnRate(self.owner, turnRate)
            js.RemoveUnit(dummy)
        end
    end)
end

_ChangeTurnRate = function(hero)
    local turnRate = 0.5
    japi.EXSetUnitMoveType(hero.object, 0x01)
    hero:set("轉身速度", 0)
    return turnRate
end

_CreateDummy = function(hero)
    local dummy = cj.CreateUnit(hero.owner.object, Base.String2Id('u009'), cj.GetUnitX(hero.object) - 16, cj.GetUnitY(hero.object) - 16, cj.GetUnitFacing(hero.object))
    return dummy
end

_ZoomDummy = function(dummy, dur)
    local scale = (dur % 2 <= 1) and dur % 2 or -1 * (dur % 2) + 2
    cj.SetUnitScale(dummy, 1 + scale, 1 + scale, 1)
end

_ReductTurnRate = function(hero, turnRate)
    japi.EXSetUnitMoveType(hero.object, 0x02)
    hero:set("轉身速度", turnRate)
end

return SkillUtil