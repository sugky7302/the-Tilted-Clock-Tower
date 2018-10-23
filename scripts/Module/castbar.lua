local setmetatable = setmetatable
local string_rep = string.rep
local math_modf = math.modf
local cj = require 'jass.common'
local Texttag = require 'texttag'
local Point = require 'point'
local Color = require 'color'

local Castbar = {}
setmetatable(Castbar, Castbar)

-- constants
Castbar.SIZE = 0.9
Castbar.Z_OFFSET = 20
Castbar.barSize = 25
Castbar.barModel = "l"

-- variables
local _Initialize, _Update, _Remove, _GetCastbarModel

function Castbar:__call(unit, timeout, isReverse)
    local obj = {
        msg = _GetCastbarModel(0, timeout, isReverse or false),
        loc = Point:GetUnitLoc(unit),
        timeout = timeout,
        lifeTime = timeout,
        size = self.SIZE,
        Initialize = _Initialize,
        Update = _Update,
        Remove = _Remove,
        isReverse = isReverse or false,
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
    cj.SetTextTagText(data.texttag, _GetCastbarModel(data.lifeTime - data.timeout, data.lifeTime), data.size)
end

_GetCastbarModel = function(current, timeout, isReverse)
    local dur = math_modf(Castbar.barSize * (isReverse and (timeout - current) or current) / timeout)
    return Color("mediumblue") .. string_rep(Castbar.barModel, dur) .. "|r" .. string_rep(Castbar.barModel, Castbar.barSize - dur)
end

_Remove = function(data)
    Texttag.Remove(data)
end

return Castbar
    