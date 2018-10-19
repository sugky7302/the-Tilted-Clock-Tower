local setmetatable = setmetatable
local Unit = require 'unit'
local cj = require 'jass.common'
local js = require 'jass_tool'
local slk = require 'jass.slk'
local War3 = require 'api'
local Game = require 'game'
local Timer = require 'timer'
local Group = require 'group'

local Hero = {}
setmetatable(Hero, Hero)
Hero.__index = Unit
Hero.type = "Hero"

function Hero.Init()
    -- 註冊英雄死亡等待復活的事件
    local trg = War3.CreateTrigger(function()
        Game:EventDispatch("單位-復活", Hero(cj.GetTriggerUnit()))
        return true
    end)
    Game:Event "單位-復活" (function(self, obj)
        Timer(10 * (1 + obj:get '等級'), false, function()
            cj.ReviveHero(obj.object, obj.revivePoint.x, obj.revivePoint.y, true)
        end)
    end)
    Game:Event "單位-創建" (function(self, target)
        if Hero(target).type == "Hero" then
            cj.TriggerRegisterUnitEvent(trg, target, cj.EVENT_UNIT_DEATH)
        end
    end)
    -- 為單位生成結構與註冊事件
    local g = Group()
    g:EnumUnitsInRange(0, 0, 9999999, Group.IsHero)
    g:Loop(function(self, i)
        Hero(self.units[i])
        Game:EventDispatch("單位-創建", self.units[i])
    end)
    g:Remove()
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
    self['增強物理護甲'] = 0
    self['增強法術護甲'] = 0
    self['額外物理護甲'] = 0
    self['額外法術護甲'] = 0
    self['近戰減傷'] = 0
    self['遠程減傷'] = 0
    self['種族增傷'] = {}
    self['種族減傷'] = {}
    for _, name in ipairs(Hero._RACE) do
        self['種族增傷'][name] = 0
        self['種族減傷'][name] = 0
    end
    self['階級增傷'] = {}
    self['階級減傷'] = {}
    for _, name in ipairs(Hero._LEVEL) do
        self['階級增傷'][name] = 0
        self['階級減傷'][name] = 0
    end
    self['元素增傷'] = {}
    for _, name in ipairs(Hero._ELEMENTS) do
        self['元素增傷'][name] = 0
    end
end

return Hero