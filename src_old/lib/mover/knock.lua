-- 擊退系統，會根據地區不同給予不同特效
-- 依賴
--   mover.core
--   point
--   jass.common
--   jass_tool
-- data內需要有以下參數
-- mover_
-- velocity_
-- max_dist_
-- angle_(度)

local function Knock(data)
    local require = require

    data.velocity_ = data.velocity_ or 300
    data.velocity_max_ = data.velocity_max_ or data.velocity_
    data.acceleration_ = data.acceleration_ or 0
    
    data.TraceMode = "StraightLine"

    -- 設定特效
    data.Execute = function(self)
        local AddEffect = require 'jass.common'.AddSpecialEffect
        local TimeEffect = require 'jass_tool'.TimeEffect
        local GetUnitLoc = require 'point'.GetUnitLoc
        
        local p_unit = GetUnitLoc(self.mover_.object_)

        TimeEffect(AddEffect("Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl", p_unit.x_, p_unit.y_), 2*self.PERIOD)
        
        p_unit:Remove()
    end

    local Mover = require 'mover.core'
    return Mover(data)
end

return Knock