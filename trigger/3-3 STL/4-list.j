<?
    import 'list.lua' [==[
        local setmetatable = setmetatable
        local Node = require 'node'

        local List = {}
        setmetatable(List,List)
        List.__index = List

        local Next

        function List:__call()
            local obj = {head = nil, tail = nil, size = 0}
            setmetatable(obj, self)
            return obj
        end

        function List:GetSize()
            return self.size
        end

        function List:GetHead()
            return self.head
        end

        function List:GetTail()
            return self.tail
        end

        function List:Insert(node, data)
            local newNode = Node(data)
            if (self.size < 2) or (node == self.head) then
                self:PushFront(newNode)
            else
                newNode.prev = node.prev
                node.prev.next = newNode
                newNode.next = node
                node.prev = newNode
            end
            self.size = self.size + 1
        end

        function List:PushFront(data)
            local newNode = Node(data)
            if self:IsEmpty() then
                self.head = newNode
                self.tail = newNode
            else
                self.head.prev = newNode
                newNode.next = self.head
                self.head = newNode
            end
            self.size = self.size + 1
        end

        function List:PushBack(data)
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

        function List:IsEmpty()
            return self.size < 1
        end

        function List:Erase(node)
            if node.EIN == self.head.EIN then          
                self:PopFront()
            elseif node.EIN == self.tail.EIN then
                self.PopBack()
            else
                for currentNode in self:Iterator() do
                    if currentNode.EIN == node.EIN then 
                        currentNode.prev.next = currentNode.next
                        currentNode.next.prev = currentNode.prev
                        currentNode:Remove()
                        self.size = self.size - 1
                        break
                    end
                end
            end
        end

        function List:PopFront()
            if self.size < 2 then
                self.head:Remove()
            else
                local currentNode = self.head.next
                currentNode.prev = nil
                self.head.next = nil
                self.head:Remove()
                self.head = currentNode
            end
            self.size = self.size - 1
        end

        function List:PopBack()
            if self.size < 2 then
                self.head:Remove()
            else
                local currentNode = self.tail.prev
                currentNode.next = nil
                self.tail.prev = nil
                self.tail:Remove()
                self.tail = currentNode
            end
            self.size = self.size - 1
        end

        function List:Find(data)
            for node in self:Iterator() do
                if node.data == data then 
                    return node
                end
            end
            return nil
        end

        function List:Remove()
            while self.head ~= nil do
                self:PopBack()
            end
        end

        function List:Iterator()
            return Next, self, nil
        end

        Next = function(list, node)
            if not node then
                return list.head
            elseif node == list.tail then -- 終止條件
                return nil
            else
                return node.next
            end
        end

        return List
    ]==]
?>