local japi = require 'jass.japi'

require 'unit.operator'.Register("攻擊速度", {
    set = function(self, attackSpeed)
        if attackSpeed >= 0 then
            japi.SetUnitState(self.object_, 0x51, 1 + attackSpeed / 100)
        else
            --当物理攻擊力速度小于0的时候,每点相当于攻擊間隔增加1%
            japi.SetUnitState(self.object_, 0x51, 1 + attackSpeed / (100 - attackSpeed))
        end
    end,
})