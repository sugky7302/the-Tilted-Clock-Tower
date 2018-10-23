local Map = {}

-- variables
local _RegUnits

function Map.Init()
    local Combat = require 'combat'
	-- 英雄初始化
    require 'heros.init'
    -- 物品核心系統初始化
    require 'Item.init'
    -- 遊戲初始化
    Combat:Init()
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
