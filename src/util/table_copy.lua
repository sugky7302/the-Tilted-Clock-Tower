-- 複製table，連同原table的mt也一起複製

local function Copy(object)      
    local search_table = {}  
    
    local function Func(object)  
        if type(object) ~= "table" then  
            return object         
        end  

        local new_table = {}  
        search_table[object] = new_table  

        local pairs = pairs
        for k, v in pairs(object) do  
            new_table[Func(k)] = Func(v)  
        end     
       
        local setmetatable, getmetatable = setmetatable, getmetatable
        return setmetatable(new_table, getmetatable(object))      
    end    
  
    return Func(object)  
end 

return Copy