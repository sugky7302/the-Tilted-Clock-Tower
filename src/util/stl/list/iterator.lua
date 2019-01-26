local mod = {}

-- assert
local getNextNode, getPrevNode

-- O(self._size_)的迭代器方法
function mod.TraverseIterator(self)
    return getNextNode --[[ (self, nil) ]], self, nil
end

getNextNode = function(list, node)
    local node_next = (not node) and list._begin_ or node.next_
    return node_next
end

-- O(self._size_)的迭代器方法
function mod.rTraverseIterator(self)
    return getPrevNode --[[ (self, nil) ]], self, nil
end

getPrevNode = function(list, node)
    local node_prev = (not node) and list._end_ or node.prev_
    return node_prev
end

return mod