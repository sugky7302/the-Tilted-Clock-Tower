local Queue = require 'stl.queue'

function QueueTest()
    local queue = Queue()

    for i = 1, 10 do 
        queue:PushBack(i)
    end

    print(queue:getLength())
    print(queue:getBegin())
    print(queue:getEnd())
    queue:PopFront()
    queue:PopFront()
    print(queue)
    queue:Clear()
    print(queue:getLength())
    queue:Remove()
end

return QueueTest