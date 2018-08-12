local runtime	= require 'jass.runtime'
local console	= require 'jass.console'
local string  = string

base = {}

-- 版本號
base.version = '0.1.0'

--打開控制台
console.enable = true

--重載print，自動轉換編碼
print = console.write

--將handle等級設為0(地圖中所有的handle均使用table封裝)
runtime.handle_level = 0

--關閉等待
runtime.sleep = false

function base.error_handle(msg)
	print("---------------------------------------")
	print(tostring(msg) .. "\n")
	print(debug.traceback())
	print("---------------------------------------")
end

--錯誤匯報
function runtime.error_handle(msg)
	base.error_handle(msg)
end

package.path = [[D:\YDWE1.25.10\example\自製技能\Mod\傾斜的時鐘塔Lua版\scripts\?.lua]]

function base.add_lua_path(dir)
	if dir ~= '' then dir = dir ..[[\]] end
	local r = dir .. '?.lua'
	package.path = package.path .. ';' .. [[D:\YDWE1.25.10\example\自製技能\Mod\傾斜的時鐘塔Lua版\scripts\]] .. r
end

-- 添加require搜寻路径
base.add_lua_path ''

-- 初始化本地腳本
require 'main'