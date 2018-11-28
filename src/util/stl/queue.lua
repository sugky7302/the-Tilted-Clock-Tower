-- 此modul是在lua上重構c++的泛型queue(隊列)，只能從後面插入元素，前面移除元素。

local setmetatable = setmetatable

local Queue, mt = {}, {}
setmetatable(Queue, Queue)
Queue.__index = mt

-- 建構函式
function Queue:__call()
    local instance = {
        _begin_ = 1,
        _end_ = 0,
        _length_ = 0,
    }

    setmetatable(instance, self)
    
    return instance
end

function mt:Remove()
    self._begin_ = nil
    self._end_ = nil
    self._length_ = nil
    self = nil
end

function Queue:__tostring()
    local print_str = "[ "
    for i = self._begin_, self._end_ do 
        print_str = print_str .. self[i] .. " "
    end
    print_str = print_str .. "]"
    return print_str
end

function mt:getLength()
    return self._length_
end

function mt:getBegin()
    return self[self._begin_]
end

function mt:getEnd()
    return self[self._end_]
end

function mt:PushBack(data)
    -- 放出新的空間
    self._end_ = self._end_ + 1
    self._length_ = self._length_ + 1

    self[self._end_] = data
end

function mt:PopFront()
    -- 釋放空間
    self[self._begin_] = nil 

    -- 調整首端索引
    self._begin_ = self._begin_ + 1 

    self._length_ = self._length_ - 1
end

-- O(length)的方法
function mt:Clear()
    for i = self._begin_, self._end_ do 
        self[i] = nil
    end

    self._begin_ = 1
    self._end_ = 0
    self._length_ = 0
end

function mt:IsEmpty()
    return self._length_ == 0
end

return Queue