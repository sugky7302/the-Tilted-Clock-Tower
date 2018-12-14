-- 模塊化施法階段

-- package
local Castbar = require 'bar.castbar'
local Timer = require 'timer.core'
local SkillUtil = require 'skill.util'

-- assert
local CastChannel, CastShot, CastFinish, SetProficiency

local function CastStart(self)

    -- 判斷需不需要引導
    if self.cast_start_time_ > 0 then
        self.castbar_ = Castbar(self.owner_, self.cast_start_time_, true)

        -- 是否定身施法
        if self.break_move_ == 1 then
            SkillUtil.RootCast(self, self.cast_start_time_)
        end

        -- 調用動作
        self:EventNotify "施法開始"

        -- 設置引導時間，時間到轉下個施法階段
        -- 可以被打斷
        self.cast_start_timer_ = Timer(self.cast_start_time_, false, function()
            CastChannel(self)
        end)
    else
        -- 調用動作
        self:EventNotify "施法開始"

        -- 設置引導時間，時間到轉下個施法階段
        -- 不能被打斷
        CastChannel(self)
    end
end

CastChannel = function(self)
    -- 判斷需不需要引導
    if self.cast_channel_time_ > 0 then
        self.castbar_ = Castbar(self.owner_, self.cast_channel_time_, true)

        -- 是否定身施法
        if self.break_move_ == 1 then
            SkillUtil.RootCast(self, self.cast_channel_time_)
        end

        -- 設置引導時間，時間到轉下個施法階段
        -- 可以被打斷
        -- 某些持續技能如 暴風雪 會在引導階段播放效果，因此可以透過cast_pulse_使動作函數和動畫效果一致
        self.cast_channel_timer_ = Timer(self.cast_pulse_, self.cast_channel_time_ / self.cast_pulse_,
            function(callback)
                -- 調用動作
                self:EventNotify "施法引導"

                if callback.is_period_ == 0 then
                    CastShot(self)
                end
            end)
    else
        -- 調用動作
        self:EventNotify "施法引導"

        -- 設置引導時間，時間到轉下個施法階段
        -- 不可被打斷
        CastShot(self)
    end
end

CastShot = function(self)
    -- 判斷需不需要引導
    if self.cast_shot_time_ > 0 then
        self.castbar_ = Castbar(self.owner_, self.cast_shot_time_, true)

        -- 是否定身施法
        if self.break_move_ == 1 then
            SkillUtil.RootCast(self, self.cast_shot_time_)
        end

        -- 設置引導時間，時間到轉下個施法階段
        -- 可以被打斷
        -- 某些持續技能效果會在出手階段播放效果，因此可以透過cast_pulse_使動作函數和動畫效果一致
        self.cast_shot_timer_ = Timer(self.cast_pulse_, self.cast_shot_time_ / self.cast_pulse_,
            function(callback)
                -- 調用動作
                self:EventNotify "施法出手"

                if callback.is_period_ == 0 then
                    CastFinish(self)
                end
            end)
    else
        -- 調用動作
        self:EventNotify "施法出手"

        -- 設置引導時間，時間到轉下個施法階段
        -- 不可被打斷
        CastFinish(self)
    end
end

CastFinish = function(self)
    -- 調用動作
    self:EventNotify "施法完成"

    -- 設定記能熟練度
    SetProficiency(self)

    -- 先暫存技能，不然技能副本刪掉會讀不到
    local skill = self.__index
    
    -- 刪除副本
    self:Remove()

    -- 判定能不能多重施法
    SkillUtil.MultiCast(skill)

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

return CastStart