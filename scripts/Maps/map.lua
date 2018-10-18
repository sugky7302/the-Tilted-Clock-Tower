local Combat = require 'combat'
local Game = require 'game'
local Group = require 'group'
local Skill = require 'skill'

local Map = {}

local function _RegisterHeros()
    Base.Heros = Group()
    Base.Heros:EnumUnitsInRange(0, 0, 1000000, Group.IsHero)
    Base.Heros:Loop(function(heros, i)
        Game:EventDispatch("單位-創建", heros.units[i])
    end)
end

function Map.Init()
	-- 註冊英雄
    require 'heros.init'
    -- 遊戲初始化
    Combat:Init()
    Skill.Init()
    _RegisterHeros()
end

return Map
