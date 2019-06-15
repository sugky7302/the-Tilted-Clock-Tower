------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

Class = require 'util.database'

a = Class(3)

a:append("a", 2, "c")
a:append("k", 5, "q")
print(a:query("k")[3])

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
