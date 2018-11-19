local setmetatable = setmetatable
local table_insert = table.insert
local cj = require 'jass.common'
local js = require 'jass_tool'
local Timer = require 'timer'
local Unit = require 'unit'
local Group = require 'group'
local Item = require 'item'
local Point = require 'point'

local Quest, mt = {}, {}
setmetatable(Quest, Quest)
Quest.__index = mt

-- constants
mt.isUnique = false  -- 任務是否唯一
mt.canAccept = true  -- 可否接取任務
local _announceDur = 6

-- varaibles
local _IsHero, _LookupQuests, _AccepteMessage, _CreateQuestList, _Generate, _SetNewQuest, _FinishMessage
local _UpdateDemands, _UpdateMessage, _CanRepeat, _IsFinished, _CheckQuest

function Quest.Init()
    Unit:Event "任務-更新" (function(trigger, self)
        if _IsHero(self.killer) then
            _LookupQuests(self.killer.quests, self.id)
        end
    end)
end

_IsHero = function(unit)
    return not (not unit.quests)
end

_LookupQuests = function(quests, id)
    for _, quest in ipairs(quests) do 
        if quest.demands[id] then
            quest:Update(id)
        end
    end
end

function mt:Update(id)
    _CheckQuest(self, id)
    if _IsFinished(self) then
        _FinishMessage(self)
        _CanRepeat(self)
        self:on_reward()
        self:Remove()
    else
        _UpdateMessage(self)
    end
end

_CheckQuest = function(self, id)
    if type(self.demands[id]) == 'number' then
        self.demands[id] = self.demands[id] - 1
        if self.demands[id] == 0 then
            self.demands[id] = false
        end
    elseif self.demands[id] then
        self.demands[id] = false
    end
end

_IsFinished = function(self)
    for _, cnd in pairs(self.demands) do
        if cnd then -- cnd = 數字或true，都代表還沒做完任務
            return false
        end
    end
    return true
end

_FinishMessage = function(self)
    js.ClearMessage(self.receiver.owner.object)
    js.Sound("gg_snd_QuestCompleted")
    self:Announce "|cff00ff00v|r|cffffcc00完成任務"
    self:Announce("|cff999999" .. self.name)
    self:Announce("   " .. self.talk)
    for _, required in ipairs(self.required) do 
        self:Announce("|cff999999- " .. required)
    end
    for _, reward in ipairs(self.rewards) do
        self:Announce("|cffffcc00獎勵|r - " .. reward)
    end
end

_CanRepeat = function(self)
    self.receiver.quests[self.name] = self.isUnique
end

function mt:Remove()
    self.receiver = nil
    self.demands = nil
    self = nil
end

_UpdateMessage = function(self)
    js.ClearMessage(self.receiver.owner.object)
    js.Sound("gg_snd_QuestLog")
    self:Announce "|cffff6600!|r|cffffcc00更新任務"
    self:Announce(self.name)
    _UpdateDemands(self, self.__index)
end

_UpdateDemands = function(self, parent)
    for i, cnd in ipairs(parent.demands) do
        if type(cnd) == 'table' then
            if self.demands[cnd[1]] == false then
                self:Announce("|cff999999- " .. parent.required[i] .. "(" .. cnd[2] .. "/" .. cnd[2] .. ")")
            else
                self:Announce("- " .. parent.required[i] .. "(" .. (cnd[2] - self.demands[cnd[1]]) .. "/" .. cnd[2] .. ")")
            end
        else
            if self.demands[cnd] == false then
                self:Announce("|cff999999- " .. parent.required[i])
            else
                self:Announce("- " .. parent.required[i])
            end
        end
    end
end

function Quest:__call(questName) -- 單一任務的子任務不能出現相同的任務怪，創建會出問題
    return function(quest)
        self[questName] = quest
        quest.name = questName
        setmetatable(quest, self)
        return quest
    end
end

function Unit.__index:AcceptQuest(questName)
    if not Quest[questName] then
        return 
    end
    -- 已接取任務就跳出
    for _, quest in ipairs(_CreateQuestList(self)) do 
        if questName == quest.name then
            return false
        end
    end
    -- 確認此任務是否為接過的唯一任務
    if not self.quests[questName] then
        _SetNewQuest(self, Quest[questName])
        return true
    end
    return false
end

_CreateQuestList = function(self)
    if not self.quests then
        self.quests = {}
    end
    return self.quests
end

_SetNewQuest = function(unit, quest)
    local questCopy = _Generate(unit, quest)
    _AccepteMessage(questCopy)
    js.Sound("gg_snd_QuestNew")
    if questCopy.on_timer then
        questCopy.timer = Timer(1, true, function(callback)
            questCopy:on_timer(callback)
        end)
    end
end

_Generate = function(unit, quest)
    local questCopy = {}
    setmetatable(questCopy, questCopy)
    questCopy.__index = quest
    questCopy.receiver = unit
    questCopy.demands = {}
    for _, demand in ipairs(quest.demands) do
        if type(demand) == 'table' then
            questCopy.demands[demand[1]] = demand[2] 
        else
            questCopy.demands[demand] = true
        end
    end
    table_insert(unit.quests, questCopy)
    return questCopy
end

_AccepteMessage = function(quest)
    js.ClearMessage(quest.receiver.owner.object)
    quest:Announce "|cffff0000?|r|cffffcc00獲得任務"
    quest:Announce(quest.name)
    quest:Announce("   " .. quest.detail)
    for _, required in ipairs(quest.required) do 
        quest:Announce("- " .. required)
    end
end

function mt:Announce(msg)
    cj.DisplayTimedTextToPlayer(self.receiver.owner.object, 0., 0., _announceDur, msg)
end

function mt:GiveItem(triggerItem, count)
    local triggerUnit = self.receiver.object -- 防止任務被刪除後，搜尋不到單位的問題
    local p = Point:GetUnitLoc(triggerUnit)
    Timer(0.1, false, function()
        count = count or 1
        for i = 1, count do
            local item = Item.Create(triggerItem, p)
            cj.UnitAddItem(triggerUnit, item)
        end
        p:Remove()
    end)
end

function mt:Near(x, y)
    local sourcePoint = Point:GetUnitLoc(self.receiver.object)
    local targetPoint = Point(x, y)
    local isNear = Point.Distance(sourcePoint, targetPoint) < 200
    sourcePoint:Remove()
    targetPoint:Remove()
    return isNear
end

function Unit.__index:SyncQuest(syncer)
    -- TODO:同步任務，用於可變身的單位。由於變身實際上是替換單位，數據會不同，因此要有這個動作
end

return Quest