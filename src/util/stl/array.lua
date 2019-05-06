-- 生成一個連續但移除中間元素後，順序會開始混亂的類vector結構

local Array = require 'util.class'("Array")

-- default
Array._end_ = 1 -- ex: for i = _begin_, _end_ - 1(要記得扣，不然空array也會執行一次迴圈) do

function Array:__tostring()
    local concat = table.concat
    local print_tb = {"["}

    for i = 1, self._end_-1 do
        print_tb[#print_tb+1] = self[i]
    end

    print_tb[#print_tb+1] = "]"

    return table.concat(print_tb, " ")
end

-- 操作元素
function Array:push_back(data)
    if not data then
        return false
    end

    -- 先添加資料再調整索引才不會錯誤
    self[self._end_] = data
    
    self._end_ = self._end_ + 1
end

-- 刪除所有"資料 = data"的空間
function Array:delete(data)
    if not data then 
        return false
    end

    for i = 1, self._end_-1 do
        if self[i] == data then
            -- 將最後一個元素覆蓋至現在位置
            self[i] = self[self._end_-1]
            self[self._end_-1] = nil

            -- 調整索引
            self._end_ = self._end_ - 1
        end
    end
end

function Array:clear()
    for i = 1, self._end_-1 do 
        self[i] = nil
    end

    self._end_ = 1
end

-- 存在的話會回傳索引
-- 只找第一筆資料
function Array:exist(data)
    if not data then 
        return false
    end

    for i = 1, self._end_-1 do
        if self[i] == data then
            return i
        end
    end

    return false
end

-- 獲取私有成員變量
function Array:empty()
    return self._end_ == 1
end

function Array:size()
    return self._end_ - 1
end

return Array