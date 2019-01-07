-- 第一個子節點直接運行，每隔一段時間才會執行下個子節點，執行規則和sequence相同。

local class     = require 'behavior_tree/middleclass'
local Registry  = require 'behavior_tree/registry'
local BranchNode  = require 'behavior_tree/node_types/branch_node'
local BT = require 'behavior_tree/behaviour_tree'
local Period = class('Period', BranchNode)
local Timer = require 'timer.core'

-- 設定為常用格式
-- 不加入Registry是因為這樣就不能自訂時間
BT.Period = Period

function Period:success()
    BranchNode.success(self)
    self.actualTask = self.actualTask + 1
    if self.actualTask <= #self.nodes then
        Timer(self.time, false, function()
            self:_run(self.object)
        end)
    else
        self.control:success()
    end
end

function Period:fail()
    BranchNode.fail(self)
    self.control:fail()
end

return Period