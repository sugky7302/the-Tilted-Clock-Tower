------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

Class = require 'lib.equipment'

a = Class{
    name = "test",
    kind = "a",
    type = "pmna",
}

a:registerPickUpEvent(function(_, self, secrets)
    print(self:enchanting(secrets))
end)

Class1 = require 'lib.secrets'
b = Class1{
    name = "test1",
    kind = "d",
    type = "sbch"
}

c = Class1{
    name = "test2",
    kind = "d",
    type = "crys"
}

a:dispatchPickUpEvent(c)
a:dispatchPickUpEvent(b)

a:update()
print(a:getName())

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
