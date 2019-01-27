-- 提供添加、刪除buff的功能

-- package
local cj = require 'jass.common'

local Operator = {}

-- assert
local table = table
local GetBuffList, CheckDisable, AddEffect, RemoveEffect

function Operator.Obtain(self)
    if self.invalid_ then
        return false
    end

    if self.cover_type_ == 0 then -- 獨佔模式
        local this = self.target_:FindBuff(self.name_)
        if this then
            -- (true, false) = (新buff覆蓋, 新buff添加失敗)
            if not this:EventDispatch("狀態-覆蓋", true, self) then
                return false
            end
                
            Operator.Delete(this)

            -- 儲存
            GetBuffList(self)
            self.target_.buffs[self.name_] = self
        end
    elseif self.cover_type_ == 1 then -- 共存模式
        local list = GetBuffList(self)
        for i = 1, #list + 1 do 
            local this = list[i]
            if not this then
                table.insert(list, i, self)

                -- 如果buff不在有效區內，則禁用
                CheckDisable(self, i)

                break
            end

            -- true表示插入到當前位置，否則繼續查詢
            if this:EventDispatch("狀態-覆蓋", false, self) then
                table.insert(list, i, self)

                -- 如果剛好把原來的buff擠出有效區，則禁用它
                if this.cover_max_ == i then
                    this:EventDispatch "狀態-刪除"
                end

                -- 如果自己不在有效區，則禁用
                CheckDisable(self, i)
                
                break
            end
        end
    end

    self:set("剩餘時間", self.dur_)
    self.invalid_ = false
    
    -- 添加特效
    AddEffect(self)

    self:EventDispatch "狀態-獲得"
    self.target_:EventDispatch("單位-獲得狀態", self)

    return self
end

GetBuffList = function(self)
    if not self.target_.buffs_ then
        self.target_.buffs_ = {}
    end
    
    if not self.target_.buffs_[self.name_] then
        self.target_.buffs_[self.name_] = {}
    end

    return self.target_.buffs_[self.name_]
end

CheckDisable = function(self, i)
    if self.cover_max_ ~= 0 and i > self.cover_max_ then
        self:Pause()
    end
end

AddEffect = function(self)
    if self.model_ then
        self.effect_ = cj.AddSpecialEffectTarget(self.model_, self.target_.object_, self.model_point_)
    end
    
    if self.tip_skill_ then
        self.target_:AddAbility(self.tip_skill_)
    end
end

function Operator.Delete(self)
    if self.invalid_ then
        return false
    end

    self.timer_:Break()
    self.target_:EventDispatch("單位-失去狀態", self)

    -- 共存模式
    local new_buff
    if self.cover_type_ == 1 then
        -- 清空
        if self.target_.buffs_ and self.target_.buffs_[self.name_] then
            local list = self.target_.buffs_[self.name_]

            for i = 1, #list do 
                if self == list[i] then
                    table.remove(list, i)

                    -- 如果在有效區內，則生效
                    if self.cover_max_ >= i then
                        new_buff = list[self.cover_max_]
                    end

                    break
                end
            end
        end
    end

    self:EventDispatch "狀態-刪除"
    
    RemoveEffect(self)
    
    self.invalid_ = true

    -- 生效擠進有效區的新buff
    if new_buff then
        new_buff:Resume()
    end
end

RemoveEffect = function(self)
    if self.effect_ then
        cj.DestroyEffect(self.effect_)
    end

    -- 刪除buff圖標技能
    if self.tip_skill_ then
        self.target_:RemoveAbility(self.tip_skill_)
    end
end

return Operator