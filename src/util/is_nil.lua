-- 檢查table是否為空

local function IsNil(tb)
    return tb == nil or next(tb) == nil
end

return IsNil