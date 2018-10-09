local setmetatable = setmetatable
local Object = require 'object'

local Array = {}
local mt = {}
setmetatable(Array, Array)
Array.__index = mt

-- 陣列
-- 特性：連續
-- 缺點：若移除中間元素之後，順序會開始混亂
function Array:__call(type)
    local obj = Object{
        type = type,
        begin = 1,
        terminus = 0,
        size = 0
    }
    setmetatable(obj, self)
    obj.__index = obj
    return obj
end

function mt:PushBack(data)
    self.terminus = self.terminus + 1
    self.size = self.size + 1
    self[self.terminus] = data
end

-- 消除所有data
function mt:Erase(data)
    for i = self.begin, self.terminus do
        if self[i] == data then
            self[i] = self[self.terminus]
            self[self.terminus] = nil
            self.terminus = self.terminus - 1
            self.size = self.size - 1
        end
    end
end

function mt:GetSize()
    return self.size
end

function mt:IsEmpty()
    return self.size < 1
end

function mt:Remove()
    self = nil
    collectgarbage("collect")
end

function mt:Clear()
    self.begin = 1
    self.terminus = 0
    self.size = 0
end

function mt:Exist(data)
    for i = self.begin, self.terminus do
        if self[i] == data then
            return true 
        end
    end
    return false
end

return Array