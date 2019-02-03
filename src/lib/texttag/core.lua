-- 擴展we的texttag的功能，提供最基本的漂浮文字功能，並建立回收機制
-- texttag最大只能到100個
-- 依賴
--   jass.common
--   timer.core
--   task_tracker


-- package
local require = require
local cj = require 'jass.common'


local Texttag = require 'class'("Texttag")

-- assert
local New, Initialize
local RunTimer, Expire

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

    local Timer = require 'timer.core'

    self._timer_ = Timer(PERIOD, true, function()
        -- 永久性的漂浮文字不扣時間
        -- 有些會沒有is_permanent_參數，因此要用not，不能直接==false
        if not self._is_permanent_ then
            self._timeout_ = self._timeout_ - PERIOD
        end

        -- 要根據所有的texttag plugin及外部調用此函數的結構來定下update_的參數
        if self.Update then
            self:Update() 
        end

        Expire(self)
    end)
end

Expire = function(self)
    if self._timeout_ <= 0 or self._invalid_ then
        self._timer_:Break()
        self:Remove()
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

function Texttag:Break()
    self._invalid_ = true
end

return Texttag