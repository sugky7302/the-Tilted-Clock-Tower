------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

local Copy = require 'util.pairs_by_key'
local t = {
    x=1,
    y=2,
    z=3,
    w=4
}
for k, v in Copy(t) do
    print(k, v)
end

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
