local list = {}
local setmetatable = setmetatable
setmetatable(list,list)
list.__index = list

function list:empty() return (self.size == 0) and true or false end
function list:size() return self.size end
function list:front() return self.begin.val end
function list:back() return self.begin.val end

function list:push_front(v)
  o = {val = v, prev = nil, next = nil} -- 生成新的區塊
  if self.size == 0 then
    self.begin = o -- 設定新的begin
    self.terminus = o -- 設定新的end
  else
    o.next = self.begin -- 把原先的begin和新區塊連接
    self.begin.prev = o -- 把原先的end和新區塊連接
    self.begin = o -- 設定新的end
  end
  self.size = self.size + 1 -- 計數
end

function list:push_back(v)
  o = {val = v, prev = nil, next = nil} -- 生成新的區塊
  if self.size == 0 then
    self.begin = o -- 設定新的begin
    self.terminus = o -- 設定新的end
  else
    o.prev = self.terminus -- 把原先的end和新區塊連接
    self.terminus.next = o -- 把原先的end和新區塊連接
    self.terminus = o -- 設定新的end
  end
  self.size = self.size + 1 -- 計數
end

function list:pop_front()
  local o = self.begin
  o.next.prev = nil
  self.begin = o.next
  o = nil
  self.size = self.size - 1
end

function list:pop_back()
  local o = self.terminus
  o.prev.next = nil
  self.terminus = o.prev
  o = nil
  self.size = self.size - 1
end

function list:erase(v)
  local a = self.begin -- 從起點搜尋位置
  while a do
    if a.val == v then
      local o = a
      a = a.next -- 因為a會被清除，所以先把索引跳到下一個，免得讀不到
      o.prev.next = o.next
      o.next.prev = o.prev
      o = nil
      self.size = self.size - 1
    else a = a.next end
  end
end

function list:insert(v,loc)
  if loc == 1 then -- 如果是放在第一個，就直接用push_front
    self:push_front(v)
    return
  end
  if loc == self.size then -- 如果是放在最後一個，就直接用push_back
    self:push_back(v)
    return
  end
  o = {val = v, prev = nil, next = nil} -- 生成新的區塊
  local a = self.begin -- 從起點搜尋位置
  local i = 1
  while a do
    if loc == i then
      o.prev = a.prev
      a.prev.next = o
      o.next = a
      a.prev = o
      self.size = self.size + 1
      return -- 停止動作
    end
    i = i + 1
    a = a.next
  end
end

function list:__call()
  local o = {begin = nil, terminus = nil, size = 0}
  setmetatble(o,self)
  o.__index = o
  return o
end

return list