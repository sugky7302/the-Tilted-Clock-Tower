------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

Item = require 'lib.item'

test = Item{
    name = "test",
    type = "1",
    kind = "2",
    description = "hi"
}

t = Item{
    name = "t",
    type = "3",
    kind = "2",
    description = "ha"
}

print(test:getOwnPlayer())
print(test:isSameType(t))
print(test:isSameKind("2"))

test:registerPickUpEvent(function()
    print("ya hahas")
    return 111
end)

print(test:dispatchPickUpEvent())

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
