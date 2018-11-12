local setmetatable = setmetatable

local BT, mt = {}, {}
setmetatable(BT, BT)
BT.__index = mt

function BT:__call(unit)
    local obj = {}
    setmetatable(obj, BT)
    return obj
end

return BT