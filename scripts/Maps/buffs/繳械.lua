local mt = require 'buff' "繳械"

-- constants
mt.id = 'Abun'

function mt:on_add()
    self.target:AddAbility(mt.id)
end

function mt:on_remove()
    self.target:RemoveAbility(mt.id)
end