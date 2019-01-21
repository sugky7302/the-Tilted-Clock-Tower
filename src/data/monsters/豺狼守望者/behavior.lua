-- 豺狼守望者
-- 錘擊
-- 沖擊波(50%HP以下觸發)

local Timer = require 'timer.core'
local BT = require 'behavior_tree.behaviour_tree'

-- assert
local Hammering = BT.Task:new()
local ShockWaveCnd, ShockWaveExec = BT.Task:new(), BT.Task:new()
local ShockWave = BT.Sequence:new{
    nodes = {ShockWaveCnd, ShockWaveExec}
}

local function Behavior(unit)
    local mt = BT:new{
        object = unit,
        tree = BT.Sequence:new{
            nodes = {Hammering, ShockWave}
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

local Unit = require 'unit.core'
local Point = require 'point'
local Damage = require 'combat.damage'
local cj = require 'jass.common'

function Hammering:run(unit)
    local js = require 'jass_tool'

    local RADIUS = 300

    -- 設定技能預警圈

    local p_unit = Point.GetUnitLoc(unit.object_)
    local PreWarn = require 'skill.util'.PreWarn
    local PREWARN_TIME = 1
    PreWarn(RADIUS, p_unit, PREWARN_TIME)

    Timer(PREWARN_TIME, false, function()
        local Group = require 'group.core'
        local Knock = require 'mover.knock'
        local abs = math.abs

        local g = Group(unit.object_)
        g:EnumUnitsInRange(p_unit.x_, p_unit.y_, RADIUS, "IsEnemy")
        g:Loop(function(group, i)
            local p_enum = Point.GetUnitLoc(group.units_[i])

            -- 只對面前90度內的單位造成傷害
            local angle = Point.Deg(p_unit, p_enum)
            if abs(angle - cj.GetUnitFacing(unit.object_)) <= 120 then
                Damage{
                    source_ = unit,
                    target_ = Unit(group.units_[i]),
                
                    name_ = "錘擊",
                    type_ = "法術",
                    element_type_ = "無",
                }

                -- 生成一個區域來選取可破壞物
                local BIAS = 12.1
                local count = 0
                local p_now, p_previous
                Knock{
                    mover_ = Unit(group.units_[i]),
                    velocity_ = 400,
                    max_dist_ = 400,
                    angle_ = angle,
                    End_Cnd = function(this)
                        -- 利用點的偏移量判斷有沒有障礙物
                        p_previous = p_now
                        p_now = Point.GetUnitLoc(this.mover_.object_)

                        -- 偵測可破壞物
                        if p_previous and Point.Distance(p_previous, p_now) < BIAS then 
                            Unit(group.units_[i]):AddBuff "暈眩"
                            {
                                dur_ = 2,
                            }

                            p_previous:Remove()
                            p_now:Remove()

                            return true
                        end

                        if this.max_dist_ <= this.current_dist_ then
                            p_previous:Remove()
                            p_now:Remove()
                        end

                        if p_previous then
                            p_previous:Remove()
                        end

                        return false
                    end,
                }

            end

            p_enum:Remove()
        end)

        p_unit:Remove()

        self:success()
    end)
end

function ShockWaveCnd:run(unit)
    if (unit:get "生命" / unit:get "生命上限") < 0.5 then
        Timer(3, false, function()
            self:success()
        end)
    else
        self:fail()
    end
end

function ShockWaveExec:run(unit)
    local Point = require 'point'
    local p_unit = Point.GetUnitLoc(unit.object_)
    p_unit:UpdateZ()

    require 'mover.missile'{
        owner_ = unit,
        model_name_ = 'A057',
        hit_mode_ = "inf",
        
        starting_point_ = p_unit,
        slope_ = 0,
        
        angle_ = cj.GetUnitFacing(unit.object_),
        velocity_ = 1000,
        max_dist_ = 800,
        starting_height = p_unit.z_,
        enum_range_ = 100,
        
        TraceMode = "Line",

        GroupExecute = function(group, i)
            Damage{
                source_ = unit,
                target_ = Unit(group.units_[i]),

                name_ = "沖擊波",
                type_ = "法術",
                element_type_ = "無",
            }

            group:Ignore(group.units_[i])
        end,
    }

    self:success()
end

return Behavior