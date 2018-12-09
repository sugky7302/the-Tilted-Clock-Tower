-- 此module獨立裝備功能

local setmetatable = setmetatable

-- local Unit = require 'unit'
local Player = require 'player'

local Equipment, Item = {}, require 'item.core'
Equipment.__index = Item
setmetatable(Equipment, Equipment)

-- assert
local GetAttribute, GetLevel
local RandRingCount
local SetAttributeState
local DialogDisplay, GetDisplayedInfo

function Equipment.Init()
    -- Unit:Event "單位-使用物品" (function(_, unit, equipment)
    --     if equipment:IsEquipment() then
    --         equipment:Update()
    --         equipment:Display()
    --     end
    -- end)

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
    local display_strings = {self:name(true)}
    
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
    if self.big_secret_order_.prefix_ then
        display_strings[#display_strings + 1] = "|cff804000"
        display_strings[#display_strings + 1] = self.big_secret_order_.state_
        display_strings[#display_strings + 1] = "|r|n"
    end

    local table_concat = table.concat
    return table_concat(display_strings)
end

-- 獲取完整的物品名字，可選擇要不要加換行符
function Equipment:name(is_replace)
    local display_strings = {}

    -- 大型秘物序列詞綴
    if self.big_secret_order_prefix_ then
        display_strings[#display_strings + 1] = "|cff804000"
        display_strings[#display_strings + 1] = self.big_secret_order_prefix_
        display_strings[#display_strings + 1] = is_replace and "|r|n" or "|r"
    end

    -- 小型秘物序列詞綴
    if self.small_secret_order_prefix_ then
        display_strings[#display_strings + 1] = "|cffff8d00"
        display_strings[#display_strings + 1] = self.small_secret_order_prefix_
        display_strings[#display_strings + 1] = is_replace and "|r|n" or "|r"
    end

    -- 精鍊等級
    if self.intensify_level_ > 0 then
        display_strings[#display_strings + 1] = "|cff00ff00+"
        display_strings[#display_strings + 1] = self.intensify_level_
        display_strings[#display_strings + 1] = "|r "
    end

    -- 顏色
    display_strings[#display_strings + 1] = self.color_

    -- 秘物詞綴
    if self.prefix_ then
        display_strings[#display_strings + 1] = self.prefix_
    end
    
    -- 名字
    display_strings[#display_strings + 1] = self.name_
    display_strings[#display_strings + 1] = is_replace and "|r|n" or "|r"

    local table_concat = table.concat
    return table_concat(display_strings)
end

-- assert
local _, ATTRIBUTE_INDEX, ATTRIBUTE_STATE, ATTRIBUTE_WEIGHT = require 'attributes'() -- 這樣才能多個返回值

function Equipment:GetGearScore()
    local sum = 0
    for i = 1, self.attribute_count_ do
        sum = sum + self.attribute_[i][2] * ATTRIBUTE_WEIGHT[ATTRIBUTE_INDEX[self.attribute_[i][1]]]
    end

    return sum
end

DialogDisplay = function(player, displayed_info)
    local dialog = Player(player).dialog_
    dialog:AddButton("關閉")
    dialog:SetTitle(displayed_info)
    dialog:Show(true)
end

-- assert
local EQUIPMENT_TEMPLATE = require 'equipment_template'

-- 建構函式
function Equipment:__call(item)
    local H2I = require 'jass_tool'.H2I

    local instance = Item[H2I(item) .. ""]
    if not instance then
        instance = Item(item)
    
        -- 前綴
        instance.prefix_             = nil 
        instance.big_secret_order_   = nil
        instance.small_secret_order_ = nil

        -- 每個元素包含index, value, states, fixed
        instance.attribute_             = GetAttribute(instance.id_)

        local attribute_size = #instance.attribute_
        instance.attribute_count_       = attribute_size
        instance.attribute_count_limit_ = attribute_size + (EQUIPMENT_TEMPLATE[instance.id_].ring_count or 0)

        instance.level_ = GetLevel(instance.id_)

        -- 額外效果
        instance.additional_effect_ = {} 

        -- 銘文
        instance.inscriptions_ = {} 

        instance.color_ = "|cffffffff"
        
        -- 精鍊
        instance.intensify_level_      = 0
        instance.intensify_fail_times_ = 0

        -- 鍊金術四項指標
        instance.stability_  = 0 -- 決定物品等級
        instance.intensify_  = 0 -- 決定精鍊上限與安定值
        instance.fusion_     = 0 -- 決定秘物屬性的增幅比例
        instance.uniqueness_ = 0 -- 決定附加效果的數量
        
        -- 讓物品不可破壞
        local cj_SetItemInvulnerable = require 'jass.common'.SetItemInvulnerable
        cj_SetItemInvulnerable(item, true)

        setmetatable(instance, instance)
        instance.__index = self
    end

    -- 更新屬性
    instance:Update()
    
    return instance
end

GetAttribute = function(id)
    local attribute = {}

    -- 根據短路的效果做二次存在判斷
    local pairs = pairs
    if EQUIPMENT_TEMPLATE[id] and EQUIPMENT_TEMPLATE[id].attribute then
        for i, v in pairs(EQUIPMENT_TEMPLATE[id].attribute) do
            attribute[#attribute + 1] = {i, v, "", true}
        end
    end

    return attribute
end

GetLevel = function(id)
    -- 設定好的是商店物品
    if EQUIPMENT_TEMPLATE[id] then
        return EQUIPMENT_TEMPLATE[id].level
    end 

    return 1
end

function Equipment:Update()
    self:Sort()
    SetAttributeState(self)

    local Prefix = require 'item.prefix'
    Prefix(self)
end

function Equipment:Sort()
    local table_sort = table.sort
    table_sort(self.attribute_, function(a, b)
        return ATTRIBUTE_INDEX[a[1]] < ATTRIBUTE_INDEX[b[1]]
    end)
end

SetAttributeState = function(self)
    local string_gsub, pairs = string.gsub, pairs

    -- 把屬性敘述的參數 N 替換成實際數字
    for i, tb in pairs(self.attribute_) do
        local str = ATTRIBUTE_STATE[ATTRIBUTE_INDEX[tb[1]]]
        self.attribute_[i][3] = string_gsub(str, "N", tb[2] .. "")
    end
end

local Unit = require 'unit.core'
function Unit.__index:DropEquipment(item)
    local equipment = Equipment(item)
    equipment:Rand(self.object_:get "等級", self.object_:get "階級")
end

local MathLib = require 'math_lib'

function Equipment:Rand(lv, layer)
    local modf = math.modf
    self.level_ = MathLib.Random(modf(lv + layer / 2), lv + layer)

    self.layer_ = layer -- 掉落的強度[1, 4]
    
    RandRingCount(self)
end

RandRingCount = function(self)
    local rand, r = MathLib.Random(100), 0
    local DROP_CHANCE = {55, 40,  4,  1, -- 普通怪物掉落2~5環物品的機率
                         35, 50, 12,  3, -- 菁英怪物掉落2~5環物品的機率
                         12, 35, 41, 12, -- 稀有菁英掉落2~5環物品的機率
                          0, 20, 55, 25} -- 頭目掉落2~5環物品的機率

    for i = (self.layer_ - 1) * 4 + 1, self.layer_ * 4 do 
        r = r + DROP_CHANCE[i]

        if r >= rand then
            -- 階級為1~4，環數為2~5
            self.attribute_count_limit_ = self.layer_ + 1

            return true
        end
    end
end

-- 檢測還能不能附魔
function Equipment:IsAttributeFull()
    return self.attribute_count_ >= self.attribute_count_limit_
end

-- 檢測還能不能強化
function Equipment:IsRingFull()
    return self.attribute_count_limit_ >= 5
end

return Equipment
