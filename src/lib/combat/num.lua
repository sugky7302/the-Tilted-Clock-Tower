-- 獲取戰鬥屬性數值

local Num = {}

-- 元素傷害和抗性一起計算
function Num.EAtk(self)
    local max = math.max
    local basic = max(0, self.source_:get(self.element_type_ .. "元素傷害")
                       - self.target_:get(self.element_type_ .. "元素抗性"))

    local ELEMENT_TYPE = require 'combat.type'.ELEMENT
    local bonus = ELEMENT_TYPE[self.element_type_][self.target_:get "元素屬性"]
                  * self.source_:get(self.element_type_ .. "元素增傷")

    return basic * bonus
end

local Rand = require 'math_lib'.Random
local BODY_TYPE = require 'combat.type'.BODY

-- 固定物理傷害和額外物理傷害都是天賦或秘物給的，只是前者會計算體型，後者不會
function Num.Atk(self, EAtk)
    local basic = Rand(self.source_:get "最小物理攻擊力", self.source_:get "最大物理攻擊力")

    local atk = (basic + self.source_:get "固定物理傷害")
                * BODY_TYPE[self.source_:get "體型"][self.target_:get "體型"]
                + self.source_:get "額外物理傷害"

    return (atk + EAtk) * Num.TalentBuffInAtk(self.source_) * Num.BuffInAtk(self.source_)
end

-- 物理傷害增益天賦
function Num.TalentBuffInAtk(source)
    return 1
end

-- 身上的物理傷害增益效果
function Num.BuffInAtk(source)
    return 1
end

function Num.Matk(self, EAtk)
    local basic_dmg = self.skill.damage_[self.skill.level_]

    -- 檢查基礎傷害是定值還是區間內隨機值
    local type = type
    if type(basic_dmg) == 'table' then
        basic_dmg = Rand(basic_dmg[1], basic_dmg[2])
    end

    local matk = basic_dmg + self.skill.proc_ * self.source_:get "法術攻擊力" + self.source_:get "額外法術傷害"

    return (matk + EAtk) * Num.TalentBuffInMatk(self.source_) * Num.BuffInMatk(self.source_)
end

-- 法術傷害增益天賦
function Num.TalentBuffInMatk(source)
    return 1
end

-- 身上的法術傷害增益效果
function Num.BuffInMatk(source)
    local bonus = 1

    -- 霜寒刺骨加成
    bonus = bonus + source:get "霜寒刺骨"

    return bonus
end

local table_concat = table.concat
-- 種族傷害增益效果，物理/法術都受益
-- 包含傷害來源的種族增傷、傷害目標的對種族降傷
function Num.RaceBuffInAtk(self)
    return 1 + self.source_:get(self.target_:get "種族" .. "增傷")
             + self.target_:get(table_concat({"對", self.source_:get "種族", "降傷"}))
end

-- 階級傷害增益效果，物理/法術都受益
-- 包含傷害來源的階級增傷、傷害目標的對階級降傷
function Num.ClassBuffInAtk(self)
    return 1 + self.source_:get(self.target_:get "階級" .. "增傷")
             + self.target_:get(table_concat({"對", self.source_:get "階級", "降傷"}))
end

-- 獨立傷害增益效果，物理/法術都受益
function Num.IndependentBuffInAtk(source)
    -- local part1 = source:get "元素戒"
    -- local part2 = source:get "空虛之戒"
    -- return part1 * part2
    return 1
end

-- 元素抗性已經算在EAtk裡了，所以這裡就不用再算
-- 固定物理護甲和額外物理護甲都是天賦或秘物給的，只是前者會計算體型，後者不會
function Num.Def(self)
    local def = (self.target_:get "物理護甲" + self.target_:get "固定物理護甲")
                * BODY_TYPE[self.source_:get "體型"][self.target_:get "體型"]
                + self.target_:get "額外物理護甲"

    return def * Num.TalentsBuffInDef(self.target_) * Num.BuffInDef(self.target_)
end

-- 物理護甲增益天賦
function Num.TalentsBuffInDef(target)
    return 1
end

-- 物理護甲增益效果
function Num.BuffInDef(target)
    return 1
end


function Num.Mdef(self)
    local mdef = self.target_:get "法術護甲" + self.target_:get "額外法術護甲"
    return mdef * Num.TalentsBuffInMdef(self.target_) * Num.BuffInMdef(self.target_)
end

-- 法術護甲增益天賦
function Num.TalentsBuffInMdef(target)
    return 1
end

-- 法術護甲增益效果
function Num.BuffInMdef(target)
    return 1
end

-- 種族護甲增益效果，物理/法術都受益
-- 包含傷害來源的對種族降傷、傷害目標的種族減傷
function Num.RaceBuffInDef(self)
    return 1 + self.target_:get(self.source_:get "種族" .. "減傷")
             + self.source_:get(table_concat({"對", self.target_:get "種族", "降傷"}))
end

-- 階級護甲增益效果，物理/法術都受益
-- 包含傷害來源的對種族降傷、傷害目標的種族減傷
function Num.ClassBuffInDef(self)
    return 1 + self.target_:get(self.source_:get "階級" .. "減傷")
             + self.source_:get(table_concat({"對", self.target_:get "階級", "降傷"}))
end

-- 獨立護甲增益效果，物理/法術都受益
function Num.IndependentBuffInDef(target)
    return 1
end

return Num