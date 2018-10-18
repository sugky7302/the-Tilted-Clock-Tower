local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local Timer = require 'timer'
local Array = require 'array'

local Buff = {}
local mt = {}
setmetatable(Buff, Buff)
Buff.__index = mt 

-- variables
local _SetObject, _SetVariables, _FindQueue, _PushBuff, _SetBuff, _AddEffect, _AddArt, _RemoveArt

-- obj含name, type, owner, remaining, art, coverMode, pulse, callback(添加/刪除屬性), execute(持續觸發函數)
function Buff:__call(obj)
    _SetObject(obj)
    _SetBuff(obj)
    return obj
end

-- 實行策略同event
_SetObject = function(self)
    _SetVariables(self)
    local buff = _FindQueue(js.H2I(self.owner) .. "", self.name)
    _PushBuff(buff, self)
end

-- 設定預設值
_SetVariables = function(self)
    self.layer = 1
end

_FindQueue = function(label, buffName)
    local buffs = Buff[label]
    if not buffs then
        buffs = Array("buffs")
        Buff[label] = buffs
    end
    local buff = buffs[buffName]
    if not buff then
        buff = Array("buff")
        buffs[buffName] = buff
    end
    return buff
end

_PushBuff = function(buff, self)
    self.buff = buff
    buff:PushBack(self)
    setmetatable(self, Buff)
end

--[[
    Mode1(獨佔) 新效果不覆蓋舊效果
    Mode2(獨佔) 新效果覆蓋舊效果
    Mode3(獨佔) 新效果失敗，但更新舊效果，並將新效果的數據加給舊效果
    Mode4(獨佔) 新效果失敗，但更新舊效果，並將新效果的數據加給舊效果，不更新時間
    Mode5(共存) 互不干涉
]]
_SetBuff = function(self)
    local buff = self.buff
    if self.coverMode == 5 or buff[1] == self then
        _AddEffect(self)
    else
        if self.coverMode == 1 then
            if buff[1] ~= self then
                self:Remove()
            end
        elseif self.coverMode == 2 then
            if buff[1] ~= self then
                buff[1]:Remove()
                _AddEffect(self)
            end
        elseif self.coverMode == 3 then
            if buff[1] ~= self then
                buff[1].layer = buff[1].layer + 1
                buff[1]:on_cover()
                buff[1].timer:SetRemaining(self.remaining) -- TODO: timer要設定此函數
                self:Remove()
            end
        elseif self.coverMode == 4 then
            if buff[1] ~= self then
                self.layer = self.layer + 1
                self:on_cover()
                self:Remove()
            end
        end
    end
end

_AddEffect = function(self)
    self:on_add()
    _AddArt(self.owner, self.art)
    if self.type == "dot" then
        local count = self.remaining / self.pulse
        self.timer = Timer(self.pulse, count, function()
            if self.on_finish then
                self:on_finish()
            end
            if count < 1 then
                _RemoveArt(self.owner, self.art)
                self:on_remove()
            end
        end)
    else
        self.timer = Timer(self.remaining, false, function()
            _RemoveArt(self.owner, self.art)
            self:on_remove()
        end)
    end
end

_AddArt = function(owner, art)
    if art then
        cj.UnitAddAbility(owner, art)
    end
    return
end

_RemoveArt = function(owner, art)
    if art then
        cj.UnitRemoveAbility(owner, art)
    end
    return
end

function mt:Remove()
    self.buff:Erase(self)
    self = nil
end

return Buff
