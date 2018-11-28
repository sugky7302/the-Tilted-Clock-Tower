-- 補充lua沒有的數學庫

local math = math

local MathLib = {}

-- constants
MathLib.e = math.exp(1)

function MathLib.Round(num)
    if num >= 0 then
        local floor = math.floor
        return floor(num + 0.5) 
    else
        local ceil = math.ceil
        return ceil(num - 0.5)
    end
end

-- 無參數 產生(0, 1)的隨機整數
-- 只有參數n 產生[1, n]的隨機整數
-- 兩個參數 產生[n, m]的隨機整數
math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))
function MathLib.Random(n, m)
    local random = math.random
    if not n then
        return random()
    end
    
    if not m  then
        return random(n)
    end

    return random(n, m)
end

function MathLib.Difference(value, compareValue)
    local abs = math.abs
    return abs(value - compareValue)
end

return MathLib