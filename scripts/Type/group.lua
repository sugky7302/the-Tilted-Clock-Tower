local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local Stack = require 'stack'
local Array = require 'array'
local Object = require 'object'

local Group = {}
local mt = {}
setmetatable(Group,Group) -- 調用元方法的設定方式
Group.__index = mt

-- variables
local _QUANTITY, _recycleGroup = 128, Stack("group")

function Group:__call(filter)
    local obj = Object{units = Array("units")}
    if _recycleGroup:IsEmpty() then
        obj.object = cj.CreateGroup()
    else
        obj.object = _recycleGroup:Top()
        _recycleGroup:Pop()
    end
    obj.filter = filter or 0 -- 用於條件判定，如果filter沒有傳參，要設定成0才不會出問題
    setmetatable(obj, self)
    obj.__index = obj
    return obj
end

function mt:Remove()
    self:Clear()
    if _recycleGroup:GetSize() >= _QUANTITY then
        cj.DestroyGroup(self.object)
    else
        _recycleGroup:Push(self)
    end 
    self.object = nil
end

function mt:Clear()
    self:Loop(function(self, i)
        self:RemoveUnit(self[i])
    end)
    cj.GroupClear(self.object)
    self.units:Remove()
end

function mt:Loop(action)
    for i = 1, self.units:GetSize() do
        action(self, i)
    end
end

function mt:EnumUnitsInRange(x, y, r, cnd)
    local temp = cj.CreateGroup()
    cj.GroupEnumUnitsInRange(temp, x, y, r+10, nil) -- 選取比原先範圍大一些的區域，好讓有些處在範圍邊緣的單位能夠被正確選取
    local u = cj.FirstOfGroup(temp)
    while js.H2I(u) ~= 0 do
    if cnd(u, self.filter) then
        self:AddUnit(u)
    end
    cj.GroupRemoveUnit(temp, u)
    u = cj.FirstOfGroup(temp)
    end
    cj.DestroyGroup(temp)
end

function mt:AddUnit(u)
    cj.GroupAddUnit(self.object, u)
    self.units:PushBack(u)
end

function mt:RemoveUnit(u)
    cj.GroupRemoveUnit(self.object, u)
    self.units:Erase(u)
end

function mt:UnitInArea(u)
    return self.units:Exist(u)
end

function mt:GetSize()
    return self.units:GetSize()
end

function mt:IsEmpty()
    return self.units:IsEmpty()
end

function Group.IsEnemy(u,filter)
    return cj.GetUnitState(u, cj.UNITX_STATE_LIFE) > 0 and cj.IsUnitEnemy(u, cj.GetOwningPlayer(filter))
end

function Group.IsAlly(u,filter)
    return cj.GetUnitState(u, cj.UNITX_STATE_LIFE) > 0 and cj.IsUnitAlly(u, cj.GetOwningPlayer(filter))
end

function Group.Nil(u, filter)
    return true
end

return Group