-- 此module提供各種對所有元素進行排序的方法

local Comparator = {}

-- 來源 honey199396, Lua -- 重写pairs方法（让字典访问有序）
function Comparator.Default(op1, op2)
    local type, tonumber, tostring = type, tonumber, tostring 

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

return Comparator