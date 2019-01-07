-- 等待一定時間才會執行子節點，執行規則和sequence相同。

local class     = require 'behavior_tree/middleclass'
local Registry  = require 'behavior_tree/registry'
local BranchNode  = require 'behavior_tree/node_types/branch_node'
local BT = require 'behavior_tree/behaviour_tree'
local Wait = class('Wait', BranchNode)
local Timer = require 'timer.core'

-- 設定為常用格式
-- 不加入Registry是因為這樣就不能自訂時間
BT.Wait = Wait

function Wait:start(object)
    Timer(self.time, false, function()
        BranchNode.start(self, object)
    end)
end

function Wait:success()
    BranchNode.success(self)
    self.control:success()
end

function Wait:fail()
    BranchNode.fail(self)
    self.control:fail()
end

return Wait