-- 此module為地圖創建多邊形區域，取代we編輯器的region功能

local setmetatble = setmetatble

local Region, mt = {}, {}
setmetatable(Region, Region)
Region.__index = mt

-- constants
mt.type = "Region"

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
    local Unit = require 'unit'

    local _period = 1

    Game:Event "單位-創建" (function(_, hero)
        if cj.IsUnitType(hero, cj.UNIT_TYPE_HERO) then
            -- 偵測玩家位置
            Timer(_period, true, function(_)
                for name, region in pairs(REGIONS) do 
                    if region:In(hero) then
                        Unit(hero)["所在區域"] = name
                    end
                end
            end)
        end
    end)
end

function Region:__call(name, points)
    local Polygon = require 'polygon'

    local instance = {
        name_ = name,
        object_ = Polygon(points),
    }

    self[name] = instance

    setmetatable(instance, self)

    return instance
end

function mt:HasUnit(unit)
    local Point = require 'point'

    local p_unit = Point:GetUnitLoc(unit)
    local in_region = self.object_:In(p_unit)

    p_unit:Remove()

    return in_region
end

function mt:In(p)
    local in_region = self.object_:In(p)
    return in_region
end

return Region