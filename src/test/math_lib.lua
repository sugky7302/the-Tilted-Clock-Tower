local function MathTest()
    local MathLib = require 'math_lib'
    
    print(MathLib.Round(123.33333))
    print(MathLib.Difference(15, -20))
end

return MathTest