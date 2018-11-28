local List = require 'stl.list.core'

-- assert
local _print

function ListTest()
    local list = List()
    
    list:PushBack(0)
    _print(list)

    list:PushBack(1)
    _print(list)

    for i = 2, 11 do
        if i < 7 then
            list:PushFront(i)
        else
            list:PushBack(i)
        end
    end
    _print(list)

    list:PopFront()
    _print(list)

    list:PopBack()
    _print(list)
    
    list:Remove()
end

_print = function(list)
    local print_str = "[ "
    print "1"
    for node in list:TraverseIterator() do
        print_str = print_str .. node:getData() .. " "
    end
    print_str = print_str .. "]"
    print(print_str)
end

return ListTest