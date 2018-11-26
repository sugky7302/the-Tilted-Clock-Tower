local Buff = require 'buff'

local mt = Buff "束縛"

-- constants
mt.id = 'Abun'

function mt:on_add()
    Buff["定身"].on_add(self)
    Buff["繳械"].on_add(self)
end

function mt:on_remove()
    Buff["定身"].on_remove(self)
    Buff["繳械"].on_remove(self)
end