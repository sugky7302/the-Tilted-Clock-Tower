-- 此module註冊單位事件

local cj = require 'jass.common'
local js = require 'jass_tool'
local War3 = require 'api'
local Unit = require 'unit.core'
local Game = require 'game'
local Point = require 'point'
local Item = require 'item.core'
local Timer = require 'timer.core'

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

    local Rand = require 'math_lit'.Random
    local ipairs = ipairs
    local p = Point:GetUnitLoc(unit.object_)

    for i = 1, #DROP_LIB[unit.id_], 2 do 
        if Random(100) < DROP_LIB[i+1] then
            local item = Item.Create(DROP_LIB[i], p)

            -- 掉落裝備
            if cj.GetItemLevel(item) == 5 then
                unit:DropEquipment(item)
            end
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

Game:Event "單位-創建" (function(_, target)
    cj.TriggerRegisterUnitEvent(trg, target, cj.EVENT_UNIT_DEATH)
end)

local Hero = require 'unit.hero'

local order_trg = War3.CreateTrigger(function()
    Hero(cj.GetOrderedUnit()):EventDispatch("單位-發布命令", cj.GetIssuedOrderId(), cj.GetOrderTarget())
        return true
end)

Unit:Event "單位-發布命令" (function(_, hero, order, target)
    if order == Base.String2OrderId('smart') then
        StackItem(hero.object_, target)
    end
end)

local unitIs_casted = War3.CreateTrigger(function()
    Hero(cj.GetTriggerUnit()):EventDispatch("單位-準備施放技能", cj.GetSpellAbilityId(), Unit(cj.GetSpellTargetUnit()), Point:GetLoc(cj.GetSpellTargetLoc()))
    return true
end)

Unit:Event '單位-準備施放技能' (function(_, hero, id, target_unit, target_loc)
    -- 打斷正在施法的技能
    for _, skill in ipairs(hero.each_casting_) do
        if skill.order_id_ ~= Base.Id2String(id) then
            skill:Break()
        end
    end

    -- 獲取技能
    local ipairs = ipairs
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

-- TODO:以下未完成
    -- 創建使用物品事件
    local _useItemTrg = War3.CreateTrigger(function()
        Hero(cj.GetTriggerUnit()):EventDispatch("單位-使用物品", cj.GetManipulatedItem())
        return true
    end)

    -- 創建獲得物品事件
    local _obtainItemTrg = War3.CreateTrigger(function()
        if cj.GetManipulatedItem() ~= nil then
            Hero(cj.GetTriggerUnit()):EventDispatch("單位-獲得物品", cj.GetManipulatedItem())
        end
        return true
    end)
    Unit:Event "單位-獲得物品" (function(trigger, hero, item)
        if Item.IsEquipment(item) then
            Equipment(item).owner = hero
            Equipment(item).ownPlayer = hero.owner
            hero:UpdateAttributes("增加", Equipment(item))
        elseif Item.IsSecrets(item) then
            Secrets(item).owner = hero
            Secrets(item).ownPlayer = hero.owner
        elseif hero:AcceptQuest(string_sub(cj.GetItemName(item), 10)) then
                return 
        else
            Item(item).owner = hero
            Item(item).ownPlayer = hero.owner
        end
        _StackItem(hero.object, item)
    end)
    
    -- 創建丟棄物品事件
    local _dropItemTrg = War3.CreateTrigger(function()
        Hero(cj.GetTriggerUnit()):EventDispatch("單位-丟棄物品", cj.GetManipulatedItem())
        return true
    end)

    Unit:Event "單位-丟棄物品" (function(trigger, hero, item)
        if Item.IsEquipment(item) then
            hero:UpdateAttributes("減少", Equipment(item))
        end
    end)
    
    -- 創建出售物品事件
    local _sellItemTrg = War3.CreateTrigger(function()
        Hero(cj.GetTriggerUnit()):EventDispatch("單位-出售物品", cj.GetSoldItem())
        return true
    end)

    local _spellEffectTrg = War3.CreateTrigger(function()
        Hero(cj.GetTriggerUnit()):EventDispatch("單位-發動技能效果", cj.GetSpellAbilityId(), cj.GetSpellTargetUnit(), cj.GetSpellTargetItem(), cj.GetSpellTargetLoc())
        return true
    end)

    -- 添加事件
    Game:Event "單位-創建" (function(trigger, target)
        if Hero(target).type == "Hero" then
            cj.TriggerRegisterUnitEvent(unitIsCasted, target, cj.EVENT_UNIT_SPELL_CHANNEL)
            cj.TriggerRegisterUnitEvent(orderTrg, target, cj.EVENT_UNIT_ISSUED_TARGET_ORDER)
            cj.TriggerRegisterUnitEvent(orderTrg, target, cj.EVENT_UNIT_ISSUED_POINT_ORDER)
            cj.TriggerRegisterUnitEvent(orderTrg, target, cj.EVENT_UNIT_ISSUED_ORDER)
            cj.TriggerRegisterUnitEvent(_useItemTrg, target, cj.EVENT_UNIT_USE_ITEM) -- 使用物品事件
            cj.TriggerRegisterUnitEvent(_obtainItemTrg, target, cj.EVENT_UNIT_PICKUP_ITEM) -- 獲得物品事件
            cj.TriggerRegisterUnitEvent(_dropItemTrg, target, cj.EVENT_UNIT_DROP_ITEM) -- 丟棄物品事件
            cj.TriggerRegisterUnitEvent(_sellItemTrg, target, cj.EVENT_UNIT_SELL_ITEM) -- 出售物品事件
            cj.TriggerRegisterUnitEvent(_spellEffectTrg, target, cj.EVENT_UNIT_SPELL_EFFECT)
        end
    end)
end

_ChekMultiCast = function(skill, hero)
    if skill.isMultiCast then
        skill.multiCastCount = skill.multiCastCount + 1
        local Texttag = require 'texttag'
        if _IsShowMultiCast(skill) then
            skill.multiCastText = Texttag{
                msg = "|cffff0000" .. skill.multiCastCount .. "重施法|r",
                loc = Point:GetUnitLoc(hero.object),
                timeout = 2,
                skill = skill,
                multiCastCount = skill.multiCastCount,
                isPermanant = false,
                Initialize = function(obj)
                    cj.SetTextTagText(obj.texttag, obj.msg, 0.04)
                    cj.SetTextTagPos(obj.texttag, obj.loc.x, obj.loc.y, 10)
                    cj.SetTextTagPermanent(obj.texttag, obj.isPermanant)
                    cj.SetTextTagLifespan(obj.texttag, obj.timeout)
                    cj.SetTextTagFadepoint(obj.texttag, 0.3)
                end,
                Update = function(obj)
                    if obj.multiCastCount < obj.skill.multiCastCount then
                        obj.msg = "|cffff0000" .. obj.skill.multiCastCount .. "重施法|r"
                        cj.SetTextTagText(obj.texttag, obj.msg, 0.03)
                        cj.SetTextTagPos(obj.texttag, obj.loc.x, obj.loc.y, 10)
                        cj.SetTextTagLifespan(obj.texttag, 2)
                        obj.timeout = 2
                    end
                end,
                Remove = function(obj)
                    Texttag.Remove(obj)
                end
            }
        end
    else
        skill.multiCastCount = 0
    end
    skill.isMultiCast = false
end

_IsShowMultiCast = function(skill)
    if not skill.multiCastText then
        return true
    elseif not skill.multiCastText.invalid then
        return true
    end
    return false
end

_GenerateSkillObject = function(skill, hero, targetUnit, targetLoc)
    local skillCopy = skill:New(hero, targetUnit, targetLoc)
    table.insert(hero.eachCasting, skillCopy)
    skillCopy:_cast_start()
end

_StackItem = function(hero, item)
    if _IsItem(item) and cj.GetItemCharges(item) > 0 then
        for i = 0, 5 do
            local bagItem = cj.UnitItemInSlot(hero, i)
            if _IsTypeSame(bagItem, item) then
                cj.SetItemCharges(bagItem, cj.GetItemCharges(bagItem) + cj.GetItemCharges(item))
                Item(item):Remove()
                return
            end
        end
    end
end

_IsItem = function(item)
    return cj.GetItemLevel(item) == 1
end

_IsTypeSame = function(bagItem, target)
    return (js.Item2Id(bagItem) == js.Item2Id(target)) and (bagItem ~= target)
end

Unit:Event "寵物-清除" (function(trigger, pet)
    pet.owner.pet = nil
    pet:Remove()
end)