local cj = require 'jass.common'
local js = require 'jass_tool'
local Test = require 'test'
local Map = require 'map'
require 'id'
require 'order_id'

local function _Main()
    print('Welcome to Orlando') -- 測試lua check訊息
    js.Debug("Welcome to Orlando") -- 測試遊戲訊息
    -- 類型初始化
    require 'Type.init'
    -- 工具初始化
    require 'Tool.init'
    -- 地圖機制初始化
    Map.Init() -- 因為要替所有單位註冊事件，因此一定要放在最後
    Test()
end

_Main()
    