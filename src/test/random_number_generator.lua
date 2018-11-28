local RNG = require 'random_number_generator'

function RNG_Test()
    local deck = RNG("test", 25)
    local valid_count = 0
    for i = 1, 96 do 
        if deck:draw() then
            print "1"
            valid_count = valid_count + 1
        else
            print "0"
        end
    end
    print("p = " .. valid_count / 96)
    deck:Reset()
    local valid_count = 0
    for i = 1, 96 do 
        if deck:draw() then
            print "1"
            valid_count = valid_count + 1
        else
            print "0"
        end
    end
    print("p = " .. valid_count / 96)
end

return RNG_Test