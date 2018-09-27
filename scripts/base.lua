local Runtime	= require 'jass.runtime'
local Console	= require 'jass.console'
local string  = string

Base = {}

-- 版本號
Base.VERSION = '0.1.0'

--打開控制台
Console.enable = true

--重載print，自動轉換編碼
print = Console.write

--將handle等級設為0(地圖中所有的handle均使用table封裝)
Runtime.handle_level = 0

--關閉等待
Runtime.sleep = false

function Base.error_handle(msg)
	print("---------------------------------------")
	print(tostring(msg) .. "\n")
	print(debug.traceback())
	print("---------------------------------------")
end

--錯誤匯報
function Runtime.error_handle(msg)
	Base.error_handle(msg)
end

package.path = [[D:\YDWE1.25.10\example\Mod\The_Tilted_Clock_Tower\scripts\?.lua]]

function Base.add_lua_path(dir)
	if dir ~= '' then dir = dir ..[[\]] end
	local r = dir .. '?.lua'
	package.path = package.path .. ';' .. [[D:\YDWE1.25.10\example\Mod\The_Tilted_Clock_Tower\scripts\]] .. r
end

-- 添加require搜寻路径
Base.add_lua_path ''

-- 初始化本地腳本
require 'main'