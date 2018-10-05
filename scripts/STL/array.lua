local setmetatable = setmetatable
local Object = require 'object'

local Array = {}
setmetatable(Array, Array)
Array.__index = Array

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

function Array:PushBack(data)
    self.terminus = self.terminus + 1
    self.size = self.size + 1
    self[self.terminus] = data
end

-- 消除所有data
function Array:Erase(data)
    for i = self.begin, self.terminus do
        if self[i] == data then
            self[i] = self[self.terminus]
            self[self.terminus] = nil
            self.terminus = self.terminus - 1
        end
    end
end

function Array:GetSize()
    return self.size
end

function Array:IsEmpty()
    return self.size < 1
end

function Array:Remove()
    self.type = nil
    self.begin = nil
    self.terminus = nil
    self.size = nil
    self = nil
end

function Array:Clear()
    self.begin = 1
    self.terminus = 0
    self.size = 0
end

function Array:Exist(data)
    for i = self.begin, self.terminus do
        if self[i] == data then
            return true 
        end
    end
    return false
end

return Array