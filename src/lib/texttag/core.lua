-- 此module擴展we的texttag的功能，提供最基本的漂浮文字功能，並建立回收機制
-- texttag最大只能到100個

local setmetatable = setmetatable

local cj = require 'jass.common'
local Array = require 'stl.array'
local Queue = require 'stl.queue'

local Texttag, mt = {}, {}
setmetatable(Texttag, Texttag)
Texttag.__index = mt

-- assert
local executing_order, recycle_texttags = Array(), Queue()
local New, Initialize
local RunTimer, PauseTimer, Expire
local GetEmptyTexttag, RecycleTexttag

-- 創建固定的漂浮文字
function Texttag:__call(str, loc, dur, is_permanant)
    str = (type(str) == 'table') and str or New(self, str, loc, dur, is_permanant)
    str._invalid_ = false
    str._texttag_ = GetEmptyTexttag()

    setmetatable(str, self)
    str.__index = str

    str:Initialize()
    
    executing_order:PushBack(str)

    RunTimer(self)
    return str
end

GetEmptyTexttag = function()
    if recycle_texttags:IsEmpty() then
        return cj.CreateTextTag()
    end

    local texttag = recycle_texttags:front()
    recycle_texttags:PopFront()
    return texttag
end

New = function(self, str, loc, dur, is_permanant)
    local instance = {
        _msg_ = str,
        _loc_ = loc,
        _timeout_ = dur,
        _is_permanant_ = is_permanant and true or false,
        
        Initialize = Initialize,
        Update = nil
    }

    return instance
end

Initialize = function(self)
    local SIZE, Z_OFFSET = 0.05, 20
    local TIME_FADE = 0.3

    cj.SetTextTagText(self._texttag_, self._msg_, SIZE)
    cj.SetTextTagPos(self._texttag_, self._loc_.x_, self._loc_.y_, SIZE * Z_OFFSET)

    -- 設置結束點、淡出動畫時間
    cj.SetTextTagPermanent(self._texttag_, self._is_permanant_)
    cj.SetTextTagLifespan(self._texttag_, self._timeout_)
    cj.SetTextTagFadepoint(self._texttag_, TIME_FADE)
end

RunTimer = function(self)
    local PERIOD = 0.03

    -- 只有1個元素表示先前array是空的
    if executing_order:getLength() == 1 then
        local Timer = require 'timer.core'

        self._timer_ = Timer(PERIOD, true, function()
            local texttag
            for i = executing_order:getLength(), 1, -1 do
                texttag = executing_order[i]

                -- 永久性的漂浮文字不扣時間
                -- 有些會沒有is_permanent_參數，因此要用not，不能直接==false
                if not texttag._is_permanent_ then
                    texttag._timeout_ = texttag._timeout_ - PERIOD
                end

                -- 要根據所有的texttag plugin及外部調用此函數的結構來定下update_的參數
                if texttag.Update then
                    texttag:Update() 
                end

                Expire(self, texttag)
            end

            PauseTimer(self)
        end)
    end
end

Expire = function(self, texttag)
    if texttag._timeout_ <= 0 or texttag._invalid_ then
        texttag:Remove()
        executing_order:Delete(texttag)
    end
end

PauseTimer = function(self)
    -- 如果沒有漂浮文字運作，就關閉計時器
    if executing_order:IsEmpty() then
        self._timer_:Break()
    end 
end

function mt:Remove()
    RecycleTexttag(self._texttag_)
    self._loc_:Remove()

    local pairs = pairs
    for _, var in pairs(self) do
        var = nil
    end

    self = nil
end

RecycleTexttag = function(texttag)
    local MAX_COUNT = 100

    if recycle_texttags:getLength() >= MAX_COUNT then
        cj.DestroyTextTag(texttag)
    else
        -- 回收漂浮文字，減少ram開銷
        recycle_texttags:PushBack(texttag)
    end
end

function mt:Invalid()
    self._invalid_ = true
end

return Texttag