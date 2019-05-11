-- list的節點，提供API讓外部能夠讀取node的資料。

local Node = require 'util.class'("Node")

function Node:_new(data)
    return {
        _data_ = data,
        prev_ = nil,
        next_ = nil
    }
end

function Node:getData()
    return self._data_
end

return Node