local Class = require 'util.class'

local Quest = Class('Quest')

function Quest:_new(text)
    text.accepters_ = {}
    text.completed_ = false
    return text
end

function Quest:has(unit)
    for accepter in self.accepters_ do
        if unit == accepter then
            return true
        end
    end

    return false
end

function Quest:isCompleted()
    -- 沒有子任務就表示當前任務為任務樹的葉節點
    if not self.tasks then
        return self.completed_
    end

    -- 有子任務的話要搜尋它們有沒有完成
    local completed = true
    for task in self.tasks do
        completed = completed and task:isCompleted()
    end

    return completed
end

function Quest:start()
    ShowText(self)
    ResetCompleted(self)
    self:on_start()
end

ShowText = function(self)
    print(self.text)
end

ResetCompleted = function(self)
    self.completed = false

    if self.tasks then
        for task in self.tasks do
            task.completed = false
        end
    end
end

function Quest:on_start()
end

function Quest:update()
    UpdateTasks(self)
    self:on_update()
end

UpdateTasks = function(self)
end

function Quest:on_update()
end

function Quest:finish()
    ShowTalk(self)
    self:on_finish()

    if not self.unique_ then
        table.remove(self.accepters_, self.receiver)
    end
end

ShowTalk = function(self)
end

function Quest:on_finish()
end

---- 管理器 ----
local QuestManager = Class('QuestManager')
QuestManager.quests_ = {}

function QuestManager:register(key, quest_text)
    self.quests_[key] = Quest(quest_text)
end

function QuestManager:createQuest(quest_name, receiver)
    local origin = self.quests_[quest_name]

    if not(origin and origin:has(receiver)) then
        return nil
    end

    return setmetatable(
        {
            receiver = receiver,
            demands = origin.demands
        },
        origin
    )
end

return QuestManager
