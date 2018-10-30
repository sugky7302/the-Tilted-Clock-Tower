local Runtime = require 'jass.runtime'
local Console = require 'jass.console'
local Debug = require 'jass.debug'

Base = {}

-- Debug模式
Base.debugMode = true

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

package.path = package.path .. ';D:\\Tools\\YDWE1.25.10\\Creation\\Mod\\The_Tilted_Clock_Tower\\scripts\\?.lua'

function Base.AddPath(dir)
    if dir ~= '' then
        dir = dir ..[[\]]
    end
	local r = dir .. '?.lua'
	package.path = package.path .. ';D:\\Tools\\YDWE1.25.10\\Creation\\Mod\\The_Tilted_Clock_Tower\\scripts\\' .. r
end

-- 添加路徑
Base.AddPath 'Item'
Base.AddPath 'Module'
Base.AddPath 'STL'
Base.AddPath 'Maps'
Base.AddPath 'Test'
Base.AddPath 'Tool'
Base.AddPath 'Type'
Base.AddPath 'War3'
Base.AddPath 'Database'
Base.AddPath 'Buff'
Base.AddPath 'Talent'

-- 初始化本地腳本
require 'main'
    