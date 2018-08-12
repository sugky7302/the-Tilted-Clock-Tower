local cj = require 'jass.common'
local queue = require 'queue'
local js = require 'jass_tool'
local setmetatable = setmetatable
local math = math

local group = {}
setmetatable(group,group) -- 調用元方法的設定方式
group.__index = group

-- 本地變量
group.quantity = 128
group.recycle = queue()

function group:erase()
  cj.GroupClear(self.object)
  if group.recycle:size() >= group.quantity then
    cj.DestroyGroup(self.object)
    self = nil
  else
    group.recycle:push(self)
  end 
end

function group:AddUnit(u)
  cj.GroupAddUnit(self.object,u)
  self[self.terminus] = u
  self.terminus = self.terminus + 1
end

function group:RemoveUnit(u)
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

function group:UnitInArea(u)
  for i = self.begin, self.terminus do
    if js.H2I(u) == js.H2I(self[i]) then return true end
  end
  return false
end

function group:size() return self.terminus - self.begin end

function group.is_enemy(u,filter)
  return cj.GetUnitState(u,cj.UNITX_STATE_LIFE) > 0 and cj.IsUnitEnemy(u,cj.GetOwningPlayer(filter))
end

function group.is_ally(u,filter)
  return cj.GetUnitState(u,cj.UNITX_STATE_LIFE) > 0 and cj.IsUnitAlly(u,cj.GetOwningPlayer(filter))
end

function group.null(u,filter)
  return true
end

function group:EnumUnitsInRange(x,y,r,cnd)
  local temp = cj.CreateGroup()
  cj.GroupEnumUnitsInRange(temp, x, y, r+10, nil) -- 選取比原先範圍大一些的區域，好讓有些處在範圍邊緣的單位能夠被正確選取
  local u = cj.FirstOfGroup(temp)
  while js.H2I(u) ~= 0 do
    if cnd(u,self.filter) then self:AddUnit(u) end
    cj.GroupRemoveUnit(temp,u)
    u = cj.FirstOfGroup(temp)
  end
  cj.DestroyGroup(temp)
end

function group:loop(ac)
  for i = 1,self:size() do
    ac(i,self)
  end
end

function group:__call(filter)
  local g
  if self.recycle:size() == 0 then
    g = {}
    g.object = cj.CreateGroup()
    self.recycle:push(g)
  else
    g = self.recycle:front()
    self.recycle:pop()
  end
  g.begin = 1
  g.terminus = 1
  g.filter = filter or 0 -- 用於條件判定，如果filter沒有傳參，要設定成0才不會出問題
  setmetatable(g,self)
  g.__index = g
  return g
end

return group
