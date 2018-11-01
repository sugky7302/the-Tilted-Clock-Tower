local Map = {}

-- variables
local _RegUnits

function Map.Init()
    local Combat = require 'combat'
    local Skill = require 'skill'
	-- 英雄初始化
    require 'heros.init'
    -- 增益效果初始化
    require 'buffs.init'
    -- 天賦初始化
    require 'talents.init'
    -- 任務初始化
    require 'quests.init'
    -- 技能系統初始化
    Skill.Init()
    -- 戰鬥系統初始化
    Combat:Init()
    -- 註冊單位
    _RegUnits()
end

_RegUnits = function()
    local cj = require 'jass.common'
    local Hero = require 'hero'
    local Unit = require 'unit'
    local Game = require 'game'
    local Group = require 'group'
    -- 為單位生成結構與註冊事件
    local g = Group()
    g:EnumUnitsInRange(0, 0, 9999999, Group.Nil)
    g:Loop(function(self, i)
        if cj.IsUnitType(self.units[i], cj.UNIT_TYPE_HERO) then
            Hero(self.units[i])
        else
            Unit(self.units[i])
        end
        Game:EventDispatch("單位-創建", self.units[i])
    end)
    g:Remove()
end

return Map
