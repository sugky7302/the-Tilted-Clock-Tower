local function NodeTest()
    local Node = require 'stl.list.node'
    
    local node = Node(1)
    print(node:getData())
    node:Remove()
end

return NodeTest