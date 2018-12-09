local cj = require 'jass.common'

require 'unit.operator'.Register("轉身速度", {
    set = function(self, val)
        cj.SetUnitTurnSpeed(self.object_, val)
    end,
    
    get = function(self)
        return cj.GetUnitTurnSpeed(self.object_)
    end
})