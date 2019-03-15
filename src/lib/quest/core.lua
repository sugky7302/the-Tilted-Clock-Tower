-- 仿魔獸戰役格式的自定義任務
-- 依賴
--   quest.util
--   jass_tool


-- package
local require = require 
local Class = require 'class'


local Quest = Class("Quest", require 'quest.util')

-- assert
local CheckQuest, IsFinished, FinishMessage, CanRepeat, UpdateMessage, UpdateDemands

-- 單一任務的子任務不能出現相同的任務怪，創建會出問題
function Quest:_new(data)
    self = Class(data.name_, Quest)
    
    self:_copy(data)
    data = nil

    Quest:setSubclass(self.name_, self)

    self._new = function(this, unit)
        this.receiver_ = unit
        this.demands_ = {}

        -- 添加任務
        for i = 1, #self.demands_, 2 do
            this.demands_[self.demands_[i]] = self.demands_[i + 1]
        end

        unit.quests_[#unit.quests_ + 1] = this
    end
end

function Quest:Update(id)
    CheckQuest(self, id)

    if IsFinished(self) then
        -- 先執行獎勵函數可以動態更動獎勵說明，如第一次試煉就會改動。
        self:on_reward()
        
        FinishMessage(self)
        CanRepeat(self)
        
        self:Remove()
    else
        UpdateMessage(self)
    end
end

-- assert
local type, ipairs = type, ipairs

CheckQuest = function(self, id)
    if type(self.demands_[id]) == 'number' then
        self.demands_[id] = self.demands_[id] - 1

        -- 設定任務完成
        if self.demands_[id] == 0 then
            self.demands_[id] = false
        end
    elseif self.demands_[id] then -- true/false型任務，比如找到某樣物件
        self.demands_[id] = false
    end
end

IsFinished = function(self)
    for _, cnd in pairs(self.demands_) do
        if cnd then -- cnd = 數字或true，都代表還沒做完任務
            return false
        end
    end

    return true
end

-- package
local js = require 'jass_tool'

-- assert
local string_gsub = string.gsub

FinishMessage = function(self)
    js.ClearMessage(self.receiver_.owner_.object_)
    js.Sound("gg_snd_QuestCompleted")

    self:Announce "|cff00ff00v|r|cffffcc00完成任務"
    self:Announce{"<", self.name_, ">"}
    self:Announce((string_gsub(self.talk_, "$NAME", self.receiver_.proper_name_)))

    if self.required_ then
        for _, required in ipairs(self.required_) do 
            self:Announce{"|cff999999- ", required}
        end
    end

    if self.rewards_ then
        for _, reward in ipairs(self.rewards_) do
            self:Announce{"|cffffcc00獎勵|r - ", reward}
        end
    end

    -- 加個空格
    self:Announce " "
end

CanRepeat = function(self)
    self.receiver_.quests_[self.name_] = self.is_unique_
end

UpdateMessage = function(self)
    js.ClearMessage(self.receiver_.owner_.object_)
    js.Sound("gg_snd_QuestLog")

    self:Announce "|cffff6600!|r|cffffcc00更新任務"
    self:Announce{"<", self.name_, ">"}

    -- self是副本，self.__index才是原本
    UpdateDemands(self, self.__index)

    -- 加個空格
    self:Announce " "
end

UpdateDemands = function(self, parent)
    local key
    for i = 1, #parent.required_ do
        key = parent.demands_[2 * i - 1]
        if type(parent.demands_[2 * i]) == 'number' then
            if self.demands_[key] == false then
                self:Announce{"|cff999999- ", parent.required_[i]}
            else
                self:Announce{"- ", parent.required_[i], "(", (parent.demands_[2*i] - self.demands_[key]),
                              "/", parent.demands_[2*i], ")"}
            end
        else
            if self.demands_[key] == false then
                self:Announce{"|cff999999- ", parent.required_[i]}
            else
                self:Announce{"- ", parent.required_[i]}
            end
        end
    end
end

return Quest