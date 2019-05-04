-- 補充lua沒有的數學庫

local math = math

local MathLib = {
    -- constants
    e = math.exp(1)
}

function MathLib.round(num)
    if num >= 0 then
        return math.floor(num + 0.5) 
    else
        return math.ceil(num - 0.5)
    end
end

-- 無參數 產生(0, 1)的隨機整數
-- 只有參數n 產生[1, n]的隨機整數
-- 兩個參數 產生[n, m]的隨機整數
-- n, m 非整數會報錯
math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))
function MathLib.rand(n, m)
    local modf = math.modf
    if not n then
        return math.random()
    end
    
    if not m then
        n = modf(n)
        return math.random(n)
    end

    n = modf(n)
    m = modf(m)
    return math.random(n, m)
end

-- 確認值是否超出最大或最小值
function MathLib.bound(value_min, value, value_max)
    -- 沒有上下限，直接回傳值
    if not(value_min or value_max) then
        return value
    end

    if not value_min then
        return math.min(value_max, value)
    end

    if not value_max then
        return math.max(value_min, value)
    end

    return math.min(value_max, math.max(value_min, value))
end

return MathLib