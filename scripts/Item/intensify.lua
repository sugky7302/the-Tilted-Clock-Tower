local cj = require 'jass.common'
local setmetatable = setmetatable
local math = math
math.randomseed(tostring(os.time()):reverse():sub(1, 6))

local mt = {}
local Intensify = {}
Intensify.__index = mt
setmetatable(Intensify, Intensify)

local refinedTable = {
    {["fixedValue"] = 1, ["randomMaxValue"] = 0},
    {["fixedValue"] = 1, ["randomMaxValue"] = 0},
    {["fixedValue"] = 1, ["randomMaxValue"] = 0},
    {["fixedValue"] = 1, ["randomMaxValue"] = 1},
    {["fixedValue"] = 1, ["randomMaxValue"] = 1},
    {["fixedValue"] = 1, ["randomMaxValue"] = 1},
    {["fixedValue"] = 2, ["randomMaxValue"] = 2},
    {["fixedValue"] = 2, ["randomMaxValue"] = 2},
    {["fixedValue"] = 2, ["randomMaxValue"] = 2},
    {["fixedValue"] = 4, ["randomMaxValue"] = 5},
}

local _IsEquipmentInBag, _IsGoldEnough, _IsRefine, _GetGoldCost

function Intensify.__call(item)
    if _IsEquipmentInBag(item.owner) then
        local goldCost = _GetGoldCost(item.stability + item.intensifyLevel, #item.holes)
        
        if _IsGoldEnough(item.ownPlayer, goldCost) then
            cj.SetPlayerState(item.ownPlayer, "PLAYER_STATE_GOLD", cj.GetPlayerState(item.ownPlayer, "PLAYER_STATE_GOLD") - goldCost)
            
            if _IsRefine(item.intensifyLevel) then
                item.intensifyLevel += 1

                local fixedValue, randomMaxValue = refinedTable[item.intensifyLevel]["fixedValue"], refinedTable[item.intensifyLevel]["randomMaxValue"]
                for i = 1, #item.holes do
                    item.holes[i].value += (fixedValue + math.random(0, randomMaxValue))
                end

                cj.DisplayTimedTextToPlayer(item.ownPlayer, 0., 0., 6., "|cff00ff00提示|r - 裝備附魔成功。")
            else
                cj.DisplayTimedTextToPlayer(item.ownPlayer, 0., 0., 6., "|cff00ff00提示|r - 裝備附魔失敗。")
            end
        else
            cj.DisplayTimedTextToPlayer(item.ownPlayer, 0., 0., 6., "|cff00ff00提示|r - 你攜帶的金錢不足。")
        end
    else
        cj.DisplayTimedTextToPlayer(item.ownPlayer, 0., 0., 6., "|cff00ff00提示|r - 你第一格沒有裝備。")
    end
end

local function _IsEquipmentInBag(owner)
    return cj.UnitItemInSlot(owner,0) != nil
end

local function _GetGoldCost(level, usedHoleCount)
    return (80 * level^2 * usedHoleCount + 100 * (level + 2)) * 1.25^level
end

local function _IsGoldEnough(ownPlayer, goldcost)
    return ownPlayer.gold >= goldcost
end

local function _IsRefine(intensifyLevel)
    local p = (intensifyLevel <= 3) and 100 - 16 * intensifyLevel or 100 / intensifyLevel
    return math.random() <= p / 100
end

return Intensify