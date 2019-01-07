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
            callback:Break()
        end
    end)
end

function Cleave:run(unit)
    local Group = require 'group.core'
    local Point = require 'point'
    local Facing = require 'jass.common'.GetUnitFacing
    local Damage = require 'combat.damage'
    local Unit = require 'unit.core'
    local abs = math.abs

    local g, p_unit = Group(unit.object_), Point.GetUnitLoc(unit.object_)
    g:EnumUnitsInRange(p_unit.x_, p_unit.y_, 300, "IsEnemy")
    g:Loop(function(group, i)
        local p_enum = Point.GetUnitLoc(group.units_[i])

        -- 只對面前半圓的單位造成傷害
        if abs(Point.Deg(p_unit, p_enum) - Facing(unit.object_)) <= 90 then
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

    g:Remove()
    p_unit:Remove()

    self:success()
end

return Behavior
