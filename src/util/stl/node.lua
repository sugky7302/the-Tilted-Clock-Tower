local setmetatable = setmetatable

local Node, mt = {}, {}
setmetatable(Node, Node)
Node.__index = mt

function Node:__call(data)
    local instance = {
        data_ = data,
        prev_ = nil,
        next_ = nil,
    }

    setmetatable(instance, self)
    
    return instance
end

function mt:Remove()
    self.data_ = nil
    self.prev_ = nil
    self.next_ = nil
    self = nil
end

return Node