-- 此module為設定好的條，作為施法條之用

function Castbar(unit, timeout, is_reverse)
    local Bar = require 'bar.core'
    return Bar(unit, nil, timeout, "mediumblue", is_reverse or false)
end

return Castbar
    