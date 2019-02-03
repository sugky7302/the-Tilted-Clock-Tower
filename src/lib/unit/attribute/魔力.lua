local require = require
local cj, japi = require 'jass.common', require 'jass.japi'

require 'unit.operator'.Register("魔力", {
    set = function(self, mana)
        cj.SetUnitState(self.object_, cj.UNIT_STATE_MANA, math.ceil(mana))
    end,

    get = function(self)
        return cj.GetUnitState(self.object_, cj.UNIT_STATE_MANA)
    end, 
    
    on_get = function(self, mana)
        if mana < 0 then
            return 0
        end

        local max_mana = self:get "魔力上限"
        if mana > max_mana then
            return max_mana
        end
        
        return mana
    end
})