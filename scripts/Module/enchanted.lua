-- 發動技能效果事件 比 使用物品事件 更早觸發
local setmetatable = setmetatable
local cj = require 'jass.common'

local Enchanted = {}

function Enchanted.Init()
    local Game = require 'game'
    local Hero = require 'hero'
    local Equipment = require 'equipment'
    local Secrets = require 'secrets'
    local cj = require 'jass.common'
    local Item = require 'item'
    
    Game:Event "單位-發動技能效果" (function(self, source, id, _, targetItem, _)
        if id == Base.String2Id('A008') then
            Hero(source).manipulatedItem = Equipment(targetItem)
        end
    end)
    Game:Event "單位-使用物品" (function(self, unit, item)
        -- 如果是能獲得附魔目標才觸發
        if Hero(unit).manipulatedItem and Item.IsSecrets(item) then
            Enchanted.Insert(Hero(unit).manipulatedItem, Secrets(item), false)
        end
    end)
end

-- 附魔
function Enchanted.Insert(item, secrets, isFixed)
    local nameCollection = {}
    for _, tb in ipairs(item.attribute) do
        nameCollection[tb[1]] = true
    end
    for name, val in pairs(secrets.attribute) do
        -- 檢查屬性是否超過限制
        if item.attributeCount > item.attributeCountLimit then
            break
        end
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