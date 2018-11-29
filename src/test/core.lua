function Test(file_name)
    local format = string.format
    local require = require
    
    local start_time = os.clock()
        
    require("test." .. file_name)()
    
    local end_time = os.clock()
    print("--------")
    print(format("start time : %.4f", start_time))
    print(format("end time   : %.4f", end_time))
    print(format("cost time  : %.4f s", end_time - start_time))
    print("--------")   
end

return Test