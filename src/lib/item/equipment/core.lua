-- 此module獨立裝備功能

local setmetatable = setmetatable

local Equipment, Item = {}, require 'item.core'
Equipment.__index = Item
setmetatable(Equipment, Equipment)

-- assert
local GetAttribute, GetLevel
local RandRingCount
local SetAttributeState

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

-- assert
local _, ATTRIBUTE_INDEX, ATTRIBUTE_STATE, _ = require 'attributes'() -- 這樣才能多個返回值

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

local MathLib = require 'math_lib'

function Equipment:Rand(lv, class)
    local modf = math.modf
    self.level_ = MathLib.Random(modf(lv + class / 2), lv + class)

    self.class_ = class -- 掉落的強度[1, 4]
    
    RandRingCount(self)
end

RandRingCount = function(self)
    local rand, r = MathLib.Random(100), 0
    local DROP_CHANCE = {55, 40,  4,  1, -- 普通怪物掉落2~5環物品的機率
                         35, 50, 12,  3, -- 菁英怪物掉落2~5環物品的機率
                         12, 35, 41, 12, -- 稀有菁英掉落2~5環物品的機率
                          0, 20, 55, 25} -- 頭目掉落2~5環物品的機率

    for i = (self.class_ - 1) * 4 + 1, self.class_ * 4 do 
        r = r + DROP_CHANCE[i]

        if r >= rand then
            -- 階級為1~4，環數為2~5
            self.attribute_count_limit_ = self.class_ + 1

            return true
        end
    end
end

local Printer = require 'item.equipment.printer'
-- 顯示數據
function Equipment:Display()
    Printer.Display(self)
end

function Equipment:name(is_replace)
    return Printer.name(self, is_replace)
end

function Equipment:GetGearScore()
    return Printer.GetGearScore(self)
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
