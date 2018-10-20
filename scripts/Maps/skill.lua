local setmetatable = setmetatable
local cj = require 'jass.common'
local Runtime = require 'jass.runtime'
local Game = require 'game'
local War3 = require 'api'
local error_handle = Runtime.ErrorHandle

local Skill = {}
local mt = {}
setmetatable(Skill, Skill)
Skill.__index = mt

-- constants
local _eventName = {
	['on_add']          = '技能-獲得',
	['on_remove']       = '技能-失去',
	['on_cast_start']   = '技能-施法開始',
	['on_cast_break']   = '技能-施法打斷',
	['on_cast_channel'] = '技能-施法引導',
	['on_cast_shot']    = '技能-施法出手',
	['on_cast_finish']  = '技能-施法完成',
	['on_cast_stop']    = '技能-施法停止',
}

-- defaultValues
mt.type = 'skill'      -- 類型
mt.name = ''           -- 技能名
mt.maxLevel = 5        -- 最大等級
mt.level = 1           -- 等級（等級為0時表示技能無效）
mt.unit = nil          -- 英雄
mt.slotId = nil        -- 技能位置(1~4)
mt.passive = false     -- 是被動技能
mt.abilityId = nil     -- 技能id
mt.cost = 0            -- 耗藍
mt.costChannel = 0     -- 每秒耗藍
mt.CD = 0              -- 冷卻
mt.range = 0           -- 施法距離
mt.area = 0            -- 影響範圍
mt.art = nil           -- 技能圖示
mt.tip = nil           -- 技能說明
mt.data = nil          -- 技能數據
mt.castStartTime = 0   -- 施法開始
mt.castChannelTime = 0 -- 施法引導
mt.castShotTime = 0    -- 施法出手
mt.castFinishTime = 0  -- 施法完成
mt.breakMove = 1       -- 打斷移動
mt.breakOrder = 0      -- 不恢復指令
mt.instant = 0         -- 瞬發技能
mt.forceCast = 0       -- 強制施法(無視技能限制)
mt.castingTag = nil    -- 施法時間條
mt.disableCount = 0    -- 禁用計數
mt.CDMode = 0          -- 冷卻模式 0:默認 1:充能
mt.chargeMaxStack = 0  -- 最大使用次數
mt.spellStack = 0      -- 當前剩餘使用次數
mt.showStack = 0       -- 顯示數位
mt.showCD = 1          -- 顯示冷卻
mt.showCharge = 0      -- 顯示充能冷卻
mt.costStack = 1       -- 當層數大於等於這個值時才可以使用充能技能(負數層數會整合顯示為一個冷卻)
mt.chargeCool = 0      -- 充能時間
mt.proc = 0            -- 觸發係數
mt.ignoreCDR = false   -- 技能不受冷卻縮減影響
mt.autoFreshTip = true -- 自動刷新文本
mt.isCastFlag = false  -- 是否是施法表
mt.pauseCount = 0      -- 暫停計數
mt.force = false       -- 無視暫停
mt.slotType = "隱藏"    -- 技能按鈕狀態類型

-- 某個階段是否可以被打斷
mt.breakCastStart = 0
mt.breakCastChannel = 0
mt.breakCastShot = 0
mt.breakCastFinish = 1

-- variables
local _CallEvent, _InitSkillAttributes

function Skill.Init()
    local unitIsCasted = War3.CreateTrigger(function()
        Game:EventDispatch("單位-發布命令", cj.GetOrderedUnit(), cj.GetIssuedOrderId(), cj.GetOrderTarget())
        return true
    end)
    Game:Event '單位-發布命令' (function(self, hero, order, target)
		if order == '' then
			return
        end
        -- 玩家在使用技能發布以下指令，停止施放技能
        if order == 'stop' or order == 'smart' or order == 'attack' then
            Skill:Stop()
			return
        end
        -- 獲取技能
        -- for _, skillName in hero.skills do
        --     Skill[skillName]:on_cast_start(hero, target)
        --     return 
        -- end
        -- Skill['暴風雪']:on_cast_start(hero, target)
    end)
    Game:Event "單位-創建" (function(self, target)
        cj.TriggerRegisterUnitEvent(unitIsCasted, target, cj.EVENT_UNIT_ISSUED_TARGET_ORDER)
        cj.TriggerRegisterUnitEvent(unitIsCasted, target, cj.EVENT_UNIT_ISSUED_POINT_ORDER)
        cj.TriggerRegisterUnitEvent(unitIsCasted, target, cj.EVENT_UNIT_ISSUED_ORDER)
    end)
end

function Skill:__call(name)
    return function(obj)
        self[name] = obj
        self[name].name = name
        _InitSkillAttributes(self[name])
        setmetatable(obj, self)
        return self[name]
    end
end

_InitSkillAttributes = function(self)
end

-- 觸發技能事件 (事件名, 無視禁用狀態)
_CallEvent = function(name, force)
	if not force then
		if self.removed then
			return false
		end
		if not self:isEnable() then
			return false
		end
	end
	if eventName[name] then
		-- todo: 有返回值的事件
		self.owner:EventDispatch(eventName[name], self.owner, self)
	end
	if not self[name] then
		return false
	end
	return select(2, xpcall(self[name], Base.ErrorHandle, self))
end


return Skill