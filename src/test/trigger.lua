local function TrgTest()
    local Trigger = require 'trigger'

    local trg = Trigger({}, function(_, a, b)
        print(table.concat({"sum = ", a + b}))
    end)

    trg:Run(5, 10)
    
    if trg:isEnable() then
        print "1"
    else
        print "0"
    end

    trg:Remove()
end

return TrgTest