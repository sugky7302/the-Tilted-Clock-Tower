local require = require
local Secrets = require 'util.class'("Secrets", require 'lib.consumables')


function Secrets:_new(tb)
    local Secrets_db = require 'data.secrets_db'

    local instance = self:super():_new(tb)

    local attribute = Secrets_db:query(tb.type)
    instance._attribute_name_ = attribute[2]
    instance._attribute_value_ = attribute[3]

    return instance
end

function Secrets:getAttribute()
    return self._attribute_name_, self._attribute_value_
end

return Secrets
