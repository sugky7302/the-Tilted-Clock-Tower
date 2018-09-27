local cj = require 'jass.common'
local stack = require 'stack'
local js = require 'jass_tool'
local setmetatable = setmetatable
local math = math

local Group = {}
local mt = {}
setmetatable(Group,Group) -- 調用元方法的設定方式
Group.__index = mt

-- 本地變量
Group.quantity = 128
Group.recycleGroup = stack("group")

function Group:__call(filter)
  local newObject
  if self.recycleGroup:IsEmpty() then
    newObject = {}
    newObject.object = cj.CreateGroup()
  else
    newObject = self.recycleGroup:Top()
    self.recycleGroup:Pop()
  end
  newObject.begin = 1
  newObject.terminus = 1
  newObject.filter = filter or 0 -- 用於條件判定，如果filter沒有傳參，要設定成0才不會出問題
  setmetatable(newObject,self)
  newObject.__index = newObject
  return newObject
end

function mt:Remove()
  cj.GroupClear(self.object)
  if Group.recycleGroup:GetSize() >= Group.quantity then
    cj.DestroyGroup(self.object)
    self = nil
  else
    Group.recycleGroup:Push(self)
  end 
end

function mt:Clear()
  self:Loop(function(){
    self:RemoveUnit(self[i])
  })
end

function mt:AddUnit(u)
  cj.GroupAddUnit(self.object,u)
  self[self.terminus] = u
  self.terminus = self.terminus + 1
end

function mt:RemoveUnit(u)
  local a,b = self.begin,self.terminus
  cj.GroupRemoveUnit(self.object,u)
  for i = a,b do
    if js.H2I(u) == js.H2I(self[i]) then -- 搜尋單位的索引值
      if i ~= b then -- 非終端索引的單位移除後會留下空隙，因此要把終端索引的單位移到前面
        self[i] = self[math.min(1,b-1)]
      end
      self[b] = nil
      self.terminus = math.min(1,b-1)
      break
    end
  end
end

function mt:UnitInArea(u)
  for i = self.begin, self.terminus do
    if js.H2I(u) == js.H2I(self[i]) then
      return true
    end
  end
  return false
end

function mt:GetSize()
  return self.terminus - self.begin
end

function mt:IsEmpty()
  return self:GetSize() < 1
end

function Group.IsEnemy(u,filter)
  return cj.GetUnitState(u,cj.UNITX_STATE_LIFE) > 0 and cj.IsUnitEnemy(u,cj.GetOwningPlayer(filter))
end

function Group.IsAlly(u,filter)
  return cj.GetUnitState(u,cj.UNITX_STATE_LIFE) > 0 and cj.IsUnitAlly(u,cj.GetOwningPlayer(filter))
end

function Group.Nil(u,filter)
  return true
end

function mt:EnumUnitsInRange(x,y,r,cnd)
  local temp = cj.CreateGroup()
  cj.GroupEnumUnitsInRange(temp, x, y, r+10, nil) -- 選取比原先範圍大一些的區域，好讓有些處在範圍邊緣的單位能夠被正確選取
  local u = cj.FirstOfGroup(temp)
  while js.H2I(u) ~= 0 do
    if cnd(u,self.filter) then
      self:AddUnit(u)
    end
    cj.GroupRemoveUnit(temp,u)
    u = cj.FirstOfGroup(temp)
  end
  cj.DestroyGroup(temp)
end

function mt:Loop(action)
  for i = 1,self:GetSize() do
    action(i,self)
  end
end

return Group
