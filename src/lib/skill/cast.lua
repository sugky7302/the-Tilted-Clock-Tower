-- 模塊化施法階段。每個施法階段所有動作都完成後，才進下一個階段

-- package
local Castbar = require 'bar.castbar'
local Timer = require 'timer.core'
local SkillUtil = require 'skill.util'
local TaskTracker = require 'task_tracker'

-- assert
local CastStart, CastChannel, CastShot, CastFinish, SetProficiency
local AddTask

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

            -- 要先重置追蹤器再調用事件，反過來的話，任務數量=-1，永遠完成不了
            if stage == 2 then
                TaskTracker(self.handle_)
                CastChannel(self)
            end

            if stage == 3 then
                TaskTracker(self.handle_)
                CastShot(self)
            end

            if stage == 4 then
                TaskTracker(self.handle_)
                CastFinish(self)
            end

            if stage == 5 then
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
    if self.cast_start_time_ > 0 then
        self.castbar_ = Castbar(self.owner_, self.cast_start_time_, true)

        -- 傳遞索引，方便回傳完成狀態
        AddTask(self.castbar_, self.handle_)

        -- 是否定身施法
        if self.break_move_ == 1 then
            SkillUtil.RootCast(self, self.cast_start_time_)

            -- 傳遞索引，方便回傳完成狀態
            AddTask(self.root_cast_timer_, self.handle_)
        end

        -- 調用動作
        TaskTracker.add(self.handle_)
        self:EventDispatch "技能-施法開始"
        TaskTracker.finish(self.handle_)

        -- 設置引導時間，時間到轉下個施法階段
        -- 可以被打斷
        -- 延遲轉階段，讓事件內的計時器動作完成
        self.cast_start_timer_ = Timer(self.cast_start_time_, false, function()
            TaskTracker.finish(self.handle_)
        end)

        -- 傳遞索引，方便回傳完成狀態
        AddTask(self.cast_start_timer_, self.handle_)
    else
        -- 調用動作
        TaskTracker.add(self.handle_)
        self:EventDispatch "技能-施法開始"
        TaskTracker.finish(self.handle_)
    end
end

CastChannel = function(self)
    -- 判斷需不需要引導
    if self.cast_channel_time_ > 0 then
        self.castbar_ = Castbar(self.owner_, self.cast_channel_time_, true)

        -- 傳遞索引，方便回傳完成狀態
        AddTask(self.castbar_, self.handle_)

        -- 是否定身施法
        if self.break_move_ == 1 then
            SkillUtil.RootCast(self, self.cast_channel_time_)

            -- 傳遞索引，方便回傳完成狀態
            AddTask(self.root_cast_timer_, self.handle_)
        end

        -- 設置引導時間，時間到轉下個施法階段
        -- 可以被打斷
        -- 某些持續技能如 暴風雪 會在引導階段播放效果，因此可以透過cast_pulse_使動作函數和動畫效果一致
        self.cast_channel_timer_ = Timer(self.cast_pulse_, self.cast_channel_time_ / self.cast_pulse_,
            function(callback)
                -- 調用動作
                self:EventDispatch "技能-施法引導"

                -- 回報任務完成
                if callback.is_period_ < 1 then
                    TaskTracker.finish(self.handle_)
                end
            end)
    else
        -- 調用動作
        TaskTracker.add(self.handle_)
        self:EventDispatch "技能-施法引導"
        TaskTracker.finish(self.handle_)
    end
end

CastShot = function(self)
    -- 判斷需不需要引導
    if self.cast_shot_time_ > 0 then
        self.castbar_ = Castbar(self.owner_, self.cast_shot_time_, true)

        -- 傳遞索引，方便回傳完成狀態
        AddTask(self.castbar_, self.handle_)

        -- 是否定身施法
        if self.break_move_ == 1 then
            SkillUtil.RootCast(self, self.cast_shot_time_)

            -- 傳遞索引，方便回傳完成狀態
            AddTask(self.root_cast_timer_, self.handle_)
        end

        -- 設置引導時間，時間到轉下個施法階段
        -- 可以被打斷
        -- 某些持續技能效果會在出手階段播放效果，因此可以透過cast_pulse_使動作函數和動畫效果一致
        self.cast_shot_timer_ = Timer(self.cast_pulse_, self.cast_shot_time_ / self.cast_pulse_,
            function(callback)
                -- 調用動作
                self:EventDispatch "技能-施法出手"

                -- 回報任務完成
                if callback.is_period_ < 1 then
                    TaskTracker.finish(self.handle_)
                end
            end)
    else
        -- 調用動作
        TaskTracker.add(self.handle_)
        self:EventDispatch "技能-施法出手"
        TaskTracker.finish(self.handle_)
    end
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
    local js = require 'jass_tool'
    js.SelectUnitRemoveForPlayer(self.owner_, self.owner_.owner_.object_)
    js.SelectUnitAddForPlayer(self.owner_, self.owner_.owner_.object_)
end

AddTask = function(object, handle)
    object.handle_ = handle
    TaskTracker.add(handle)
end

return Cast