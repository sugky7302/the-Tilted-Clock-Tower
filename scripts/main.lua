local cj = require 'jass.common'
local js = require 'jass_tool'
local gbs = require 'general_bonus_system'
local Color = require 'color'
local Test = require 'test'
local Group = require 'group'
local Combat = require 'combat'
local Timer = require 'timer'
require 'id'

local function _RegisterHeros()
    Base.Heros = Group()
    Base.Heros:EnumUnitsInRange(0, 0, 1000000, Group.IsNonHero)
    Base.Heros:Loop(function(heros, i)
        Combat:RegisterEvent(heros.units[i])
    end)
end

local function _Main()
    print('Welcome to Orlando') -- 測試lua check訊息
    js.Debug("Welcome to Orlando") -- 測試遊戲訊息
    Timer.Init()
    gbs.Init()
    Color:Init()
    Combat:Init()
    _RegisterHeros()
    Test()
end

_Main()
    