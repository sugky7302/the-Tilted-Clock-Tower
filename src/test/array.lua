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

    local tb = {1, 2, 3, 4, 5}
    tb[0] = 0
    print(#tb) -- 5

    local sum = 0
    for i in ipairs(tb) do 
        sum = sum + 1
    end
    print(sum) -- 5

    local sum = 0
    for i in pairs(tb) do 
        sum = sum + 1
    end
    print(sum) -- 6
end

return ArrayTest