local setmetatable = setmetatable

local Node, mt = {}, {}
setmetatable(Node, Node)
Node.__index = mt

-- assert
mt.type = "Node"

function Node:__call(data)
    local instance = {
        _data_ = data,
        prev_ = nil,
        next_ = nil,
    }

    setmetatable(instance, self)
    
    return instance
end

function mt:Remove()
    self._data_ = nil
    self.prev_ = nil
    self.next_ = nil
    self = nil
end

function mt:getData()
    return self._data_
end

return Node