local setmetatable = setmetatable
local cj = require 'jass.common'
local Unit = require 'unit'
local Game = require 'game'
local Skill = require 'skill'
local table_insert = table.insert
local table_sort = table.sort

local Talent, mt = {}, {}
setmetatable(Talent, Talent)
Talent.__index = mt

-- constants
local _EVENT_NAME = {
    ['天賦-初始化'] = 'on_init',
    ['天賦-添加'] = 'on_add',
    ['天賦-呼叫'] = 'on_call',
    ['天賦-刪除'] = 'on_remove'
}

-- variables
mt.on_add = nil    -- 添加事件
mt.on_remove = nil -- 刪除事件
mt.on_call = nil   -- 呼叫事件
local _CompareFn, _GetTalentList, _HasTalent, _CallEvent

function Talent.Init()
    Game:Event "單位-發動技能效果" (function(self, target, id)
        Unit(target):LearnTalent(id)
    end)
end

function Talent:__call(name)
    return function(obj)
        self[name] = obj
        obj.name = name
        setmetatable(obj, self)
        return obj
    end
end

function Unit.__index:LearnTalent(id)
    local name = string.sub(cj.GetObjectName(id), 10) -- 把技能前綴 "[天賦] "去掉(中文=3個字符)
    if not Talent[name] then
        return 
    end
    self:RemoveAbility(id)
    local talent = Talent[name]
    local talents = _GetTalentList(self, talent)
    table_insert(talents, talent)
    table_sort(talents, _CompareFn)
    _CallEvent(Talent[name], "on_init", self)
    local skill = Skill[talent.skill]
    skill.owner = self
    skill:UpdateTip()
end

_CompareFn = function(a, b)
    return a.cost < b.cost
end

function Unit.__index:EventDispatch(name)
    return function(event, ...)
        if not Talent[name] then
            return false
        end
        if _HasTalent(self, Talent[name]) then
            return _CallEvent(Talent[name], _EVENT_NAME[event], self, ...)
        end
        return false
    end
end

_HasTalent = function(self, talent)
    for _, tl in ipairs(_GetTalentList(self, talent)) do 
        if tl == talent then 
            return true 
        end
    end
    return false
end

_GetTalentList = function(self, talent)
    if not self.talents then -- 創建天賦表
        self.talents = {}
    end
    local hotkey = Skill[talent.skill].hotkey
    if not self.talents[hotkey] then -- 創建技能的天賦表
        self.talents[hotkey] = {}
    end
    return self.talents[hotkey]
end

_CallEvent = function(self, name, ...)
    if self[name] then
        return self[name](self, ...)
    end
    return false
end

return Talent