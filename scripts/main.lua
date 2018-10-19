local cj = require 'jass.common'
local js = require 'jass_tool'
local Color = require 'color'
local Test = require 'test'
local Timer = require 'timer'
local Map = require 'map'
require 'id'

local function _Main()
    print('Welcome to Orlando') -- 測試lua check訊息
    js.Debug("Welcome to Orlando") -- 測試遊戲訊息
    Timer.Init()
    Color:Init()
    Map.Init()
    Test()
end

_Main()
    