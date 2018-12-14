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
-- n, m 非整數會報錯
math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))
function MathLib.Random(n, m)
    local random, modf = math.random, math.modf
    if not n then
        return random()
    end
    
    if not m then
        n = modf(n)
        return random(n)
    end

    n = modf(n)
    m = modf(m)
    return random(n, m)
end

function MathLib.Difference(value, compareValue)
    local abs = math.abs
    return abs(value - compareValue)
end

function MathLib.BoundValue(value_min, value, value_max)
    local max, min = math.max, math.min

    -- 沒有上下限，直接回傳值
    if not(value_min or value_max) then
        return value
    end

    if not value_min then
        return min(value_max, value)
    end

    if not value_max then
        return max(value_min, value)
    end

    return min(value_max, max(value_min, value))
end

return MathLib