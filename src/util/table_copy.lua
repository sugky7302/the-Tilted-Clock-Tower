-- 複製table，連同原table的mt也一起複製
-- 使用遞迴在處理速度上會比較慢

local function Copy(object)      
    local search_table = {}  
    
    local function Func(object)  
        if type(object) ~= "table" then  
            return object         
        end  

        local new_table = {}  
        search_table[object] = new_table  

        for k, v in pairs(object) do  
            new_table[Func(k)] = Func(v)  
        end     
    
        return setmetatable(new_table, getmetatable(object))      
    end    

    return Func(object)  
end 

return Copy