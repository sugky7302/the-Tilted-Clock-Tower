local function DamageTest(self)
    -- 初始化
    self.InitTimer()
    self.InitAttribute()

    -- package
    local Unit = require 'unit.core'
    local Game = require 'game'
    local cj = require 'jass.common'
    local War3 = require 'api'
    local Hero = require 'unit.hero'

    -- 造成傷害
    Unit:Event "單位-造成傷害" (function(_, source, target)
        local Damage = require 'combat.damage'
        Damage{
            source_ = source,
            target_ = target,
            type_ = "物理",
            name_ = "普通攻擊",
            element_type_ = "無",
        }
    end)

    -- 傷害事件觸發
    local unit_is_attacked = War3.CreateTrigger(function()
        local source, target = Unit(cj.GetEventDamageSource()), Unit(cj.GetTriggerUnit())
    
        -- 先將當前傷害值歸零，以免實際扣血 ~= 預計扣血
        local SetEventDamage = require 'jass.japi'.EXSetEventDamage
        SetEventDamage(0)
    
        -- 怕技能攻擊又會再次調用此觸發，形成死循環
        -- is_spell_damaged第一次不會創建，所以用not，用false會出問題
        if not source.is_spell_damaged_ then
            source:EventDispatch("單位-造成傷害", target)
            -- source:EventDispatch("單位-傷害完成", target)
        end
    
        return true
    end)

    -- 先註冊，不然進去遊戲再註冊會卡頓
    Hero(self.EnumUnit())
    Unit(self.EnumTestUnit())

    -- 創建傷害事件
    Game:Event "單位-創建" (function(_, target)
        cj.TriggerRegisterUnitEvent(unit_is_attacked, target, cj.EVENT_UNIT_DAMAGED)
    end)
    Game:EventDispatch("單位-創建", self.EnumUnit())
    Game:EventDispatch("單位-創建", self.EnumTestUnit())
end

return DamageTest