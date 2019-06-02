local require = require
local japi = require 'jass.japi'

require 'unit.operator'.Register("攻擊間隔", {
    set = function(self, attackCool)
        japi.SetUnitState(self.object_, 0x25, attackCool)
    end,

    get = function(self)
        return japi.GetUnitState(self.object_, 0x25)
    end, 
})