local Combat = require 'combat'
local Group = require 'group'
local Skill = require 'skill'
local Unit = require 'unit'
local Hero = require 'hero'

local Map = {}

function Map.Init()
	-- 註冊英雄
    require 'heros.init'
    -- 遊戲初始化
    Combat:Init()
    Skill.Init()
    Unit.Init()
    Hero.Init()
end

return Map
