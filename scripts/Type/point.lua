local sin, cos, rad, sqrt, atan = math.sin, math.cos, math.rad, math.sqrt, math.atan
local setmetatable = setmetatable
local cj = require 'jass.common'
local Object = require 'object'

local Point = {}
local mt = {}
setmetatable(Point, Point)
Point.__index = mt

function Point:__call(x, y, z)
    local obj = Object{
        x = x or 0,
        y = y or 0,
        z = z or 0
    }
    setmetatable(obj, self)
    obj.__index = obj
    return obj 
end

function mt:GetZ()
    local loc = cj.Location(self.x, self.y)
    self.z = cj.GetLocationZ(loc)
    cj.RemoveLocation(loc)
end

function Point:GetUnitLoc(unit)
    return self(cj.GetUnitX(unit), cj.GetUnitY(unit))
end

function mt:Remove()
    self = nil
end

function Point.Distance(p1, p2)
    return sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)
end

function Point.DistanceInSpace(p1, p2)
    return sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2 + (p1.z - p2.z)^2)
end

function Point.Angle(p1, p2)
    return atan(p2.y - p1.y, p2.x - p1.x)
end

function mt:Rotate(val)
    self.x, self.y = self.x * sin(rad(val)), self.y * cos(rad(val))
end

function Point:__tostring()
    return '(' .. self.x .. ', ' .. self.y .. ', ' .. self.z .. ')'
end

function Point:__add(p)
    local newPoint = Point(self.x + p.x, self.y + p.y, self.z + p.z)
    return newPoint
end

function Point:__sub(p)
    local newPoint = Point(self.x - p.x, self.y - p.y, self.z - p.z)
    return newPoint
end

function Point:__mul(val)
    local newPoint = Point(self.x * val, self.y  * val, self.z  * val)
    return newPoint
end

function Point:__div(val)
    local newPoint = Point(self.x / val, self.y  / val, self.z  / val)
    return newPoint
end

return Point