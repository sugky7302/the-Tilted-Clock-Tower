local setmetatable = setmetatable

local mt = {}
local SmallSpiritEquipment = {}
SmallSpiritEquipment.__index = mt
setmetatable(SmallSpiritEquipment, SmallSpiritEquipment)

function SmallSpiritEquipment:__call()
end

return SmallSpiritEquipment