-- 用於判斷包含table是否為Nil

local function IsNil(tb)
    return tb == nil or next(tb) == nil
end

return IsNil