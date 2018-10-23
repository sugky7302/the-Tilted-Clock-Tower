local math = math
local setmetatable = setmetatable
local cj = require 'jass.common'
local Timer = require 'timer'
local List = require 'list'
local Object = require 'object'

local Texttag = {}
local mt = {}
setmetatable(Texttag, Texttag)
Texttag.__index = mt

-- constants
Texttag.PERIOD = 0.03
Texttag.TIME_FADE = 0.3
Texttag.SIZE = 0.05
Texttag.Z_OFFSET = 20

-- variables
Texttag.executingOrder = List()
local _IsPauseTimer, _IsExpired, Initialize, Update

-- TODO:核心提供最基本的漂浮文字功能，在固定點創建有時間性的固定漂浮文字
function Texttag:__call(str, loc, dur, isPermanant)
    str = (type(str) == 'table') and str or self:New(str, loc, dur, isPermanant)
    str.invalid = false
    str.texttag = cj.CreateTextTag() 
    str:Initialize()
    self.executingOrder:PushBack(str)
    self:RunTimer()
    return str
end

function mt:New(str, loc, dur, isPermanant)
    local obj = Object{
        msg = str,
        loc = loc,
        timeout = dur,
        isPermanant = isPermanant and true or false,
        Initialize = _Initialize,
        Update = _Update
    }
    setmetatable(obj, obj)
    obj.__index = self
    return obj
end

_Initialize = function(obj) 
    cj.SetTextTagText(obj.texttag, obj.msg, obj.SIZE)
    cj.SetTextTagPos(obj.texttag, obj.loc.x, obj.loc.y, obj.SIZE * obj.Z_OFFSET)
    cj.SetTextTagPermanent(obj.texttag, obj.isPermanant)
    cj.SetTextTagLifespan(obj.texttag, obj.timeout)
    cj.SetTextTagFadepoint(obj.texttag, obj.TIME_FADE)
end

_Update = function(data)
end

function Texttag:RunTimer()
    if self.executingOrder:GetSize() < 2 then --啟動計時器
        self.timer = Timer(self.PERIOD, true, function()
            for node in self.executingOrder:Iterator() do
                if not node.data.isPermanent then
                    node.data.timeout = node.data.timeout - self.PERIOD
                end
                node.data.Update(node.data) -- TODO: 要根據所有的texttag plugin及外部調用此函數的結構來定下Update的參數。
                _IsExpired(self, node)
            end
            _IsPauseTimer(self)
        end)
    end
end

_IsExpired = function(self, node)
    if node.data.timeout <= 0 or node.data.invalid then
        node.data:Remove()
        self.executingOrder:Erase(node)
    end
end

_IsPauseTimer = function(self)
    if self.executingOrder:IsEmpty() then -- 如果沒有漂浮文字運作，就關閉計時器
        self.timer:Remove()
    end 
end

function mt:Remove()
    cj.DestroyTextTag(self.texttag)
    self.texttag = nil
    self = nil
    collectgarbage("collect")
end

function mt:Break()
    self.invalid = true
end

return Texttag