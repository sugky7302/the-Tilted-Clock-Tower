-- 處理單位事件
-- 要注意某些事件參數可以傳instance，有些只能傳jass參數

-- package
local cj = require 'jass.common'
local js = require 'jass_tool'
local War3 = require 'api'
local Unit = require 'unit.core'
local Game = require 'game'
local Point = require 'point'
local Item = require 'item.core'
local Timer = require 'timer.core'
local Equipment = require 'item.equipment.core'
local Secrets = require 'item.secrets'

-- assert
local ipairs = ipairs

local unit_is_attacked = War3.CreateTrigger(function()
    local source, target = Unit(cj.GetEventDamageSource()), Unit(cj.GetTriggerUnit())

    -- 先將當前傷害值歸零，以免實際扣血 ~= 預計扣血
    local SetEventDamage = require 'jass.japi'.EXSetEventDamage
    SetEventDamage(0)

    -- 怕技能攻擊又會再次調用此觸發，形成死循環
    if source.is_spell_damaged_ == false then
        source:EventDispatch("單位-造成傷害", target)
        source:EventDispatch("單位-傷害完成", target)
    end

    return true
end)

Unit:Event "單位-造成傷害" (function(_, source, target)
    local Damage = require 'combat.damage'
    Damage{
        source_ = source,
        target_ = target,
        
        name_ = "普通攻擊",
        type_ = "物理",
        element_type_ = "無",
    }
end)

-- 註冊單位死亡要刷新的事件
local trg = War3.CreateTrigger(function()
    local target = Unit(cj.GetTriggerUnit())
    if target.type == "Unit" then
        target:EventDispatch("單位-掉落物品")
        target:EventDispatch("單位-刷新")
    elseif target.type == "Pet" then
        target:EventDispatch("寵物-清除")
    elseif target.type == "Hero" then
        target:EventDispatch("英雄-復活")
    end

    target:EventDispatch("任務-更新")

    return true
end)

Unit:Event "單位-掉落物品" (function(_, unit)
    local DROP_LIB = require 'drop_lib'
    if not DROP_LIB[unit.id_] then
        return false
    end

    local Rand = require 'math_lib'.Random
    local p = Point.GetUnitLoc(unit.object_)

    for i = 1, #DROP_LIB[unit.id_], 2 do
        if Rand(100) < DROP_LIB[unit.id_][i+1] then
            local item = Item.Create(DROP_LIB[unit_id_][i], p)

            -- 掉落裝備
            if Item.IsEquipment(item) then
                unit:DropEquipment(item)
            end

            -- 設定成秘物
            if Item.IsSecrets(item) then
                Secrets(item)
            end

            -- 非上面類別就設定成普通物品
            Item(item)
        end
    end

    p:Remove()
end)

Unit:Event "單位-刷新" (function(_, unit)
    -- 移除單位前先存單位id才不會讀不到
    local id = js.U2Id(unit.object_)
    Unit.RemoveUnit(unit.object_)
    
    Timer(unit:get "刷新時間", false, function()
        local new_unit = Unit.Create(cj.Player(cj.PLAYER_NEUTRAL_AGGRESSIVE), id, unit.revive_point_, cj.GetRandomReal(0, 180))
        
        -- 新單位註冊實例
        Unit(new_unit)

        Game:EventDispatch("單位-創建", new_unit)

        -- 移除舊實例
        unit:Remove()
    end)
end)

Unit:Event "英雄-復活" (function(_, self)
    for _, skill in ipairs(self.each_casting_) do
        skill:Break()
    end

    -- 解除js.RemoveUnit設置的水元素週期
    cj.UnitPauseTimedLife(self.object_, true)

    Timer(10 + 5 * self:get "等級", false, function()
        cj.ReviveHero(self.object_, self.revive_point_.x_, self.revive_point_.y_, true)

        -- 不然獲取到的生命值會跟死亡前的生命值相同，導致dealdamage會判定擊殺
        self:set("生命", self:get "生命上限")
    end)
end)

Unit:Event "寵物-清除" (function(_, self)
    -- 寵物的擁有者要清除寵物，不然有機會報錯
    self.owner_.pet_ = nil
    
    self:Remove()
end)

-- assert
local IsHero, LookupQuests

Unit:Event "任務-更新" (function(_, self)
    if IsHero(self.attacker_) then
        LookupQuests(self.attacker_.quests_, self.id_)
    end
end)

IsHero = function(unit)
    return not (not unit.quests_)
end

LookupQuests = function(quests, id)
    for _, quest in ipairs(quests) do 
        if quest.demands_[id] then
            quest:Update(id)
        end
    end
end

Game:Event "單位-創建" (function(_, target)
    cj.TriggerRegisterUnitEvent(trg, target, cj.EVENT_UNIT_DEATH)
    cj.TriggerRegisterUnitEvent(unit_is_attacked, target, cj.EVENT_UNIT_DAMAGED)
end)

local Hero = require 'unit.hero'

local order_trg = War3.CreateTrigger(function()
    Hero(cj.GetOrderedUnit()):EventDispatch("單位-發布命令", cj.GetIssuedOrderId(), cj.GetOrderTarget())
    return true
end)

-- Unit:Event "單位-發布命令" (function(_, hero, order, target)
--     if order == Base.String2OrderId('smart') then
--         StackItem(hero.object_, Item(target))
--     end
-- end)

-- 創建使用物品事件
local use_item_trg = War3.CreateTrigger(function()
    Hero(cj.GetTriggerUnit()):EventDispatch("單位-使用物品", Item(cj.GetManipulatedItem()))
    return true
end)

-- 創建獲得物品事件
local obtain_item_trg = War3.CreateTrigger(function()
    if cj.GetManipulatedItem() ~= nil then
        Hero(cj.GetTriggerUnit()):EventDispatch("單位-獲得物品", cj.GetManipulatedItem())
    end

    return true
end)

Unit:Event "單位-獲得物品" (function(trigger, hero, item)
    local string_sub = string.sub
    
    if Item.IsEquipment(item) then
        Equipment(item).owner_ = hero
        Equipment(item).own_player_ = hero.owner_
        hero:UpdateAttributes("增加", Equipment(item))
    elseif Item.IsSecrets(item) then
        Secrets(item).owner_ = hero
        Secrets(item).own_player_ = hero.owner_
    elseif hero:AcceptQuest(string_sub(cj.GetItemName(item), 10)) then
        return 
    else
        Item(item).owner_ = hero
        Item(item).own_player_ = hero.owner_
    end

    StackItem(hero.object_, Item(item))
end)
    
-- 創建丟棄物品事件
local drop_item_trg = War3.CreateTrigger(function()
    Hero(cj.GetTriggerUnit()):EventDispatch("單位-丟棄物品", cj.GetManipulatedItem())
    return true
end)

Unit:Event "單位-丟棄物品" (function(trigger, hero, item)
    if Item.IsEquipment(item) then
        hero:UpdateAttributes("減少", Equipment(item))
    end
end)
    
-- 創建出售物品事件
local sell_itemT_trg = War3.CreateTrigger(function()
    Hero(cj.GetTriggerUnit()):EventDispatch("單位-出售物品", cj.GetSoldItem())
    return true
end)

local spell_effect_trg = War3.CreateTrigger(function()
    Hero(cj.GetTriggerUnit()):EventDispatch("單位-發動技能效果", cj.GetSpellAbilityId(), Unit(cj.GetSpellTargetUnit()), cj.GetSpellTargetItem(), Point:GetLoc(cj.GetSpellTargetLoc()))
    return true
end)

Unit:Event "單位-發動技能效果" (function(_, target, id)
    target:LearnTalent(id)
end)

-- 添加事件
Game:Event "單位-創建" (function(_, target)
    if Unit.IsHero(target) then
        -- 發布命令
        cj.TriggerRegisterUnitEvent(order_trg, target, cj.EVENT_UNIT_ISSUED_TARGET_ORDER)
        cj.TriggerRegisterUnitEvent(order_trg, target, cj.EVENT_UNIT_ISSUED_POINT_ORDER)
        cj.TriggerRegisterUnitEvent(order_trg, target, cj.EVENT_UNIT_ISSUED_ORDER)

        cj.TriggerRegisterUnitEvent(use_item_trg, target, cj.EVENT_UNIT_USE_ITEM) -- 使用物品事件
        cj.TriggerRegisterUnitEvent(obtain_item_trg, target, cj.EVENT_UNIT_PICKUP_ITEM) -- 獲得物品事件
        cj.TriggerRegisterUnitEvent(drop_item_trg, target, cj.EVENT_UNIT_DROP_ITEM) -- 丟棄物品事件
        cj.TriggerRegisterUnitEvent(sell_item_trg, target, cj.EVENT_UNIT_SELL_ITEM) -- 出售物品事件
        cj.TriggerRegisterUnitEvent(spell_effect_trg, target, cj.EVENT_UNIT_SPELL_EFFECT)
    end
end)

StackItem = function(hero, item)
    if not(Item.IsSecrets(item.object_) or Item.IsMaterial(item.object_)) then
        return false
    end

    if item:get "數量" == 0 then
        return false
    end

    for i = 0, 5 do
        local bag_item = Item(cj.UnitItemInSlot(hero, i))
        if IsTypeSame(bag_item, item) then
            bag_item:add("數量", item:get "數量")
                
            item:Remove()
            return true
        end
    end
end

IsTypeSame = function(bag_item, target_item)
    return (bag_item.id_ == target_item.id_) and (bag_item.handle_ ~= target_item.handle_)
end
