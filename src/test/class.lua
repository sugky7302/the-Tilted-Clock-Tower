local function ClassTest()
    -- 測試結果 require 只會載一次
    local class1 = require 'class'
    local class2 = require 'class'

    local test_class = class1("test")
    local test_class1 = class1("test1", test_class)
    local test_class11 = class1("test11", test_class)
    local test_class2 = class1("test2", test_class1, test_class11)
    
    test_class.y_ = 3
    test_class11.z_ = 4

    function test_class:_new()
        self.x_ = 1
    end

    function test_class1:_new()
        self.x_ = 2
    end

    function test_class11:_new()
        self.x_ = 5
    end

    local test_instance = test_class()
    print(test_instance.x_)
    print(test_instance.y_)
    print " " 

    local test_instance1 = test_class1()
    print(test_instance1.x_)
    print(test_instance1.y_)
    print " " 

    local test_instance3 = test_class11()
    print(test_instance3.x_)
    print(test_instance3.y_)
    print " " 
    
    local test_instance2 = test_class2()
    print(test_instance2.x_)
    print(test_instance2.y_)
    print(test_instance2.z_)
end

return ClassTest