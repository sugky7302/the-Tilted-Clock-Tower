-- 屬性換算

local Conversion = {}

-- 命中和閃避
function Conversion.Hit_Dodge(x, y)
    return (x - y) / (2 * y + 100)
end

-- 暴擊和韌性
function Conversion.Cri_ACT(x, y)
    return x / (x + 60 * y + 50)
end

-- 穿透和格擋
function Conversion.Pnt_Blk(x, y)
    return x / (2 * y)
end

return Conversion