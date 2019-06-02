-- 擴展英雄單位的功能，為單位的subclass
-- 依賴
--   Unit 
--   Skill 
--   jass_tool
--   jass.common
--   jass.slk


-- package
local require = require
local Unit = require 'unit.core'
local Skill = require 'skill.core'
local js = require 'jass_tool'


local Hero = require 'class'("Hero", Unit)

-- constants
local hero_datas = {} -- 儲存所有英雄資料
Hero.hero_datas = hero_datas

-- assert
local InitHeroState, AbilityDisable

function Hero:_new(hero)
    if js.H2I(hero) == 0 then
        return false
    end

    Unit._new(self, hero)

    local ProperName = require 'jass.common'.GetHeroProperName
    self.proper_name_ = ProperName(hero)
        
    -- 施法序列
    self.each_casting_ = {}

    if hero_datas[self.name_] and hero_datas[self.name_].specialty_name then
        self["專長"] = Skill:getSubclass(hero_datas[self.name_].specialty_name)
    end
        
    InitHeroState(self)

    -- 關閉技能
    AbilityDisable(self)
end

-- assert
local ipairs = ipairs

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

AbilityDisable = function(self)
    -- 偵查
    self:AbilityDisable 'A00M'

    -- 情報
    self:AbilityDisable 'A055'
end

function Hero:_delete()
    Unit._delete(self)
end

function Hero:getInstance(hero)
    return Unit:getInstance(hero)
end


function Hero.Template(name)
    return function(obj)
        hero_datas[name] = obj

        -- 註冊技能
        obj.skill_datas = {}
        
        for _, name in ipairs(obj.skill_names) do
            obj.skill_datas[#obj.skill_datas + 1] = Skill:getSubclass(name)
        end

        return obj
    end
end

function Hero:UpdateAttributes(sign, equipment)
    sign = (sign == "+") and 1 or -1

    for _, tb in ipairs(equipment.attribute_) do 
        self:add(tb[1], sign * tb[2])
    end
end

return Hero