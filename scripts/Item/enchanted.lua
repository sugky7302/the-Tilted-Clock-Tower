-- 發動技能效果事件 比 使用物品事件 更早觸發
local setmetatable = setmetatable

local Enchanted = {}

function Enchanted.Init()
    local Game = require 'game'
    local Hero = require 'hero'
    local Equipment = require 'equipment'
    local Secrets = require 'secrets'
    local cj = require 'jass.common'
    
    Game:Event "單位-發動技能效果" (function(self, source, id, _, targetItem, _)
        if id == Base.String2Id('A008') then
            Hero(source).manipulatedItem = Equipment(targetItem)
        end
    end)
    Game:Event "單位-使用物品" (function(self, unit, item)
        -- 如果是能獲得附魔目標才觸發
        if Hero(unit).manipulatedItem then
            Enchanted.Insert(Hero(unit).manipulatedItem, Secrets(item), false)
        end
    end)
end

function Enchanted.Insert(item, secrets, isFixed)
    for name, val in pairs(secrets.attribute) do
    print("run")
    print(name .. "./" .. val)
        if item.attributeCount > item.attributeCountLimit then
            break
        end
        item.attributeCount = item.attributeCount + 1
        item.attribute[item.attributeCount] = {name, val}
    end
    item:Sort()
    item:Update()
end

function Enchanted.Erase()
end

return Enchanted