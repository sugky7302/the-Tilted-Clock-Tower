local Buff = require 'buff'

local mt = Buff "定身" {
    pulse = 0.1,
}

function mt:on_set(timeout, at_end)
    _ChangeTurnRate(self.owner)
    self.timer = Timer(self.pulse, timeout / self.pulse, function(callback)
        if at_end or callback.isPeriod < 1 or self.timer.invalid then
            _ReductTurnRate(self.owner, turnRate)
            self.timer = nil
        end
    end)
end

_ChangeTurnRate = function(hero)
    japi.EXSetUnitMoveType(hero.object, 0x01)
    hero:set("轉身速度", 0)
end

_ReductTurnRate = function(hero)
    japi.EXSetUnitMoveType(hero.object, 0x02)
    hero:set("轉身速度", mt._TURN_RATE)
end