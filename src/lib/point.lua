-- 此module取代we的point，減少ram的開銷

local setmetatable = setmetatable

local cj = require 'jass.common'

local Point, mt = {}, {}
setmetatable(Point, Point)
Point.__index = mt

-- constants
mt.type = "Point"

function Point:__call(x, y, z)
    local instance = {
        x_ = x or 0,
        y_ = y or 0,
        z_ = z or 0
    }

    setmetatable(instance, self)

    return instance 
end

function mt:Remove()
    self.x_ = nil
    self.y_ = nil
    self.z_ = nil
    self = nil
end

function Point:__tostring()
    return '(' .. self.x_ .. ', ' .. self.y_ .. ', ' .. self.z_ .. ')'
end

function Point:__add(p)
    local new_point = Point(self.x_ + p.x_, self.y_ + p.y_, self.z_ + p.z_)
    return new_point
end

function Point:__sub(p)
    local new_point = Point(self.x_ - p.x_, self.y_ - p.y_, self.z_ - p.z_)
    return new_point
end

function Point:__mul(scale)
    local new_point = Point(self.x_ * scale, self.y_ * scale, self.z_ * scale)
    return new_point
end

function Point:__div(scale)
    local new_point = Point(self.x_ / scale, self.y_ / scale, self.z_ / scale)
    return new_point
end

function mt:UpdateZ()
    local loc = cj.Location(self.x_, self.y_)
    self.z_ = cj.GetLocationZ(loc)

    cj.RemoveLocation(loc)
end

-- 假定極點為(0, 0)
function mt:Rotate(deg)
    local rad, sin, cos, sqrt = math.rad, math.sin, math.cos, math.sqrt

    local angle, length = rad(deg), sqrt(self.x_ ^ 2 + self.y_ ^ 2)
    self.x_, self.y_ = length * cos(angle), length * sin(angle)
end

-- 相關功能
function Point.Deg(p1, p2)
    local deg = math.deg
    return deg(Point.Rad(p1, p2))
end

function Point.Rad(p1, p2)
    local atan = math.atan
    return atan(p2.y_ - p1.y_, p2.x_ - p1.x_)
end

function Point.Slope(p1, p2)
    return (p2.y_ - p1.y_) / (p2.x_ - p1.x_)
end

function Point.SlopeInSpace(p1, p2)
    -- 獲取高度
    p1:UpdateZ()
    p2:UpdateZ()
    
    local z_difference = p2.z_ - p1.z_
    local distance = Point.Distance(p1, p2)

    return z_difference / distance
end


function Point.Distance(p1, p2)
    local sqrt = math.sqrt
    return sqrt((p1.x_ - p2.x_) ^ 2 + (p1.y_ - p2.y_) ^ 2)
end

function Point.DistanceInSpace(p1, p2)
    local sqrt = math.sqrt
    return sqrt((p1.x_ - p2.x_) ^ 2 + (p1.y_ - p2.y_) ^ 2 + (p1.z_ - p2.z_) ^ 2)
end

-- 注意是 . 不是 :
function Point.GetUnitLoc(unit)
    return Point(cj.GetUnitX(unit), cj.GetUnitY(unit))
end

function Point.GetLoc(p)
    return Point(cj.GetLocationX(p), cj.GetLocationY(p))
end

return Point