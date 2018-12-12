-- 統一技能施放，細分施法階段

local setmetatable = setmetatable

local Skill, mt = {}, require 'skill.init'
setmetatable(Skill, Skill)
Skill.__index = mt

-- constants
mt.type_ = 'Skill'

-- assert
local _ChangeTurnRate, _CreateDummy, _ReductTurnRate, _ZoomDummy, _ResetAbility, _CheckSkillOrder, _SetProficiency

local EVENT_NAME = {
    ['施法開始'] = 'on_cast_start',
    ['施法引導'] = 'on_cast_channel',
    ['施法出手'] = 'on_cast_shot',
    ['施法完成'] = 'on_cast_finish',
    ['擊中單位'] = 'on_hit',
    ['造成傷害'] = 'on_deal_damage',
}

function Skill:__call(name)
    return function(instance)
        self[name] = instance

        local slk_ability = require 'jass.slk'.ability
        instance.name   = name
        instance.order_ = slk_ability[instance.order_id_].Order
        instance.order_ = (instance.order_ == "channel") and slk_ability[instance.order_id_].DataF
        instance.cool_  = slk_ability[instance.order_id_].Cool
        instance.blp_   = slk_ability[instance.order_id_].Art

        setmetatable(instance, self)
        instance.__index = instance

        return self[name]
    end
end

-- 複製一個skill副本，使連續施放技能互相獨立，這樣才不會報錯
function mt:New(hero, target_unit, target_loc)
    local instance = {
        owner_ = hero,
        target_unit_ = target_unit,
        target_loc_ = target_loc,
    }

    -- 寫入、讀取都操作在原skill上
    setmetatable(instance, instance)
    instance.__index = self
    instance.__newindex = self

    return instance
end

function mt:Remove()
    local pairs = pairs
    for _, var in pairs(self) do
        var = nil
    end

    -- 從玩家施法隊列中清除當前技能副本
    local table_remove = table.remove
    for i, skill in pairs(self.owner_.each_casting_) do 
        if v == self then
            table_remove(self.owner_.each_casting_, i)
            break
        end
    end
    
    self = nil
end

function mt:Break()
    if (self.breakCastStart == 1) and self.castStartTimer then
        self.castbar:Break()
        self.castStartTimer:Break()
        self:Remove()
    end
    if (self.breakCastChannel == 1) and self.castChannelTimer then
        self.castbar:Break()
        self.castChannelTimer:Break()
        self:Remove()
    end
    if (self.breakCastShot == 1) and self.castShotTimer then
        self.castbar:Break()
        self.castShotTimer:Break()
        self:Remove()
    end
end



function mt:EventDispatch(name, force, ...)
    force = force or false
    if not force then
        if self.invalid then
            return false
        end
    end
    name = _EventName[name]
    if self[name] then
        self[name](self, ...)
    else
        return false
    end
end

_SetProficiency = function(self)
    if self.level == self.maxLevel then
        return 
    end
    self.proficiency = self.proficiency + 1
    if self.proficiency >= self.proficiencyNeed[self.level] then
        self.proficiency = self.proficiency % self.proficiencyNeed[self.level]
        self.level = self.level + 1
        self:UpdateTip()
    end
    self:UpdateName()
    js.SelectUnitRemoveForPlayer(self.owner, self.owner.owner.object)
    js.SelectUnitAddForPlayer(self.owner, self.owner.owner.object)
end

function mt:UpdateName()
    local msg = self.name .. "(|cffffcc00" .. self.hotkey .. "|r) - [等級 |cffffcc00" .. self.level .. "|r"
    if self.level == self.maxLevel then
        msg = msg .."]"
    else
        msg = msg .. " - |cffffcc00" .. self.proficiency .. "|r/|cffffcc00" .. self.proficiencyNeed[self.level] .. "|r]"
    end
    japi.EXSetAbilityDataString(japi.EXGetUnitAbility(self.owner.object, Base.String2Id(self.orderId)), 1, 215, msg)
end

function mt:UpdateTip()
    local string_gsub, state = string.gsub
    if self.damage then
        state = string_gsub(self.tip, "N", self.damage[self.level][1] .. "-" .. self.damage[self.level][2]) -- 基礎傷害
        state = string_gsub(state, "P", self.proc .. "") -- 技能係數
    else
        state = self.tip
    end
    if self.owner.talents and self.owner.talents[self.hotkey] then -- 天賦
        state = state .. "|n"
        for _, talent in ipairs(self.owner.talents[self.hotkey]) do 
            state = state .. "|n|Cffffff00[" .. talent.name .. "]|r" .. talent.tip 
        end
    end
    japi.EXSetAbilityDataString(japi.EXGetUnitAbility(self.owner.object, Base.String2Id(self.orderId)), 1, 218, state)
end

function mt:MultiCast()
    if self.canMultiCast and (MathLib.Random(100) < self.multiCastChance) then
        self.__index.isMultiCast = true
        _ResetAbility(self.owner.object, Base.String2Id(self.orderId))
        _CheckSkillOrder(self.owner.object, self.order, self.targetUnit.object, self.targetLoc)
    end
end

_ResetAbility = function(unit, id)
    cj.UnitRemoveAbility(unit, id)
    cj.UnitAddAbility(unit, id)
end

_CheckSkillOrder = function(source, order, target, targetLoc)
    local immediateOrder = cj.IssueImmediateOrder(source, order) or nil
    local pointOrder = cj.IssuePointOrder(source, order, targetLoc.x, targetLoc.y) or nil
    local targetOrder = cj.IssueTargetOrder(source, order, target) or nil
end  

return Skill
