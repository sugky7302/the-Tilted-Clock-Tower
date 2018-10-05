local cj = require 'jass.common'
local User = require 'User'
local War3 = require 'war3.api'
local setmetatable = setmetatable

local mt = {}
local Item = {}
Item.__index = mt
setmetatable(Item, Item)

-- 本地函式聲明
local DisplayedInfo, DialogDisplay = nil, nil

-- 建構函式
function Item:__call(item)
    local object = {}
    
    object.name = cj.GetItemName(item)
    object.owner = nil
    object.ownPlayer = cj.GetOwningPlayer(object.owner)
    object.prefix = nil 
    object.bigSecretOrderPrefix = nil
    object.smallSecretOrderPrefix = nil
    object.level = nil
    object.fixedAttributes = nil
    object.attribute = {additionalEffect = {}, inscription = {}} -- 為一table,每個元素包含index, value, states三個部分
    object.attributeCount = nil
    object.color = "|cffffffff"
    object.intensifyLevel = 0
    object.stability = nil
    object.intensify = nil
    object.fusion = nil
    object.uniqueness = nil
    
    setmetatable(object, self)
    object.__index = object
    return object
end

-- 移除函式
function mt:Remove()
    object = nil
end

-- 顯示數據
function mt:Display()
    DialogDisplay(self.ownPlayer, GetDisplayedInfo(self))
end

local function GetDisplayedInfo(self)
    -- 名稱
    local bigSecretOrderPrefix = self.bigSecretOrderPrefix and "|cff804000" .. self.bigSecretOrderPrefix .. "|r|n" or ""
    local smallSecretOrderPrefix = self.smallSecretOrderPrefix and "|cffff8d00" .. self.smallSecretOrderPrefix .. "|r|n" or ""
    local prefix = self.prefix and self.prefix or ""
    local name = bigSecretOrderPrefix .. smallSecretOrderPrefix .. self.color .. self.intensifyLevel .. " " .. prefix .. self.name .. "|n"
    
    -- 基本資料
    local basicInfo = "|cffffffff物品等級：|r" .. (self.level + self.intensifyLevel) .. "[S" .. string.format("%0.2f",self.stability) .. "I" .. string.format("%0.2f",self.intensify) .. "F" .. string.format("%0.2f",self.fusion) .. "U" .. string.format("%0.2f",self.uniqueness) .. "]|n"

    -- 屬性
    local attributes = ""
    for i = 1, self.attributeCount do
        attributes = attributes .. (self.attribute[i] and "|cff3366ff◆|r" .. self.attribute[i].state or "|cff3366ff◇|r") .. "|n"
    end
    for i = 1, #self.attribute.additionalEffect do
        attributes = attributes .. "|cff3366ff◆|r" .. self.attribute.additionalEffect[i].state .. "|n"
    end
    attributes = attributes .. (self.attribute.inscription.state and "|cff3366ff◆|r" .. self.attribute.inscription.state .. "|n" or "")

    -- 秘物序列
    local smallSecretOrderState = self.smallSecretOrderPrefix and "|cffff8d00" .. self.smallSecretOrder.state .. "|r|n" or ""
    local bigSecretOrderState = self.bigSecretOrderPrefix and "|cff804000" .. self.bigSecretOrder.state .. "|r|n" or ""
    local secretOrderState = smallSecretOrderState .. bigSecretOrderState

    local returnString = name .. basicInfo .. attributes .. secretOrderState

    return returnString
end

local function DialogDisplay(player, displayedInfo)
    local dialog = User[cj.GetPlayerId(player)].dialog
    local button = cj.DialogAddButton(dialog, "關閉", 0)
    local trigger = War3.CreateTrigger(function()
        -- 關閉對話框
        cj.DialogDisplay(player, dialog, false)
        cj.DialogClear(dialog)
        -- 刪除觸發
        war3.DestroyTrigger(trigger)
        return true
    end)

    cj.DialogSetMessage(dialog, displayedInfo)
    cj.DialogDisplay(player, dialog, true)
    cj.TriggerRegisterDialogButtonEvent(tr,button)
end

return Item
