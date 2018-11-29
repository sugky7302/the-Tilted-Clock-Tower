local Buff = require 'buff'

local mt = Buff "暈眩"

-- constants
mt.model = [[Abilities\Spells\Human\Thunderclap\ThunderclapTarget.mdl]]

function mt:on_add()
    _ChangeTurnRate(self.target, 0x01, 0)
    Buff["沉默"].on_add(self)
    Buff['繳械'].on_add(self)
end

function mt:on_remove()
    _ChangeTurnRate(self.target, 0x02, mt._TURN_RATE)
    Buff["沉默"].on_remove(self)
    Buff['繳械'].on_remove(self)
end

_ChangeTurnRate = function(hero, index, val)
    local EXSetUnitMoveType = require 'japi'.EXSetUnitMoveType 
    
    EXSetUnitMoveType(hero.object, index)
    hero:set("轉身速度", 0)
end