-- 0x10:骰子數量
-- 0x11:骰子面數
-- 0x12:基礎傷害

local cj, japi = require 'jass.common', require 'jass.japi'

require 'unit.operator'.Register("最小物理攻擊力", {
    set = function(self, attack)
        local max_attack = self:get "最大物理攻擊力"
        
        -- -1是讓面板顯示正常
        japi.SetUnitState(self.object_, 0x12, attack - 1)

        if max_attack < attack then
            max_attack = attack
        end

        -- 調整最小攻擊力會影響到物理攻擊力
        self['最小物理攻擊力暫存'] = attack

        self:set("最大物理攻擊力", max_attack)
    end,

    get = function(self)
        -- 設定骰子數量、骰子面數
        japi.SetUnitState(self.object_, 0x10, 1)
        japi.SetUnitState(self.object_, 0x11, self["骰子面數"])

        local min = japi.GetUnitState(self.object_, 0x12) + 1
        return min
    end, 
})