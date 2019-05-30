------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

Class = require 'util.class'

a = Class("a")
a.x = 1

b = Class("b", a)
b.y = 2

c = Class("c", b)
print(c.y) -- 呼叫b.y
print(c.x) -- 呼叫a.x
print(c.z) -- nil

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
