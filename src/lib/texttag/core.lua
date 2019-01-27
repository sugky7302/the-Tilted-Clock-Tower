-- 擴展we的texttag的功能，提供最基本的漂浮文字功能，並建立回收機制
-- texttag最大只能到100個

-- package
local cj = require 'jass.common'
local Array = require 'stl.array'

local Texttag = require 'class'("Texttag")

-- assert
local executing_order = Array()
local New, Initialize
local RunTimer, PauseTimer, Expire
local GetEmptyTexttag, RecycleTexttag

-- 創建固定的漂浮文字
-- 不要重複使用漂浮文字，因為只要設定成不永久顯示，系統會自動刪除
function Texttag:_new(str, loc, dur, is_permanant)
    -- 子類不需要複製或創建，要做忽略判定
    if str then
        if type(str) == 'table' then
            self:_copy(str) 
        else
            New(self, str, loc, dur, is_permanant)
        end
    end

    self._invalid_ = false
    self._texttag_ = cj.CreateTextTag()

    self:Initialize()
    
    executing_order:PushBack(self)

    RunTimer(self)
end

New = function(self, str, loc, dur, is_permanant)
    self._msg_ = str
    self._loc_ = loc
    self._timeout_ = dur
    self._is_permanant_ = is_permanant and true or false
        
    self.Initialize = Initialize
    self.Update = nil
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

function Texttag:_delete()
    -- 回傳任務完成
    if self.handle_ then
        local TaskTracker = require 'task_tracker'
        TaskTracker.finish(self.handle_)
    end

    cj.DestroyTextTag(self._texttag_)
    self._loc_:Remove()
end

function Texttag:Invalid()
    self._invalid_ = true
end

return Texttag