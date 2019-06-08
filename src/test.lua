------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

Class = require 'lib.attribute'

a = Class()

a:push_back("法術攻擊力", 3, "t45")
a:push_back("物理攻擊力", 3, "test")
print(a)

a:sort()
print(a)

print(a:exist("法術攻擊力"))
a:erase("法術攻擊力")
print(a:size())
print(a)

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
