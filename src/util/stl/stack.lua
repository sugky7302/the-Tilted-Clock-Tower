-- 在lua重構C++的泛型棧
-- 依賴
--   class

local Stack = require 'util.class'("Stack")

-- default
Stack._top_   = nil
Stack._size_ = 0 

function Stack:__tostring()
    local print_str = {"[bot->"}

    for i = 1, self._size_ do 
        print_str[#print_str+1] = self[i]
    end

    -- 把最後一個空格換掉
    print_str[#print_str+1] = "<-top]"

    return table.concat(print_str, " ")
end

function Stack:clear()
    for i = 1, self._size_ do 
        self[i] = nil
    end

    self._top_ = nil
    self._size_ = 0
end

-- 索引從 1 開始，因此要先增加size
function Stack:push(data)
    self._size_ = self._size_ + 1

    self[self._size_] = data

    self._top_ = data
end

-- 先減少size再清空會無法清除末端元素
function Stack:pop()
    self[self._size_] = nil

    self._size_ = self._size_ - 1

    self._top_ = self[self._size_] or nil
end

function Stack:empty()
    return self._size_ == 0
end

-- 獲取私有成員變量
function Stack:top()
    return self._top_
end

function Stack:size()
    return self._size_
end

return Stack