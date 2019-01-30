local mod = {_VERSION = "1.0.0"}

-- assert
local IsNil = require 'is_nil'

-- O(self._size_)的迭代器方法
function mod.TraverseIterator(self)
    local node = self._begin_
    return function()
        if IsNil(node) then
            return nil 
        end

        local prev = node
        node = node.next_ or nil
        return prev
    end
end

-- O(self._size_)的迭代器方法
function mod.rTraverseIterator(self)
    local node = self._end_
    return function()
        if IsNil(node) then
            return nil 
        end

        local prev = node
        node = node.prev_ or nil
        return prev
    end
end


return mod