local require = require
local japi = require 'jass.japi'

require 'unit.operator'.Register("物理攻擊力", {
    set = function(self, attack)
        japi.SetUnitState(self.object_, 0x12, self["最小物理攻擊力暫存"] + attack - 1)
        
        self["最小物理攻擊力"] = self["最小物理攻擊力暫存"] + attack
        self["最大物理攻擊力"] = self["最小物理攻擊力"] + self["骰子面數"] - 1
    end,

    get = function(self)
        self['最小物理攻擊力暫存'] = self:get "最小物理攻擊力"
        return self['物理攻擊力'] or 0
    end, 
})