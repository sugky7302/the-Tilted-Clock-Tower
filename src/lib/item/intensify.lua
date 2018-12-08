-- 此module強化裝備屬性

local setmetatable = setmetatable

local Intensify = {}
setmetatable(Intensify, Intensify)

-- assert
local IsGoldEnough, IsRefine, GetGoldCost, NotLimit
local Print

function Intensify.Init()
    local Unit = require 'unit'

    Unit:Event "單位-使用物品" (function(_, unit, item)
        Intensify(item)
    end)
end

local Random = require 'math_lib'.Random
local INTENSIFY_COEFFICIENT = {[0] = 1, 2, 3, 4, 6, 8, 10, 14, 18, 22, 31}

function Intensify:__call(equipment)
    local Tip = require 'jass_tool'.Tip

    if not NotLimit(equipment) then
        Tip(equipment.own_player_.object_, {"|cff00ff00提示|r - ", equipment:name(), " 的精鍊值已達上限。"})

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
        Tip(equipment.own_player_.object_, {"|cff00ff00提示|r - ", equipment:name(), " 精鍊失敗。"})
        
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
        if INTENSIFY_ATTRIBUTE[equipment.attribute_[i][1]] then
            equipment.attribute_[i][2] = equipment.attribute_[i][2] + fixed_value + Random(random_max_value)
        end
    end
    
    -- 更新屬性
    equipment:Update()
    
    Tip(equipment.own_player_.object_, {"|cff00ff00提示|r - ", equipment:name(), " 精鍊成功。"})
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