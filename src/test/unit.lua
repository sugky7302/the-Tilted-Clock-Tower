function UnitTest(self)
    local Unit = require 'unit.core'

    require 'unit.attribute.init'

    local test_unit = Unit(self.EnumUnit())
    print(test_unit:get "生命")
    test_unit:set("生命", 50)
    print(test_unit:get "生命")
    --test_unit:set("生命%", 30) <- 會報錯
    test_unit:add("生命%", 20)
    print(test_unit:get "生命")
    test_unit:add("生命", 100)
    print(test_unit:get "生命")

    print(test_unit:get "生命上限")
    print(test_unit:get "魔力上限")
    print(test_unit:get "最大物理攻擊力")
    print(test_unit:get "物理攻擊力")
    print(test_unit:get "攻擊速度")
    print(test_unit:get "移動速度")

    if test_unit:IsAlive() then
        print "1"
    else
        print "0"
    end

    test_unit:AbilityDisable "A00H"
    test_unit:AddAbility "A00A"

    if test_unit:HasAbility "A00A" then
        print "3"
    else
        print "2"
    end

    Unit:Event "測試" (function()
        print "test..."
    end)

    test_unit:EventDispatch("測試")
end

return UnitTest