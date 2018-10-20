local cj = require 'jass.common'
local js = require 'jass_tool'
local Color = require 'color'
local Test = require 'test'
local Timer = require 'timer'
local Map = require 'map'
local Unit = require 'unit'
local Hero = require 'hero'
local Player = require 'player'
require 'id'
require 'order_id'

local function _Main()
    print('Welcome to Orlando') -- 測試lua check訊息
    js.Debug("Welcome to Orlando") -- 測試遊戲訊息
    Timer.Init()
    Color:Init()
    Player.Init()
    Unit.Init()
    Hero.Init()
    Map.Init() -- 因為要替所有單位註冊事件，因此一定要放在最後
    Test()
end

_Main()
    