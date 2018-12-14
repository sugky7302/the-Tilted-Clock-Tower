local cj = require 'jass.common'

local mt = require 'buff.core' "定身"

function mt:on_add()
    cj.SetUnitPropWindow(self.target_.object_, 0)
end

function mt:on_remove()
    cj.SetUnitPropWindow(self.target_.object_, cj.GetUnitDefaultPropWindow(self.target_.object_))
end