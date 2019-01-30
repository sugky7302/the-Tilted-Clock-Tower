-- assert
local _TestInTime
local _Recursive

local function GCF_Test()
    local gcf = require 'greatest_common_factor'

    _TestInTime(gcf, 10, 20)
    _TestInTime(_Recursive, 10, 20)
    _TestInTime(gcf, 77, 99)
    _TestInTime(_Recursive, 77, 99)
end

_TestInTime = function(fn, a, b)
    local format = string.format

    local start = os.clock()
    local num = fn(a, b)
    local cost = format("%d : %.8f s", num, os.clock() - start)
    print(cost)
end

_Recursive = function (num1, num2)
    if num1 > num2 then
        num1 = num1 % num2
        return (num1 == 0) and num2 or _Recursive(num1, num2)
    else 
        num2 = num2 % num1 
        return (num2 == 0) and num1 or _Recursive(num1, num2)
    end
    
    return 1
end 

return GCF_Test