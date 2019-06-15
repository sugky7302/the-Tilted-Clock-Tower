------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

Class = require 'lib.attribute'

a = Class()

a:insert("法術護甲%", 25, true)
a:insert("物理攻擊力", 15)
a:insert("龍系增傷", 10)
print(a:size())
print(a)
a:sort()
print(a)
a:setValue("物理攻擊力", 30)
print(a)
a:addValue("龍系增傷", -5)
print(a)
print(a:getName(5))
print(a:getValue(3))

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
