local setmetatable = setmetatable

local mt = {}
local Enchanted = {}
Enchanted.__index = mt
setmetatable(Enchanted, Enchanted)
print("1")
function Enchanted:__call()
end

function mt:Insert(item, secrets, isFixed)
end

function mt:Remove()
end

function mt:Sort()
end

return Enchanted