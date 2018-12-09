local japi = require 'jass.japi'

require 'unit.operator'.Register("物理護甲", {
    set = function(self, defence)
        japi.SetUnitState(self.object_, 0x20, defence)
    end,

    get = function(self)
        return japi.GetUnitState(self.object_, 0x20)
    end, 
})