-- 生成一個連續但移除中間元素後，順序會開始混亂的類vector結構

local Array = require 'class'("Array")

-- default
Array._begin_  = 1
Array._end_    = 1 -- ex: for i = _begin_, _end_ - 1(要記得扣，不然空array也會執行一次迴圈) do
Array._length_ = 0

-- 操作元素
function Array:PushBack(data)
    if not data then
        return false
    end

    -- 先添加資料再調整索引才不會錯誤
    self[self._end_] = data
    
    self._end_ = self._end_ + 1
    self._length_ = self._length_ + 1
end

-- 刪除所有"資料 = data"的空間
function Array:Delete(data)
    if not data then 
        return false
    end

    local first, last = self._begin_, self._end_ - 1
    for i = first, last do
        if self[i] == data then
            -- 將最後一個元素覆蓋至現在位置
            self[i] = self[last]
            self[last] = nil

            -- 調整索引
            self._end_ = self._end_ - 1
            self._length_ = self._length_ - 1
        end
    end
end

function Array:Clear()
    for i = self._begin_, self._end_ - 1 do 
        self[i] = nil
    end

    self._begin_ = 1
    self._end_ = 1
    self._length_ = 0
end

-- 存在的話會回傳索引
-- 只找第一筆資料
function Array:Exist(data)
    if not data then 
        return false
    end

    for i = self._begin_, self._end_ - 1 do
        if self[i] == data then
            return i
        end
    end

    return false
end

-- 獲取私有成員變量
function Array:IsEmpty()
    return self._length_ == 0
end

function Array:getLength()
    return self._length_
end

return Array