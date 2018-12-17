-- 計算傷害並顯示數值

local setmetatable = setmetatable

local Damage = {}
setmetatable(Damage, Damage)

-- assert
local SetDamageRatio, ObtainSkillData
local ComputeAttack, ComputeDefense

-- instance = {
--     source_(Hero type),
--     target_(Hero type),

--     name_,
--     type_,
--     element_type_,

--     ratio_(混合傷害的物法比例，只有type = 混合才使用)
function Damage:__call(instance)
    -- DealDamge的扣血可能會造成二次觸發，這時來源跟目標會是同一單位
    -- 因此使用判斷式排除 "來源 = 目標" 的情況
    if instance.source_ == instance.target_ then 
        return false
    end

    -- 防止技能攻擊二次觸發
    -- 使用instance.type_會比較不準確，比如混合傷害可以是技能，也可以是普攻
    if instance.name_ ~= "普通攻擊" then
        instance.target_.is_spell_damaged_ = true
    end

    SetDamageRatio(instance)

    -- 計算matk會用到skill的damage、proc
    ObtainSkillData(instance)

    local atk, def = ComputeAttack(instance), ComputeDefense(instance)

    -- 傷害判定
    local DamageCheck = require 'combat.checker'.Damage
    local dmg, text_size = DamageCheck(instance, atk, def)

    -- 計算護盾
    -- string表示傷害判定為 "閃避"
    if type(dmg) ~= "string" then
        -- dmg < 0 表示護盾比較厚
        dmg = dmg - instance.target_:get "護盾"

        if dmg > 0 then
            DealDamage(instance.target_, dmg)
        end

        -- 扣除護盾量
        local max = math.max
        instance.target_:set("護盾", max(0, -dmg))

        -- 儲存最後傷害，有些技能會用到
        instance.source_:set("最後造成的傷害", dmg)
    end

    -- 根據傷害類型不同，漂浮文字會有不同顏色
    Show(instance.target_.object_, dmg, instance.type_, text_size)

    -- 儲存攻擊者
    instance.target_.attacker_ = instance.source_

    -- 關閉判定，以免傷害函數無法執行
    instance.target_.is_spell_damaged_ = false 

    -- 有些天賦會觸發結算事件
    instance.source_:EventDispatch("單位-傷害結算", instance.name_)
end

SetDamageRatio = function(self)
    if self.ratio_ then
        return true
    end

    -- 設定比例{物理, 法術}
    if self.type_ == "物理" then
        self.ratio_ = {1, 0}
        return true
    end

    -- type == 法術
    self.ratio_ = {0, 1}
    return true
end

ObtainSkillData = function(self)
    local skill = require 'skill.core'[self.name_]
    if skill then
        self.damage_ = {skill.damage_[2 * skill.level_ - 1], skill.damage_[2 * skill.level_]}
        self.proc_ = skill.proc_
    end
end

local Num = require 'combat.num'

ComputeAttack = function(self)
    local eatk, total_atk, extra_dmg = Num.EAtk(self), 0, 0

    -- 等於0就不用算了，節省算力
    if self.ratio_[1] > 0 then
        total_atk = total_atk + self.ratio_[1] * Num.Atk(self, eatk)
        extra_dmg = extra_dmg + self.ratio_[1] * self.source_:get "特殊物理傷害"
    end

    if self.ratio_[2] > 0 then
        total_atk = total_atk + self.ratio_[2] * Num.Matk(self, eatk)
        extra_dmg = extra_dmg + self.ratio_[2] * self.source_:get "特殊法術傷害"
    end

    return total_atk * (1 + self.source_:get "精通")
           * Num.RaceBuffInAtk(self) * Num.ClassBuffInAtk(self)
           * Num.IndependentBuffInAtk(self.source_) + extra_dmg
end

ComputeDefense = function(self)
    local total_def, extra_amr = 0, 0

    -- 等於0就不用算了，節省算力
    if self.ratio_[1] > 0 then
        total_def = total_def + self.ratio_[1] * Num.Def(self)
        extra_amr = extra_amr + self.ratio_[1] * self.source_:get "特殊物理護甲"
    end

    if self.ratio_[2] > 0 then
        total_def = total_def + self.ratio_[2] * Num.Mdef(self)
        extra_amr = extra_amr + self.ratio_[2] * self.source_:get "特殊法術護甲"
    end
    
    return total_def * Num.RaceBuffInDef(self) * Num.ClassBuffInDef(self)
           * Num.IndependentBuffInDef(self.source_) + extra_amr
end

DealDamage = function(target, dmg)
    if dmg < target:get "生命" then
        target:set('生命', target:get "生命" - dmg)
    else
        local RemoveUnit = require 'jass_tool'.RemoveUnit
        RemoveUnit(target.object_)
    end
end

Show = function(target, value, text_type, scale)
    local modf, Round, type = math.modf, require 'math_lib'.Round, type

    local text
    if type(value) == "string" then -- 閃避生效
        local table_concat = table.concat
        text = table_concat({"|cffff0000", value, "!"})

    elseif text_type == "法術" then
        text = "|cffffff00" .. modf(Round(value))

    elseif text_type == "混合" then
        text = "|cff8080c0" .. modf(Round(value))

    else
        text = modf(Round(value))
    end

    -- 創建漂浮文字
    -- 是Point "." GetUnitLoc，不是Point ":" GetUnitLoc
    local GetUnitLoc   = require 'point'.GetUnitLoc
    local ArcText = require 'texttag.arc' 
    ArcText(text, GetUnitLoc(target), scale)
end

return Damage