-- 此module擴展英雄單位的功能，為單位的子集

local setmetatable = setmetatable

-- package
local Skill = require 'skill.core'

local Hero, Unit = {}, require 'unit.core'
setmetatable(Hero, Hero)
Hero.__index = Unit

-- constants
Hero.type = "Hero"

-- assert
local InitHeroState
Hero.hero_datas = {} -- 儲存所有英雄資料

function Hero:__call(hero)
    local H2I = require 'jass_tool'.H2I

    if H2I(hero) == 0 then
        return false
    end

    local instance = Unit[H2I(hero) .. ""] -- Hero搜尋不到，會去搜尋Unit
    if not instance then
        instance = Unit(hero)

        local ProperName = require 'jass.common'.GetHeroProperName
        instance.proper_name_ = ProperName(hero)
        
        -- 施法序列
        instance.each_casting_ = {}

        if self.hero_datas[instance.name_] and self.hero_datas[instance.name_].specialty_name then
            instance["專長"] = Skill[self.hero_datas[instance.name_].specialty_name]
        end
        
        setmetatable(instance, instance)
        instance.__index = self
        
        Unit[H2I(hero) .. ""] = instance
        
        InitHeroState(self)
    end
    return instance
end

InitHeroState = function(self)
    local slk_unit = require 'jass.slk'.unit
    local U2Id = require 'jass_tool'.U2Id

    local data = slk_unit[Base.Id2String(U2Id(self.object_))]
    if not data then
        return false
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
    self['額外物理傷害'] = 0
    self['額外法術傷害'] = 0
    self['特殊物理傷害'] = 0
    self['特殊法術傷害'] = 0

    self['固定物理護甲'] = 0
    self['額外物理護甲'] = 0
    self['額外法術護甲'] = 0
    self['特殊物理護甲'] = 0
    self['特殊法術護甲'] = 0
    
    self['近戰減傷'] = 0
    self['遠程減傷'] = 0
    self['護盾'] = 0

    local ipairs = ipairs
    for _, name in ipairs(Unit.RACE) do
        self[name .. '增傷'] = 0
        self[name .. '減傷'] = 0
        self['對' .. name .. '降傷'] = 0
    end

    for _, name in ipairs(Unit.LEVEL) do
        self[name .. '增傷'] = 0
        self[name .. '減傷'] = 0
        self['對' .. name .. '降傷'] = 0
    end

    for _, name in ipairs(Unit.ELEMENTS) do
        self[name .. '元素增傷'] = 0
    end
end

function Hero.Create(name)
    return function(obj)
        Hero.hero_datas[name] = obj

        -- 註冊技能
        obj.skill_datas = {}
        
        for _, name in ipairs(obj.skill_names) do
            obj.skill_datas[#obj.skill_datas + 1] = Skill[name]
        end

        return obj
    end
end

function Hero:UpdateAttributes(sign, equipment)
    sign = (sign == "增加") and 1 or -1

    local ipairs = ipairs
    for _, tb in ipairs(equipment.attribute_) do 
        self:add(tb[1], sign * tb[2])
    end
end

return Hero