------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

Price = require 'lib.item'

a = Price(0, -205, -300)
print(a)
a = a + Price(35, 1, 5934)
print(a)
a = a - Price(3, 21245, 66)
print(a)
a = a * 5
print(a)
a = a / 17
print(a)
-- print(math.modf(-2100, 1000))
-- print(math.abs(-2))

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
