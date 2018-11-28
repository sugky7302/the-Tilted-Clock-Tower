local ListIterator = {}

-- assert
local _getNextNode, _getPrevNode

-- O(self._size_)的迭代器方法
function ListIterator.TraverseIterator(self)
    return _getNextNode --[[ (self, nil) ]], self, nil
end

_getNextNode = function(list, node)
    local node_next = (not node) and list._begin_ or node.next_
    return node_next
end

-- O(self._size_)的迭代器方法
function ListIterator.rTraverseIterator(self)
    return _getPrevNode --[[ (self, nil) ]], self, nil
end

_getPrevNode = function(list, node)
    local node_prev = (not node) and list._end_ or node.prev_
    return node_prev
end

return ListIterator