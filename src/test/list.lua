-- assert
local _print

local function ListTest()
    local List = require 'stl.list.core'

    local list = List()
    
    list:PushBack(0)
    print(list)

    list:PushBack(1)
    print(list)

    for i = 2, 11 do
        if i < 7 then
            list:PushFront(i)
        else
            list:PushBack(i)
        end
    end
    print(list)

    print(list:Find(5):getData())

    list:PopFront()
    print(list)

    list:PopBack()
    print(list)

    list:Clear()
    print(list)

    list:Remove()
end

return ListTest