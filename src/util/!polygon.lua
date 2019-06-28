-- 創建多邊形區域，並可偵測有沒有點在多邊形內
-- 依賴
--   point
--   class


local require = require

local Polygon = require 'class'("Polygon")

-- assert
local GeneratePoints

-- points.shape = (2n, 1)
function Polygon:_new(points)
    self.point_num_ = #points / 2
    self.points_ = GeneratePoints(points)
end

GeneratePoints = function(points)

    -- 奇數索引是X座標，偶數索引是Y座標
    local pts, x_tmp = {}
    for i = 1, #points do
        if i % 2 == 1 then
            x_tmp = points[i]
        else
            pts[#pts + 1] = require 'util.point':new(x_tmp, points[i])
        end
    end

    return pts
end

function Polygon:__tostring()
    local print_str_tb = {}

    for i = 1, self.point_num_ do
        print_str_tb[#print_str_tb + 1] = "("
        print_str_tb[#print_str_tb + 1] = self.points_[i].x_
        print_str_tb[#print_str_tb + 1] = ", "
        print_str_tb[#print_str_tb + 1] = self.points_[i].y_
        print_str_tb[#print_str_tb + 1] = ", "
        print_str_tb[#print_str_tb + 1] = self.points_[i].z_
        print_str_tb[#print_str_tb + 1] = ") "
    end

    return table.concat(print_str_tb)
end

-- 以p為起點，向右作一條射線，看射線跟邊相交的點的數量是奇還偶
function Polygon:In(p)
    local math = math
    local cross_num = 0

    for i = 1, self.point_num_ do 
        local p1 = self.points_[i]

        local next_index = (i + 1) - math.floor(i / self.point_num_) * self.point_num_ -- 最後一個點與第一個點的連接
        local p2 = self.points_[next_index]

        -- 點經過水平的邊不算
        -- 點的y座標比兩端點都低或都高，都代表碰不到邊
        if (p1.y_ ~= p2.y_) and
           (p.y_  >= math.min(p1.y_, p2.y_)) and
           (p.y_  <  math.max(p1.y_, p2.y_)) then
            -- 計算斜率，再用比例求x
            local x = (p.y_ - p1.y_) * (p2.x_ - p1.x_) / (p2.y_ - p1.y_) + p1.x_

            if x > p.x_ then
                cross_num = cross_num + 1
            end
        end
    end

    -- 奇數表示在裡面，偶數表示在外面
    return cross_num % 2 == 1
end

return Polygon