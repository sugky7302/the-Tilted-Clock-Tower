local setmetatable = setmetatable
local collectgarbage = collectgarbage
local Object = require 'object'

local Node = {}
local mt = {}
setmetatable(Node, Node)
Node.__index = mt

function Node:__call(data)
    local obj = Object{
        data = data,
        prev = nil,
        next = nil,
    }
    setmetatable(obj, self)
    return obj
end

function mt:Remove()
    self.data = nil
    self.prev = nil
    self.next = nil
    self = nil
    collectgarbage("collect")
end

return Node