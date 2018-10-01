        local setmetatable = setmetatable
        local math = math
        local cj = require 'jass.common'
        local Object = require 'object'
        local Texttag = require 'texttag'

        local TextToAttachUnit = {}
        local mt = {}
        setmetatable(TextToAttachUnit, TextToAttachUnit)
        TextToAttachUnit.__index = mt

        -- constants
        TextToAttachUnit.DEFAULT_ANGLE = math.pi / 2
        TextToAttachUnit.IS_ANGLE_RANDOM = true
        TextToAttachUnit.TIME_LIFE = 0.7
        TextToAttachUnit.TIME_FADE = 0.3
        TextToAttachUnit.VELOCITY = 5
        TextToAttachUnit.SIZE = 0.75
        TextToAttachUnit.SIZE_MIN = 0.018
        TextToAttachUnit.Z_OFFSET = 20
        TextToAttachUnit.SIZE_BONUS = 0.012
        TextToAttachUnit.Z_OFFSET_BONUS = 55
        TextToAttachUnit.PERIOD = 0.03125

        function TextToAttachUnit:__call(object, shieldValue, dur)
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
            setmetatable(obj, self)
            return obj
        end

        SetTexttag = function(self, obj)
            cj.SetTextTagPermanent(obj.texttag, false)
            cj.SetTextTagLifespan(obj.texttag, obj.timeout)
            cj.SetTextTagFadepoint(obj.texttag, self.TIME_FADE)
            cj.SetTextTagText(obj.texttag, obj.msg, obj.size * self.SIZE_MIN)
            cj.SetTextTagPos(obj.exttag, obj.offset.x, obj.offset.y, obj.size * self.Z_OFFSET)
        end

        Update = function(list, data)
            local trace = math.sin(math.pi * data.timeout) -- 文字的運動軌跡
            data.timeout = data.timeout - list.PERIOD
            data.loc = data.loc + data.offset
            cj.SetTextTagPos(data.texttag, data.loc.x, data.loc.y, data.size * (list.Z_OFFSET + list.Z_OFFSET_BONUS * trace))
            cj.SetTextTagText(data.texttag, data.msg, data.size * (list.SIZE_MIN + list.SIZE_BONUS * trace))
        end

        Remove = function()
        end

        return TextToAttachUnit