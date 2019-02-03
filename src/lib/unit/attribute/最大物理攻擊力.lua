-- 0x10:骰子數量
-- 0x11:骰子面數
-- 0x12:基礎傷害


local require = require
local cj, japi = require 'jass.common', require 'jass.japi'

require 'unit.operator'.Register("最大物理攻擊力", {
    set = function(self, attack)
        local side = math.max(1, attack - self:get "最小物理攻擊力")
        japi.SetUnitState(self.object_, 0x11, side)

        -- 固定骰子數量為1，只要調整骰子面數就可以改變攻擊力
        self["骰子面數"] = side
    end,

    get = function(self)
        local max = japi.GetUnitState(self.object_, 0x12) + self["骰子面數"]
        return max
    end, 
})