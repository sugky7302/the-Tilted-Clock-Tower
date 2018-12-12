-- 此module替裝備附魔秘物
-- 發動技能效果事件 比 使用物品事件 更早觸發

local cj = require 'jass.common'

local Enchanted = {}

function Enchanted.Insert(equipment, secrets, is_fixed)
    -- 檢查屬性數量是否超過限制
    if equipment.attribute_count_ >= equipment.attribute_count_limit_ then
        cj.DisplayTimedTextToPlayer(equipment.owner_.owner_.object_, 0., 0., 6., "|cff00ff00提示|r - 已無空的秘環。")

        secrets:add("數量", 1)
        
        return false
    end
    
    local pairs = pairs

    -- 先確認那些屬性已經有了
    local existed_attribute = {}
    for _, attribute in pairs(equipment.attribute_) do
        existed_attribute[attribute[1]] = true
    end

    for name, val in pairs(secrets.attribute_) do
        -- 檢查是否有相同的屬性
        if existed_attribute[name] then
            cj.DisplayTimedTextToPlayer(item.owner_.owner_.object_, 0., 0., 6., "|cff00ff00提示|r - 已附魔相同的秘物。")

            -- 返還數量
            secrets:add('數量', 1)

            break
        end

        -- 添加屬性
        equipment.attribute_count_ = equipment.attribute_count_ + 1
        equipment.attribute_[equipment.attribute_count_] = {name, val, "", false}
    end

    -- 更新屬性
    equipment:Update()
end

return Enchanted