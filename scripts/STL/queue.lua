--此標準庫搭載的是c++的queue(隊列)，只能從後面插入元素，前面移除元素。
local setmetatable = setmetatable
local Object = require 'object'

local Queue = {}
local mt = {}
setmetatable(Queue,Queue)
Queue.__index = mt

function Queue:__call(type)
    local obj = Object{
        type = type,
        begin = 1,
        terminus = 0
    }
    setmetatable(obj, self)
    obj.__index = obj
    return obj
end

function mt:Remove()
    self = nil
end

function mt:GetSize()
    return self.terminus - self.begin + 1
end

function mt:Push(data)
    self.terminus = self.terminus + 1 --索引往後一格，放出新的空間
    self[self.terminus] = data
end

function mt:Pop()
    self[self.begin] = nil --把這格空間釋放
    self.begin = self.begin + 1 --索引往後一格
end

function mt:Front()
    return self[self.begin]
end

function mt:Back()
    return self[self.terminus]
end

function mt:IsEmpty()
    return self.terminus < self.begin
end

return Queue