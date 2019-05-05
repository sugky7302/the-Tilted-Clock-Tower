-- 此Point是util.point的子類別，加入jass函數，專門處理魔獸的點。
-- 依賴
--   class
--   util.point

local require = require
local cj = require 'jass.common'
local Point = require 'util.point'
local CJ_Point = require 'util.class'("CJ_Point", Point)

function CJ_Point:_new(x, y, z)
    return Point(x, y, z)
end

function CJ_Point.Slope3D(p1, p2)
    p1:UpdateZ()
    p2:UpdateZ()

    local z_difference = p2.z_ - p1.z_
    local distance = Point.Distance(p1, p2)

    return z_difference / distance
end

function CJ_Point:UpdateZ()
    local loc = cj.Location(self.x_, self.y_)
    self.z_ = cj.GetLocationZ(loc)

    cj.RemoveLocation(loc)
end

-- 注意是 . 不是 :
function CJ_Point.GetUnitLoc(unit)
    return Point(cj.GetUnitX(unit), cj.GetUnitY(unit))
end

function CJ_Point.GetLoc(p)
    return CJ_Point(cj.GetLocationX(p), cj.GetLocationY(p))
end

return CJ_Point