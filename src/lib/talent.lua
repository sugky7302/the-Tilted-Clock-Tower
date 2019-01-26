-- 創建天賦、玩家學習天賦、調用天賦效果

-- package
local require = require
local Skill = require 'skill.core'
local Unit = require 'unit.core'

local Talent = require 'class'("Talent")

-- assert
-- 事件預設值
Talent.on_init   = nil
Talent.on_add    = nil
Talent.on_call   = nil
Talent.on_remove = nil
Talent.on_cast   = nil

-- assert
local GetTalentList, HasTalent, CallEvent

function Talent:_new(config)
    -- 把模板設定給實例
    self:_copy(config)

    Talent:setInstance(self.name_, self)
end

-- id是jass裡的技能id
function Unit:LearnTalent(id)
    local GetObjectName = require 'jass.common'.GetObjectName

    -- 把技能前綴 "[天賦] "去掉(中文=3個字符)
    local name = string.sub(GetObjectName(id), 10) 

    if not Talent:getInstance(name) then
        return false
    end

    -- 刪除學過的天賦
    self:RemoveAbility(id)

    local talent = Talent:getInstance(name)
    local talents = GetTalentList(self, talent.skill_)
    talents[#talents + 1] = talent

    -- 根據天賦點花費來排序
    table.sort(talents, function(a, b)
        return a.cost_ < b.cost_
    end)

    -- 調用初始化函數
    CallEvent(talent, "on_init", self)

    -- 將天賦描述顯示在技能說明
    -- 設置擁有者是因為UpdateTip會呼叫
    local skill = Skill[talent.skill_]
    skill.owner_ = self
    skill:UpdateTip()
end


function Unit:TalentDispatch(name, event, ...)
    if not Talent:getInstance(name) then
        return false
    end

    local talent = Talent:getInstance(name)

    local EVENT_NAME = {
        ['初始化'] = 'on_init',
        ['添加'] = 'on_add',
        ['呼叫'] = 'on_call',
        ['刪除'] = 'on_remove',
        ['施法'] = 'on_cast',
    }
    
    if HasTalent(self, talent) then
        return CallEvent(talent, EVENT_NAME[event], self, ...)
    end

    return false
end

HasTalent = function(self, talent)
    for _, tl in ipairs(GetTalentList(self, talent.skill_)) do 
        if tl == talent then 
            return true 
        end
    end

    return false
end

GetTalentList = function(self, associated_skill)
    -- 創建天賦表
    if not self.talents_ then
        self.talents_ = {}
    end

    local hotkey = Skill[associated_skill].hotkey_

    -- 創建技能的天賦表
    if not self.talents_[hotkey] then
        self.talents_[hotkey] = {}
    end

    return self.talents_[hotkey]
end

CallEvent = function(self, name, ...)
    if self[name] then
        return self[name](self, ...)
    end

    return false
end

return Talent