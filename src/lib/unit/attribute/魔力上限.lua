local require = require
local cj, japi = require 'jass.common', require 'jass.japi'

require 'unit.operator'.Register("魔力上限", {
    set = function(self, max_mana)
        japi.SetUnitState(self.object_, cj.UNIT_STATE_MAX_MANA, max_mana)
    end,

    get = function(self)
        return cj.GetUnitState(self.object_, cj.UNIT_STATE_MAX_MANA)
    end, 
    
    on_set = function(self)
        local rate = self:get "魔力" / self:get "魔力上限"
        return function()
            self:set("魔力", self:get "魔力上限" * rate)
        end
    end
})