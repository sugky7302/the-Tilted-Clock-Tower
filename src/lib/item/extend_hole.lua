-- 此module會提高裝備可附魔的上限
-- 依賴
--   jass_tool
--   math_lib


-- assert
local GetGoldCost, IsGoldEnough, CanExtend

local function ExtendHole(equipment)
    local Tip = require 'jass_tool'.Tip

    local gold_cost = GetGoldCost(equipment.level_ + equipment.intensify_level_, equipment.attribute_count_)
    if not IsGoldEnough(equipment.own_player_, gold_cost) then
        Tip(equipment.own_player_.object_, {"|cff00ff00提示|r - 你攜帶的金錢不足。"})
        return false 
    end

    if not CanExtend(equipment) then
        Tip(equipment.own_player_.object_, {"|cff00ff00提示|r - ", equipment:name(), " 的環數已達上限。"})
        return false 
    end

    equipment.own_player_:add("黃金", -gold_cost)
    
    equipment.attribute_count_limit_ = equipment.attribute_count_limit_ + 1
    
    Tip(equipment.own_player_.object_, {"|cff00ff00提示|r - ", equipment:name(), " 鑲環成功。"})
end

GetGoldCost = function(level, hole_count)
    local e, modf = require 'math_lib'.e, math.modf

    return 100 * e ^ hole_count * level * (modf((level-1) / 8) + 1)
end

IsGoldEnough = function(player, gold_cost)
    return player:get "黃金" >= gold_cost
end

CanExtend = function(equip)
    return equip.attribute_count_limit_ < 5
end

return ExtendHole