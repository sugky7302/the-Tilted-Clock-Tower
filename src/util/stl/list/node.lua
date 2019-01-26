-- list的節點，提供API讓外部能夠讀取node的資料。

local Node = require 'class'("Node")

-- default
Node.prev_ = nil
Node.next_ = nil

function Node:_new(data)
    self._data_ = data
end

function Node:getData()
    return self._data_
end

return Node