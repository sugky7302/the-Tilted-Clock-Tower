-- 擊退系統，會根據地區不同給予不同特效
-- data內需要有以下參數
-- mover_
-- velocity_
-- max_dist_
-- angle_(度)

local function Knock(instance)
    local Mover = require 'mover.core'
    local Point = require 'point'

    instance.velocity_max_ = instance.velocity_max_ or instance.velocity_
    instance.acceleration_ = instance.acceleration_ or 0
    
    instance.TraceMode = "Line"

    -- 透過設定0讓util.projectile無效化
    -- 起始高度要一直更新，不然會跟地面高度不符，導致mover會升高的問題
    local p_unit = Point.GetUnitLoc(instance.mover_.object_)
    p_unit:UpdateZ()
    instance.starting_height_ = p_unit.z_
    p_unit:Remove()

    instance.height_ = 0
    instance.slope_ = 0

    -- 設定特效
    local AddEffect = require 'jass.common'.AddSpecialEffect
    local TimeEffect = require 'jass_tool'.TimeEffect
    instance.Execute = function(self)
        local p_unit = Point.GetUnitLoc(self.mover_.object_)
        p_unit:UpdateZ()
        self.starting_height_ = p_unit.z_

        TimeEffect(AddEffect("Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl", p_unit.x_, p_unit.y_), 2*self.PERIOD)
        
        p_unit:Remove()
    end

    return Mover(instance)
end

return Knock