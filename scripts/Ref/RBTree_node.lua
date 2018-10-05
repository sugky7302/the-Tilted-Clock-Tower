local setmetatable = setmetatable
local Object = require 'object'

local Node = {}
local mt = {}
setmetatable(Node, Node)
Node.__index = mt

function Node:__call(data)
    local obj = Object{
        data = data,
        parent = nil,
        left = nil,
        right = nil,
        isRed = true,
    }
    setmetatable(obj, self)
    return obj
end

function mt:Remove()
    self = nil
end

function mt:IsLeafNode()
    return (self.left or self.right) and false or true
end

function mt:IsRootNode()
    return self.parent and false or true
end

function mt:GetUncle()
    local grandpa = self.parent.parent
    return (grandpa.left == self.parent) and grandpa.right or grandpa.left
end

function mt:Discolor()
    self.isRed = self.isRed and false or true
end

return Node
    