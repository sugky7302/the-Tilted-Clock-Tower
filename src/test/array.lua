local Array = require 'stl.array'

function ArrayTest()
    local array = Array()
    print(array.type)
    array:PushBack(1)
    array:Delete(1)
    for i = 1, 10 do 
        array:PushBack(i)
    end
    print(array:Exist(5))
    print(array:getLength())
    array:Clear()
    print(array:getLength())
    array:Remove()
end

return ArrayTest