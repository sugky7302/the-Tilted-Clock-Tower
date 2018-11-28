local Node = require 'stl.node'

function NodeTest()
    local node = Node(1)
    print(node:getData())
    node:Remove()
end

return NodeTest