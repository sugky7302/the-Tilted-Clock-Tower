-- 在lua重構C++的泛型棧

local Stack = require 'class'("Stack")

-- default
Stack._top_   = nil
Stack._depth_ = 0 

function Stack:__tostring()
    local print_str = {"[bot-> "}

    for i = self._depth_, 1, -1 do 
        print_str[#print_str] = self[i]
    end

    print_str[#print_str] = "<-top]"
    return table.concat(print_str)
end

function Stack:Clear()
    for i = 1, self._depth_ do 
        self[i] = nil
    end

    self._top_ = nil
    self._depth_ = 0
end

-- 索引從 1 開始，因此要先增加size
function Stack:PushTop(data)
    self._depth_ = self._depth_ + 1

    self[self._depth_] = data

    self._top_ = data
end

-- 先減少size再清空會無法清除末端元素
function Stack:PopTop()
    self[self._depth_] = nil

    self._depth_ = self._depth_ - 1

    self._top_ = self[self._depth_] or nil
end

function Stack:IsEmpty()
    return self._depth_ == 0
end

-- 獲取私有成員變量
function Stack:getTop()
    return self._top_
end

function Stack:getDepth()
    return self._depth_
end

return Stack