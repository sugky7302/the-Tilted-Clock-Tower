------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

Array = require 'util.stl.array'

a = Array()

for i = 1, 9 do
    a:push_back(i)
    a:push_back(i)
end

print(a, a:length())

a:delete(5)
print(a, a:length())

print(a:exist(3), a:length())

a:clear()
print(a, a:length())

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
