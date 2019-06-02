--- 此module是將低級材料合成高級材料，比例為3:1
-- 依賴
--   jass_tool
--   point
--   jass.common
--   item.core


-- assert
local require = require
local CombineItem, IsAmountsEnough, IsGoldEnough, AddItem
local COMBINATIONS = require 'combinations'

local function Combine(item)
    local Tip = require 'jass_tool'.Tip

    if not COMBINATIONS[item.id_] then
        Tip(item.own_player_.object_, {"|cff00ff00提示|r - 這種材料無法合成。"})
        return false
    end

    if not IsAmountsEnough(item) then
        Tip(item.own_player_.object_, {"|cff00ff00提示|r - 你攜帶的材料不足。"})
        return false
    end

    local gold_cost = COMBINATIONS[item.id_ .. "_cost"]
    if not IsGoldEnough(item.own_player_, gold_cost) then
        Tip(item.own_player_.object_, {"|cff00ff00提示|r - 你攜帶的金錢不足。"})
        return false
    end
    
    item.own_player_:add("黃金", -gold_cost)
    
    CombineItem(item)
    
    Tip(item.own_player_.object_, {"|cff00ff00提示|r - 合成成功。"})
end

IsAmountsEnough = function(item)
    return item:get "數量" > 2
end

IsGoldEnough = function(player, gold_cost)
    return player:get "黃金" >= gold_cost
end

CombineItem = function(item)
    local combined_item_id = COMBINATIONS[item.id_]

    if item:get "數量" > 3 then
        item:add("數量", -3)
    else
        item:Remove()
    end

    AddItem(item.owner_.object_, combined_item_id)
end

AddItem = function(hero, id)
    local Point = require 'point'
    local Item = require 'item.core'

    local p = Point:GetUnitLoc(hero)
    local new_item = Item.Create(id, p)

    local UnitAddItem = require 'jass.common'.UnitAddItem
    UnitAddItem(hero, new_item)

    p:Remove()
end

return Combine