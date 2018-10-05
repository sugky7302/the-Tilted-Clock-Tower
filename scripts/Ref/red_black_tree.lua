local setmetatable = setmetatable
local Object = require 'object'
local Node = require 'RBTree_node'

local RBTree = {}
local mt = {}
setmetatable(RBTree, RBTree)
RBTree.__index = mt

-- variables
local _FindFeasibleLeafNode, _InsertNode, _CheckDoubleRed, _EraseLeafNode, _RotateLeft, _RotateRight
local _GetMaxNodeInLeftSubtree, _GetMinNodeInRightSubtree, _EraseRoot

function RBTree:__call()
    local obj = Object{
        root = Node(),
    }
    setmetatable(obj, self)
    obj.__index = obj
    return obj
end

function mt:Insert(data)
    local newNode = Node(data)
    -- 情況一：新節點是根節點，紅轉黑
    if not self.root then
        self.root = newNode
        self.root:Discolor()
    else
        local parent = _FindFeasibleLeafNode(self.root, newNode)
        _InsertNode(parent, newNode)
        -- 情況二:父節點是黑色，不調整；若為紅色，做進一步動作
        if parent.isRed then
            -- 情況三:若叔叔節點是紅色，則直接變色；若為黑色，先旋轉，再變色
            local uncle = newNode:GetUncle()
            if uncle.isRed then    
                _CheckDoubleRed(parent, uncle)
            else
                local grandpa = parent.parent
                -- 情況四：父節點是紅色，叔叔節點是黑色
                if parent == granpa.left then
                    -- 四之一：newNode是parnet的右孩子，parent是grandpa的左孩子
                    -- 先左旋parent，轉成五之一
                    if newNode == parent.right then
                        parent = _RotateLeft(parent)
                    end
                    -- 五之一：newNode是parnet的左孩子，parent是grandpa的左孩子
                    -- 先右旋granpa，grandpa、parent、uncle再變色
                    grandpa = _RotateRight(grandpa)
                    grandpa:Discolor()
                    grandpa.left:Discolor()
                    grandpa.right:Discolor()
                else
                    -- 四之二：newNode是parnet的左孩子，parent是grandpa的右孩子
                    -- 先右旋parent，轉成五之二
                    if newNode == parent.left then
                        parent = _RotateRight(parent)
                    end
                    -- 五之二：newNode是parnet的右孩子，parent是grandpa的右孩子
                    -- 先左旋granpa，grandpa、parent、uncle再變色
                    grandpa = _RotateLeft(grandpa)
                    grandpa:Discolor()
                    grandpa.left:Discolor()
                    grandpa.right:Discolor()
                end
            end
        end
    end
end

_FindFeasibleLeafNode = function(root, newNode)
    local node = root
    while not node:IsLeafNode() do
        node = (node.data < newNode.data) and node.right or node.left
    end
    return node
end

_InsertNode = function(parent, newNode)
    if parent.data < newNode.data then
        parent.right = newNode
    else
        parent.left = newNode
    end
end

_CheckDoubleRed = function(parent, uncle)
    parent:Discolor()
    uncle:Discolor()
    local grandpa = parent.parent
    local grandUncle = parent:GetUncle()
    grandpa:Discolor()
    if grandUncle.isRed then
        _CheckDoubleRed(grandpa, grandUncle)
    end
    return true
end

_RotateLeft = function(node)
    local right = node.right
    node.right = right.left
    right.left = node
    return right
end

_RotateRight = function(node)
    local left = node.left
    node.left = left.right
    left.right = node
    return left
end

function mt:Erase(node)
    if node == self.root then
        _EraseRoot(self)
    if node:IsLeafNode() then
        _EraseLeafNode(node)
    else
        if self.right then
        else
    end
end

_EraseRoot = function(self)
    if self.root:IsLeafNode() then
        self.root:Remove()
        self.root = nil
    else
        local node
        -- 如果左子樹存在，把左子樹最大值給根
        if self.left then
            node = _GetMaxNodeInLeftSubtree(self.left)
            if node.left then
                node.parent.right = node.left
                node.left.parent = node.parent
            end
        else -- 如果左子樹不存在，把右子樹最小值給根
            node = _GetMinNodeInRightSubtree(self.right)
            if node.right then
                node.parent.left = node.right
                node.right.parent = node.parent
            end
        end
        self.root.data = node.data
        node:Remove()
    end
end

_GetMaxNodeInLeftSubtree = function(subtree)
    local node = subtree
    local prev
    while node.right != nil do
        prev = node
        node = node.right
    end
    return prev
end

_GetMinNodeInRightSubtree = function(subtree)
    local node = subtree
    local prev
    while node.left != nil do
        prev = node
        node = node.left
    end
    return prev
end

_EraseLeafNode = function(node)
    if node == node.parent.left then
        node.parent.left = nil
    else
        node.parent.right = nil
    end
    node:Remove()
end

function mt:Find(data)
end

function mt:Remove()
end

function mt.GetElementNum(subtree)
    if not subtree.data then
        return 0
    else
        local totalNum = subtree.data.size
        if subtree.children then
            for i = 1, #subtree.children.size do
                totalNum = totalNum + mt.GetSize(subtree.children[i])
            end
        end
        return totalNum
    end
end

return RBTree
