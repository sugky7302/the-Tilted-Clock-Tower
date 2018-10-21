local Item = require 'item'
local js = require 'jass_tool'
require 'secrets_database'

local Secrets = {}
Secrets.__index = Item
setmetatable(Secrets, Secrets)

-- variables
local _GenerateAttributes

function Secrets:__call(item)
    local obj = self[js.H2I(item) .. ""]
    if not obj then
        obj = Item(item)
        _GenerateAttributes(obj)
        self[js.H2I(item) .. ""] = obj
        setmetatable(obj, obj)
        obj.__index = self
    end
    return obj
end

_GenerateAttributes = function(self)
    self.attribute = {}
    if not SecretsDatabase[self.id] then
        return 
    end
    for name, val in pairs(SecretsDatabase[self.id]) do
        self.attribute[name] = val
    end
end

function Secrets:set(name, val)
    if not SecretsDatabase[self.id][name] then
        return 
    end
    if not self.attribute[name] then
        self.attribute[name] = SecretsDatabase[self.id][name]
    end
    self.attribute[name] = val
end

function Secrets:get(name)
    if not SecretsDatabase[self.id][name] then
        return 
    end
    if not self.attribute[name] then
        self.attribute[name] = SecretsDatabase[self.id][name]
    end
    return self.attribute[name]
end

return Secrets