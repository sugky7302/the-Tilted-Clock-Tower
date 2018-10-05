local setmetatable = setmetatable

local mt = {}
local BigSpiritEquipment = {}
BigSpiritEquipment.__index = mt
setmetatable(BigSpiritEquipment, BigSpiritEquipment)

function BigSpiritEquipment:__call()
end

return BigSpiritEquipment