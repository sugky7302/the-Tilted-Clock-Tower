-- 模塊化施法階段。每個施法階段所有動作都完成後，才進下一個階段
-- 依賴
--   bar.castbar
--   timer.core
--   skill.util
--   task_tracker
--   jass_tool

-- package
local require = require
local Castbar = require 'bar.castbar'
local Timer = require 'timer.core'
local SkillUtil = require 'skill.util'
local TaskTracker = require 'task_tracker'


-- assert
local CastStart, CastChannel, CastShot, CastFinish, SetProficiency
local AddTask, CallEvent, CheckRootCast, RechooseHero, GetChannelTimer

local function Cast(self)
    -- 記錄某階段需要完成的任務數量
    -- 不用局域變量的原因是其他模塊也要用
    self.handle_ = Timer.frame()
    TaskTracker(self.handle_)

    local PERIOD = 0.01
    local stage = 1
    Timer(PERIOD, true, function(callback)
        if TaskTracker.IsCompleted(self.handle_) then
            stage = stage + 1

            -- 使用狀態機
            -- 要先重置追蹤器再調用事件，反過來的話，任務數量=-1，永遠完成不了
            if stage == 2 then
                TaskTracker(self.handle_)
                CastChannel(self)
            else if stage == 3 then
                TaskTracker(self.handle_)
                CastShot(self)
            else if stage == 4 then
                TaskTracker(self.handle_)
                CastFinish(self)
            else if stage == 5 then
                TaskTracker.Remove(self.handle_)
                self:Remove()
                callback:Break()
            end
        end
    end)
    
    CastStart(self)
end

CastStart = function(self)
    -- 判斷需不需要引導
    if self.cast_start_time_ <= 0 then
        -- 調用動作
        CallEvent(self, "技能-施法開始")
        return 
    end

    self.castbar_ = Castbar(self.owner_, self.cast_start_time_, true)

    -- 傳遞索引，方便回傳完成狀態
    AddTask(self.castbar_, self.handle_)

    -- 是否定身施法
    CheckRootCast(self, self.cast_start_time_)

    -- 調用動作
    CallEvent(self, "技能-施法開始")

    -- 設置引導時間，時間到轉下個施法階段
    -- 可以被打斷
    -- 延遲轉階段，讓事件內的計時器動作完成
    self.cast_start_timer_ = Timer(self.cast_start_time_, false, function()
        TaskTracker.finish(self.handle_)
    end)

    -- 傳遞索引，方便回傳完成狀態
    AddTask(self.cast_start_timer_, self.handle_)
end

CastChannel = function(self)
    -- 判斷需不需要引導
    if self.cast_channel_time_ <= 0 then
        -- 調用動作
        CallEvent(self, "技能-施法引導")
        return 
    end

    self.castbar_ = Castbar(self.owner_, self.cast_channel_time_, true)

    -- 傳遞索引，方便回傳完成狀態
    AddTask(self.castbar_, self.handle_)

    -- 是否定身施法
    CheckRootCast(self, self.cast_channel_time_)

    -- 設置引導時間，時間到轉下個施法階段
    -- 可以被打斷
    -- 某些持續技能如 暴風雪 會在引導階段播放效果，因此可以透過cast_pulse_使動作函數和動畫效果一致
    self.cast_channel_timer_ = GetChannelTimer(self, "技能-施法引導", self.cast_channel_time_, self.cast_pulse_)
end

CastShot = function(self)
    -- 判斷需不需要引導
    if self.cast_shot_time_ <= 0 then
        -- 調用動作
        CallEvent(self, "技能-施法出手")
        return 
    end

    self.castbar_ = Castbar(self.owner_, self.cast_shot_time_, true)

    -- 傳遞索引，方便回傳完成狀態
    AddTask(self.castbar_, self.handle_)

    -- 是否定身施法
    CheckRootCast(self, self.cast_shot_time_)

    -- 設置引導時間，時間到轉下個施法階段
    -- 可以被打斷
    -- 某些持續技能效果會在出手階段播放效果，因此可以透過cast_pulse_使動作函數和動畫效果一致
    self.cast_shot_timer_ = GetChannelTimer(self, "技能-施法出手", self.cast_shot_time_, self.cast_pulse_)
end

CheckRootCast = function(self, dur)
    if self.break_move_ == 1 then
        SkillUtil.RootCast(self, dur)

        -- 傳遞索引，方便回傳完成狀態
        AddTask(self.root_cast_timer_, self.handle_)
    end
end

CallEvent = function(self, event_name)
    TaskTracker.add(self.handle_)
    self:EventDispatch(event_name)
    TaskTracker.finish(self.handle_)
end

GetChannelTimer = function(self, event_name, dur, pulse)
    return Timer(pulse, dur / pulse,
        function(callback)
            -- 調用動作
            self:EventDispatch(event_name)

            -- 回報任務完成
            if callback.is_period_ < 1 then
                TaskTracker.finish(self.handle_)
            end
        end)
end

CastFinish = function(self)
    -- 調用動作
    TaskTracker.add(self.handle_)
    self:EventDispatch "技能-施法完成"

    -- 設定技能熟練度
    SetProficiency(self)

    -- 判定能不能多重施法
    SkillUtil.MultiCast(self)

    -- 回報任務完成
    TaskTracker.finish(self.handle_)
end

SetProficiency = function(self)
    -- 檢查技能是不是生滿了
    if self.level_ == self.max_level_ then
        return false
    end

    -- 增加熟練度
    self.proficiency_ = self.proficiency_ + 1

    -- 檢查是不是可以升級了
    if self.proficiency_ >= self.proficiency_need_[self.level_] then
        -- 升級
        self.proficiency_ = self.proficiency_ % self.proficiency_need_[self.level_]
        self.level_ = self.level_ + 1

        -- 更新技能描述
        self:UpdateTip()
    end

    -- 更新技能等級與熟練度
    self:UpdateName()

    -- 要重新選取，技能說明才會更新
    RechooseHero(self.owner_)
end

AddTask = function(object, handle)
    object.handle_ = handle
    TaskTracker.add(handle)
end

RechooseHero = function(hero)
    local js = require 'jass_tool'
    js.SelectUnitRemoveForPlayer(hero, hero.owner_.object_)
    js.SelectUnitAddForPlayer(hero, hero.owner_.object_)
end

return Cast