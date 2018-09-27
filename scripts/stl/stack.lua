local setmetatable = setmetatable

local stack = {}
local mt = {}
setmetatable(stack, stack)
stack.__index = mt

function stack:__call(type)
    newObject = {
        type = type,
        top = nil,
        size = 0, 
    }
    setmetatable(newObject, self)
    newObject.__index = newObject
    return newObject
end

function mt:Push(data)
    self.size += 1
    self[self.size] = data
    self.top = data
end

function mt:Pop()
    self[self.size] = nil
    self.size -= 1
    self.top = self[self.size] or nil
end

function mt:Top()
    return self.top
end

function mt:IsEmpty()
    return self.size < 1
end

function mt:GetSize()
    return self.size
end

function mt:GetType()
    return self.type
end

return stack