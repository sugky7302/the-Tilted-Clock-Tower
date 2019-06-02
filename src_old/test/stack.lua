local Stack = require 'stl.stack'

function StackTest()
    local stack = Stack()

    for i = 1, 10 do 
        stack:PushTop(i)
    end

    print(stack:getDepth())
    print(stack:getTop())
    print(stack)
    stack:PopTop()
    print(stack)
    stack:Clear()
    print(stack:getDepth())
    stack:Remove()
end

return StackTest