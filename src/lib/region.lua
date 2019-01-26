-- 為地圖創建多邊形區域，取代we編輯器的region功能

local require = require

local Region = require 'class'("Region")

function Region.Init()
    local pairs = pairs
    local REGIONS = require 'regions'

    -- 初始化區域
    for name, points in pairs(REGIONS) do
        Region(name, points)
    end

    local Game = require 'game'
    local cj = require 'jass.common'
    local Timer = require 'timer.core'
    local Unit = require 'unit.core'

    local period = 1

    Game:Event "單位-創建" (function(_, hero)
        if cj.IsUnitType(hero, cj.UNIT_TYPE_HERO) then
            -- 偵測玩家位置
            Timer(period, true, function(_)
                for name, region in pairs(REGIONS) do 
                    if region:In(hero) then
                        Unit(hero)["所在區域"] = name
                    end
                end
            end)
        end
    end)
end

function Region:_new(name, points)
    local Polygon = require 'polygon'
    self.name_   = name
    self.object_ = Polygon(points)
    
    Region:setInstance(name, self)
end

function Region:HasUnit(unit)
    local Point = require 'point'

    local p_unit = Point.GetUnitLoc(unit)
    local in_region = self.object_:In(p_unit)

    p_unit:Remove()

    return in_region
end

function Region:In(p)
    local in_region = self.object_:In(p)
    return in_region
end

return Region