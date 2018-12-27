local mt = require 'talent' "冰晶"
{
    cost_ = 5,
    tip_ = "當水元素攻擊受到冰冷效果影響的目標時，其傷害量會化為冰晶儲存，持續|Cffffcc0060|r秒。" ..
    "同一時間內最多可儲存|Cffffcc005|r顆冰晶。施放寒冰箭會釋放所有儲存的冰晶，造成額外傷害。",
    skill_ = "寒冰箭",

    damage_ = 0,
}

-- package
local Unit = require 'unit.core'

Unit:Event "單位-傷害完成" (function(_, source, target)
    if source.name_ == '水元素' and target:FindBuff "霜寒刺骨debuff" then
        source.owner_:TalentDispatch("冰晶", "添加", source:get "最後造成的傷害")
    end
end)

Unit:Event "單位-傷害結算" (function(_, source, name)
    if name == "寒冰箭" then
        source:TalentDispatch("冰晶", "刪除")
    end
end)

local Point = require 'point'

-- assert
local ipairs = ipairs
local CheckArray

function mt:on_add(target, damage)
    CheckArray(target)

    local MAX = 5
    if target.ice_crystals_:getLength() >= MAX then
        return false
    end

    local p = Point.GetUnitLoc(target.object_)
    p:UpdateZ()

    local Missile = require 'missile.core'
    local Rand = require 'math_lib'.Random
    local SetUnitHeight = require 'jass.common'.SetUnitFlyHeight

    local missile = Missile{
        owner_ = target,
        model_name_ = 'A046',
        hit_mode_ = "inf",

        starting_point_ = p,
            
        angle_ = Rand(0, 360),
        radius_ = 50,
        starting_height_ = p.z_ + 50,
        velocity_ = 1,
        velocity_max_ = 5,
        acceleration_ = 0.1,
        max_distance_ = 0,

        SetHeight = "SetSurroundHeight",
        TraceMode = "Surround",
    }

    -- 冰晶只存在60秒
    local Timer = require 'timer.core'
    local timer = Timer(60, false, function()
        target:add("額外法術傷害", -damage)
        self.damage_ = self.damage_ - damage

        for _, tb in ipairs(target.ice_crystals_) do 
            if tb[1] == missile then
                target.ice_crystals_:Delete(tb)
                missile:Remove()
                break
            end
        end
    end)

    target.ice_crystals_:PushBack({missile, timer})

    target:add("額外法術傷害", damage)
    self.damage_ = self.damage_ + damage
end

-- 跟隨寒冰箭出去
function mt:on_call(target, target_point, range)
    local TraceLib = require 'missile.trace'
    local frost_bolt = require 'skill.core'[self.skill_]

    local ipairs = ipairs
    for _, tb in ipairs(target.ice_crystals_) do
        local missile_point = Point.GetUnitLoc(tb[1].missile_.object_)

        -- 改變投射物軌跡
        tb[1].target_point_ = target_point + Point(0, 0)

        -- 要注意寒冰箭改了哪些
        tb[1].velocity_ = frost_bolt.velocity_
        tb[1].velocity_max_ = frost_bolt.velocity_
        tb[1].acceleration_ = 0

        -- 要用加法是因為環繞函數會一直增加max distance
        -- 如果沒加，會導致投射物的移動距離比寒冰箭短
        tb[1].max_distance_ = tb[1].max_distance_ + range

        tb[1].TraceMode = TraceLib.StraightLine
        tb[1].hit_mode_ = 1
        tb[1].angle_ = Point.Rad(missile_point, target_point)

        missile_point:Remove()
    end
end

-- 清空所有冰晶
function mt:on_remove(target)
    CheckArray(target)

    -- 這在寒冰箭施放結束後才觸發，投射物都已經刪除了，因此不需要再刪除投射物
    for i, tb in ipairs(target.ice_crystals_) do
        tb[2]:Break()
        target.ice_crystals_:Delete(tb)
    end

    -- 傷害清零以免影響下一次冰晶觸發
    target:add("額外法術傷害", -self.damage_)
    self.damage_ = 0
end

CheckArray = function(self)
    if not self.ice_crystals_ then
        local Array = require 'stl.array'
        self.ice_crystals_ = Array()
    end
end
