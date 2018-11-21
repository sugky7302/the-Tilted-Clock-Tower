-- 發動技能效果事件 比 使用物品事件 更早觸發
local setmetatable = setmetatable
local cj = require 'jass.common'

local Enchanted = {}

function Enchanted.Init()
    local Unit = require 'unit'
    local Equipment = require 'equipment'
    local Secrets = require 'secrets'
    local cj = require 'jass.common'
    local Item = require 'item'
    
    Unit:Event "單位-發動技能效果" (function(trigger, source, id, _, targetItem, _)
        if id == Base.String2Id('A008') then
            source.manipulatedItem = Equipment(targetItem)
        end
    end)
    Unit:Event "單位-使用物品" (function(trigger, unit, item)
        -- 如果是能獲得附魔目標才觸發
        if unit.manipulatedItem and Item.IsSecrets(item) then
            unit:UpdateAttributes("減少", unit.manipulatedItem)
            Enchanted.Insert(unit.manipulatedItem, Secrets(item), false)
            unit:UpdateAttributes("增加", unit.manipulatedItem)
        end
    end)
end

-- 附魔
function Enchanted.Insert(item, secrets, isFixed)
    -- 檢查屬性數量是否超過限制
    if item.attributeCount >= item.attributeCountLimit then
        cj.DisplayTimedTextToPlayer(item.ownPlayer.object, 0., 0., 6., "|cff00ff00提示|r - 已無空的秘環。")
        secrets:add("數量", 1)
        return
    end
    
    local nameCollection = {}
    for _, tb in ipairs(item.attribute) do
        nameCollection[tb[1]] = true
    end
    for name, val in pairs(secrets.attribute) do
        -- 檢查是否有相同的屬性
        if nameCollection[name] then
            cj.DisplayTimedTextToPlayer(item.ownPlayer.object, 0., 0., 6., "|cff00ff00提示|r - 已附魔相同的秘物。")
            secrets:add('數量', 1) -- 返還數量
            break
        end
        item.attributeCount = item.attributeCount + 1
        item.attribute[item.attributeCount] = {name, val, "", false}
    end
    item:Sort()
    item:Update()
end

-- 拆卸
function Enchanted.Erase()
end

return Enchanted