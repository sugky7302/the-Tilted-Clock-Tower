local cj = require 'jass.common'

local mt = require 'buff' "定身"

function mt:on_add()
    cj.SetUnitPropWindow(self.target.object, 0)
end

function mt:on_remove()
    cj.SetUnitPropWindow(self.target.object, cj.GetUnitDefaultPropWindow(self.target.object))
end