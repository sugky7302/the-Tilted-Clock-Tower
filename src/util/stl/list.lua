-- 在lua上建構c++的泛型list，提供插入/移除任意類型元素

-- package
local require = require
local List = require 'util.class'('List')

-- default
List._VERSION = '1.1.0'

function List:_new()
    return {
        _begin_ = nil,
        _end_ = nil,
        _size_ = 0
    }
end

function List:__tostring()
    local print_str = {'['}

    for node in self:iterator() do
        print_str[#print_str + 1] = node:getData()
    end

    print_str[#print_str + 1] = ']'

    return table.concat(print_str, ' ')
end

function List:clear()
    self:_delete()

    self._begin_ = nil
    self._end_ = nil
    self._size_ = 0
end

-- O(self._size_)的方法
function List:_delete()
    for node in self:reverseIterator() do
        self:delete(node)
    end
end

function List:erase(data)
    for node in self:reverseIterator() do
        if node:getData() == data then
            self:delete(node)
        end
    end
end

function List:pop_front()
    self:delete(self._begin_)
end

function List:pop_back()
    self:delete(self._end_)
end

local DeleteBeginNode, DeleteEndNode, DeleteMidNode, DeleteSingleNode

function List:delete(node)
    if not node then
        return false
    end

    if self:isEmpty() then
        return true
    end

    if self._size_ == 1 then
        DeleteSingleNode(self, node)
    elseif node == self._begin_ then
        DeleteBeginNode(self, node)
    elseif node == self._end_ then
        DeleteEndNode(self, node)
    else
        DeleteMidNode(self, node)
    end

    return true
end

local DeleteNode

DeleteSingleNode = function(self, node)
    DeleteNode(self, node)

    -- list沒節點了，重置成員變數
    self._begin_ = nil
    self._end_ = nil
end

DeleteBeginNode = function(self, node)
    -- 把node的next_指標設定成新的first節點
    node.next_.prev_ = nil
    self._begin_ = node.next_

    DeleteNode(self, node)
end

DeleteEndNode = function(self, node)
    -- 把node的prev_指標設定成新的last節點
    node.prev_.next_ = nil
    self._end_ = node.prev_

    DeleteNode(self, node)
end

DeleteMidNode = function(self, node)
    -- 處理刪除中間節點的情況
    -- 先把node的上個節點和下個節點相互指向對方
    node.prev_.next_ = node.next_
    node.next_.prev_ = node.prev_

    DeleteNode(self, node)
end

DeleteNode = function(self, node)
    node:remove()
    self._size_ = self._size_ - 1
end

function List:merge(other_list)
    for node in other_list:iterator() do
        self:push_back(node:getData())
    end

    other_list:remove()
end

function List:push_front(data)
    self:insert(data, self._begin_)
end

function List:push_back(data)
    self:insert(data, nil)
end

local ListEnd
local InsertNodeToBegin, InsertNodeToEmptyList, InsertNodeToEnd, InsertNodeFrontOfThePosition

-- node 等於 nil，視作插在 list 的最末端
function List:insert(data, node)
    if not data then
        return false
    end

    local new_node = require 'util.stl.node':new(data)

    if self:isEmpty() then
        InsertNodeToEmptyList(self, new_node)
    elseif node == self._begin_ then
        InsertNodeToBegin(self, new_node)
    elseif ListEnd(node) then
        InsertNodeToEnd(self, new_node)
    else
        InsertNodeFrontOfThePosition(new_node, node)
    end

    self._size_ = self._size_ + 1

    return true
end

InsertNodeToEmptyList = function(self, new_node)
    self._begin_ = new_node
    self._end_ = new_node
end

InsertNodeToBegin = function(self, new_node)
    -- 只需把頂端的prev_指標指向新節點
    self._begin_.prev_ = new_node
    new_node.next_ = self._begin_

    -- 頂端指向新的節點
    self._begin_ = new_node
end

ListEnd = function(node)
    return not node
end

InsertNodeToEnd = function(self, new_node)
    -- 只需把last的next_指標指向新節點
    self._end_.next_ = new_node
    new_node.prev_ = self._end_

    -- 末端指向新的節點
    self._end_ = new_node
end

InsertNodeFrontOfThePosition = function(new_node, node)
    -- 處理插在中間節點的情況
    -- 先把node的prev_指標指向新節點
    new_node.prev_ = node.prev_
    node.prev_.next_ = new_node

    -- 再把新節點的next_指標指向node
    new_node.next_ = node
    node.prev_ = new_node
end

-- 只找第一筆資料
function List:find(data)
    local i = 0
    for node in self:iterator() do
        i = i + 1

        if node:getData() == data then
            return node, i
        end
    end

    return false
end

-- assert
local IsNil = require 'util.is_nil'

-- O(self._size_)的迭代器方法
-- HACK: 使用閉包的寫法會比無狀態的迭代器多開銷
function List:iterator()
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
function List:reverseIterator()
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

-- 獲取私有成員變量
function List:isEmpty()
    return self._size_ == 0
end

function List:size()
    return self._size_
end

function List:getBegin()
    return self._begin_
end

function List:getEnd()
    return self._end_
end

function List:front()
    return self._begin_:getData()
end

function List:back()
    return self._end_:getData()
end

return List
