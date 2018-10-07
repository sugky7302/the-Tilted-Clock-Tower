local setmetatable = setmetatable
local table = table

local Object = {}
local mt = {}
setmetatable(Object, Object)
Object.__index = mt

-- variables
Object.CountOfEIN = 0

function Object:__call(obj)
    obj = obj or {}
    self.CountOfEIN = self.CountOfEIN + 1
    obj.EIN = self.CountOfEIN
    return obj
end

function mt:Insert(data)
    table.insert(self, data)
end

function mt:Sort()
    table.sort(self)
end

return Object