-- 提供unit操作buff的功能

-- package
local require = require
local Unit = require 'unit.core'
local Buff = require 'buff.core'

-- instance內部的name可以填寫自己想要的名稱
function Unit:AddBuff(name, delay)
    return function(data)
        local class = pcall(require, table.concat({"buffs.", name}))
        if not class then
            return false
        end

        if not self.buffs_ then
            self.buffs_ = {}
        end

        -- 這邊把資料複製給實例就不用在各種buff模板裡面各寫一個_new函數，又容易維護
        local instance = class()
        instance:_copy(data)

        -- 初始化數據
        instance.name_ = instance.name_ or name
        instance.target_ = self

        if not instance.source_ then
            instance.source_ = self
        end

        if delay then
            Delay(instance, delay)
            return instance
        end
        
        return instance:Obtain()
    end
end

Delay = function(self, delay)
    local Timer = require 'timer.core'
    Timer(delay, false, function()
        if self.invalid_ then
            return false
        end

        self:Obtain()
    end)
end

local pairs = pairs

function Unit:FindBuff(name)
    if not self.buffs_ then
        return nil
    end

    for buff_name, buff in pairs(self.buffs_) do
        if buff_name == name then
            return buff
        end
    end

    return nil
end

function Unit:RemoveBuff(name)
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
