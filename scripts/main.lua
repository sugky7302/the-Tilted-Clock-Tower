base.add_lua_path 'types'
base.add_lua_path 'stl'
base.add_lua_path 'war3'
base.add_lua_path 'maps'

local cj = require 'jass.common'
local js = require 'jass_tool'
local timer = require 'timerutils'
local group = require 'grouputils'
local spell = require 'spell'
local point = require 'point'
local map = require 'map'
local unit = require 'unit'
local gbs = require 'general_bonus_system'
require 'id'

local function main()
	print('歡迎進入 奧蘭多') -- 測試lua check訊息
	--js.Debug("1") -- 測試遊戲訊息
	gbs.init()
	map.init()
	unit.init()
	spell.init()
end

main()


