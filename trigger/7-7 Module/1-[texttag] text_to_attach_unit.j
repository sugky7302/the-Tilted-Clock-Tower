<?
    import 'text_to_attach_unit.lua' [==[
        local setmetatable = setmetatable
        local math = math
        local cj = require 'jass.common'
        local Object = require 'object'
        local Texttag = require 'texttag'
        local Point = require 'point'

        local TextToAttachUnit = {}
        setmetatable(TextToAttachUnit, TextToAttachUnit)

        -- constants
        TextToAttachUnit.DEFAULT_ANGLE = math.pi / 2
        TextToAttachUnit.IS_ANGLE_RANDOM = true
        TextToAttachUnit.TIME_LIFE = 0.7
        TextToAttachUnit.TIME_FADE = 0.3
        TextToAttachUnit.VELOCITY = 5
        TextToAttachUnit.SIZE = 0.9
        TextToAttachUnit.SIZE_MIN = 0.018
        TextToAttachUnit.Z_OFFSET = 20
        TextToAttachUnit.SIZE_BONUS = 0.012
        TextToAttachUnit.Z_OFFSET_BONUS = 55

        function TextToAttachUnit:__call(str, loc, scale)
            local angle = (self.IS_ANGLE_RANDOM and cj.GetRandomReal(0, 2*math.pi) or self.DEFAULT_ANGLE)
            scale = scale or 1
            local obj = Object{
                msg = str,
                loc = loc,
                timeout = self.TIME_LIFE,
                offset = Point(math.cos(angle) * self.VELOCITY, math.sin(angle) * self.VELOCITY), 
                size = self.SIZE * scale,
                Initialize = Initialize,
                Update = Update,
                Remove = Remove
            }
            setmetatable(obj, obj)
            obj.__index = self
            return Texttag(obj)
        end

        Initialize = function(obj)
            cj.SetTextTagPermanent(obj.texttag, false)
            cj.SetTextTagLifespan(obj.texttag, obj.timeout)
            cj.SetTextTagFadepoint(obj.texttag, obj.TIME_FADE)
            cj.SetTextTagText(obj.texttag, obj.msg, obj.size * obj.SIZE_MIN)
            cj.SetTextTagPos(obj.texttag, obj.loc.x, obj.loc.y, obj.size * obj.Z_OFFSET)
        end

        Update = function(data)
            local trace = math.sin(math.pi * data.timeout) -- 文字的運動軌跡
            data.loc = data.loc + data.offset
            cj.SetTextTagPos(data.texttag, data.loc.x, data.loc.y, data.size * (data.Z_OFFSET + data.Z_OFFSET_BONUS * trace))
            cj.SetTextTagText(data.texttag, data.msg, data.size * (data.SIZE_MIN + data.SIZE_BONUS * trace))
        end

        Remove = function(data)
            Texttag.Remove(data)
        end

        return TextToAttachUnit
    ]==]
?>