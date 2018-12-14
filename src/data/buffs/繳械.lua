local mt = require 'buff.core' "繳械"

-- constants
mt.id_ = 'Abun'

function mt:on_add()
    self.target_:AddAbility(mt.id_)
end

function mt:on_remove()
    self.target_:RemoveAbility(mt.id_)
end