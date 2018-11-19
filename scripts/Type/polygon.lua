local setmetatable = setmetatable
local math = math
local Point = require 'point'

local Polygon, mt = {}, {}
setmetatable(Polygon, Polygon)
Polygon.__index = mt

-- constants
mt.type = 'Polygon'

-- variables
local _GeneratePoints

function Polygon:__call(points)
    local obj = {
        points = _GeneratePoints(points),
        pointNum = #points,
    }
    setmetatable(obj, self)
    return obj
end

_GeneratePoints = function(points)
    local table_insert = table.insert
    
    local pts = {}
    for i = 1, #points do 
        local p = Point(points[i][1], points[i][2])
        table_insert(pts, p)
    end
    return pts
end

function mt:In(p)
    local crossNum = 0
    for i = 1, self.pointNum do 
        local p1 = self.points[i]
        local p2 = self.points[(i + 1) % self.pointNum] -- 最後一個點與第一個點的連接
        if (p1.y != p2.y) and (p.y >= math.min(p1.y, p2.y)) and (p.y < math.max(p1.y, p2.y)) then
            local x = (p.y - p1.y) * (p2.x - p1.x) / (p2.y - p1.y) + p1.x
            if x > p.x then
                crossNum = crossNum + 1
            end
    end
    return crossNum % 2 == 1
end

return Polygon