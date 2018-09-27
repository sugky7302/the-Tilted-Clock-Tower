local Base = require 'Base'

Base.add_lua_path 'types'
Base.add_lua_path 'stl'
Base.add_lua_path 'war3'
Base.add_lua_path 'maps'

local cj = require 'jass.common'
local js = require 'jass_tool'

local main = nil

main()

local function main()
	print('歡迎進入 奧蘭多') -- 測試lua check訊息
	--js.Debug("1") -- 測試遊戲訊息
end

