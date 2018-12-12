-- 處理單位事件
-- 要注意某些事件參數可以傳instance，有些只能傳jass參數

local cj = require 'jass.common'
local js = require 'jass_tool'
local War3 = require 'api'
local Unit = require 'unit.core'
local Game = require 'game'
local Point = require 'point'
local Item = require 'item.core'
local Timer = require 'timer.core'
local Equipment = require 'item.equipment'
local Secrets = require 'item.secrets'

-- assert
local ipairs = ipairs

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
    local p = Point:GetUnitLoc(unit.object_)

    for i = 1, #DROP_LIB[unit.id_], 2 do 
        if Random(100) < DROP_LIB[i+1] then
            local item = Item.Create(DROP_LIB[i], p)

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
    if IsHero(self.killer_) then
        LookupQuests(self.killer_.quests_, self.id_)
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
end)

Unit:Event "單位-發布命令" (function(_, unit, order, target)
    -- 中斷施法
    if (order == Base.String2OrderId('smart')) or
       (order == Base.String2OrderId('stop')) or
       (order == Base.String2OrderId('attack')) then
        for _, skill in ipairs(unit.each_casting_) do
            skill:Break()
        end
    end
end)

local Hero = require 'unit.hero'

local order_trg = War3.CreateTrigger(function()
    Hero(cj.GetOrderedUnit()):EventDispatch("單位-發布命令", cj.GetIssuedOrderId(), Unit(cj.GetOrderTarget()))
    return true
end)

Unit:Event "單位-發布命令" (function(_, hero, order, target)
    if order == Base.String2OrderId('smart') then
        StackItem(hero.object_, target)
    end
end)

local unit_is_casted = War3.CreateTrigger(function()
    Hero(cj.GetTriggerUnit()):EventDispatch("單位-準備施放技能", cj.GetSpellAbilityId(), Unit(cj.GetSpellTargetUnit()), Point:GetLoc(cj.GetSpellTargetLoc()))
    return true
end)

-- assert
local GenerateSkillObject, ChekMultiCast

Unit:Event '單位-準備施放技能' (function(_, hero, id, target_unit, target_loc)
    -- 打斷正在施法的技能
    for _, skill in ipairs(hero.each_casting_) do
        if skill.order_id_ ~= Base.Id2String(id) then
            skill:Break()
        end
    end

    -- 獲取技能
    for _, skill in ipairs(hero.hero_datas[hero.name_].skill_datas) do
        if skill.order_id_ == Base.Id2String(id) then
            if skill.can_use_ then
                ChekMultiCast(skill, hero)
                GenerateSkillObject(skill, hero, target_unit, target_loc)
            else 
                hero:ResetAbility(skill.order_id_)
            end

            return true
        end
    end
end)

ChekMultiCast = function(skill, hero)
    if skill.is_multi_cast_ then
        skill.multi_cast_count_ = skill.multi_cast_count_ + 1

        local Texttag = require 'texttag.core'
        if IsShowMultiCast(skill) then
            skill.multi_cast_text_ = Texttag{
                msg_ = "|cffff0000" .. skill.multi_cast_count_ .. "重施法|r",
                loc_ = Point:GetUnitLoc(hero.object_),
                timeout_ = 2,
                skill_ = skill,
                multi_cast_count_ = skill.multi_cast_count_,
                is_permanant_ = false,

                Initialize = function(obj)
                    cj.SetTextTagText(obj.texttag_, obj.msg_, 0.04)
                    cj.SetTextTagPos(obj.texttag_, obj.loc_.x_, obj.loc_.y_, 10)
                    cj.SetTextTagPermanent(obj.texttag_, obj.is_permanant_)
                    cj.SetTextTagLifespan(obj.texttag_, obj.timeout_)
                    cj.SetTextTagFadepoint(obj.texttag_, 0.3)
                end,

                Update = function(obj)
                    if obj.multi_cast_count_ < obj.skill.multi_cast_count_ then
                        -- 更新文字
                        obj.msg_ = "|cffff0000" .. obj.skill.multi_cast_count_ .. "重施法|r"

                        -- 重新調整漂浮文字的位置
                        cj.SetTextTagText(obj.texttag_, obj.msg_, 0.03)
                        cj.SetTextTagPos(obj.texttag_, obj.loc_.x_, obj.loc_.y_, 10)
                        cj.SetTextTagLifespan(obj.texttag_, 2)

                        obj.timeout_ = 2
                    end
                end,
            }
        end
    else
        skill.multi_cast_count_ = 0
    end

    -- 結束判斷，
    skill.is_multi_cast_ = false
end

IsShowMultiCast = function(skill)
    if not skill.multi_cast_text_ then
        return true
    end
    
    if not skill.multi_cast_text_.invalid_ then
        return true
    end

    return false
end

GenerateSkillObject = function(skill, hero, target_unit, target_loc)
    local skill_copy = skill:New(hero, target_unit, target_loc)
    hero.each_casting_[#hero.each_casting_ + 1] = skill_copy
    skill_copy:_cast_start()
end

-- 創建使用物品事件
local use_item_trg = War3.CreateTrigger(function()
    Hero(cj.GetTriggerUnit()):EventDispatch("單位-使用物品", cj.GetManipulatedItem())
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

    StackItem(hero.object_, item)
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
        cj.TriggerRegisterUnitEvent(unit_is_casted, target, cj.EVENT_UNIT_SPELL_CHANNEL)

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
    if not(Item.IsSecrets(item) or Item.IsMaterial(item)) then
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
    return (bag_item.id_ == target_item.id_) and (bag_item ~= target_item)
end
