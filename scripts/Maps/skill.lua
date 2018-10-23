local setmetatable = setmetatable
local cj = require 'jass.common'

local Skill = {}
local mt = {}
setmetatable(Skill, Skill)
Skill.__index = mt

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

function Skill:__call(name)
    return function(obj)
        self[name] = obj
        obj.name = name
        setmetatable(obj, self)
        return self[name]
    end
end

function mt:ChangeModel(unit, model)
    local slk = require 'jass.slk'
    slk.ability.AEme.DataA1 = model
    slk.ability.AEme.UnitID1 = Base.Id2String(U2Id(unit))
    slk.ability.AEme.DataE1 = 0
    cj.UnitAddAbility(unit, Base.String2Id('AEme'))
    cj.UnitRemoveAbility(unit, Base.String2Id('AEme'))
end

function mt:_cast_start()
    if self.castStartTime > 0 then
        local Cast = require 'castbar'
        self.castbar = Castbar(hero.object, self.castStartTime, true)
        -- 看能不能被打斷
        if self.breakCastStart == 1 then
            local period = 0.03
            self.castStartTimer = Timer(period, self.castStartTime / period, function(callback)
                self:on_cast_start(hero, unit, loc)
                if callback.isPeriod < 1 then
                    self:_cast_channel(hero, unit, loc)
                end
            end)
        else
            Timer(self.castStartTime, false, function()
                self:_cast_channel(hero, unit, loc)
            end)
        end
    else
        self:_cast_channel(hero, unit, loc)
    end
end

function mt:_cast_channel(hero, unit, loc)
    if self.castChannelTime > 0 then
        self.castbar = Castbar(hero.object, self.castChannelTime)
        -- 看能不能被打斷
        if self.breakCastStart == 1 then
            local period = 0.03
            self.castChannelTimer = Timer(period, self.castChannelTime / period, function()
                self:_cast_shot(hero, unit, loc)
            end)
        else
            Timer(self.castChannelTime, false, function()
                self:_cast_shot(hero, unit, loc)
            end)
        end
    else
        self:_cast_shot(hero, unit, loc)
    end
end

_CallEvent = function(self, name, force)
    if not force then
        if self.invalid then
            return false
        end
    end
    if self[name] then
        self[name](self)
    else
        return false
    end
end

return Skill