local _PACKAGE = (...):match("^(.+)[%./][^%./]+"):gsub("[%./]?node_types", "")
local class = require(_PACKAGE..'/middleclass')
local BranchNode  = require(_PACKAGE..'/node_types/branch_node')
local Random = class('Random', BranchNode)

function Random:start(object)
    BranchNode.start(self, object)

    local Rand = require 'math_lib'.Random
    self.actualTask = Rand(1, self.nodes)
end

function Random:success()
    BranchNode.success(self)
    self.control:success()
end

function Random:fail()
    BranchNode.fail(self)
    self.control:fail()
end

return Random
