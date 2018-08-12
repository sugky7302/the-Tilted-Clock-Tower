local sin, cos, rad = math.sin, math.cos, math.rad
local setmetatable = setmetatable

local point = {}
local mt = {} -- 功能區
setmetatable(point,point)
point.__index = mt

function mt:distance(p) return math.sqrt((self.x - p.x)^2 + (self.y - p.y)^2) end

function mt:angle(p) return math.atan(p.y - self.y, p.x - self.x) end

function mt:rotate(val)
  self.x, self.y = self.x * sin(rad(val)), self.y * cos(rad(val))
end

function mt:erase()
  self.x, self.y, self.z, self = nil, nil, nil, nil
end

function point:__tostring()
  return '(' .. self.x .. ', ' .. self.y .. ', ' .. self.z .. ')'
end

function point:__add(p)
  self.x, self.y, self.z = self.x + p.x, self.y + p.y, self.z + p.z
  return self
end

function point:__sub(p)
  self.x, self.y, self.z = self.x - p.x, self.y - p.y, self.z - p.z
  return self
end

function point:__mul(val)
  self.x, self.y, self.z = self.x * val, self.y * val, self.z * val
  return self
end

function point:__div(val)
  self.x, self.y, self.z = self.x * val, self.y * val, self.z * val
  return self
end

function point:__call(o)
  o = o or {}
  setmetatable(o,self)
  o.__index = o
  -- 本地變量
  o.x = o.x or 0
  o.y = o.y or 0
  o.z = o.z or 0
  return o 
end

return point