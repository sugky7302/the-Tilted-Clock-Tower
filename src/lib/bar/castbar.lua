-- 此module為設定好的條，作為施法條之用

function Castbar(unit, timeout, isReverse)
    local Bar = require 'bar.core'
    return Bar(unit, timeout, "mediumblue", isReverse or false)
end

return Castbar
    