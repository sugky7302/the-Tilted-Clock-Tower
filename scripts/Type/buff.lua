local setmetatable = setmetatable
local cj = require 'jass.common'
local js = require 'jass_tool'
local Unit = require 'unit'
local Point = require 'point'
local Timer = require 'timer'
local Game = require 'game'
local table_insert = table.insert 
local table_remove = table.remove 

local Buff = {}
local mt = {}
setmetatable(Buff, Buff)
Buff.__index = mt 

-- constants
mt._TURN_RATE = 0.5

-- variables
mt.coverGlobal = 0       -- (0, 1) = (名字和來源都相同才視為同名狀態, 只要名字相同就是為同名狀態)
mt.coverMax = 0          -- 當單位身上有多個同名狀態，最多可以同時生效的狀態數量。0為無限制。只有當coverType為共存模式才有意義
mt.coverType = 0         -- (0, 1) = (只能同時保留一個同名狀態, 可以同時保留多個同名狀態)
mt.keep = false          -- (true, false) = (死亡時保留狀態或可以添加給死亡單位，死亡時移除狀態或無法添加給死亡單位)
mt.pulse = nil           -- 觸發週期事件(on_pulse)的頻率，單位為秒
mt.dur = 0               -- 持續時間，單位為秒
mt.timeout = 0           -- 剩餘時間，單位為秒
mt.val = 0               -- 效果數值，用於某些要添加數值的效果
mt.tip = ''              -- buff說明
mt.tipSkill = nil        -- buff說明的相關技能
mt.isForce = false       -- 是否無視暫停
mt.isPause = false       -- 是否為暫停狀態
mt.on_add = nil          -- 添加事件
mt.on_remove = nil       -- 刪除事件
mt.on_cover = nil        -- 覆蓋事件
mt.on_finish = nil       -- 結束事件
mt.on_stop = nil         -- 中止事件
mt.target = nil          -- 獲得buff的單位
mt.invalid = false       -- 是否失效
mt.timer = nil           -- 關聯計時器
mt.effect = nil          -- 特效
mt.model = nil           -- 特效模型
mt.modelPoint = "origin" -- 特效綁定點，預設為地面
mt.beginTimestep = nil   -- 新增buff的時間點
local set, get = {}, {}
local _CallEvent, _CallSetFn, _InitValue, _HasTimerOrNot, _CreateTimer, _CheckDisable, _Delay, _GetBuffList 
local _AddEffect, _RemoveEffect

-- 事件有on_add, on_cover, on_finish, on_pulse, on_remove
-- on_cover根據buff的coverType做不同處理
-- coverType = 0 -> (true, false) = (當前狀態被移除，新的狀態被添加)
-- coverType = 1 -> (true, false) = (新的狀態排序到當前狀態之前，新的狀態排序到當前狀態之後)
function Buff:__call(name)
    local obj = {}
    self[name] = obj
    obj.name = name
    setmetatable(obj, self)
    obj.__index = obj
    return self[name]
end

function mt:add(name, val)
    _InitValue(self, name)
    self[name] = self[name] + val
    _CallSetFn(self, name)
end

function mt:set(name, val)
    _InitValue(self, name)
    self[name] = val
    _CallSetFn(self, name)
end

_CallSetFn = function(self, name)
    if set[name] then
        set[name](self, self[name])
    end
end

function mt:get(name)
    _InitValue(self, name)
    return self[name]
end

_InitValue = function(self, name)
    if not self[name] then
        self[name] = get[name] and get[name](self) or 0
    end
end

function mt:Pause()
    if self.isForce then
        return 
    end
    if not self.isPause then
        self.isPause = true
        if self.timer then
            self.timer:Pause()
        end
        _CallEvent(self, "on_remove")
    end
end

function Unit.__index:AddBuff(name, delay)
    return function(obj)
        local data = Buff[name]
        if not data then
            return 
        end
        if not self.buffs then
            self.buffs = {}
        end

        -- 初始化數據
        obj.name = obj.name or name
        obj.target = self
        if not obj.source then
            obj.source = self
        end
        setmetatable(obj, data)
        if delay then
            _Delay(obj, delay)
            return obj
        else
            return obj:_Add()
        end
    end
end

_Delay = function(obj, delay)
    Timer(delay, false, function()
        if obj.invalid then
            return 
        end
        obj:_Add()
    end)
end

function mt:_Add()
    if self.invalid then
        return 
    end
    if self.coverType == 0 then -- 獨佔模式
        local this = self.target:FindBuff(self.name)
        if this then
            -- (true, false) = (新buff覆蓋, 新buff添加失敗)
            if _CallEvent(this, "on_cover", true, self) then
                this:Remove()
            else
                return 
            end
        end
    elseif self.coverType == 1 then -- 共存模式
        local list = _GetBuffList(self)
        for i = 1, #list + 1 do 
            local this = list[i]
            if not this then
                table_insert(list, i, self)
                -- 如果buff不在有效區內，則禁用
                _CheckDisable(self, i)
                break
            end
            -- true表示插入到當前位置，否則繼續查詢
            if _CallEvent(this, "on_cover", false, self) then
                table_insert(list, i, self)
                -- 如果剛好把原來的buff擠出有效區，則禁用它
                if this.coverMax == i then
                    _CallEvent(this, "on_remove")
                end
                -- 如果自己不在有效區，則禁用
                _CheckDisable(self, i)
                break
            end
        end
    end
    self.target.buffs[self] = true
    self:set("剩餘時間", self.dur)
    _AddEffect(self)
    self.invalid = false
    _CallEvent(self, 'on_add')
    Game:EventDispatch("單位-獲得狀態", self.target, self)
    return self
end

function Unit.__index:FindBuff(name)
    if not self.buffs then
        return nil
    end
    for buff in pairs(self.buffs) do
        if buff.name == name then
            return buff
        end
    end
    return nil
end

_GetBuffList = function(self)
    if not self.target.buffList then
        self.target.buffList = {}
    end
    if not self.target.buffList[self.name] then
        self.target.buffList[self.name] = {}
    end
    return self.target.buffList[self.name]
end

_CheckDisable = function(self, i)
    if self.coverMax ~= 0 and i > self.coverMax then
        self:Pause()
    end
end

set['剩餘時間'] = function(self, timeout)
    if timeout < 0 then
        return 
    end
    self.timeout = timeout
    self.beginTimestep = Timer.Clock()
    _HasTimerOrNot(self.timer)
    _CreateTimer(self)
end

_HasTimerOrNot = function(timer)
    if timer then
        timer:Remove()
    end
end

_CreateTimer = function(self)
    if self.pulse then
        self.timer = Timer(self.pulse, self.timeout / self.pulse, function(callback)
            if self.target then
                _CallEvent(self, "on_pulse")
                if callback.isPeriod < 1 then
                    _CallEvent(self, "on_finish")
                    self:Remove()
                end
            else
                self:Remove()
            end
        end)
    else
        self.timer = Timer(self.timeout, false, function()
            _CallEvent(self, "on_finish")
            self:Remove()
        end)
    end
end

_AddEffect = function(self)
    if self.model then
        self.effect = cj.AddSpecialEffectTarget(self.model, self.target.object, self.modelPoint)
    end
    if self.tipSkill then
        self.target:AddAbility(self.tipSkill)
    end
end

function Unit.__index.RemoveBuff(self, name)
	if not self.buffs then
		return
	end
	local tbl = {}
	for _, buff in pairs(self.buffs) do
		if buff.name == name then
			tbl[#tbl + 1] = buff
		end
	end
	for i = 1, #tbl do
		tbl[i]:Remove()
	end
end

function mt:Remove()
    if self.invalid then
        return 
    end
    self.timer:Break()
    Game:EventDispatch("單位-失去狀態", self.target, self)
    -- 移除target身上的buff
    self.target.buffs[self] = nil
    local newBuff
    if self.coverType == 1 then -- 共存模式
        if self.target.buffList and self.target.buffList[self.name] then
            local list = self.target.buffList[self.name]
            for i = 1, #list do 
                if self == list[i] then
                    table_remove(list, i)
                    -- 如果在有效區內，則生效
                    if self.coverMax >= i then
                        newBuff = list[self.coverMax]
                    end
                    break
                end
            end
        end
    end
    _CallEvent(self, "on_remove")
    _RemoveEffect(self)
    self.invalid = true
    if newBuff then
        newBuff:Resume()
    end
end

_RemoveEffect = function(self)
    if self.effect then
        cj.DestroyEffect(self.effect)
    end
    if self.tipSkill then
        self.target:RemoveAbility(self.tipSkill)
    end
end

function mt:Resume()
    if self.isPause then
        self.isPause = false
        self.timer:Resume()
        _CallEvent(self, "on_add")
    end
end

_CallEvent = function(self, name, default, ...)
    default = default or false
    if self.invalid then
        return default
    end
    if self[name] then
        local result = self[name](self, ...)
        return result or default
    else
        return default
    end
end

get['剩餘時間'] = function(self)
    if self.beginTimestep then 
        return self.timeout + self.beginTimestep - Timer.Clock()
    end
    return 0
end

return Buff