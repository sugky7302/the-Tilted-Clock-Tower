-- 屬性判定

local Checker = {}

-- assert
local require = require
local IsDodge, IsCri, IsPnt, CheckBoundary

function Checker.Damage(self, atk, def)
    -- 閃避判定
    if IsDodge(self.source_:get "命中", self.target_:get "閃避") then
        return "閃避", 1
    end

    -- 命中判定通過
    -- 暴擊與韌性判定
        local cri_proc = IsCri(self.source_:get(self.type_ .. "暴擊"), self.target_:get(self.type_ .. "韌性"),
                               self.source_:get "等級", self.target_:get "等級")
   
    -- 穿透與格擋判定
    if IsPnt(self.source_:get(self.type_ .. "穿透"), self.target_:get(self.type_ .. "格擋"), atk, def) then
        return CheckBoundary(self.target_:get "生命上限", atk, 0, cri_proc), cri_proc
    end
    
    -- 格擋判定通過
    return CheckBoundary(self.target_:get "生命上限", atk, def, cri_proc), cri_proc
end

local Conversion = require 'combat.conversion'
local Rand = require 'math_lib'.Random

IsDodge = function(hit, dodge)
    -- 閃避>命中，機率從80%++
    if hit < dodge then
        return Rand(100) < 80 + 100 * Conversion.Hit_Dodge(dodge, hit)
    end

    -- 閃避=命中，機率固定50%
    if hit == dodge then
        return Rand(100) < 51
    end
    
    -- 閃避<命中，機率從20%--
    if hit > dodge then
        return not(Rand(100) < 80 + 100 * Conversion.Hit_Dodge(hit, dodge))
    end
end

-- 暴擊倍率在這調
IsCri = function(cri, act, source_lv, target_lv)
    if Conversion.Cri_ACT(cri, source_lv) > Conversion.Cri_ACT(act, target_lv) then
        return 2
    end

    return 1
end

IsPnt = function(pnt, blk, atk, def)
    local pnt_chance, blk_chance = Conversion.Pnt_Blk(pnt, def), Conversion.Pnt_Blk(blk, atk)
    return (pnt_chance > blk_chance) and (Rand(100) < 100 * (pnt_chance - blk_chance))
end

CheckBoundary = function(max_life, atk, def, cri_proc)
    local BoundValue = require 'math_lib'.BoundValue

    -- 傷害值在[5%攻擊力, 95%最大生命值]之間，防止0傷害值或秒殺
    return BoundValue(0.05 * atk, cri_proc * (atk - def), 0.95 * max_life)
end

function Checker.Heal()
end

return Checker