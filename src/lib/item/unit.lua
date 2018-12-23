-- 初始化單位操作物品事件

-- package
local Unit = require 'unit.core'
local Equipment = require 'item.equipment.core'

function Unit.__index:DropEquipment(item)
    local equipment = Equipment(item)
    equipment:Rand(self.object_:get "等級", self.object_:get "階級")
end