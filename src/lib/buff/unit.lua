-- 提供unit操作buff的功能

-- package
local Unit = require 'unit.core'
local Buff = require 'buff.core'
local Operator = require 'buff.operator'

function Unit.__index:AddBuff(name, delay)
    return function(instance)
        local data = Buff[name]
        if not data then
            return false
        end

        if not self.buffs_ then
            self.buffs_ = {}
        end

        -- 初始化數據
        instance.name_ = instance.name_ or name
        instance.target_ = self

        if not instance.source_ then
            instance.source_ = self
        end

        -- instance可以視為副本
        setmetatable(instance, data)

        if delay then
            Delay(instance, delay)
            return instance
        end
        
        return Operator.Obtain(instance)
    end
end

Delay = function(self, delay)
    local Timer = require 'timer.core'
    Timer(delay, false, function()
        if self.invalid_ then
            return false
        end

        Operator.Obtain(self)
    end)
end

local pairs = pairs

function Unit.__index:FindBuff(name)
    if not self.buffs_ then
        return nil
    end

    for buff in pairs(self.buffs_) do
        if buff.name_ == name then
            return buff
        end
    end

    return nil
end

function Unit.__index.RemoveBuff(self, name)
	if not self.buffs_ then
		return false
    end
    
    -- 收集要刪除的buff
	local removed_buffs = {}
	for _, buff in pairs(self.buffs_) do
		if buff.name_ == name then
			removed_buffs[#removed_buffs + 1] = buff
		end
    end

	for i = 1, #removed_buffs do
		removed_buffs[i]:Delete()
	end
end