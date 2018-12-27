-- 提供技能可能會用到的工具

-- package
local cj = require 'jass.common'

local SkillUtil = {}

-- 使用逆變身更換模型
function SkillUtil.ChangeModel(unit, model)
    local AEme = require 'jass.slk'.ability.AEme
    AEme.DataA1 = model
    AEme.UnitID1 = unit.id_
    AEme.DataE1 = 0

    unit:AddAbility('AEme')
    unit:RemoveAbility('AEme')
end

-- assert
local CreateDummy, ZoomDummy

function SkillUtil.RootCast(self, timeout)
    -- 定身
    SkillUtil.ChangeTurnRate(self.owner_, 0x01, 0)
    
    -- 創建施法光環
    local Timer = require 'timer.core'
    local PERIOD = 0.1

    -- 因為cast有可能結束比這裡快，所以要暫存owner_，不然會報錯
    local owner = self.owner_
    self.root_cast_timer_ = Timer(PERIOD, timeout / PERIOD, function(callback)
        -- 施法中斷或時間到都關閉此計時器
        if self.castbar_.invalid_ or (callback.is_period_ < 1) then
            -- 恢復轉身
            SkillUtil.ChangeTurnRate(owner, 0x02, 0.5)

            -- 回傳任務完成
            if self.root_cast_timer_.handle_ then
                local TaskTracker = require 'task_tracker'
                TaskTracker.finish(self.root_cast_timer_.handle_)
            end
        end
    end)
end

function SkillUtil.ChangeTurnRate(hero, index, val)
    local EXSetUnitMoveType = require 'jass.japi'.EXSetUnitMoveType 
    
    EXSetUnitMoveType(hero.object_, index)

    val = val or 0.5
    hero:set("轉身速度", val)
end

-- assert 
local AutoCast

function SkillUtil.MultiCast(self)
    local Rand = require 'math_lib'.Random

    if self.can_multi_cast_ and (Rand(100) < self.multi_cast_chance_) then
        -- 讓 unit event-準備施放技能 知道當前是多重施法狀態
        self.is_multi_cast_ = true

        -- 重置技能，使"自動施放技能" 指令能夠正確執行
        self.owner_:ResetAbility(self.order_id_)

        AutoCast(self.owner_, self.order_, self.target_unit_, self.target_loc_)
    end
end

-- 因為不知道技能是哪種命令類型，所以三種命令都調用一遍
AutoCast = function(source, order, target, target_loc)
    -- 施放立即命令
    cj.IssueImmediateOrder(source.object_, order)

    -- 施放點命令
    cj.IssuePointOrder(source.object_, order, target_loc.x_, target_loc.y_)

    -- 施放單位命令
    cj.IssueTargetOrder(source.object_, order, target.object_)
end  

return SkillUtil