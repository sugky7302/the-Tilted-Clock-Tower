local setmetatable = setmetatable
local math = math
local cj = require 'jass.common'
local MathLib = require 'math_lib'
local Equipment = require 'equipment'
require 'intensify_database'

local mt = {}
local Intensify = {}
Intensify.__index = mt
setmetatable(Intensify, Intensify)

-- constants
-- 第一個元素是固定提升值，第二個是隨機提升值
local _REFINE_TABLE = {{1, 0}, {1, 0}, {1, 0}, {1, 1}, {1, 1}, {1, 1}, {2, 2}, {2, 2}, {2, 2}, {4, 5}}
local _INTENSIFY_SCALE = {[0] = 1, 2, 3, 4, 6, 8, 10, 14, 18, 22, 31}

-- variables
local _IsEquipmentInBag, _IsGoldEnough, _IsRefine, _GetGoldCost, _NotLimit

function Intensify.Init()
    local Game = require 'game'
    local Hero = require 'hero'

    -- Game:Event "單位-使用物品" (function(self, unit, item)
    --     Intensify(Hero(unit))
    -- end)
end

function Intensify:__call(hero)
    if _IsEquipmentInBag(hero.object) then
        local item = Equipment(cj.UnitItemInSlot(hero.object, 0))
        if _NotLimit(item) then
            local goldCost = _GetGoldCost(item)
            if _IsGoldEnough(item.ownPlayer, goldCost) then
                item.ownPlayer:add("黃金", -goldCost)
                if _IsRefine(item.intensifyLevel) then
                    item.intensifyFailTimes = 0 -- 重置失敗次數
                    item.intensifyLevel = item.intensifyLevel + 1
                    local fixedValue, randomMaxValue = _REFINE_TABLE[item.intensifyLevel][1], _REFINE_TABLE[item.intensifyLevel][2]
                    for i = 1, item.attributeCount do
                        if INTENSIFY_ATTRIBUTE[item.attribute[i][1]] then
                            item.attribute[i][2] = item.attribute[i][2] + fixedValue + MathLib.Random(0, randomMaxValue)
                        end
                    end
                    item:Update()
                    cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 裝備精鍊成功。")
                else
                    cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 裝備精鍊失敗。")
                    item.intensifyFailTimes = item.intensifyFailTimes + 1
                end
            else
                cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 你攜帶的金錢不足。")
            end
        else
            cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 裝備精鍊值已達上限。")
        end
    else
        cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 你第一格沒有裝備。")
    end
end

_IsEquipmentInBag = function(owner)
    return cj.GetItemLevel(cj.UnitItemInSlot(owner, 0)) == 5
end

_NotLimit = function(item)
    return item.intensifyLevel < 10
end

_GetGoldCost = function(item)
    local base = 50 * (2 + math.modf(item.level + item.intensifyLevel - 1) / 8)
    local punishProc = 1 + 0.2 * item.intensifyFailTimes
    return base * item:GetGearScore() * _INTENSIFY_SCALE[item.intensifyLevel] * punishProc
end

_IsGoldEnough = function(ownPlayer, goldCost)
    return ownPlayer:get "黃金" >= goldCost
end

_IsRefine = function(intensifyLevel)
    local p = (intensifyLevel < 4) and 100 - 16 * intensifyLevel or 100 / intensifyLevel
    return MathLib.Random(100) <= p
end

return Intensify