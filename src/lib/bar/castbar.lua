-- 施法條

-- unit為Unit實例
local function Castbar(unit, timeout, is_reverse)
    local Bar = require 'bar.core'
    return Bar(unit, nil, timeout, "mediumblue", is_reverse or false)
end

return Castbar
    