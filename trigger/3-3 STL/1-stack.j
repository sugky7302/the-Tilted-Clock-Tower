<?
    import 'stack.lua' [==[
        local setmetatable = setmetatable
        local Object = require 'object'

        local Stack = {}
        local mt = {}
        setmetatable(Stack, Stack)
        Stack.__index = mt

        function Stack:__call(type)
            local obj = Object{
                type = type,
                top = nil,
                size = 0, 
            }
            setmetatable(obj, self)
            obj.__index = obj
            return obj
        end

        function mt:Push(data)
            self.size = self.size + 1
            self[self.size] = data
            self.top = data
        end

        function mt:Pop()
            self[self.size] = nil
            self.size = self.size - 1
            self.top = self[self.size] or nil
        end

        function mt:Top()
            return self.top
        end

        function mt:IsEmpty()
            return self.size < 1
        end

        function mt:GetSize()
            return self.size
        end

        function mt:GetType()
            return self.type
        end

        return Stack
    ]==]
?>