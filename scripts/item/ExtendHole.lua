local setmetatable = setmetatable

local mt = {}
local ExtendHole = {}
ExtendHole.__index = mt
setmetatable(ExtendHole, ExtendHole)

local IsEquipmentInBag, GetGoldCost, IsGoldEnough, IsSpaceHole = nil, nil, nil, nil

function ExtendHole:__call(item)
    if IsEquipmentInBag(item.owner) then
        local goldCost = GetGoldCost(item.stability + item.intensifyLevel)
        if IsGoldEnough(item.ownPlayer, goldCost) then
            if IsSpaceHole(item.holeCount) then
                cj.SetPlayerState(item.ownPlayer, "PLAYER_STATE_GOLD", cj.GetPlayerState(item.ownPlayer, "PLAYER_STATE_GOLD") - goldCost)
                item.holeCount += 1
                cj.DisplayTimedTextToPlayer(item.ownPlayer, 0., 0., 6., "|cff00ff00提示|r - 擴充成功。")
            else
                cj.DisplayTimedTextToPlayer(item.ownPlayer, 0., 0., 6., "|cff00ff00提示|r - 裝備插槽已達上限。")
            end
        else
            cj.DisplayTimedTextToPlayer(item.ownPlayer, 0., 0., 6., "|cff00ff00提示|r - 你攜帶的金錢不足。")
        end
    else
        cj.DisplayTimedTextToPlayer(item.ownPlayer, 0., 0., 6., "|cff00ff00提示|r - 你第一格沒有裝備。")
    end
end

local function IsEquipmentInBag(owner)
    return cj.UnitItemInSlot(owner,0) != nil
end

local function GetGoldCost(level, holeCount)
    return 100 * e^holeCount * level
end

local function IsGoldEnough(ownPlayer, goldcost)
    return ownPlayer.gold >= goldcost
end

local function IsSpaceHole(holeCount) 
    return holeCount < 5
end

return ExtendHole