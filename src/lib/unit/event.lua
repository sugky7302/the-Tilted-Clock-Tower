-- 處理單位事件
-- 要注意某些事件參數可以傳instance，有些只能傳jass參數
-- 依賴
--   jass.common
--   jass.japi
--   jass_tool
--   api
--   unit.core
--   game
--   point
--   item.core
--   timer.core
--   item.equipment.core
--   item.secrets
--   combat.damage
--   drop_lib
--   math_lib
--   unit.hero
--   intelligenct


-- package
local require = require
local cj = require 'jass.common'
local js = require 'jass_tool'
local War3 = require 'api'
local Unit = require 'unit.core'
local Game = require 'game'
local Point = require 'point'
local Item = require 'item.core'
local Timer = require 'timer.core'
local Equipment = require 'item.equipment.core'
local Secrets = require 'item.secrets'

-- assert
local table_concat = table.concat
local ipairs = ipairs
local RunBehaviorTree

local unit_is_attacked = War3.CreateTrigger(function()
    local source, target = Unit:getInstance(cj.GetEventDamageSource()), Unit:getInstance(cj.GetTriggerUnit())

    -- 先將當前傷害值歸零，以免實際扣血 ~= 預計扣血
    local SetEventDamage = require 'jass.japi'.EXSetEventDamage
    SetEventDamage(0)

    -- 怕技能攻擊又會再次調用此觸發，形成死循環
    if source.is_spell_damaged_ == false then
        source:EventDispatch("單位-造成傷害", target)
        source:EventDispatch("單位-傷害完成", target)

        -- 執行行為樹
        if target.type == "Unit" then
            RunBehaviorTree(target)
        end
    end

    return true
end)

Unit:Event "單位-造成傷害" (function(_, source, target)
    local Damage = require 'combat.damage'
    Damage{
        source_ = source,
        target_ = target,
        
        name_ = "普通攻擊",
        type_ = "物理",
        element_type_ = "無",
    }
end)

-- 精英生物以上才會有行為樹
-- 不管是xpcall或是pcall都無法在報錯的情況下正常運行，會出現連帶問題，比如水元素報錯，進而導致遊戲崩潰
RunBehaviorTree = function(target)
    if target["階級"] > 1 and (not target.behavior_running_) then
        local name = string.match(target.name_, 'n(.+)%s')
        local path = table_concat({'monsters.', name, ".behavior"})
        local behavior

        -- 如果找不到behavior找不到就根據debug模式或release模式給予兩種不同保護機制
        if Base.debug_mode then
            behavior = select(2, xpcall(require, Base.ErrorHandle, path))
        else
            behavior = select(2, pcall(require, path))
        end

        if behavior then
            -- 避免重複啟動行為樹
            target.behavior_running_ = true

            behavior(target)
        end
    end
end

-- 註冊單位死亡要刷新的事件
local trg = War3.CreateTrigger(function()
    local target = Unit:getInstance(cj.GetTriggerUnit())

    -- 放到最底下會導致EventDispatch獲取不到target，可能是因為Unit會刪除實例
    target:EventDispatch("任務-更新")

    if target.type == "Unit" then
        target:EventDispatch("單位-掉落物品")
        target:EventDispatch("單位-刷新")
    
        return true
    end

    if target.type == "Pet" then
        target:EventDispatch("寵物-清除")
        
        return true
    end
    
    if target.type == "Hero" then
        target:EventDispatch("英雄-復活")
        target:EventDispatch("英雄-死亡後終止所有技能")

        return true
    end

    return true
end)

-- assert
local LookupQuests

Unit:Event "任務-更新" (function(_, self)
    -- 防止召喚物死亡後執行
    if not self.attacker_ then
        return false
    end

    -- NOTE: 如果不設定召喚物擊殺的單位的攻擊者為英雄，英雄會沒辦法更新任務
    local attacker = self.attacker_
    if attacker.type == "Pet" then
        attacker = attacker.owner_
    end

    if attacker.type == 'Hero' then
        LookupQuests(attacker.quests_, self.id_)
    end
end)

LookupQuests = function(quests, id)
    if not quests then 
        return false
    end

    for _, quest in ipairs(quests) do 
        if quest.demands_[id] then
            quest:Update(id)
        end
    end
end

Unit:Event "單位-掉落物品" (function(_, unit)
    local DROP_LIB = require 'drop_lib'
    if not DROP_LIB[unit.id_] then
        return false
    end

    local Rand = require 'math_lib'.Random
    local p = Point.GetUnitLoc(unit.object_)

    for i = 1, #DROP_LIB[unit.id_], 2 do
        if Rand(100) < DROP_LIB[unit.id_][i+1] then
            local item = Item.Create(DROP_LIB[unit.id_][i], p)

            -- 掉落裝備
            if Item.IsEquipment(item) then
                unit:DropEquipment(item)
            end

            -- 設定成秘物
            if Item.IsSecrets(item) then
                Secrets(item)
            end

            -- 非上面類別就設定成普通物品
            Item(item)
        end
    end

    p:Remove()
end)

Unit:Event "單位-刷新" (function(_, unit)
    -- 移除單位前先存單位id才不會讀不到
    js.RemoveUnit(unit.object_)

    Timer(unit:get "刷新時間", false, function()
        local new_unit = Unit.Create(cj.Player(cj.PLAYER_NEUTRAL_AGGRESSIVE), unit.id_, unit.revive_point_,
                                     cj.GetRandomReal(0, 180))

        -- 新單位註冊實例
        Unit(new_unit)

        Game:EventDispatch("單位-創建", new_unit)

        -- 移除舊實例
        unit:Remove()
    end)
end)

Unit:Event "英雄-復活" (function(_, self)
    -- 清空施放技能隊列
    for _, skill in ipairs(self.each_casting_) do
        skill:Break()
    end

    -- 解除js.RemoveUnit設置的水元素週期，不然英雄復活會直接死亡
    cj.UnitPauseTimedLife(self.object_, true)

    local revive_time = 10 + 5 * self:get "等級"
    local floor = math.floor
    self.owner_.leaderboard_:SetTitle(table_concat({"英雄將於|cffffcc00",
                                      floor(revive_time), "|r秒後復活"}))
    self.owner_.leaderboard_:SetStyle(true, false, false, false)
    self.owner_.leaderboard_:Show(true)
    
    Timer(1, 10 + 5 * self:get "等級", function(callback)
        self.owner_.leaderboard_:SetTitle(table_concat({"英雄將於|cffffcc00",
                                          floor(callback.is_period_), "|r秒後復活"}))
        if callback.is_period_ == 0 then
            cj.ReviveHero(self.object_, self.revive_point_.x_, self.revive_point_.y_, true)

            -- 清空排行榜
            self.owner_.leaderboard_:Show(false)
            self.owner_.leaderboard_:Clear()

            -- 不然獲取到的生命值會跟死亡前的生命值相同，導致dealdamage會判定擊殺
            self:set("生命", self:get "生命上限")
        end
    end)
end)

Unit:Event "寵物-清除" (function(_, self)
    -- 寵物的擁有者要清除寵物，不然有機會報錯
    self.owner_.pet_ = nil
    
    self:Remove()
end)

Game:Event "單位-創建" (function(_, target)
    cj.TriggerRegisterUnitEvent(trg, target, cj.EVENT_UNIT_DEATH)
    cj.TriggerRegisterUnitEvent(unit_is_attacked, target, cj.EVENT_UNIT_DAMAGED)
end)


-- package
local Hero = require 'unit.hero'

local order_trg = War3.CreateTrigger(function()
    Hero:getInstance(cj.GetOrderedUnit()):EventDispatch("單位-發布命令", cj.GetIssuedOrderId(), cj.GetOrderTarget())
    return true
end)

-- 滿格拾取
-- Unit:Event "單位-發布命令" (function(_, hero, order, target)
--     if order == Base.String2OrderId('smart') then
--         StackItem(hero.object_, Item(target))
--     end
-- end)


-- 創建使用物品事件
local use_item_trg = War3.CreateTrigger(function()
    Hero:getInstance(cj.GetTriggerUnit()):EventDispatch("單位-使用物品", Item:getInstance(cj.GetManipulatedItem()))
    return true
end)


-- 創建獲得物品事件
local obtain_item_trg = War3.CreateTrigger(function()
    if cj.GetManipulatedItem() ~= nil then
        Hero:getInstance(cj.GetTriggerUnit()):EventDispatch("單位-獲得物品", cj.GetManipulatedItem())
    end

    return true
end)

Unit:Event "單位-獲得物品" (function(trigger, hero, item)
    local string_sub = string.sub
    
    if Item.IsEquipment(item) then
        Equipment(item).owner_ = hero
        Equipment(item).own_player_ = hero.owner_
        hero:UpdateAttributes("增加", Equipment(item))
    elseif Item.IsSecrets(item) then
        Secrets(item).owner_ = hero
        Secrets(item).own_player_ = hero.owner_
    elseif hero:AcceptQuest(string_sub(cj.GetItemName(item), 10)) then
        return true
    else
        Item(item).owner_ = hero
        Item(item).own_player_ = hero.owner_
    end

    StackItem(hero.object_, Item(item))
end)

StackItem = function(hero, item)
    if not(Item.IsSecrets(item.object_) or Item.IsMaterial(item.object_)) then
        return false
    end

    if item:get "數量" == 0 then
        return false
    end

    for i = 0, 5 do
        local bag_item = Item:getInstance(cj.UnitItemInSlot(hero, i))
        if IsTypeSame(bag_item, item) then
            bag_item:add("數量", item:get "數量")
                
            item:Remove()
            return true
        end
    end
end

IsTypeSame = function(bag_item, target_item)
    return (bag_item.id_ == target_item.id_) and (bag_item.handle_ ~= target_item.handle_)
end


-- 創建丟棄物品事件
local drop_item_trg = War3.CreateTrigger(function()
    Hero:getInstance(cj.GetTriggerUnit()):EventDispatch("單位-丟棄物品", cj.GetManipulatedItem())
    return true
end)

Unit:Event "單位-丟棄物品" (function(_, hero, item)
    if Item.IsEquipment(item) then
        hero:UpdateAttributes("減少", Equipment(item))
    end
end)


-- 創建出售物品事件
local sell_itemT_trg = War3.CreateTrigger(function()
    Hero:getInstance(cj.GetTriggerUnit()):EventDispatch("單位-出售物品", cj.GetSoldItem())
    return true
end)


local spell_effect_trg = War3.CreateTrigger(function()
    Hero:getInstance(cj.GetTriggerUnit()):EventDispatch("單位-發動技能效果", cj.GetSpellAbilityId(),
                                                        Unit:getInstance(cj.GetSpellTargetUnit()),
                                                        Item:getInstance(cj.GetSpellTargetItem()),
                                                        Point.GetLoc(cj.GetSpellTargetLoc()))
    return true
end)

Unit:Event "單位-發動技能效果" (function(_, target, id)
    target:LearnTalent(id)
end)

Unit:Event "單位-發動技能效果" (function(_, source, id, _, _, target_loc)
    local S2Id = Base.String2Id

    -- A00M = 偵查
    if id == S2Id('A00M') then
        local Save = require 'intelligence'.Save
        Save(source, target_loc)
        target_loc:Remove()
    end

    -- A055 = 情報
    if id == S2Id('A055') then
        local Load = require 'intelligence'.Load
        Load(source)
    end
end)

-- 添加事件
Game:Event "單位-創建" (function(_, target)
    if Unit.IsHero(target) then
        -- 發布命令
        cj.TriggerRegisterUnitEvent(order_trg, target, cj.EVENT_UNIT_ISSUED_TARGET_ORDER)
        cj.TriggerRegisterUnitEvent(order_trg, target, cj.EVENT_UNIT_ISSUED_POINT_ORDER)
        cj.TriggerRegisterUnitEvent(order_trg, target, cj.EVENT_UNIT_ISSUED_ORDER)

        cj.TriggerRegisterUnitEvent(use_item_trg, target, cj.EVENT_UNIT_USE_ITEM) -- 使用物品事件
        cj.TriggerRegisterUnitEvent(obtain_item_trg, target, cj.EVENT_UNIT_PICKUP_ITEM) -- 獲得物品事件
        cj.TriggerRegisterUnitEvent(drop_item_trg, target, cj.EVENT_UNIT_DROP_ITEM) -- 丟棄物品事件
        cj.TriggerRegisterUnitEvent(sell_item_trg, target, cj.EVENT_UNIT_SELL_ITEM) -- 出售物品事件
        cj.TriggerRegisterUnitEvent(spell_effect_trg, target, cj.EVENT_UNIT_SPELL_EFFECT)
    end
end)
