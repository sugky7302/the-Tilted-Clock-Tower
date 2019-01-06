-- 此module強化裝備屬性

local setmetatable = setmetatable

local Intensify = {}
setmetatable(Intensify, Intensify)

-- assert
local IsGoldEnough, IsRefine, GetGoldCost, NotLimit
local Print

local Random = require 'math_lib'.Random
local INTENSIFY_COEFFICIENT = {[0] = 1, 2, 3, 4, 6, 8, 10, 14, 18, 22, 31}
local INTENSIFY_POS = {-2026, -3991}

function Intensify:__call(equipment)
    -- 檢查有沒有在精煉爐附近
    local Point = require 'point'
    local unit_point, pos = Point.GetUnitLoc(equipment.owner_.object_)
    local is_near = false
    for i = 1, #INTENSIFY_POS, 2 do
        pos = Point(INTENSIFY_POS[i], INTENSIFY_POS[i+1])
        
        if Point.Distance(unit_point, pos) < 200 then
            is_near = true

            -- 避免break後的動作不會執行
            pos:Remove()
            break
        end

        pos:Remove()
    end

    unit_point:Remove()

    local Tip = require 'jass_tool'.Tip

    if not is_near then
        Tip(equipment.own_player_.object_, "|cff00ff00提示|r - 你不在精煉爐附近。")
        return false
    end

    if not NotLimit(equipment) then
        Tip(equipment.own_player_.object_, {"|cff00ff00提示|r - ", equipment:name(), " 的精煉值已達上限。"})
        return false 
    end

    local gold_cost = GetGoldCost(equipment)
    if not IsGoldEnough(equipment.own_player_, gold_cost) then
        Tip(equipment.own_player_.object_, {"|cff00ff00提示|r - 你攜帶的金錢不足。"})
        return false 
    end

    equipment.own_player_:add("黃金", -gold_cost)

    -- 精鍊失敗
    if not IsRefine(equipment.intensify_level_) then
        Tip(equipment.own_player_.object_, {"|cff00ff00提示|r - ", equipment:name(), " 精煉失敗。"})
        
        -- 失敗次數會提高下次強化的花費
        equipment.intensify_fail_times_ = equipment.intensify_fail_times_ + 1

        return false 
    end

    -- 精鍊成功會重置失敗次數
    equipment.intensify_fail_times_ = 0
    equipment.intensify_level_ = equipment.intensify_level_ + 1
    
    -- 奇數元素是固定提升值，偶數是隨機提升值
    local REFINE_TABLE = {1, 0,  1, 0,  1, 0,  1, 1,  1, 1,  1, 1,  2, 2,  2, 2,  2, 2,  4, 5}

    local fixed_value      = REFINE_TABLE[2 * equipment.intensify_level_]
    local random_max_value = REFINE_TABLE[2 * equipment.intensify_level_ + 1]

    local INTENSIFY_ATTRIBUTE = require 'intensify_attribute'

    -- 搜尋可被強化的屬性並增加屬性值
    for i = 1, equipment.attribute_count_ do
        local plus_value = fixed_value + Random(random_max_value)
        if INTENSIFY_ATTRIBUTE[equipment.attribute_[i][1]] then
            equipment.attribute_[i][2] = equipment.attribute_[i][2] + plus_value
            
            -- 英雄屬性也要更新
            equipment.owner_:add(equipment.attribute_[i][1], plus_value)
        end
    end
    
    -- 更新屬性
    equipment:Update()
    
    Tip(equipment.own_player_.object_, {"|cff00ff00提示|r - ", equipment:name(), " 精煉成功。"})
end

NotLimit = function(item)
    return item.intensify_level_ < 10
end

GetGoldCost = function(item)
    local modf = math.modf

    local base = 50 * (2 + modf(item.level_ + item.intensify_level_ - 1) / 8)
    local punishProc = 1 + 0.2 * item.intensify_fail_times_

    return base * item:GetGearScore() * INTENSIFY_COEFFICIENT[item.intensify_level_] * punishProc
end

IsGoldEnough = function(own_player, gold_cost)
    return own_player:get "黃金" >= gold_cost
end

IsRefine = function(intensify_level)
    local p = (intensify_level < 4) and 100 - 16 * intensify_level or 100 / intensify_level
    return Random(100) <= p
end

return Intensify