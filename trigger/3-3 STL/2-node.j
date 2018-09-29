<?
    import 'node.lua' [==[
        local setmetatable = setmetatable
        local collectgarbage = collectgarbage

        local Node = {}
        setmetatable(Node, Node)
        Node.__index = Node
        Node._EIN = 1

        function Node:__call(data)
            local obj = {
                data = data,
                prev = nil,
                next = nil,
                EIN = self._EIN
            }
            self._EIN = self._EIN + 1
            setmetatable(obj, self)
            return obj
        end

        function Node:Remove()
            self.prev = nil
            self.next = nil
            self = nil
            collectgarbage("collect")
        end

        return Node
    ]==]
?>