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
local _GetTalentsBonusInDef, _GetBuffInDef, _GetIndependentBonusInDef

-- obj 含 source(Hero type), target(Hero type), type, name, elementType, basicDamage, proc
function Damage:__call(obj)
    local atk, def = _ComputeAttack(obj), _ComputeDefense(obj)
    local dmg = _DamageDetermine(obj, atk, def)
    if type(dmg) != "string" then
        _DealDamage(obj.target, dmg)
    end
end

_ComputeAttack = function(obj)
    local atk
    if obj.type == "物理" then
        atk = (MathLib.Random(obj.source:get "最小物理攻擊力", obj.source:get "最大物理攻擊力") + obj.source:get "固定傷害") * _BODY_TYPE[obj.source:get "體型"][obj.target:get "體型"]
    elseif obj.type == "法術" then
        if type(obj.basicDamage) == "table" then
            obj.basicDamage = MathLib.Random(obj.basicDamage[1], obj.basicDamage[2])
        end
        atk = obj.basicDamage + obj.proc * obj.source:get "法術攻擊力"
    end
    local eAtk = _GetEAtk(obj)
    local part1 = (atk + eAtk + obj.source:get "額外傷害") * _GetTalentsBonusInAtk(obj.source) * _GetBuffInAtk(obj.source, obj.target)
    local part2 = obj.source:get("種族增傷", obj.target:get "種族") * obj.source:get("階級增傷", obj.target:get "階級") * obj.source:get "精通" 
    return  part1 * part2 * _GetIndependentBonusInAtk(obj.source) + obj.source:get "特殊傷害"
end

_GetIndependentBonusInAtk = function(source)
    -- local part1 = source:get "元素戒"
    -- local part2 = source:get "空虛之戒"
    -- return part1 * part2
    return 1
end

_GetEAtk = function(obj)
    return obj.source:get "元素傷害" * obj.source:get "元素增幅" * obj.target:get "元素抗性" * _ELEMENT_TYPE[obj.elementType][obj.target:get "元素屬性"]
end

_GetTalentsBonusInAtk = function(source)
    return 1
end

_GetBuffInAtk = function(source, target)
    return 1
end

_ComputeDefense = function(obj)
    local def, part3
    if obj.type == "物理" then
        def = obj.target:get "物理護甲" * _BODY_TYPE[obj.source:get "體型"][obj.target:get "體型"] * obj.target:get "增強物理護甲"
    elseif obj.type == "法術" then
        def = obj.target:get "法術護甲" * obj.target:get "增強法術護甲"
    end
    local part1 = def * _GetTalentsBonusInDef(obj.source) * _GetBuffInDef(obj.source, obj.target) * _GetIndependentBonusInDef(obj.source)
    local part2 = obj.source:get("種族減傷", obj.target:get "種族") * obj.source:get("階級減傷", obj.target:get "階級")
    return part1 * part2 + obj.target:get("額外" .. obj.type .. "護甲")
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
            return _BoundaryDetermine(obj.target:get "最大生命值", atk, 0, criProc)
        else
            return _BoundaryDetermine(obj.target:get "最大生命值", atk, def, criProc)
        end
    else
        return "閃避"
    end
end

_IsHitOrDodge = function(hit, dodge)
    if hit > dodge then
        return MathLib.Random() < 0.8 + _TransposeHitAndDodge(hit, dodge)
    elseif hit == dodge then
        return MathLib.Random() < 0.5
    else
        return not(MathLib.Random() < 0.8 + _TransposeHitAndDodge(dodge, hit))
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
    return _TransposeCriAndACT(cri, sourceLv) > _TransposeCriAndACT(act, targetLv)
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
        return 0.05 * atk * criProc
    end
    local dmg = criProc * (atk - def)
    if dmg >= maxLife then
        return dmg * 0.95
    end
    return dmg
end

_DealDamage = function(target, dmg)
    if target:get "生命" <= dmg then
        target:set("生命", -0.95 * target:get "生命")
    else
        target:set('生命', -dmg)
    end
end

return Damage
