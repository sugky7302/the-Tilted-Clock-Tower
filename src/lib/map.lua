-- 初始化地圖數據

-- assert
local RegUnits

local function Map()
	-- 英雄初始化
    require 'heros.init'

    -- 註冊單位
    RegUnits()
end

RegUnits = function()
    local Hero = require 'unit.hero'
    local Unit = require 'unit.core'
    local Game = require 'game'
    local Group = require 'group.core'

    -- 為單位生成結構與註冊事件
    local g = Group()
    g:EnumUnitsInRange(0, 0, 9999999, "Nil")
    g:Loop(function(self, i)
        if Unit.IsHero(self.units_[i]) then
            Hero(self.units_[i])
        else
            Unit(self.units_[i])
        end

        Game:EventDispatch("單位-創建", self.units_[i])
    end)

    g:Remove()
end

-- call
Map()
