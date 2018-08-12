--此標準庫搭載的是c++的queue(隊列)，只能從後面插入元素，前面移除元素。
local setmetatable = setmetatable

local queue = {}
setmetatable(queue,queue)
queue.__index = queue

function queue:erase()
  self = nil
end

function queue:size()
  return self.terminus - self.begin
end

function queue:push(val)
  self[self.terminus] = val
  self.terminus = self.terminus + 1 --索引往後一格，放出新的空間
end

function queue:pop()
  self[self.begin] = nil --把這格空間釋放
  self.begin = self.begin + 1 --索引往後一格
end

function queue:front()
  return self[self.begin]
end

function queue:back()
  return self[self.terminus-1]
end

function queue:__call(o)
  o = o or {begin = 1,terminus = 1}
  setmetatable(o,self)
  o.__index = o
  return o
end

return queue