-- 單位的相關任務事件

-- package
local Unit  = require 'unit.core'
local Quest = require 'quest.core'

-- assert
local ipairs = ipairs

function Unit.__index:AcceptQuest(quest_name)
    if not Quest[quest_name] then
        return false
    end

    -- 已接取任務就跳出
    for _, quest in ipairs(CreateQuestList(self)) do 
        if quest_name == quest.name_ then
            return false
        end
    end

    -- 確認此任務是否為接過的唯一任務
    if not self.quests_[quest_name] then
        SetNewQuest(self, Quest[quest_name])
        return true
    end

    return false
end

CreateQuestList = function(self)
    if not self.quests_ then
        self.quests_ = {}
    end

    return self.quests_
end

-- package
local js = require 'jass_tool'

SetNewQuest = function(unit, quest)
    local quest_copy = Generate(unit, quest)

    AccepteMessage(quest_copy)
    js.Sound("gg_snd_QuestNew")

    -- 前置函數
    if quest_copy.on_prepare then
        quest_copy:on_prepare()
    end

    -- 執行週期監聽函數
    if quest_copy.on_timer then
        local Timer = require 'timer.core'
        quest_copy.timer_ = Timer(1, true, function(callback)
            quest_copy:on_timer(callback)
        end)
    end
end

Generate = function(unit, quest)
    local quest_copy = {
        receiver_ = unit,
        demands_ = {},
    }
    setmetatable(quest_copy, quest_copy)
    quest_copy.__index = quest

    -- 添加任務
    for i = 1, #quest.demands_, 2 do
        quest_copy.demands_[quest.demands_[i]] = quest.demands_[i + 1]
    end

    unit.quests_[#unit.quests_ + 1] = quest_copy

    return quest_copy
end

AccepteMessage = function(quest)
    quest:Announce "|cffff0000?|r|cffffcc00獲得任務"
    quest:Announce{"<", quest.name_, ">"}

    local string_gsub = string.gsub
    quest:Announce((string_gsub(quest.detail_, "$NAME", quest.receiver_.proper_name_)))

    for _, required in ipairs(quest.required_) do 
        quest:Announce{"- ", required}
    end

    -- 加個空格
    quest:Announce " "
end

function Unit.__index:SyncQuest(syncer)
    -- TODO: 同步任務，用於可變身的單位。由於變身實際上是替換單位，數據會不同，因此要有這個動作
end