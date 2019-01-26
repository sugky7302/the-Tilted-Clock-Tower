-- 在lua上重構c++的泛型queue(隊列)，只能從後面插入元素，前面移除元素。

local Queue = require 'class'("Queue")

-- default
Queue._begin_  = 1
Queue._end_    = 0
Queue._length_ = 0

function Queue:__tostring()
    local print_str = {"["}

    for i = self._begin_, self._end_ do 
        print_str[#print_str] = self[i]
    end

    print_str[#print_str] = "]"
    return table.concat(print_str)
end

function Queue:PushBack(data)
    -- 放出新的空間
    self._end_ = self._end_ + 1
    self._length_ = self._length_ + 1

    self[self._end_] = data
end

function Queue:PopFront()
    -- 釋放空間
    self[self._begin_] = nil 

    -- 調整首端索引
    self._begin_ = self._begin_ + 1 

    self._length_ = self._length_ - 1
end

-- O(length)的方法
function Queue:Clear()
    for i = self._begin_, self._end_ do 
        self[i] = nil
    end

    self._begin_ = 1
    self._end_ = 0
    self._length_ = 0
end

-- 獲取私有成員變量
function Queue:IsEmpty()
    return self._length_ == 0
end

function Queue:getLength()
    return self._length_
end

function Queue:front()
    return self[self._begin_]
end

return Queue