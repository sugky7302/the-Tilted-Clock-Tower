-- 創建天賦、玩家學習天賦、調用天賦效果

local setmetatable = setmetatable

-- package
local Skill = require 'skill'
local Unit = require 'unit.core'

local Talent, mt = {}, {}
setmetatable(Talent, Talent)
Talent.__index = mt

-- constants
local EVENT_NAME = {
    ['初始化'] = 'on_init',
    ['添加'] = 'on_add',
    ['呼叫'] = 'on_call',
    ['刪除'] = 'on_remove',
    ['施法'] = 'on_cast',
}

-- assert
-- 事件預設值
mt.on_init   = nil
mt.on_add    = nil
mt.on_call   = nil
mt.on_remove = nil
mt.on_cast   = nil

local GetTalentList, HasTalent, CallEvent

function Talent:__call(name)
    return function(instance)
        self[name] = instance
        instance.name_ = name

        setmetatable(instance, self)
        return instance
    end
end

-- id是jass裡的技能id
function Unit.__index:LearnTalent(id)
    local GetObjectName, string_sub = require 'jass.common'.GetObjectName, string.sub

    local name = string_sub(GetObjectName(id), 10) -- 把技能前綴 "[天賦] "去掉(中文=3個字符)

    if not Talent[name] then
        return false
    end

    -- 刪除學過的天賦
    self:RemoveAbility(id)

    local talent = Talent[name]
    local talents = GetTalentList(self, talent.skill_)
    talents[#talents + 1] = talent

    -- 根據天賦點花費來排序
    local table_sort = table.sort
    table_sort(talents, function(a, b)
        return a.cost_ < b.cost_
    end)

    -- 調用初始化函數
    CallEvent(Talent[name], "on_init", self)

    -- 將天賦描述顯示在技能說明
    -- 設置擁有者是因為UpdateTip會呼叫
    local skill = Skill[talent.skill_]
    skill.owner_ = self
    skill:UpdateTip()
end

function Unit.__index:TalentDispatch(name, event, ...)
    if not Talent[name] then
        return false
    end

    if HasTalent(self, Talent[name]) then
        return CallEvent(Talent[name], EVENT_NAME[event], self, ...)
    end

    return false
end

HasTalent = function(self, talent)
    local ipairs = ipairs
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