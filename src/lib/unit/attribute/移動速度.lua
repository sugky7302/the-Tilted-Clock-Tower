local cj = require 'jass.common'

require 'unit.operator'.Register("移動速度", {
    set = function(self, move_speed)
        cj.SetUnitMoveSpeed(self.object_, move_speed)
    end,
    
    get = function(self)
        return cj.GetUnitDefaultMoveSpeed(self.object_)
    end
})