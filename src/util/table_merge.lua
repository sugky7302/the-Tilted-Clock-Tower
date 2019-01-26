-- 將兩個table合併，但不合併內部的table元素

local function TableMerge(tb1, tb2)
    local type = type
    
    for k, v in pairs(tb2) do 
        if type(k) == 'number' then
            tb1[#tb1 + 1] = v
        end

        -- 如果tb1[k]有值，就把tb2[k]塞到tb1末端
        if type(k) == 'string' then
            if tb1[k] then
                tb1[#tb1 + 1] = v
            else
                tb1[k] = v 
            end
        end
    end
end

return TableMerge