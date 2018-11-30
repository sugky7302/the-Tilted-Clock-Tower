local Trigger = require 'trigger'

function TrgTest()
    local trg = Trigger({}, function(_, a, b)
        print(table.concat({"sum = ", a + b}))
    end)

    trg:Run(5, 10)
    
    if trg:IsEnable() then
        print "1"
    else
        print "0"
    end

    trg:Remove()
end

return TrgTest