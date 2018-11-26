local setmetatable = setmetatable
local Bar = require 'bar'

local Castbar = {}
setmetatable(Castbar, Castbar)

function Castbar:__call(unit, timeout, isReverse)
    return Bar(unit, timeout, "mediumblue", isReverse or false)
end

return Castbar
    