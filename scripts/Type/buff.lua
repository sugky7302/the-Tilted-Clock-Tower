local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local BuffLib = require 'buff_lib'
local Timer = require 'timer'
local Unit = require 'unit'

local Buff = {}
local mt = {}
setmetatable(Buff, Buff)
Buff.__index = mt 

local _GetObject, _GetPreviousObject, _GetNewObject

function Buff:__call(unit, buffName)
    local obj = _GetObject(unit, buffName)
    _Run(obj)
    return obj
end

-- 實行策略同event
_GetObject = function(unit, buffName)
    local buffs = Buff[js.H2I(unit) .. ""]
    if not buffs then
        buffs = Array("buffQueue")
        Buff[js.H2I(unit) .. ""] = buffs
    end
    local buffQueue = buffs[buffName]
    if not buffQueue then
        buff = Array("buff")
        buff.coverMode = BuffLib[buffName].coverMode
        buff.icon = BuffLib[buffName].icon
        buff.remaining = BuffLib[buffName].remaining
        buffs[buffName] = buff
        return _GetNewObject(buff, buffName)
    end
    return 
end

_GetNewObject = function(buff, buffName)
    local obj = {
        buff = buff,
        remaining = buff.remaining,
        layer = 1
    }
    buff:PushBack(obj)
    setmetatable(obj, Buff)
    obj.__index = obj
    return obj
end

--[[
    Mode1(獨佔) 新效果不覆蓋舊效果
    Mode2(獨佔) 新效果覆蓋舊效果
    Mode3(獨佔) 新效果失敗，但更新舊效果，並將新效果的數據加給舊效果
    Mode4(共存) 互不干涉
]]
_GetPreviousObject = function(obj)
    if obj.coverMode == 1 then
    elseif obj.coverMode == 2 then
    elseif obj.coverMode == 3 then
    elseif obj.coverMode == 4 then
    end
end

return Buff
