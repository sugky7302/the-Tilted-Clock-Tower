local cj = require 'jass.common'
local sin, cos, rad = math.sin, math.cos, math.rad
local setmetatable = setmetatable

local Point = {}
local mt = {} -- 私有函數區
setmetatable(Point,Point)
Point.__index = mt

function Point:__call(o)
  o = o or {}
  setmetatable(o,self)
  o.__index = o
  -- 初始化
  o.x = o.x or 0
  o.y = o.y or 0
  o.z = o.z or o:GetZ()
  return o 
end

function mt:GetZ()
  local loc = cj.Location(self.x, self.y)
  self.z = cj.GetLocationZ(loc)
  cj.RemoveLocation(loc)
end

function mt:Remove()
  self.x, self.y, self.z, self = nil, nil, nil, nil
end

function Point.Distance(p1, p2)
  return math.sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)
end

function Point.Angle(p1, p2)
  return math.atan(p2.y - p1.y, p2.x - p1.x)
end

function mt:Rotate(val)
  self.x, self.y = self.x * sin(rad(val)), self.y * cos(rad(val))
end

function Point:__tostring()
  return '(' .. self.x .. ', ' .. self.y .. ', ' .. self.z .. ')'
end

function Point:__add(p)
  self.x, self.y, self.z = self.x + p.x, self.y + p.y, self.z + p.z
  return self
end

function Point:__sub(p)
  self.x, self.y, self.z = self.x - p.x, self.y - p.y, self.z - p.z
  return self
end

function Point:__mul(val)
  self.x, self.y, self.z = self.x * val, self.y * val, self.z * val
  return self
end

function Point:__div(val)
  self.x, self.y, self.z = self.x * val, self.y * val, self.z * val
  return self
end

return Point