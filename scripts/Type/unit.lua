local setmetatable = setmetatable
local math = math
local cj = require 'jass.common'
local js = require 'jass_tool'
local Group = require 'group'
local Point = require 'point'
local Timer = require 'timer'
local Game = require 'game'
local War3 = require 'api'
local Event = require 'event'
local Player = require 'player'

local Unit = {}
local mt = require 'attribute'
setmetatable(Unit, Unit)
Unit.__index = mt

-- constants
mt.type = "Unit"
mt.isSpellDamaged = false

function Unit.Init()
    -- 註冊單位死亡要刷新的事件
    local trg = War3.CreateTrigger(function()
        local target = Unit(cj.GetTriggerUnit())
        if target.type == "Unit" then
            Game:EventDispatch("單位-刷新", target)
        elseif target.type == 'Pet' then
            Game:EventDispatch("寵物-清除", target)
        elseif target.type == "Hero" then
            Game:EventDispatch("英雄-復活", target)
        end
        return true
    end)
    Game:Event "單位-刷新" (function(self, obj)
        local id = js.U2Id(obj.object) -- 移除單位前先存單位id才不會讀不到
        Unit.KillUnit(obj.object)
        -- Timer(obj:get '刷新時間', false, function()
        Timer(5, false, function()
            local unit = cj.CreateUnit(cj.Player(cj.PLAYER_NEUTRAL_AGGRESSIVE), id, obj.revivePoint.x, obj.revivePoint.y, cj.GetRandomReal(0, 180))
            Unit(unit) -- 新單位註冊實例
            Game:EventDispatch("單位-創建", unit)
            obj:Remove() -- 移除實例
        end)
    end)
    Game:Event "單位-創建" (function(self, target)
        cj.TriggerRegisterUnitEvent(trg, target, cj.EVENT_UNIT_DEATH)
    end)
end

function mt.KillUnit(unit)
    js.RemoveUnit(unit)
end

function Unit:__call(unit)
    if not unit then
        return 
    end
    local obj = Unit[js.H2I(unit) .. ""]
    if not obj then
        obj = {
            object = unit,
            handle = js.H2I(unit),
            name = cj.GetUnitName(unit),
            owner = Player(cj.GetOwningPlayer(unit)),
            revivePoint = Point:GetUnitLoc(unit)
        }
        Unit[js.H2I(unit) .. ""] = obj -- 利用單位呼叫實例
        setmetatable(obj, self)
        obj.__index = obj
        obj:InitUnitState() -- 初始化單位狀態
    end
    return obj
end

function mt:Remove()
    Unit[js.H2I(self.object) .. ""] = nil -- 清除實例
    self = nil
end 

function mt:AddAbility(id, lv)
    lv = lv or 1
    id = (type(id) == "number") and id or Base.String2Id(id)
    cj.UnitAddAbility(self.object, id)
    cj.SetUnitAbilityLevel(self.object, id, lv)
end

function mt:RemoveAbility(id)
    id = (type(id) == "number") and id or Base.String2Id(id)
    cj.UnitRemoveAbility(self.object, id)
end

function mt:HasAbility(id)
    id = (type(id) == "number") and id or Base.String2Id(id)
    return cj.GetUnitAbilityLevel(self.object, id) > 0
end

function mt:ResetAbility(id)
    self:RemoveAbility(id)
    self:AddAbility(id)
end

function Unit.Create(player, id, loc, facing)
    return cj.CreateUnit(player, Base.String2Id(id), loc.x, loc.y, facing)
end

function mt:AbilityDisable(id)
    id = (type(id) == "number") and id or Base.String2Id(id)
    cj.SetPlayerAbilityAvailable(self.owner.object, id, false)
end

function mt:AbilityEnable(id)
    id = (type(id) == "number") and id or Base.String2Id(id)
    cj.SetPlayerAbilityAvailable(self.owner.object, id, true)
end

function mt:Event(eventName)
    return Event(self, eventName)
end

function mt:EventDispatch(eventName, ...)
	local res = Event.Dispatch(self, eventName, ...)
	if res ~= nil then
		return res
	end
	local player = self.owner
	if player then
		local res = Event.Dispatch(self, eventName, ...)
		if res ~= nil then
			return res
		end
	end
	local res = Event.Dispatch(Game, eventName, ...)
	if res ~= nil then
		return res
	end
	return nil
end

function mt:IsAlive()
    return self:get "生命" > 0.3
end

return Unit