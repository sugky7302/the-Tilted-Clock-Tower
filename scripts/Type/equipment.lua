local setmetatable = setmetatable
local math = math
local table_sort = table.sort
local cj = require 'jass.common'
local js = require 'jass_tool'
local japi = require 'jass.japi'
local Unit = require 'unit'
local MathLib = require 'math_lib'
local Item = require 'item'
local Player = require 'player'
local Prefix = require 'prefix'
require 'attribute_database'
require 'equipment_database'

local Equipment = {}
Equipment.__index = Item
setmetatable(Equipment, Equipment)

-- constants
local _DROP_CHANCE = {{55, 40, 4, 1}, {35, 50, 12, 3}, {12, 35, 41, 12}, {0, 20, 55, 25}}

-- varaibles
local _CompareFn, _RandRingCount, _SetAttributeState, _GetDisplayedInfo, _DialogDisplay, _GetAttribute, _GetLevel

function Equipment.Init()
    local Game = require 'game'
    local Equipment = require 'equipment'
    
    Game:Event "單位-使用物品" (function(self, unit, item)
        if Item.IsEquipment(item) then
            Equipment(item):Update()
            Equipment(item):Display()
        end
    end)
    -- 裝備顯示框被點擊事件
    Game:Event "玩家-對話框被點擊" (function(self, player, button)
        -- 關閉對話框
        if player.dialog:Find("關閉") == button then
            player.dialog:Show(false)
            player.dialog:Clear()
        end
    end)
end

-- 顯示數據
function Equipment:Display()
    _DialogDisplay(self.ownPlayer, _GetDisplayedInfo(self))
end
_DialogDisplay = function(player, displayedInfo)
    local dialog = Player(player).dialog
    dialog:Insert("關閉")
    dialog:SetTitle(displayedInfo)
    dialog:Show(true)
end

_GetDisplayedInfo = function(self)
    -- 名稱
    local bigSecretOrderPrefix = self.bigSecretOrderPrefix and "|cff804000" .. self.bigSecretOrderPrefix .. "|r|n" or ""
    local smallSecretOrderPrefix = self.smallSecretOrderPrefix and "|cffff8d00" .. self.smallSecretOrderPrefix .. "|r|n" or ""
    local prefix = self.prefix and self.prefix or ""
    local intensifyLevel = (self.intensifyLevel > 0) and "|cff00ff00+" .. self.intensifyLevel .. " " or ""
    local name = bigSecretOrderPrefix .. smallSecretOrderPrefix .. intensifyLevel .. self.color .. prefix .. self.name .. "|n"
    -- 基本資料
    local basicInfo = "|cff808080Lv " .. (self.level + self.intensifyLevel) .. " / Gs " .. self:GetGearScore() .. "|r|n"
    -- 屬性
    local attributes = ""
    for i = 1, self.attributeCountLimit do
        local str = (self.attribute[i] and "|cff3366ff◆|r|cff99ccff" .. self.attribute[i][3] or "|cff3366ff◇") .. "|r|n"
        attributes = attributes .. str
    end
    for i = 1, #self.additionalEffect do
        local additionalEffect = "|cff3366ff◆|r" .. self.additionalEffect[i].state .. "|n"
        attributes = attributes .. additionalEffect
    end
    local inscriptions = (self.inscriptions.state and "|cff3366ff◆|r" .. self.inscriptions.state .. "|n" or "")
    attributes = attributes .. inscriptions
    -- 秘物序列
    local smallSecretOrderState = self.smallSecretOrder.prefix and "|cffff8d00" .. self.smallSecretOrder.state .. "|r|n" or ""
    local bigSecretOrderState = self.bigSecretOrder.prefix and "|cff804000" .. self.bigSecretOrder.state .. "|r|n" or ""
    local secretOrderState = smallSecretOrderState .. bigSecretOrderState

    local returnString = name .. basicInfo .. attributes .. secretOrderState

    return returnString
end

function Equipment:GetGearScore()
    local sum = 0
    for i = 1, self.attributeCount do
        sum = sum + self.attribute[i][2] * ATTRIBUTE_SCORE[self.attribute[i][1]]
    end
    return sum
end

-- 建構函式
function Equipment:__call(item)
    local obj = self[js.H2I(item) .. ""]
    if not obj then
        obj = Item(item)
        obj.prefix = nil 
        obj.bigSecretOrder= {}
        obj.smallSecretOrder = {}
        obj.attribute = _GetAttribute(obj.id) -- 每個元素包含index, value, states, fixed
        obj.level = _GetLevel(obj.id)
        obj.additionalEffect = {} -- 額外效果
        obj.inscriptions = {} -- 銘文
        obj.color = "|cffffffff"
        obj.attributeCount = #obj.attribute
        obj.attributeCountLimit = #obj.attribute + (EQUIPMENT_TEMPLATE[obj.id].ringCount or 0)
        obj.intensifyLevel = 0
        obj.intensifyFailTimes = 0
        obj.stability = 0
        obj.intensify = 0
        obj.fusion = 0
        obj.uniqueness = 0
        cj.SetItemInvulnerable(item, true)
        self[js.H2I(item) .. ""] = obj
        setmetatable(obj, obj)
        obj.__index = self
    end
    return obj
end

_GetAttribute = function(id)
    local obj = {}
    if EQUIPMENT_TEMPLATE[id] and EQUIPMENT_TEMPLATE[id].attribute then
        for i, v in pairs(EQUIPMENT_TEMPLATE[id].attribute) do
            table.insert(obj, {i, v, "", true})
        end
    end
    return obj
end

_GetLevel = function(id)
    if EQUIPMENT_TEMPLATE[id] then
        return EQUIPMENT_TEMPLATE[id].level
    end 
    return 1
end

function Equipment:Update()
    self:Sort()
    _SetAttributeState(self)
    Prefix(self)
end

_SetAttributeState = function(self)
    local string_gsub = string.gsub
    for i, tb in pairs(self.attribute) do
        local str = ATTRIBUTE_STATE[tb[1]]
        self.attribute[i][3] = string_gsub(str, "N", tb[2] .. "")
    end
end

-- 移除函式
function Equipment:Remove()
    self = nil
end

function Equipment:Sort()
    table_sort(self.attribute, _CompareFn)
end

_CompareFn = function(a, b)
    return ATTRIBUTE_INDEX[a[1]] < ATTRIBUTE_INDEX[b[1]]
end

function Unit.__index:DropItem()
    local item = Equipment()
    item:Rand(self.object:get "等級", self.object:get "階級")
end

function Equipment:Rand(lv, layer)
    self.level = MathLib.Random(math.modf(lv + layer / 2), lv + layer)
    self.layer = layer -- 掉落的強度
    _RandRingCount(self)
end

_RandRingCount = function(self)
    local rand, r = MathLib.Random(100), 0
    for c, p in ipairs(_DROP_CHANCE[self.layer]) do
        r = r + p
        if rand <= r then
            self.attributeCountLimit = c + 1
            break
        end
    end
end

function Equipment:IsFull()
    return not(self.attributeCount < self.attributeCountLimit)
end

function Equipment:IsLimit()
    return self.attributeCountLimit < 5
end

return Equipment
