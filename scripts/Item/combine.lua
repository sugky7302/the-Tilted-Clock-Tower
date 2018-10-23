local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local Item = require 'item'
local Point = require 'point'
require 'combine_database'

local Combine= {}
setmetatable(Combine, Combine)

-- Variables
local _Combine, _GetGoldCost, _IsAmountsEnough, _IsGoldEnough, _IsItemCanCombine, _GetCombineCost, _AddItem

function Combine.Init()
    local slk = require 'jass.slk'

    -- 解析資料庫
    for _, tb in ipairs(COMBINATIONS) do 
        for i = 1, #tb - 1 do 
            COMBINATIONS[tb[i]] = tb[i+1]
            COMBINATIONS[tb[i] .. "_cost"] = _GetCombineCost(slk.item[tb[i]].HP)
        end
    end

    local Game = require 'game'
    local Hero = require 'hero'
    Game:Event "單位-發動技能效果" (function(self, source, id)
        if id == Base.String2Id('') then
            Combine(Hero(source))
        end
    end)
end

-- TODO: 合成物品的生命值為材料等級
_GetCombineCost = function(lv)
    local math = math

    return 50 * math.exp(lv - 1)
end

function Combine:__call(hero)
    local item = cj.UnitItemInSlot(hero.object, 0)
    if _IsItemCanCombine(item) then
        if _IsAmountsEnough(item) then
            local goldCost = _GetGoldCost(item)
            if _IsGoldEnough(hero.owner, goldCost) then
                hero.owner:add("黃金", -goldCost)
                _Combine(hero.object, item)
                cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 合成成功。")
            else
                cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 你攜帶的金錢不足。")
            end
        else
            cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 你攜帶的材料不足。")
        end
    else
        cj.DisplayTimedTextToPlayer(hero.owner.object, 0., 0., 6., "|cff00ff00提示|r - 你第一格沒有可合成的物品。")
    end
end

_IsItemCanCombine = function(item)
    return COMBINATIONS[js.Item2Str(item)]
end

_IsAmountsEnough = function(item)
    return cj.GetItemCharges(item) > 2
end

_GetGoldCost = function(item)
    return COMBINATIONS[js.Item2Str(item) .. "_cost"]
end

_IsGoldEnough = function(player, goldCost)
    return player:get "黃金" >= goldCost
end

_Combine = function(hero, item)
    local newItem = COMBINATIONS[js.Item2Str(item)]
    if Item(item):get '數量' > 3 then
        Item(item):add("數量", -3)
    else
        Item(item):Remove()
    end
    _AddItem(hero, newItem)
end

_AddItem = function(hero, id)
    local p = Point:GetUnitLoc(hero)
    local newItem = Item.Create(id, p)
    cj.UnitAddItem(hero, newItem)
    p:Remove()
end

return Combine