-- 技能事件

-- package
local Unit  = require 'unit.core'
local Hero  = require 'unit.hero'
local Point = require 'point'
local Game  = require 'game'
local War3  = require 'api'
local cj    = require 'jass.common'

-- assert
local ipairs = ipairs

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

local unit_is_casted = War3.CreateTrigger(function()
    Hero(cj.GetTriggerUnit()):EventDispatch("單位-準備施放技能", cj.GetSpellAbilityId(), Unit(cj.GetSpellTargetUnit()), Point.GetLoc(cj.GetSpellTargetLoc()))
    return true
end)

-- assert
local GenerateSkillObject, CheckMultiCast

Unit:Event '單位-準備施放技能' (function(_, hero, id, target_unit, target_loc)
    -- 打斷正在施法的技能
    for _, skill in ipairs(hero.each_casting_) do
        if skill.order_id_ ~= Base.Id2String(id) then
            skill:Break()
        end
    end

    -- 獲取技能
    for _, skill in ipairs(Hero.hero_datas[hero.name_].skill_datas) do
        if skill.order_id_ == Base.Id2String(id) then
            if skill.can_use_ then
                CheckMultiCast(skill, hero)
                GenerateSkillObject(skill, hero, target_unit, target_loc)
            else 
                hero:ResetAbility(skill.order_id_)
            end

            return true
        end
    end
end)

CheckMultiCast = function(skill, hero)
    if skill.is_multi_cast_ then
        skill.multi_cast_count_ = skill.multi_cast_count_ + 1

        local Texttag = require 'texttag.core'
        if IsShowMultiCast(skill) then
            skill.multi_cast_text_ = Texttag{
                msg_ = "|cffff0000" .. skill.multi_cast_count_ .. "重施法|r",
                loc_ = Point.GetUnitLoc(hero.object_),
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
    skill_copy:Cast()
end

-- 添加事件
Game:Event "單位-創建" (function(_, target)
    if Unit.IsHero(target) then
        cj.TriggerRegisterUnitEvent(unit_is_casted, target, cj.EVENT_UNIT_SPELL_CHANNEL)
    end
end)