------------------------------------------
-- 直接F5測試程式碼有無問題，不用再開啟war3.exe
local clock = os.clock
local start_time = clock()
----------------以下為撰寫區----------------

local a = string.match("冷卻時間: |Cffffcc004|r|n|n對目標造成|Cffffcc00*60|r|Cff99ccff[+*5]|r點冰寒傷害。", "*%d+")
local b = string.find("冷卻時間: |Cffffcc004|r|n|n對目標造成|Cffffcc0020-45|r|Cff99ccff[+6]|r點冰寒傷害。", "|Cffffcc00[%d+]|r")
print(a)

----------------以上為撰寫區----------------
local end_time = clock()
print("--------")
print(string.format("cost: %.4f (s)", end_time - start_time))
print("--------")
------------------------------------------
