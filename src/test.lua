------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

Stack = require 'util.stl.stack'

a = Stack()

for i = 1, 9 do
    a:push(i)
    a:push(i)
end

print(a, a:size())

print(a:top())

a:pop()
print(a, a:size())

-- print(a:exist(3), a:size())

a:clear()
print(a, a:size())

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
