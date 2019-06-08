-- 測試員的戰鬥行為
-- 隨機選擇器
-- - 攻擊
-- - 順劈斬

-- package
local Timer = require 'timer.core'
local BT = require 'behavior_tree.behaviour_tree'

-- assert
local Cleave = BT.Task:new()

local function Behavior(unit)
    local mt = BT:new{
        object = unit,
        tree = BT.Sequence:new{
            nodes = {Cleave}
        }
    }

    Timer(5, true, function(callback)
        mt:run(unit)

        if not unit:IsAlive() then
            -- 回傳中止狀態
            unit.behavior_running_ = false

            callback:Break()
        end
    end)
end

function Cleave:run(unit)
    local cj = require 'jass.common'
    local Unit = require 'unit.core'
    local Point = require 'point'
    local js = require 'jass_tool'

    local RADIUS = 300

    -- 設定技能預警圈
    local p_unit = Point.GetUnitLoc(unit.object_)
    local PreWarn = require 'skill.util'.PreWarn
    PreWarn(RADIUS, p_unit, 1)

    Timer(1, false, function()
        local Damage = require 'combat.damage'
        local Group = require 'group.core'
        local abs = math.abs

        local g = Group(unit.object_)
        g:EnumUnitsInRange(p_unit.x_, p_unit.y_, RADIUS, "IsEnemy")
        g:Loop(function(group, i)
            local p_enum = Point.GetUnitLoc(group.units_[i])

            -- 只對面前90度內的單位造成傷害
            if abs(Point.Deg(p_unit, p_enum) - cj.GetUnitFacing(unit.object_)) <= 90 then
                Damage{
                    source_ = unit,
                    target_ = Unit(group.units_[i]),
                
                    name_ = "順劈斬",
                    type_ = "法術",
                    element_type_ = "無",
                }
            end

            p_enum:Remove()
        end)

        p_unit:Remove()

        self:success()
    end)
end

return Behavior
