local japi = require 'jass.japi'

local mt = require'buff' "暈眩"

-- constants
mt.model = [[Abilities\Spells\Human\Thunderclap\ThunderclapTarget.mdl]]

function mt:on_add()
    _ChangeTurnRate(self.target)
end

_ChangeTurnRate = function(hero)
    japi.EXSetUnitMoveType(hero.object, 0x01)
    hero:set("轉身速度", 0)
end

function mt:on_remove()
    _ReductTurnRate(self.target, mt._TURN_RATE)
end

_ReductTurnRate = function(hero)
    japi.EXSetUnitMoveType(hero.object, 0x02)
    hero:set("轉身速度", mt._TURN_RATE)
end