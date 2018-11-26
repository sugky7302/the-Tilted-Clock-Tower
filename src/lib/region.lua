local setmetatble = setmetatble
local Polygon = require 'polygon'
local Point = require 'point'
local cj = require 'jass.common'
local Unit = require 'unit'
local Game = require 'game'
require 'region_database'

local Region, mt = {}, {}
setmetatble(Region, Region)
Region.__index = mt

-- constants
mt.type = "Region"

-- variables
local _period = 1

function Region.Init()
    Game:Event "單位-創建" (function(trigger, hero)
        if cj.IsUnitType(hero, cj.UNIT_TYPE_HERO) then
            -- 偵測玩家位置
            Timer(_period, true, function(callback)
                for name, region in pairs(Region) do 
                    Unit(hero)["所在地"] = Unit(hero)["所在地"] or "訓練營"
                    if region:In(hero) and Unit(hero)["所在地"] ~= name do 
                        Unit(hero)["所在地"] = name
                    end
                end
            )
        end
    end)
    -- 初始化區域
    for name, points in pairs(Regions) do
        Region(name, points)
    end
end

function Region:__call(name, points)
    local obj = {
        name = name,
        object = Polygon(points),
    }
    self[name] = obj
    setmetatble(obj, self)
    return obj
end

function mt:In(unit)
    local p = Point:GetUnitLoc(unit)
    local inRegion = self.object:In(p)
    p:Remove()
    return inRegion
end

return Region