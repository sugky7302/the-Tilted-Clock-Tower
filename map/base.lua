-- 此module啟用lua訊息框，並加載路徑，使後續module在require時，能夠省去父路徑

local Runtime = require 'jass.runtime'
local Console = require 'jass.console'
local Debug = require 'jass.debug'

Base = {}

-- Debug模式
Base.debug_mode = true

-- 打開控制台
Console.enable = true

-- 重載print，自動轉換編碼
print = Console.write

-- 將handle等級設為0(地圖中所有的handle均使用table封裝)
Runtime.handle_level = 0

-- 關閉等待
Runtime.sleep = false

function Base.ErrorHandle(msg)
    print("---------------------------------------")
    print(tostring(msg) .. "\n")
    print(Debug.traceback())
    print("---------------------------------------")
end

-- 錯誤匯報
function Runtime.ErrorHandle(msg)
    Base.ErrorHandle(msg)
end

local abs_path = ';D:\\Tools\\YDWE1.25.10\\Creation\\Mod\\The_Tilted_Clock_Tower\\src\\'
-- 一定要絕對路徑，不然lua會找不到
package.path = package.path .. abs_path .. '?.lua'

function Base.AddPath(dir)
    if dir ~= '' then
        dir = dir ..[[\]]
    end
	local path = dir .. '?.lua'
	package.path = package.path .. abs_path .. path
end

Base.AddPath 'data'
Base.AddPath 'lib'
Base.AddPath 'war3'
Base.AddPath 'util'

-- 初始化本地腳本
require 'main'
    