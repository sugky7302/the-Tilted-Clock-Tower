local setmetatable = setmetatable
local math = math
local cj = require 'jass.common'
local TextToAttachUnit = require 'text_to_attach_unit'
local Point = require 'point'
local MathLib = require 'math_lib'

local Damage = {}
setmetatable(Damage, Damage)

-- constants
local _BODY_TYPE = {
    ["小"] = {
        ["小"] = 1,
        ["中"] = 0.75,
        ["大"] = 1.25
    },
    ["中"] = {
        ["小"] = 1.25,
        ["中"] = 1,
        ["大"] = 0.75
    },
    ["大"] = {
        ["小"] = 0.75,
        ["中"] = 1.25,
        ["大"] = 1
    },
}
local _ELEMENT_TYPE = {
    ["無"] ={
        ["無"] = 1,
        ["地"] = 1,
        ["水"] = 1,
        ["火"] = 1,
        ["風"] = 1,
    },
    ["地"] ={
        ["無"] = 1,
        ["地"] = 0.5,
        ["水"] = 1.25,
        ["火"] = 1,
        ["風"] = 0.75,
    },
    ["水"] ={
        ["無"] = 1,
        ["地"] = 0.75,
        ["水"] = 0.5,
        ["火"] = 1.25,
        ["風"] = 1,
    },
    ["火"] ={
        ["無"] = 1,
        ["地"] = 1,
        ["水"] = 0.75,
        ["火"] = 0.5,
        ["風"] = 1.25,
    },
    ["風"] ={
        ["無"] = 1,
        ["地"] = 1.25,
        ["水"] = 1,
        ["火"] = 0.75,
        ["風"] = 0.5,
    },
}

-- variables 
local _ComputeAttack, _ComputeDamageDefense, _DealDamage, _TransHitAndDodge, _IsHitOrDodge
local _IsCriOrACT, _TransCriAndACT, _DeterminCriOrACT, _IsPntOrBlk, _TransPntOrBlk
local _GetIndependentBonusInAtk, _GetWeakness, _GetEAtk, _GetTalentsBonusInAtk, _GetBuffInAtk
local _GetTalentsBonusInDef, _GetBuffInDef, _GetIndependentBonusInDef, _GetAtk, _GetMatk, _GetDef, _GetMdef

-- obj 含 source(Hero type), target(Hero type), type, name, elementType, basicDamage(技能基礎傷害), proc(法術攻擊力係數), ratio(混合傷害的物法比例)
function Damage:__call(obj)
    local atk, def = _ComputeAttack(obj), _ComputeDefense(obj)
    local dmg, textSize = _DamageDetermine(obj, atk, def)
    if type(dmg) ~= "string" then
        _DealDamage(obj.target, dmg)
    end
    _Show(obj.target.object, dmg, obj.type, textSize)
end

_ComputeAttack = function(obj)
    local atk, extraDmg
    if obj.type == "物理" then
        atk = _GetAtk(obj.source, obj.target)
        extraDmg = obj.source:get "特殊物理傷害"
    elseif obj.type == "法術" then
        atk = _GetMatk(obj.source, obj.basicDamage, obj.proc)
        extraDmg = obj.source:get "特殊法術傷害"
    elseif obj.type == "混合" then
        atk = obj.ratio[1] * _GetAtk(obj.source, obj.target) + obj.ratio[2] * _GetMatk(obj.source, obj.basicDamage, obj.proc)
        extraDmg = obj.ratio[1] * obj.source:get "特殊物理傷害" + obj.ratio[2] * obj.source:get "特殊法術傷害"
    end
    local eAtk = _GetEAtk(obj)
    local part1 = (atk + eAtk) * _GetTalentsBonusInAtk(obj.source) * _GetBuffInAtk(obj.source, obj.target)
    local part2 = obj.source:get(obj.target:get "種族" .. "增傷")  * obj.source:get(obj.target:get "階級" .. "增傷") * obj.source:get "精通" 
    local part3 = obj.target:get("對" .. obj.source:get "種族" .. "降傷")  * obj.target:get("對" .. obj.source:get "階級" .. "降傷")
    return part1 * (1 + part2) * (1 + part3) * _GetIndependentBonusInAtk(obj.source) + extraDmg
end

_GetAtk = function(source, target)
    local basic = MathLib.Random(source:get "最小物理攻擊力", source:get "最大物理攻擊力") + source:get "增強物理攻擊力"
    return (basic + source:get "固定傷害") * _BODY_TYPE[source:get "體型"][target:get "體型"] + source:get "額外物理傷害"
end

_GetMatk = function(source, basicDamage, proc)
    if type(basicDamage) == "table" then
        basicDamage = MathLib.Random(basicDamage[1], basicDamage[2])
    end
    return basicDamage + proc * source:get "法術攻擊力" + source:get "額外法術傷害"
end

_GetIndependentBonusInAtk = function(source)
    -- local part1 = source:get "元素戒"
    -- local part2 = source:get "空虛之戒"
    -- return part1 * part2
    return 1
end

_GetEAtk = function(obj)
    return obj.source:get "元素傷害" * (1 - obj.target:get "元素抗性") * _ELEMENT_TYPE[obj.elementType][obj.target:get "元素屬性"]
end

_GetTalentsBonusInAtk = function(source)
    return 1
end

_GetBuffInAtk = function(source, target)
    return 1
end

_ComputeDefense = function(obj)
    local def, extraAmr
    if obj.type == "物理" then
        def = _GetDef(obj.source, obj.target)
        extraAmr = obj.target:get("特殊物理護甲")
    elseif obj.type == "法術" then
        def = _GetMdef(obj.target)
        extraAmr = obj.target:get("特殊法術護甲")
    elseif obj.type == "混合" then
        def = obj.ratio[1] * _GetDef(obj.source, obj.target) + obj.ratio[2] * _GetMdef(obj.target)
        extraAmr = obj.ratio[1] * obj.target:get("特殊物理護甲") + obj.ratio[2] * obj.target:get("特殊法術護甲")
    end
    local part1 = def * _GetTalentsBonusInDef(obj.source) * _GetBuffInDef(obj.source, obj.target) * _GetIndependentBonusInDef(obj.source)
    local part2 = obj.target:get(obj.source:get "種族" .. "減傷")  * obj.target:get(obj.source:get "階級" .. "減傷")
    local part3 = obj.source:get("對" .. obj.target:get "種族" .. "降傷")  * obj.source:get("對" .. obj.target:get "階級" .. "降傷")
    return part1 * (1 + part2) * (1 + part3) + extraAmr
end

_GetDef = function(source, target)
    return target:get "物理護甲" * _BODY_TYPE[source:get "體型"][target:get "體型"] + target:get("額外物理護甲")
end

_GetMdef = function(target)
    return target:get "法術護甲" + target:get("額外法術護甲")
end

_GetTalentsBonusInDef = function(source)
    return 1
end

_GetBuffInDef = function(source, target)
    return 1
end

_GetIndependentBonusInDef = function(source)
    return 1
end

_DamageDetermine = function(obj, atk, def)
    -- 命中與閃避判定
    if _IsHitOrDodge(obj.source:get "命中", obj.target:get "閃避") then
        -- 暴擊與韌性判定
        local criProc = _DeterminCriOrACT(obj.source:get(obj.type .. "暴擊率"), obj.target:get(obj.type .. "韌性"), obj.source:get "等級", obj.target:get "等級")
        if _IsPntOrBlk(obj.source:get(obj.type .. "穿透"), obj.target:get(obj.type .. "格擋"), atk, def) then
            return _BoundaryDetermine(obj.target:get "生命上限", atk, 0, criProc), criProc
        else
            return _BoundaryDetermine(obj.target:get "生命上限", atk, def, criProc), criProc
        end
    else
        return "閃避", 1
    end
end

_IsHitOrDodge = function(hit, dodge)
    if hit > dodge then
        return MathLib.Random() < 0.8 + _TransHitAndDodge(hit, dodge)
    elseif hit == dodge then
        return MathLib.Random() < 0.5
    else
        return not(MathLib.Random() < 0.8 + _TransHitAndDodge(dodge, hit))
    end
end

_TransHitAndDodge = function(x, y)
    return (x - y) / (2 * y + 100)
end

_DeterminCriOrACT = function(cri, act, sourceLv, targetLv)
    if _IsCriOrACT(cri, act, sourceLv, targetLv) then
        return 2
    else
        return 1
    end
end

_IsCriOrACT = function(cri, act, sourceLv, targetLv)
    return _TransCriAndACT(cri, sourceLv) > _TransCriAndACT(act, targetLv)
end

_TransCriAndACT = function(x, y)
    return x / (x + 60 * y + 50)
end

_IsPntOrBlk = function(pnt, blk, atk, def)
    local x, y = _TransPntOrBlk(pnt, def), _TransPntOrBlk(blk, atk)
    return (x > y) and (MathLib.Random() < x - y)
end

_TransPntOrBlk = function(x, y)
    return x / (2 * y)
end

_BoundaryDetermine = function(maxLife, atk, def, criProc)
    if atk < def then
        return math.max(1, 0.05 * atk)
    end
    local dmg = criProc * (atk - def)
    if dmg >= maxLife then
        return maxLife * 0.95
    end
    return dmg
end

_DealDamage = function(target, dmg)
    if dmg < target:get "生命" then
        target:set('生命', target:get "生命" - dmg)
    else
        cj.KillUnit(target.object)
    end
end

_Show = function(target, value, textType, scale)
    local text
    if type(value) == "string" then
        text = "|cffff0000" .. value .. "!"
    elseif textType == "法術" then
        text = "|cffffff00" .. math.modf(MathLib.Round(value))
    elseif textType == "混合" then
        text = "|cff8080c0" .. math.modf(MathLib.Round(value))
    else
        text = math.modf(MathLib.Round(value))
    end
    TextToAttachUnit(text, Point(cj.GetUnitX(target), cj.GetUnitY(target)), scale)
end

return Damage