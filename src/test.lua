------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

List = require 'util.stl.list'

a = List()
print(a)
for i = 1, 10 do
    a:push_back(i)
    a:push_back(i)
end
print(a)
a:erase(5)
print(a)
a:insert(11)
print(a)
a:insert(12)
print(a)
a:erase(8)
print(a)

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
