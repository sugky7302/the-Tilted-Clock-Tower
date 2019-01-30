local function pairsTest()
    local pairsByKey = require 'pairs_by_key'
    
    local tb = {1, 2, 3, 4, 5, 6, 7, 8,
                a = "a", b = "b", c = "c", d = "d", e = "e", f = "f", g = "g", h = "h"}
    local start = os.clock()
    for _, val in pairs(tb) do 
        print(val)
    end
    print(os.clock() - start)
    print "----"
    local start = os.clock()
    for _, val in pairsByKey(tb) do
        print(val)
    end
    print(os.clock() - start)
end

return pairsTest
