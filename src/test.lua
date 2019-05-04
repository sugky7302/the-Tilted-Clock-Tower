------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

rng = require 'util.random_number_generator'
rand = require 'util.math_lib'.rand

for i = 1, 100 do
    print(rand())
end

local t = rng(50)
for i = 1, t:count() do
    print(t:draw())
end

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
