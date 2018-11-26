local math = math

local MathLib = {}
math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))

-- constants
MathLib.e = math.exp(1)

function MathLib.Round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- 無參數 產生(0, 1)的隨機整數
-- 只有參數n 產生[1, n]的隨機整數
-- 兩個參數 產生[n, m]的隨機整數
function MathLib.Random(n, m)
    if not n then
        return math.random()
    elseif not m  then
        n = math.modf(n)
        return math.random(n)
    else
        n = math.modf(n)
        m = math.modf(m)
        return math.random(n, m)
    end
end

function MathLib.Error(value, compareValue)
    return math.abs(value - compareValue)
end
return MathLib