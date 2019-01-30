-- 在lua上建構c++的泛型list，提供插入/移除任意類型元素

-- package
local require = require
local List = require 'class'("List", require 'stl.list.iterator')

-- default
List._VERSION = "1.0.0"
List._begin_ = nil
List._end_   = nil
List._size_  = 0

-- assert
local EraseNode

function List:__tostring()
    local print_str = {"["}

    for node in self:TraverseIterator() do
        print_str[#print_str + 1] = node:getData()
        print_str[#print_str + 1] = " "
    end

    if print_str[#print_str] == " " then
        print_str[#print_str] = "]"
    else
        print_str[#print_str + 1] = "]" -- 代表list是空的，因此不要用覆蓋，不然會回傳 ] 而不是 []
    end

    return table.concat(print_str)
end

function List:Clear()
    self:_delete()

    self._begin_ = List._begin_
    self._end_ = List._end_
    self._size_ = List._size_
end

-- O(self._size_)的方法
function List:_delete()
    for node in self:rTraverseIterator() do
        self:Delete(node)
    end
end

function List:PopFront()
    self:Delete(self._begin_)
end

function List:PopBack()
    self:Delete(self._end_)
end

function List:Delete(node)
    if not node then 
        return false
    end

    if self:IsEmpty() then
        return true
    end

    if self._size_ == 1 then
        EraseNode(self, node)

        -- list沒節點了，重置成員變數
        self._begin_ = nil
        self._end_ = nil

        return true
    end

    if node == self._begin_ then
        -- 把node的next_指標設定成新的first節點
        node.next_.prev_ = nil
        self._begin_ = node.next_
        
        EraseNode(self, node)

        return true
    end

    if node == self._end_ then
        -- 把node的prev_指標設定成新的last節點
        node.prev_.next_ = nil
        self._end_ = node.prev_

        EraseNode(self, node)

        return true
    end

    -- 處理刪除中間節點的情況
    -- 先把node的上個節點和下個節點相互指向對方
    node.prev_.next_ = node.next_
    node.next_.prev_ = node.prev_
    
    EraseNode(self, node)

    return true
end

function List:IsEmpty()
    return self._size_ == 0
end

EraseNode = function(self, node)
    node:Remove()
    self._size_ = self._size_ - 1
end

function List:PushFront(data)
    self:Insert(self._begin_, data)
end

function List:PushBack(data)
    self:Insert(nil, data)
end

-- data 會插在 node 的前面
-- node 等於 nil，視作插在 list 的最末端
function List:Insert(node, data)
    if not data then 
        return false
    end

    local Node = require 'stl.list.node'
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

-- 只找第一筆資料
function List:Find(data)
    for node in self:TraverseIterator() do
        if node:getData() == data then 
            return node
        end
    end

    return false
end

-- 獲取私有成員變量
function List:getSize()
    return self._size_
end

function List:getBegin()
    return self._begin_
end

function List:getEnd()
    return self._end_
end

return List