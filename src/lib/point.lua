-- 此module取代we的point，減少ram的開銷

-- package
local cj = require 'jass.common'

local Point = require 'class'("Point")

function Point:_new(x, y, z)
    self.x_ = x or 0
    self.y_ = y or 0
    self.z_ = z or 0
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


function Point:UpdateZ()
    local loc = cj.Location(self.x_, self.y_)
    self.z_ = cj.GetLocationZ(loc)

    cj.RemoveLocation(loc)
end

-- assert
local math = math

-- 假定極點為(0, 0)
function Point:Rotate(deg)
    local angle, length = math.rad(deg), math.sqrt(self.x_ ^ 2 + self.y_ ^ 2)
    self.x_, self.y_ = length * math.cos(angle), length * math.sin(angle)
end


-- 相關功能
function Point.Deg(p1, p2)
    return math.deg(Point.Rad(p1, p2))
end

-- 範圍為[0, 2 * pi]
function Point.Rad(p1, p2)
    local rad = math.atan(p2.y_ - p1.y_, p2.x_ - p1.x_)

    if rad < 0 then
        rad = rad + 2 * math.pi
    end

    return rad
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
    return math.sqrt((p1.x_ - p2.x_) ^ 2 + (p1.y_ - p2.y_) ^ 2)
end

function Point.DistanceInSpace(p1, p2)
    return math.sqrt((p1.x_ - p2.x_) ^ 2 + (p1.y_ - p2.y_) ^ 2 + (p1.z_ - p2.z_) ^ 2)
end

-- 注意是 . 不是 :
function Point.GetUnitLoc(unit)
    return Point(cj.GetUnitX(unit), cj.GetUnitY(unit))
end

function Point.GetLoc(p)
    return Point(cj.GetLocationX(p), cj.GetLocationY(p))
end

return Point