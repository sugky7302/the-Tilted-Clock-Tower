        local math = math
        local table = table
        local setmetatable = setmetatable
        local cj = require 'jass.common'
        local Point = require 'point'
        local Timer = require 'timer'
        local List = require 'list'
        local Object = require 'object'
        local Texttag = {}
        local mt = {}
        setmetatable(Texttag, Texttag)
        Texttag.__index = mt
        -- 本地變量
        Texttag.executingOrder = List()
        -- 常數
        Texttag.DEFAULT_ANGLE = math.pi / 2
        Texttag.IS_ANGLE_RANDOM = true
        Texttag.TIME_LIFE = 0.7
        Texttag.TIME_FADE = 0.3
        Texttag.VELOCITY = 5
        Texttag.SIZE = 0.75
        Texttag.SIZE_MIN = 0.018
        Texttag.Z_OFFSET = 20
        Texttag.SIZE_BONUS = 0.012
        Texttag.Z_OFFSET_BONUS = 55
        Texttag.PERIOD = 0.03125
        local IsPauseTimer, IsExpired, Update, SetTexttag, RunTimer
        function Texttag:__call(str, loc, scale)
            local angle = (self.IS_ANGLE_RANDOM and cj.GetRandomReal(0, 2*math.pi) or self.DEFAULT_ANGLE)
            scale = scale or 1
            local obj = Object{
                msg = str,
                loc = loc,
                timeout = self.TIME_LIFE,
                offset = Point(math.cos(angle) * self.VELOCITY, math.sin(angle) * self.VELOCITY), 
                size = self.SIZE * scale,
            }
            setmetatable(obj, self)
            obj.__index = obj
            self.executingOrder:PushBack(obj)
            SetTexttag(self, obj)
            RunTimer(self)
            return obj
        end
        SetTexttag = function(self, obj)
            obj.texttag = cj.CreateTextTag()
            cj.SetTextTagPermanent(obj.texttag, false)
            cj.SetTextTagLifespan(obj.texttag, obj.timeout)
            cj.SetTextTagFadepoint(obj.texttag, self.TIME_FADE)
            cj.SetTextTagText(obj.texttag, obj.msg, obj.size * self.SIZE_MIN)
            cj.SetTextTagPos(obj.exttag, obj.offset.x, obj.offset.y, obj.size * self.Z_OFFSET)
        end
        RunTimer = function(self)
            if self.executingOrder:GetSize() < 2 then --啟動計時器
                self.timer = Timer(self.PERIOD, true, function()
                    for node in self.executingOrder:Iterator() do
                        Update(self, node.data)
                        IsExpired(self, node)
                    end
                    IsPauseTimer(self)
                end)
            end
        end
        Update = function(list, data)
            local trace = math.sin(math.pi * data.timeout) -- 文字的運動軌跡
            data.timeout = data.timeout - list.PERIOD
            data.loc = data.loc + data.offset
            cj.SetTextTagPos(data.texttag, data.loc.x, data.loc.y, data.size * (list.Z_OFFSET + list.Z_OFFSET_BONUS * trace))
            cj.SetTextTagText(data.texttag, data.msg, data.size * (list.SIZE_MIN + list.SIZE_BONUS * trace))
        end
        IsExpired = function(self, node)
            if node.data.timeout <= 0 then
                self.executingOrder:Erase(node)
            end
        end
        IsPauseTimer = function(self)
            if self.executingOrder:IsEmpty() then -- 如果沒有漂浮文字運作，就關閉計時器
                self.timer:Pause()
            end 
        end
        function mt:Remove()
            self.loc:Remove()
            self.offset:Remove()
            cj.DestroyTextTag(self.texttag)
            self.texttag = nil
            self = nil
        end
        return Texttag
    