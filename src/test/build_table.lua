function TableTest()
    local format = string.format
    local times = 2000000

    local tb = {}
    tb.f = function() print "111" end
    tb["f"]()
    
    local start_time = os.clock()
    local tb1 = {}
    for i = 1, times do
        tb1[#tb1 + 1] = i
    end
    local end_time = os.clock()
    print(format("cost %.8f s to build.", end_time - start_time))

    local start_time = os.clock()
    local tb2, tb3 = {}, {}
    for i = 1, times do
        if i > times / 2 then
            tb3[#tb3 + 1] = i    
        else
            tb2[#tb2 + 1] = i
        end
    end

    local end_time = os.clock()
    print(format("cost %.8f s to build.", end_time - start_time))

    local start_time = os.clock()
    local tb7, tb8, tb9, tb10 = {}, {}, {}, {}
    for i = 1, times do
        if i > 1500000 then
            tb10[#tb10 + 1] = i 
        elseif i > 1000000 then
            tb9[#tb9 + 1] = i 
        elseif i > 500000 then
            tb8[#tb8 + 1] = i 
        else
            tb7[#tb7 + 1] = i 
        end
    end

    local end_time = os.clock()
    print(format("cost %.8f s to build.", end_time - start_time))

    local start_time = os.clock()
    local tb4 = {}
    for i = 1, times do
        local label = i .. ""
        tb4[label] = i
    end
    local end_time = os.clock()
    print(format("cost %.8f s to build.", end_time - start_time))

    local start_time = os.clock()
    local tb5, tb6 = {}, {}
    for i = 1, times do
        local label = i .. ""
        if i > times / 2 then
            tb3[label] = i    
        else
            tb2[label] = i
        end
    end
    local end_time = os.clock()
    print(format("cost %.8f s to build.", end_time - start_time))
end

return TableTest