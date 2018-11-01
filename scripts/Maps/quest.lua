local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local Timer = require 'timer'
local Unit = require 'unit'

local Quest, mt = {}, {}
setmetatable(Quest, Quest)
Quest.__index = mt
require 'quest_database'

-- constants
mt.isUnique = false  -- 任務是否唯一
mt.canAccept = true  -- 可否接取任務
local _announceDur = 6

function Quest:__call(questName)
    return function(quest)
        self[questName] = quest
        quest.name = questName
        setmetatable(quest, self)
        return quest
    end
end

function Unit.__index:AcceptQuest(questName)
    -- TODO:添加任務給接受任務的人
    -- 已接取任務就跳出
    for _, quest in ipairs(self.quests) do 
        if Quest[questName] == quest then
            return 
        end
    end
    local quest = _NewQuest(questName)
end

_NewQuest = function(unit, questName)
    Quest[questName].
end

function mt:Update()
    -- TODO:更新任務
end

function mt:Remove()
    -- TODO:刪除任務(已完成或放棄)
end

function mt:Announce(msg)
    cj.DisplayTimedTextToPlayer(self.receiver, 0., 0., _announceDur, msg)
end

function mt:HandIn()
    -- TODO:提交任務。多數任務採自動提交機制，因此會使用到計時器
end

function Unit.__index:SyncQuest(syncer)
    -- TODO:同步任務，用於可變身的單位。由於變身實際上是替換單位，數據會不同，因此要有這個動作
end

return Quest