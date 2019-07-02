------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

local Copy = require 'util.copy'
t = {1, 2, 3, {5,4,2}}
t1 = Copy.copy(t)
t2 = Copy.deepCopy(t)
print(t, t1, t2)

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
