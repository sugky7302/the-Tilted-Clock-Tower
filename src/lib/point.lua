-- Point is a subclass of util.point, we use functions of jass.common to deal with z-axis

function Point:UpdateZ()
    local loc = cj.Location(self.x_, self.y_)
    self.z_ = cj.GetLocationZ(loc)

    cj.RemoveLocation(loc)
end

-- 注意是 . 不是 :
function Point.GetUnitLoc(unit)
    return Point(cj.GetUnitX(unit), cj.GetUnitY(unit))
end

function Point.GetLoc(p)
    return Point(cj.GetLocationX(p), cj.GetLocationY(p))
end