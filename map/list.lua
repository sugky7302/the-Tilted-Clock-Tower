        local setmetatable = setmetatable
        local Node = require 'node'
        local Object = require 'object'
        local List = {}
        local mt = {}
        setmetatable(List, List)
        List.__index = mt
        local Next
        function List:__call()
            local obj = Object{
                head = nil,
                tail = nil,
                size = 0
            }
            setmetatable(obj, self)
            return obj
        end
        function mt:GetSize()
            return self.size
        end
        function mt:GetHead()
            return self.head
        end
        function mt:GetTail()
            return self.tail
        end
        function mt:Insert(node, data)
            if (self.size < 2) or (node == self.head) then
                self:PushFront(data)
            else
                local newNode = Node(data)
                local prevNode = node.prev
                newNode.prev = prevNode
                prevNode.next = newNode
                newNode.next = node
                node.prev = newNode
            end
            self.size = self.size + 1
        end
        function mt:PushFront(data)
            local newNode = Node(data)
            if self:IsEmpty() then
                self.head = newNode
                self.tail = newNode
            else
                local head = self.head
                head.prev = newNode
                newNode.next = head
                self.head = newNode
            end
            self.size = self.size + 1
        end
        function mt:PushBack(data)
            local newNode = Node(data)
            if self:IsEmpty() then
                self.head = newNode
                self.tail = newNode
            else
                local tail = self.tail
                tail.next = newNode
                newNode.prev = tail
                self.tail = newNode
            end
            self.size = self.size + 1
        end
        function mt:IsEmpty()
            return self.size < 1
        end
        function mt:Erase(node)
            if node.EIN == self.head.EIN then 
                self:PopFront()
            elseif node.EIN == self.tail.EIN then
                self.PopBack()
            else
                local prevNode = node.prev
                local nextNode = node.next
                prevNode.next = nextNode
                nextNode.prev = prevNode
                node:Remove()
                self.size = self.size - 1
            end
        end
        function mt:PopFront()
            if self.size == 1 then
                self.head:Remove()
                self.head = nil
                self.tail = nil
            else
                local head = self.head
                local currentNode = head.next
                currentNode.prev = nil
                head:Remove()
                self.head = currentNode
            end
            self.size = self.size - 1
        end
        function mt:Remove()
            while self.tail ~= nil do
                self:PopBack()
            end
        end
        function mt:PopBack()
            if self.size == 1 then
                self.head:Remove()
                self.head = nil
                self.tail = nil
            else
                local tail = self.tail
                local currentNode = tail.prev
                currentNode.next = nil
                tail:Remove()
                self.tail = currentNode
            end
            self.size = self.size - 1
        end
        function mt:Find(data)
            for node in self:Iterator() do
                if node.data == data then 
                    return node
                end
            end
            return nil
        end
        function mt:Iterator()
            return Next, self, nil
        end
        Next = function(list, node)
            if not node then
                return list.head
            else
                return node.next
            end
        end
        return List
    