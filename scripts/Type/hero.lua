local setmetatable = setmetatable
local string_sub = string.sub
local Unit = require 'unit'
local cj = require 'jass.common'
local js = require 'jass_tool'
local slk = require 'jass.slk'
local War3 = require 'api'
local Game = require 'game'
local Timer = require 'timer'
local Group = require 'group'
local Item = require 'item'
local Equipment = require 'equipment'
local Secrets = require 'secrets'
local Player = require 'player'
local Skill = require 'skill'
local Point = require 'point'

local Hero = {}
setmetatable(Hero, Hero)
Hero.__index = Unit
Hero.type = "Hero"

-- varaiables
local _IsItem, _IsTypeSame, _ChekMultiCast, _GenerateSkillObject, _IsShowMultiCast
Hero.heroDatas = {} -- 儲存所有英雄資料

function Hero.Init()
    local orderTrg = War3.CreateTrigger(function()
        Hero(cj.GetOrderedUnit()):EventDispatch("單位-發布命令", cj.GetIssuedOrderId(), cj.GetOrderTarget())
        return true
    end)
    Unit:Event "單位-發布命令" (function(trigger, hero, order, target)
        if order == Base.String2OrderId('smart') then
            _StackItem(hero.object, target)
        end
    end)

    local unitIsCasted = War3.CreateTrigger(function()
        Hero(cj.GetTriggerUnit()):EventDispatch("單位-準備施放技能", cj.GetSpellAbilityId(), Unit(cj.GetSpellTargetUnit()), Point:GetLoc(cj.GetSpellTargetLoc()))
        return true
    end)
    Unit:Event '單位-準備施放技能' (function(trigger, hero, id, targetUnit, targetLoc)
        -- 打斷正在施法的技能
        for _, skill in ipairs(hero.eachCasting) do
            if skill.orderId ~= Base.Id2String(id) then
                skill:Break()
            end
        end
        -- 獲取技能
        for _, skill in ipairs(hero.heroDatas[hero.name].skillDatas) do
            if skill.orderId == Base.Id2String(id) then
                if skill.canUse then
                    _ChekMultiCast(skill, hero)
                    _GenerateSkillObject(skill, hero, targetUnit, targetLoc)
                else 
                    hero:ResetAbility(skill.orderId)
                end
                return 
            end
        end
    end)

    Unit:Event "英雄-復活" (function(trigger, obj)
        for _, skill in ipairs(obj.eachCasting) do
            skill:Break()
        end
        cj.UnitPauseTimedLife(hero, true) -- 解除js.RemoveUnit設置的水元素週期
        local hero = obj.object
        Timer(10 + 5 * obj:get "等級", false, function()
            cj.ReviveHero(hero, obj.revivePoint.x, obj.revivePoint.y, true)
            obj:set("生命", obj:get "生命上限") -- 不然獲取到的生命值會跟死亡前的生命值相同，導致dealdamage會判定擊殺
        end)
    end)

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

function Hero:__call(hero)
    if not hero then
        return 
    end
    local obj = self[js.H2I(hero) .. ""] -- Hero搜尋不到，會去搜尋Unit
    if not obj then
        obj = Unit(hero)
        obj.eachCasting = {}
        obj["專長"] = Skill[self.heroDatas[obj.name].specialtyName]
        setmetatable(obj, obj)
        obj.__index = self
        self[js.H2I(hero) .. ""] = obj
        obj:InitHeroState()
    end
    return obj
end

function Hero.Create(name)
    return function(obj)
        Hero.heroDatas[name] = obj
        -- 註冊技能
		obj.skillDatas = {}
		if type(obj.skillNames) == 'string' then
            for name in string.gmatch(obj.skillNames, '%S+') do
				table.insert(obj.skillDatas, Skill[name])
			end
		elseif type(obj.skillNames) == 'table' then
			for _, name in ipairs(obj.skillNames) do
				table.insert(obj.skillDatas, Skill[name])
			end
        end
        return obj
    end
end

function Hero:UpdateAttributes(sign, equipment)
    sign = (sign == "增加") and 1 or -1
    for _, tb in ipairs(equipment.attribute) do 
        self:add(tb[1], sign * tb[2])
    end
end

return Hero