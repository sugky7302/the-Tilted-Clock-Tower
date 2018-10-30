local setmetatable = setmetatable
local table = table
local cj = require 'jass.common'
local js = require 'jass_tool'
local japi = require 'jass.japi'
local slk = require 'jass.slk'
local Castbar = require 'castbar'
local Timer = require 'timer'
local MathLib = require 'math_lib'

local Skill = {}
local mt = {}
setmetatable(Skill, Skill)
Skill.__index = mt

-- defaultValues
mt.type = 'skill'       -- 類型
mt.name = ''            -- 技能名
mt.hotkey = ""          -- 快捷鍵
mt.cool = 0             -- 冷卻時間
mt.level = 1            -- 等級
mt.maxLevel = 5         -- 最高等級
mt.proficiency = 0      -- 當前熟練度
mt.proficiencyNeed = 0  -- 所需熟練度
mt.tip = ""             -- 技能說明
mt.disBlp = nil         -- 暗圖標
mt.canUse = true        -- 判斷能否使用
mt.castPulse = 1        -- 施法計時器間隔
mt.castStartTime = 0    -- 施法開始
mt.castChannelTime = 0  -- 施法引導
mt.castShotTime = 0     -- 施法出手
mt.castFinishTime = 0   -- 施法完成
mt.breakMove = 1        -- 打斷移動
mt.breakOrder = 0       -- 不恢復指令
mt.castbar = nil        -- 施法時間條
mt.canMultiCast = false -- 是否能多重施法
mt.multiCastChance = 0  -- 多重施法機率，每次接獨立計算
mt.multiCastCount = 0   -- 多重施法次數
mt.isMultiCast = false  -- 是否在多重施法
mt.multiCastText = nil  -- 多重施法漂浮文字

-- 某個階段是否可以被打斷
mt.breakCastStart = 0
mt.breakCastChannel = 0
mt.breakCastShot = 0
mt.breakCastFinish = 1

-- variables
local _ChangeTurnRate, _CreateDummy, _ReductTurnRate, _ZoomDummy, _ResetAbility, _CheckSkillOrder, _SetProficiency
local _EventName = {
    ['施法開始'] = 'on_cast_start',
    ['施法引導'] = 'on_cast_channel',
    ['施法出手'] = 'on_cast_shot',
    ['施法完成'] = 'on_cast_finish',
    ['擊中單位'] = 'on_hit',
    ['造成傷害'] = 'on_deal_damage',
}

function Skill.Init()
    local Game = require 'game'
    Game:Event "單位-發布命令" (function(self, unit, order, target)
        -- 中斷施法
        if (order == Base.String2OrderId('smart')) or (order == Base.String2OrderId('stop')) or (order == Base.String2OrderId('attack')) then
            for _, skill in ipairs(unit.eachCasting) do
                skill:Break()
            end
        end
    end)
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

function Skill:__call(name)
    return function(obj)
        self[name] = obj
        obj.name = name
        obj.order = slk.ability[obj.orderId].Order
        obj.order = (obj.order == "channel") and slk.ability[obj.orderId].DataF
        obj.cool = slk.ability[obj.orderId].Cool
        obj.blp = slk.ability[obj.orderId].Art
        setmetatable(obj, self)
        obj.__index = obj
        return self[name]
    end
end

function Skill:__tostring()
    return self.name
end

function mt:New(hero, targetUnit, targetLoc)
    local obj = {
        owner = hero,
        targetUnit = targetUnit,
        targetLoc = targetLoc,
        multiCastChance = multiCastChance,
    }
    setmetatable(obj, obj)
    obj.__index = self
    obj.__newindex = self
    return obj
end

function mt:ChangeModel(unit, model)
    local slk = require 'jass.slk'
    slk.ability.AEme.DataA1 = model
    slk.ability.AEme.UnitID1 = Base.Id2String(U2Id(unit))
    slk.ability.AEme.DataE1 = 0
    cj.UnitAddAbility(unit, Base.String2Id('AEme'))
    cj.UnitRemoveAbility(unit, Base.String2Id('AEme'))
end

function mt:_cast_start()
    if self.castStartTime > 0 then
        self.castbar = Castbar(self.owner.object, self.castStartTime, true)
        -- 是否定身施法
        if self.breakMove == 1 then
            self:RootCast(self.castStartTime)
        end
        -- 調用動作
        self:EventDispatch "施法開始"
        -- 看能不能被打斷
        self.castStartTimer = Timer(self.castStartTime, false, function(callback)
            self:_cast_channel()
        end)
        
    else
        self:EventDispatch "施法開始"
        self:_cast_channel()
    end
end

function mt:_cast_channel()
    if self.castChannelTime > 0 then
        self.castbar = Castbar(self.owner.object, self.castChannelTime, true)
        -- 是否定身施法
        if self.breakMove == 1 then
            self:RootCast(self.castChannelTime)
        end
        self.castChannelTimer = Timer(self.castPulse, self.castChannelTime / self.castPulse, function(callback)
            self:EventDispatch "施法引導"
            if callback.isPeriod == 0 then
                self:_cast_shot()
            end
        end)
    else
        self:EventDispatch "施法引導"
        self:_cast_shot()
    end
end

function mt:_cast_shot()
    if self.castShotTime > 0 then
        self.castbar = Castbar(self.owner.object, self.castShotTime)
        -- 是否定身施法
        if self.breakMove == 1 then
            self:RootCast(self.castShotTime)
        end
        -- 看能不能被打斷
        self.castShotTimer = Timer(self.castPulse, self.castShotTime / self.castPulse, function(callback)
            self:EventDispatch "施法出手"
            if callback.isPeriod < 1 then
                self:_cast_finish()
            end
        end)
    else
        self:EventDispatch "施法出手"
        self:_cast_finish()
    end
end

function mt:RootCast(timeout)
    local period, turnRate = 0.1, _ChangeTurnRate(self.owner)
    local dummy = _CreateDummy(self.owner)
    self.rootCastTimer = Timer(period, timeout / period, function(callback)
        _ZoomDummy(dummy, timeout - callback.isPeriod * period)
        if (self.castbar and self.castbar.invalid) or (callback.isPeriod < 1) then
            _ReductTurnRate(self.owner, turnRate)
            js.RemoveUnit(dummy)
        end
    end)
end

_ChangeTurnRate = function(hero)
    local turnRate = 0.5
    japi.EXSetUnitMoveType(hero.object, 0x01)
    hero:set("轉身速度", 0)
    return turnRate
end

_CreateDummy = function(hero)
    local dummy = cj.CreateUnit(hero.owner.object, Base.String2Id('u009'), cj.GetUnitX(hero.object) - 16, cj.GetUnitY(hero.object) - 16, cj.GetUnitFacing(hero.object))
    return dummy
end

_ZoomDummy = function(dummy, dur)
    local scale = (dur % 2 <= 1) and dur % 2 or -1 * (dur % 2) + 2
    cj.SetUnitScale(dummy, 1 + scale, 1 + scale, 1)
end

_ReductTurnRate = function(hero, turnRate)
    japi.EXSetUnitMoveType(hero.object, 0x02)
    hero:set("轉身速度", turnRate)
end

function mt:_cast_finish()
    self:EventDispatch "施法完成"
    _SetProficiency(self)
    self:Remove()
    self:MultiCast()
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
    local string_gsub = string.gsub
    local state = string_gsub(self.tip, "N", self.damage[self.level][1] .. "-" .. self.damage[self.level][2]) -- 基礎傷害
    state = string_gsub(state, "P", self.proc .. "") -- 技能係數
    if self.owner.talents and self.owner.talents[self.hotkey] then -- 天賦
        state = state .. "|n"
        for _, talent in ipairs(self.owner.talents[self.hotkey]) do 
            state = state .. "|n|Cffffff00[" .. talent.name .. "]|r" .. talent.tip 
        end
    end
    japi.EXSetAbilityDataString(japi.EXGetUnitAbility(self.owner.object, Base.String2Id(self.orderId)), 1, 218, state)
end

function mt:Remove()
    self.rootCastTimer = nil
    self.castStartTimer = nil
    self.castChannelTimer = nil
    self.castShotTimer = nil
    self.castbar = nil
    for i, v in ipairs(self.owner.eachCasting) do 
        if v == self then
            table.remove(self.owner.eachCasting, i)
            break
        end
    end
    self = nil
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
