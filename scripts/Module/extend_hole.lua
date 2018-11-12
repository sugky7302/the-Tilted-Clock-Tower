local setmetatable = setmetatable
local math = math
local MathLib = require 'math_lib'
local cj = require 'jass.common'
local Equipment = require 'equipment'

local ExtendHole = {}
setmetatable(ExtendHole, ExtendHole)

-- variables
local _IsEquipmentInBag, _GetGoldCost, _IsGoldEnough

function ExtendHole.Init()
    local Game = require 'game'
    local Hero = require 'hero'

    -- Game:Event "單位-使用物品" (function(self, unit, item)
    --     ExtendHole(Hero(unit))
    -- end)
end

function ExtendHole:__call(hero)
    if _IsEquipmentInBag(hero.object) then
        local item = Equipment(cj.UnitItemInSlot(hero.object, 0))
        local goldCost = _GetGoldCost(item.level + item.intensifyLevel, item.attributeCount)
        if _IsGoldEnough(item.ownPlayer, goldCost) then
            if item:IsLimit() then
                item.ownPlayer:add("黃金", -goldCost)
                item.attributeCountLimit = item.attributeCountLimit + 1
                cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 鑲環成功。")
            else
                cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 環數已達上限。")
            end
        else
            cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 你攜帶的金錢不足。")
        end
    else
        cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 你第一格沒有裝備。")
    end
end

_IsEquipmentInBag = function(owner)
    return cj.GetItemLevel(cj.UnitItemInSlot(owner, 0)) == 5
end

_GetGoldCost = function(level, holeCount)
    return 100 * MathLib.e ^ holeCount * level * (math.modf((level-1) / 8) + 1)
end

_IsGoldEnough = function(ownPlayer, goldCost)
    return ownPlayer:get "黃金" >= goldCost
end

return ExtendHole