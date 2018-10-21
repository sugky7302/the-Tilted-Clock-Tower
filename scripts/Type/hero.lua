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

local Hero = {}
setmetatable(Hero, Hero)
Hero.__index = Unit
Hero.type = "Hero"

-- varaiables
local _RegDropItemEvent, _RegObtainItemEvent, _RegReviveEvent, _RegSellItemEvent, _RegUseItemEvent, _RegSpellEffectEvent

function Hero.Init()
    -- 添加事件
    Game:Event "單位-創建" (function(self, target)
        if Hero(target).type == "Hero" then
            cj.TriggerRegisterUnitEvent(_RegReviveEvent(), target, cj.EVENT_UNIT_DEATH) -- 死亡事件
            cj.TriggerRegisterUnitEvent(_RegUseItemEvent(), target, cj.EVENT_UNIT_USE_ITEM) -- 使用物品事件
            cj.TriggerRegisterUnitEvent(_RegObtainItemEvent(), target, cj.EVENT_UNIT_PICKUP_ITEM) -- 獲得物品事件
            cj.TriggerRegisterUnitEvent(_RegDropItemEvent(), target, cj.EVENT_UNIT_DROP_ITEM) -- 丟棄物品事件
            cj.TriggerRegisterUnitEvent(_RegSellItemEvent(), target, cj.EVENT_UNIT_SELL_ITEM) -- 出售物品事件
            cj.TriggerRegisterUnitEvent(_RegSpellEffectEvent(), target, cj.EVENT_UNIT_SPELL_EFFECT)
        end
    end)
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
        Game:EventDispatch("單位-獲得物品", cj.GetTriggerUnit(), cj.GetManipulatedItem())
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
        Game:EventDispatch("單位-出售物品", cj.GetTriggerUnit(), cj.GetManipulatedItem())
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

return Hero