local setmetatable = setmetatable
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
local _RegDropItemEvent, _RegObtainItemEvent, _RegReviveEvent, _RegSellItemEvent, _RegUseItemEvent, _RegSpellEffectEvent
local _IsItem, _IsTypeSame, _ChekMultiCast, _GenerateSkillObject, _IsShowMultiCast
local set, get = {}, {}
Hero.heroDatas = {}

function Hero.Init()
    local orderTrg = War3.CreateTrigger(function()
        Game:EventDispatch("單位-發布命令", Hero(cj.GetOrderedUnit()), cj.GetIssuedOrderId(), cj.GetOrderTarget())
        return true
    end)
    local unitIsCasted = War3.CreateTrigger(function()
        Game:EventDispatch("單位-準備施放技能", Hero(cj.GetTriggerUnit()), cj.GetSpellAbilityId(), Hero(cj.GetSpellTargetUnit()), Point:GetLoc(cj.GetSpellTargetLoc()))
        return true
    end)
    Game:Event '單位-準備施放技能' (function(self, hero, id, targetUnit, targetLoc)
        -- 獲取技能
        for _, skill in pairs(hero.heroDatas[cj.GetUnitName(hero.object)].skillDatas) do
            if skill.orderId == Base.Id2String(id) then
                _ChekMultiCast(skill, hero)
                _GenerateSkillObject(skill, hero, targetUnit, targetLoc)
                return 
            end
        end
    end)
    -- 添加事件
    Game:Event "單位-創建" (function(self, target)
        if Hero(target).type == "Hero" then
            cj.TriggerRegisterUnitEvent(unitIsCasted, target, cj.EVENT_UNIT_SPELL_CHANNEL)
            cj.TriggerRegisterUnitEvent(orderTrg, target, cj.EVENT_UNIT_ISSUED_TARGET_ORDER)
            cj.TriggerRegisterUnitEvent(orderTrg, target, cj.EVENT_UNIT_ISSUED_POINT_ORDER)
            cj.TriggerRegisterUnitEvent(orderTrg, target, cj.EVENT_UNIT_ISSUED_ORDER)
            cj.TriggerRegisterUnitEvent(_RegReviveEvent(), target, cj.EVENT_UNIT_DEATH) -- 死亡事件
            cj.TriggerRegisterUnitEvent(_RegUseItemEvent(), target, cj.EVENT_UNIT_USE_ITEM) -- 使用物品事件
            cj.TriggerRegisterUnitEvent(_RegObtainItemEvent(), target, cj.EVENT_UNIT_PICKUP_ITEM) -- 獲得物品事件
            cj.TriggerRegisterUnitEvent(_RegDropItemEvent(), target, cj.EVENT_UNIT_DROP_ITEM) -- 丟棄物品事件
            cj.TriggerRegisterUnitEvent(_RegSellItemEvent(), target, cj.EVENT_UNIT_SELL_ITEM) -- 出售物品事件
            cj.TriggerRegisterUnitEvent(_RegSpellEffectEvent(), target, cj.EVENT_UNIT_SPELL_EFFECT)
        end
    end)

    Game:Event "單位-發布命令" (function(self, hero, order, target)
        if _IsItem(target) and (order == Base.String2OrderId('smart')) then
            if cj.GetItemCharges(target) > 0 then
                for i = 0, 5 do
                    local bagItem = cj.UnitItemInSlot(hero, i)
                    if _IsTypeSame(bagItem, target) then
                        cj.SetItemCharges(bagItem, cj.GetItemCharges(bagItem) + cj.GetItemCharges(target))
                        cj.RemoveItem(target)
                        return
                    end
                end
            end
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

_IsItem = function(item)
    return cj.GetItemName(item)
end

_IsTypeSame = function(bagItem, target)
    return (js.Item2Id(bagItem) == js.Item2Id(target)) and (bagItem ~= target)
end

_RegReviveEvent = function()
    -- 註冊英雄死亡等待復活的事件
    local _reviveTrg = War3.CreateTrigger(function()
        Game:EventDispatch("單位-復活", Hero(cj.GetTriggerUnit()))
        return true
    end)
    Game:Event "單位-復活" (function(self, obj)
        Timer(10 * (1 + obj:get '等級'), false, function()
            cj.ReviveHero(obj.object, obj.revivePoint.x, obj.revivePoint.y, true)
        end)
    end)
    return _reviveTrg
end

_RegUseItemEvent = function()
    -- 創建使用物品事件
    local _useItemTrg = War3.CreateTrigger(function()
        Game:EventDispatch("單位-使用物品", cj.GetTriggerUnit(), cj.GetManipulatedItem())
        return true
    end)
    Game:Event "單位-使用物品" (function(self, hero, item)
    end)
    return _useItemTrg
end

_RegObtainItemEvent = function()
    -- 創建獲得物品事件
    local _obtainItemTrg = War3.CreateTrigger(function()
        if cj.GetManipulatedItem() ~= nil then
            Game:EventDispatch("單位-獲得物品", cj.GetTriggerUnit(), cj.GetManipulatedItem())
        end
        return true
    end)
    Game:Event "單位-獲得物品" (function(self, hero, item)
        if Item.IsEquipment(item) then
            Equipment(item).owner = Hero(hero)
            Equipment(item).ownPlayer = Player(cj.GetOwningPlayer(hero))
        elseif Item.IsSecrets(item) then
            Secrets(item).owner = Hero(hero)
            Secrets(item).ownPlayer = Player(cj.GetOwningPlayer(hero))
        else
            Item(item).owner = Hero(hero)
            Item(item).ownPlayer = Player(cj.GetOwningPlayer(hero))
        end
    end)
    return _obtainItemTrg
end

_RegDropItemEvent = function()
    -- 創建丟棄物品事件
    local _dropItemTrg = War3.CreateTrigger(function()
        Game:EventDispatch("單位-丟棄物品", cj.GetTriggerUnit(), cj.GetManipulatedItem())
        return true
    end)
    return _dropItemTrg
end

_RegSellItemEvent = function()
    -- 創建出售物品事件
    local _sellItemTrg = War3.CreateTrigger(function()
        Game:EventDispatch("單位-出售物品", cj.GetTriggerUnit(), cj.GetSoldItem())
        return true
    end)
    Game:Event "單位-出售物品" (function(self, hero, item)
    end)
    return _sellItemTrg
end

_RegSpellEffectEvent = function()
    local _spellEffectTrg = War3.CreateTrigger(function()
        Game:EventDispatch("單位-發動技能效果", cj.GetTriggerUnit(), cj.GetSpellAbilityId(), cj.GetSpellTargetUnit(), cj.GetSpellTargetItem(), cj.GetSpellTargetLoc())
        return true
    end)
    return _spellEffectTrg
end

function Hero:__call(hero)
    local obj = self[js.H2I(hero) .. ""] -- TODO: 不確定Hero搜尋不到，會不會去搜尋Unit
    if not obj then
        obj = Unit(hero)
        obj.eachCasting = {}
        setmetatable(obj, obj)
        obj.__index = self
        self[js.H2I(hero) .. ""] = obj
        obj:InitState()
    end
    return obj
end

function Hero:InitState()
    local data = slk.unit[Base.Id2String(cj.GetUnitTypeId(self.object))]
    if not data then
        return 
    end
    self['技巧'] = 0
    self['感知'] = 0
    self['耐力'] = 0
    self['精神'] = 0
    self['急速'] = 0
    self['精通'] = 0
    self['幸運'] = 0
    self['靈敏'] = 0
    self['傷害擴散'] = 0
    self['減少魔力消耗'] = 0
    self['固定物理傷害'] = 0
    self['固定法術傷害'] = 0
    self['額外物理傷害'] = 0
    self['額外法術傷害'] = 0
    self['特殊物理傷害'] = 0
    self['特殊法術傷害'] = 0
    self['物理護甲%'] = 0
    self['法術護甲%'] = 0
    self['額外物理護甲'] = 0
    self['額外法術護甲'] = 0
    self['特殊物理護甲'] = 0
    self['特殊法術護甲'] = 0
    self['近戰減傷'] = 0
    self['遠程減傷'] = 0
    for _, name in ipairs(Hero._RACE) do
        self[name .. '增傷'] = 0
        self[name .. '減傷'] = 0
        self['對' .. name .. '降傷'] = 0
    end
    for _, name in ipairs(Hero._LEVEL) do
        self[name .. '增傷'] = 0
        self[name .. '減傷'] = 0
        self['對' .. name .. '降傷'] = 0
    end
    for _, name in ipairs(Hero._ELEMENTS) do
        self[name .. '元素增傷'] = 0
    end
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

get['施法速度'] = function(self)
    return 2 * self:get "急速" / (self:get "急速" + 100 + 50 * self.level)
end

return Hero