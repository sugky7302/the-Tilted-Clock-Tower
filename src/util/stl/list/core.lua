-- 本module是在lua上建構c++的泛型list，提供插入/移除任意類型元素

local setmetatable = setmetatable

local Node = require 'stl.node'
local mt = require 'stl.list.iterator'

local List = {}
setmetatable(List, List)
List.__index = mt

-- assert
local _EraseNode

-- 建構函式
function List:__call()
    local instance = {
        _begin_ = nil,
        _end_ = nil,
        _size_ = 0
    }

    setmetatable(instance, self)

    return instance
end

-- O(self._size_)的方法
function mt:Remove()
    -- 從末端刪除比較簡單
    for node in self:rTraverseIterator() do
        self:Delete(node)
    end

    self._begin_ = nil
    self._end_ = nil
    self._size_ = nil
    self = nil
end

function mt:Delete(node)
    if not node then 
        return false
    end

    if self:IsEmpty() then
        return true
    end

    if self._size_ == 1 then
        _EraseNode(self, node)

        -- list沒節點了，重置成員變數
        self._begin_ = nil
        self._end_ = nil

        return true
    end

    if node == self._begin_ then
        -- 把node的next_指標設定成新的first節點
        node.next_.prev_ = nil
        self._begin_ = node.next_
        
        _EraseNode(self, node)

        return true
    end

    if node == self._end_ then
        -- 把node的prev_指標設定成新的last節點
        node.prev_.next_ = nil
        self._end_ = node.prev_
        
        _EraseNode(self, node)

        return true
    end

    -- 處理刪除中間節點的情況
    -- 先把node的上個節點和下個節點相互指向對方
    node.prev_.next_ = node.next_
    node.next_.prev_ = node.prev_
    
    _EraseNode(self, node)

    return true
end

function mt:IsEmpty()
    return self._size_ == 0
end

_EraseNode = function(self, node)
    node:Remove()
    self._size_ = self._size_ - 1
end

function mt:PopFront()
    self:Delete(self._begin_)
end

function mt:PopBack()
    self:Delete(self._end_)
end

-- data 會插在 node 的前面
-- node 等於 nil，視作插在 list 的最末端
function mt:Insert(node, data)
    if not data then 
        return false
    end

    local node_new = Node(data)
    if self:IsEmpty() then

        -- 新node是第一個node，也是最後一個node
        self._begin_ = node_new
        self._end_ = node_new

        self._size_ = self._size_ + 1

        return true
    end

    -- 只需把first的prev_指標指向新節點
    if node == self._begin_ then
        self._begin_.prev_ = node_new
        node_new.next_ = self._begin_

        -- 更新first指標
        self._begin_ = node_new

        self._size_ = self._size_ + 1

        return true
    end

    -- 只需把last的next_指標指向新節點
    if not node then
        self._end_.next_ = node_new
        node_new.prev_ = self._end_

        -- 更新last指標
        self._end_ = node_new

        self._size_ = self._size_ + 1

        return true
    end

    -- 處理插在中間節點的情況
    -- 先把node的prev_指標指向新節點
    node_new.prev_ = node.prev_
    node.prev_.next_ = node_new

    -- 再把新節點的next_指標指向node
    node_new.next_ = node
    node.prev_ = node_new

    self._size_ = self._size_ + 1

    return true
end

function mt:PushFront(data)
    self:Insert(self._begin_, data)
end

function mt:PushBack(data)
    self:Insert(nil, data)
end

-- 只找第一筆資料
function mt:Find(data)
    for node in self:TraverseIterator() do
        if node:getData() == data then 
            return node
        end
    end

    return false
end

-- 獲取成員變量
function mt:getSize()
    return self._size_
end

function mt:getBegin()
    return self._begin_
end

function mt:getEnd()
    return self._end_
end

return List