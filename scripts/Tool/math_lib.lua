local math = math

local MathLib = {}

function MathLib.Round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- 無參數 產生(0, 1)的浮點隨機數
-- 只有參數n 產生[1, n]的隨機整數
-- 兩個參數 產生[n, m]的隨機整數
function MathLib.Random(n, m)
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    if not n then
        return math.random()
    elseif not m then
        return math.random(n)
    else
        return math.random(n, m)
    end
end

return MathLib