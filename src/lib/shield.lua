local setmetatable = setmetatable
local string_rep = string.rep
local math_modf = math.modf
local cj = require 'jass.common'
local Texttag = require 'texttag'
local Point = require 'point'
local Color = require 'color'

local Shield, mt = {}, {}
setmetatable(Shield, Shield)
Shield.__index = mt

-- constants
mt.SIZE = 0.015
mt.Z_OFFSET = 150
mt.motivation = Point(-40, 0)
mt.BarSize = 25
mt.BarModel = "l"

-- variables
local _Initialize, _Update, _Remove, _GetBarModel

function Shield:__call(unit, value, timeout)
    local obj = {
        msg = _GetBarModel(0, value, "white"),
        loc = Point:GetUnitLoc(unit) + self.motivation,
        timeout = timeout,
        maxValue = value,
        size = self.SIZE,
        Initialize = _Initialize,
        Update = _Update,
        Remove = _Remove,
        color = "white",
        owner = unit,
        invalid = false,
    }
    unit:set("護盾", value)
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
    -- 如果護盾歸零就自動移除，不用再手動移除
    if data.owner:get "護盾" < 1 then
        data:Break()
        return 
    end
    data.loc = Point:GetUnitLoc(data.owner.object) + data.motivation
    cj.SetTextTagPos(data.texttag, data.loc.x, data.loc.y, data.Z_OFFSET)
    cj.SetTextTagText(data.texttag, _GetBarModel(data.maxValue - data.owner:get "護盾", data.maxValue, data.color), data.size)
end

function mt:Break()
    self.invalid = true 
end

_GetBarModel = function(current, maxValue, color)
    local dur = math_modf(mt.BarSize * current / maxValue)
    return Color(color) .. string_rep(mt.BarModel, dur) .. "|r|cffc0c0c0" .. string_rep(mt.BarModel, mt.BarSize - dur)
end

_Remove = function(data)
    Texttag.Remove(data)
end

return Shield