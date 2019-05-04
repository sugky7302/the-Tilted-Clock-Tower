------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local format = string.format
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

Color = require 'util.color'

print(Color("red"))
print(Color("skin"))
print(Color("a"))
print(Color(255, 0, 0))

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
