local require = require


local Combine = require 'util.class'("Combine")
local CombineItem, IsAmountsEnough, IsGoldEnough, AddItem


function Combine:_new(consumables)
    return {
        _object_ = consumables,
        _message_ = nil,
    }
end

function Combine:invoke()
    local Combination_db = require 'data.combination_db'
    local combination = Combination_db:query(self._object_:getType())

    if not combination then
        self._message_ = "|cff00ff00提示|r - 這種材料無法合成。"
        return false
    end

    if IsNotEnough(self._object_) then
        self._message_ = "|cff00ff00提示|r - 你攜帶的材料不足。"
        return false
    end

    if IsGoldNotEnough(self._object_) then
        self._message_ = table.concat{"|cff00ff00提示|r - 你還缺少", GetCost(self._object_) - 100, "。"}
        return false
    end
    
    -- 扣錢
    
    CombineItem(item)
    
    self._message_ = "|cff00ff00提示|r - 合成成功。"
    return true
end

IsNotEnough = function(consumables)
    return consumables:getCount() < 3
end

IsGoldNotEnough = function(consumables, gold_cost)
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