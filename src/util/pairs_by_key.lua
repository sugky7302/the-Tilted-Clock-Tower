-- 解決pairs無序的問題

-- assert 
local _Comparator

-- O(#tb)的方法
function pairsByKey(tb)
    local pairs = pairs
    local tb_key, size = {}, 0
    for n in pairs(tb) do 
        size = size + 1
        tb_key[size] = n 
    end
    
    local table_sort = table.sort
    table_sort(tb_key, _Comparator)
    
    local i = 0
    return function()
        i = i + 1
        return tb_key[i], tb[tb_key[i]]
    end
end

-- 來源 honey199396, Lua -- 重写pairs方法（让字典访问有序）
_Comparator = function(op1, op2)
    local type1, type2 = type(op1), type(op2)
    local num1,  num2  = tonumber(op1), tonumber(op2)

    -- 處理number, string, boolean
    if ( num1 ~= nil) and (num2 ~= nil) then
        return  num1 < num2
    end

    if type1 ~= type2 then
        return type1 < type2
    end
    
    if type1 == "string"  then
        return op1 < op2
    end

    if type1 == "boolean" then
        return op1
    end
    
    -- 處理剩下的 function, table, thread, userdata
    -- tostring之後比較字串
    return tostring(op1) < tostring(op2)  
end

return pairsByKey
    