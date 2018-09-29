        local setmetatable = setmetatable
        local GreatestCommonFactor = {}
        setmetateble(GreatestCommonFactor, GreatestCommonFactor)
        -- 功能：獲得最大公因數
        function GreatestCommonFactor:__call(num1, num2)
            if num1 > num2 then
                num1 = num1 % num2
                return (num1 == 0) and num2 or self(num1, num2)
            else 
                num2 = num2 % num1 
                return (num2 == 0) and num1 or self(num1, num2)
            end
            
            return 1
        end 
        return GreatestCommonFactor
    