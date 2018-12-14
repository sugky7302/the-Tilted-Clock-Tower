-- 此module提供測試工具

local setmetatable = setmetatable

local Test = {}
setmetatable(Test, Test)

function Test:__call(file_name)
    local format = string.format
    local require = require
    
    local start_time = os.clock()
        
    require("test." .. file_name)(self)
    
    local end_time = os.clock()
    print("--------")
    print(format("start time : %.4f", start_time))
    print(format("end time   : %.4f", end_time))
    print(format("cost time  : %.4f s", end_time - start_time))
    print("--------")   
end

-- 為了在測試時能夠直接獲取測試英雄，使測試簡化
function Test.EnumUnit()
    -- 選取英雄
    local Group = require 'group.core'
    local group = Group()
    group:EnumUnitsInRange(15009, 9869, 1000, "IsHero")

    -- 暫存
    local enum_unit = group.units_[1]

    group:Remove()

    return enum_unit
end

-- 為了在測試時能夠直接獲取測試單位，使測試簡化
function Test.EnumTestUnit()
    -- 選取英雄
    local Group = require 'group.core'
    local group = Group()
    group:EnumUnitsInRange(15009, 9869, 1000, "IsNonHero")

    -- 暫存
    local enum_unit = group.units_[1]

    group:Remove()

    return enum_unit
end

-- 某些測試需要觸發獲取物品事件
function Test.PickItemEvent(test_unit, test_fn)
    local Api = require 'api'
    local cj = require 'jass.common'

    local trg = Api.CreateTrigger(function()
        test_fn(test_unit)
        return true
    end)

    cj.TriggerRegisterUnitEvent(trg, test_unit, cj.EVENT_UNIT_PICKUP_ITEM)
end

function Test.PrintAttribute(equip)
    local table_concat = table.concat 

    print(table_concat({"+", equip.intensify_level_, " ", equip.prefix_, equip.name_}))
    for _, tb in ipairs(equip.attribute_) do
        print(tb[3])
    end
    print(" ")
end

function Test.Player()
    -- 設定玩家
    local cj = require 'jass.common'
    local Player = require 'player'
    
    return Player(cj.Player(0))
end

function Test.CreateItem(test_id)
    -- 創建物品
    local Item = require 'item.core'
    local Point = require 'point'

    return Item.Create(test_id, Point(15009, 9869))
end

function Test.AddRecipe(recipe)
    -- 設定配方
    require 'item.add_recipe'(test_recipe)
end

-- 啟動中心計時器
function Test.InitTimer()
    require 'timer.init'.Init()
end

function Test.InitAttribute()
    require 'unit.attribute.init'
end

return Test