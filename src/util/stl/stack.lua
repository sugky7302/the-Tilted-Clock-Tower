-- 此module是在lua重構C++的泛型棧

local setmetatable = setmetatable

local Stack, mt = {}, {}
setmetatable(Stack, Stack)
Stack.__index = mt

function Stack:__call(type)
    local instance = {
        _top_ = nil,
        _depth_ = 0, 
    }
    setmetatable(instance, self)

    return instance
end

function mt:Remove()
    self:Clear()

    self._top_ = nil
    self._depth_ = nil
    self = nil
end

function mt:Clear()
    for i = 1, self._depth_ do 
        self[i] = nil
    end

    self._top_ = nil
    self._depth_ = 0
end

function Stack:__tostring()
    local print_str = "[bot-> "
    for i = self._depth_, 1, -1 do 
        print_str = print_str .. self[i] .. " "
    end
    print_str = print_str .. "<-top]"
    return print_str
end

function mt:getTop()
    return self._top_
end

function mt:getDepth()
    return self._depth_
end

-- 索引從 1 開始，因此要先增加size
function mt:PushTop(data)
    self._depth_ = self._depth_ + 1

    self[self._depth_] = data

    self._top_ = data
end

-- 先減少size再清空會無法清除末端元素
function mt:PopTop()
    self[self._depth_] = nil

    self._depth_ = self._depth_ - 1

    self._top_ = self[self._depth_] or nil
end

function mt:IsEmpty()
    return self._depth_ == 0
end

return Stack