local setmetatable = setmetatable
local string_rep = string.rep
local math_modf = math.modf
local cj = require 'jass.common'
local Texttag = require 'texttag'
local Point = require 'point'
local Color = require 'color'

local Bar, mt = {}, {}
setmetatable(Bar, Bar)
Bar.__index = mt

-- constants
mt.SIZE = 0.015
mt.Z_OFFSET = 150
mt.motivation = Point(-40, 0)
mt.BarSize = 25
mt.BarModel = "l"

-- variables
local _Initialize, _Update, _Remove, _GetBarModel

function Bar:__call(unit, timeout, color, isReverse)
    local obj = {
        msg = _GetBarModel(0, timeout, color, isReverse),
        loc = Point:GetUnitLoc(unit) + self.motivation,
        timeout = timeout,
        lifeTime = timeout,
        size = self.SIZE,
        Initialize = _Initialize,
        Update = _Update,
        Remove = _Remove,
        isReverse = isReverse,
        color = color,
        owner = unit,
        invalid = false,
    }
    setmetatable(obj, obj)
    obj.__index = self
    return Texttag(obj)
end

_Initialize = function(obj)
    cj.SetTextTagPermanent(obj.texttag, false)
    cj.SetTextTagLifespan(obj.texttag, obj.timeout)
    cj.SetTextTagText(obj.texttag, obj.msg, obj.size)
    cj.SetTextTagPos(obj.texttag, obj.loc.x, obj.loc.y, obj.Z_OFFSET)
end

_Update = function(data)
    data.loc = Point:GetUnitLoc(data.owner) + data.motivation
    cj.SetTextTagPos(data.texttag, data.loc.x, data.loc.y, data.Z_OFFSET)
    cj.SetTextTagText(data.texttag, _GetBarModel(data.lifeTime - data.timeout, data.lifeTime, data.color, data.isReverse), data.size)
end

_GetBarModel = function(current, timeout, color, isReverse)
    current = isReverse and (timeout - current) or current
    local dur = math_modf(Bar.BarSize * current / timeout)
    return Color(color) .. string_rep(Bar.BarModel, dur) .. "|r|cffc0c0c0" .. string_rep(Bar.BarModel, Bar.BarSize - dur)
end

_Remove = function(data)
    Texttag.Remove(data)
end

function mt:Break()
    self.invalid = true 
end

return Bar