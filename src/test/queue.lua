local function QueueTest()
    local Queue = require 'stl.queue'

    local queue = Queue()

    for i = 1, 10 do 
        queue:PushBack(i)
    end

    print(queue:getLength())
    print(queue:front())
    queue:PopFront()
    queue:PopFront()
    print(queue)
    queue:Clear()
    print(queue:getLength())
    queue:Remove()
end

return QueueTest