-- 此module獨立裝備功能

local setmetatable = setmetatable
local Player = require 'player'

local Equipment, Item = {}, require 'item.core'
Equipment.__index = Item
setmetatable(Equipment, Equipment)

-- constants
local _DROP_CHANCE = {{55, 40, 4, 1}, {35, 50, 12, 3}, {12, 35, 41, 12}, {0, 20, 55, 25}}

-- varaibles
local _CompareFn, _RandRingCount, _SetAttributeState, _GetDisplayedInfo, _DialogDisplay, _GetAttribute, _GetLevel

function Equipment.Init()
    local Unit = require 'unit'

    Unit:Event "單位-使用物品" (function(_, unit, equipment)
        if equipment:IsEquipment() then
            equipment:Update()
            equipment:Display()
        end
    end)

    -- 裝備顯示框被點擊事件
    Player:Event "玩家-對話框被點擊" (function(_, player, button)
        -- 關閉對話框
        if player.dialog_:Find("關閉") == button then
            player.dialog_:Show(false)
            player.dialog_:Clear()
        end
    end)
end

-- 顯示數據
function Equipment:Display()
    local info = GetDisplayedInfo(self)
    DialogDisplay(self.own_player_, info)
end

GetDisplayedInfo = function(self)
    local display_strings = {}

    -- 大型秘物序列詞綴
    if self.big_secret_order_prefix_ then
        display_strings[#display_strings + 1] = "|cff804000"
        display_strings[#display_strings + 1] = self.big_secret_order_prefix_
        display_strings[#display_strings + 1] = "|r|n"
    end

    -- 小型秘物序列詞綴
    if self.small_secret_order_prefix_ then
        display_strings[#display_strings + 1] = "|cffff8d00"
        display_strings[#display_strings + 1] = self.small_secret_order_prefix_
        display_strings[#display_strings + 1] = "|r|n"
    end
    
    -- 秘物詞綴
    if self.prefix_ then
        display_strings[#display_strings + 1] = self.prefix_
    end

    -- 精鍊等級
    if self.intensify_level_ > 0 then
        display_strings[#display_strings + 1] = "|cff00ff00+"
        display_strings[#display_strings + 1] = self.intensify_level_
        display_strings[#display_strings + 1] = " "
    end
    
    -- 名字
    display_strings[#display_strings + 1] = self.color_
    display_strings[#display_strings + 1] = self.name_
    display_strings[#display_strings + 1] = "|n"
    
    -- 基本資料
    display_strings[#display_strings + 1] = "|cff808080Lv "
    display_strings[#display_strings + 1] = self.level_ + self.intensify_level_
    display_strings[#display_strings + 1] = " / Gs "
    display_strings[#display_strings + 1] = self:GetGearScore()
    display_strings[#display_strings + 1] = "|r|n"
    
    -- 屬性
    local attributes = ""
    for i = 1, self.attribute_count_limit_ do
        -- 因為屬性最大數量是給定的，所以有可能會沒屬性
        if self.attribute_[i] then
            display_strings[#display_strings + 1] = "|cff3366ff◆|r|cff99ccff"
            display_strings[#display_strings + 1] = self.attribute_[i][3]
        else
            display_strings[#display_strings + 1] = "|cff3366ff◇"
        end

        display_strings[#display_strings + 1] = "|r|n"
    end

    -- 額外效果
    for i = 1, #self.additional_effect_ do
        display_strings[#display_strings + 1] = "|cff3366ff◆|r"
        display_strings[#display_strings + 1] = self.additional_effect_[i].state_
        display_strings[#display_strings + 1] = "|n"
    end

    -- 銘文
    if self.inscriptions_.state_ then
        display_strings[#display_strings + 1] = "|cff3366ff◆|r"
        display_strings[#display_strings + 1] = self.inscriptions_.state_
        display_strings[#display_strings + 1] = "|n"
    end

    -- 小型秘物序列敘述
    if self.small_secret_order_.prefix_ then
        display_strings[#display_strings + 1] = "|cffff8d00"
        display_strings[#display_strings + 1] = self.small_secret_order_.state_
        display_strings[#display_strings + 1] = "|r|n"
    end

    -- 大型秘物序列敘述
    if self.small_big_order_.prefix_ then
        display_strings[#display_strings + 1] = "|cff804000"
        display_strings[#display_strings + 1] = self.small_big_order_.state_
        display_strings[#display_strings + 1] = "|r|n"
    end

    local table_concat = table.concat
    return table_concat(display_strings)
end

-- assert
local _, _, _, ATTRIBUTE_WEIGHT = require 'attributes'

function Equipment:GetGearScore()
    local sum = 0
    for i = 1, self.attribute_count_ do
        sum = sum + self.attribute_[i][2] * ATTRIBUTE_WEIGHT[self.attribute_[i][1]]
    end

    return sum
end

DialogDisplay = function(player, displayed_info)
    local dialog = Player(player).dialog_
    dialog:AddButton("關閉")
    dialog:SetTitle(displayed_info)
    dialog:Show(true)
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

function Unit.__index:DropEquipment(equipment)
    local item = Equipment(equipment)
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
