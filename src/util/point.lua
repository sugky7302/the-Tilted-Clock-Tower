-- 創建一個3維的點類別及提供基礎功能
-- 依賴
--   class


local Point = require 'util.class'("Point")

function Point:_new(x, y, z)
    return {
        x_ = x or 0,
        y_ = y or 0,
        z_ = z or 0
    }
end

function Point:__tostring()
    return table.concat({'(', self.x_, ', ', self.y_, ', ', self.z_, ')'})
end

function Point:__add(p)
    return Point(self.x_ + p.x_, self.y_ + p.y_, self.z_ + p.z_)
end

function Point:__sub(p)
    return Point(self.x_ - p.x_, self.y_ - p.y_, self.z_ - p.z_)
end

function Point:__mul(scale)
    return Point(self.x_ * scale, self.y_ * scale, self.z_ * scale)
end

function Point:__div(scale)
    return Point(self.x_ / scale, self.y_ / scale, self.z_ / scale)
end


function Point:copy()
    return Point(self.x_, self.y_, self.z_)
end

-- assert
local math = math

-- 假定極點為(0, 0)
-- 只會旋轉平面座標
function Point:rotate(deg)
    local angle, length = math.rad(deg), math.sqrt(self.x_ ^ 2 + self.y_ ^ 2)
    self.x_, self.y_ = length * math.cos(angle), length * math.sin(angle)
end

-- 只會計算平面夾角
function Point.Deg(p1, p2)
    return math.deg(Point.Rad(p1, p2))
end

-- 範圍為[0, 2 * pi]
-- 只會計算平面夾角
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

function Point.Slope3D(p1, p2)
    local z_difference = p2.z_ - p1.z_
    local distance = Point.Distance(p1, p2)

    return z_difference / distance
end

function Point.Distance(p1, p2)
    return math.sqrt((p1.x_ - p2.x_) ^ 2 + (p1.y_ - p2.y_) ^ 2)
end

function Point.Distance3D(p1, p2)
    return math.sqrt((p1.x_ - p2.x_) ^ 2 + (p1.y_ - p2.y_) ^ 2 + (p1.z_ - p2.z_) ^ 2)
end

return Point