-- 統一處理物品事件

local Player = require 'player'
local Hero = require 'unit.hero'
local Unit = require 'unit.core'

-- Unit:Event "單位-發動技能效果" (function(_, source, id)
--     if id == Base.String2Id('') then
--         local Combine = require 'item.combine'
--         Combine(Hero(source)) -- FIXME:
--     end
-- end)

--                                       Unit instance         Item instance
Unit:Event "單位-發動技能效果" (function(_, source,       id, _, target_item, _)
    -- A008 = T秘物附魔
    if id == Base.String2Id('A008') then
        source.manipulated_item_ = target_item
    end
end)
    
--                                    Unit instance  Item instance
Unit:Event "單位-使用物品" (function(_, unit,          item)
    -- 如果是能獲得附魔目標才觸發
    if unit.manipulated_item_ and item.IsSecrets(item.object_) then
        local Enchanted = require 'item.enchanted'

        unit:UpdateAttributes("減少", unit.manipulated_item_)
    
        Enchanted.Insert(unit.manipulated_item_, item, false)
    
        unit:UpdateAttributes("增加", unit.manipulated_item_)
    end
end)

Unit:Event "單位-使用物品" (function(_, unit, item)
    local ExtendHole = require 'item.extend_hole'
    ExtendHole(item)
end)

Unit:Event "單位-使用物品" (function(_, unit, item)
    local Intensify = require 'item.intensify'
    Intensify(item)
end)

Player:Event "玩家-對話框被點擊" (function(_, player, button)
    -- 查詢最後點擊的產品
    local ipairs = ipairs
    for i, btn in ipairs(player.dialog_.buttons_) do
        if btn == button then
            last_enum_product = i
            break
        end
    end

    -- 關閉對話框
    player.dialog_:Show(false)
    player.dialog_:Clear()
end)

Unit:Event "單位-使用物品" (function(_, unit, equipment)
    if equipment:IsEquipment() then
        equipment:Update()
        equipment:Display()
    end
end)

-- 裝備顯示框被點擊事件
Player:Event "玩家-對話框被點擊" (function(_, player, button)
    -- 關閉對話框
    if player.dialog_:Find("關閉") == button then
        player.dialog_:Show(false)
        player.dialog_:Clear()
    end
end)