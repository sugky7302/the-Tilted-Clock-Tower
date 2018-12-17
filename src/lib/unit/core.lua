-- 此module創建unit結構，擴展we的單位的功能

local setmetatable = setmetatable

local cj = require 'jass.common'
local Player = require 'player'

local Unit, mt = {}, {}
setmetatable(Unit, Unit)
Unit.__index = mt

-- constants
mt.type = "Unit"
mt.RACE     = {'龍族', '元素', '靈魂', '動物', '人形', '人造', '惡魔'}
mt.ELEMENTS = {"無", "地", "水", "火", "風"}
mt.LEVEL    = {"普通", "菁英", "稀有菁英", "頭目"}

-- assert
local H2I, S2Id = require 'jass_tool'.H2I, Base.String2Id
local GetBodySize, InitUnitState

function Unit:__call(unit)
    if H2I(unit) == 0 then
        return false
    end

    local instance = self[H2I(unit) .. ""]
    if not instance then
        local U2Id = require 'jass_tool'.U2Id
        local Point = require 'point'

        instance = {
            object_           = unit,
            id_               = Base.Id2String(U2Id(unit)),
            handle_           = H2I(unit),
            name_             = cj.GetUnitName(unit),
            owner_            = Player(cj.GetOwningPlayer(unit)),
            revive_point_     = Point.GetUnitLoc(unit),
            is_spell_damaged_ = false
        }

        self[H2I(unit) .. ""] = instance

        setmetatable(instance, self)

        InitUnitState(instance) -- 初始化單位狀態
    end

    return instance
end

InitUnitState = function(self)
    local slk_unit = require 'jass.slk'.unit
    local data = slk_unit[Base.Id2String(cj.GetUnitTypeId(self.object_))]
    if not data then
        return false
    end

    self['等級'] = data.level
    self['骰子面數'] = 7
    self['法術攻擊力'] = 0
    self['元素抗性'] = 0
    self['攻擊範圍'] = data.rangeN1
    self['魔力恢復'] = 0
    self['生命恢復'] = 0
    self['物理暴擊'] = 0
    self['法術暴擊'] = 0
    self['種族'] = mt.RACE[data.goldcost]
    self['物理韌性'] = 0
    self['法術韌性'] = 0
    self['施法速度'] = 0
    self['物理穿透'] = 0
    self['法術穿透'] = 0
    self['物理格擋'] = 0
    self['法術格擋'] = 0
    self['閃避'] = 0
    self['命中'] = 1
    self['階級'] = data.points
    self['元素屬性'] = "無"
    self['體型'] = GetBodySize(data.collision)

    if self.type_ == 'Unit' then
        self['刷新時間'] = data.stockRegen
    end
end 

GetBodySize = function(collision)
    if collision < 24 then
        return "小"
    elseif collision < 41 then
        return "中"
    else
        return "大"
    end
end

function mt:Remove()
    Unit.RemoveUnit(self.object_)

    Unit[H2I(self.object_) .. ""] = nil -- 清除實例

    local pairs = pairs
    for _, var in pairs(self) do
        var = nil
    end

    self = nil
end 

-- 操作符
local Operator = require 'unit.operator'

function mt:add(name, value)
    Operator.add(self, name, value)
end

function mt:set(name, value)
    Operator.set(self, name, value)
end

function mt:get(name)
    return Operator.get(self, name)
end

-- 事件
local Event = require 'event'

function mt:Event(event_name)
    return Event(self, event_name)
end

function mt:EventDispatch(event_name, ...)
	local res = Event.Dispatch(Unit, event_name, self, ...)
	if res ~= nil then
		return res
    end
    
	local player = self.owner_
	if player then
		local res = Event.Dispatch(Player, event_name, player, ...)
		if res ~= nil then
			return res
		end
    end
    
    local Game = require 'game'
	local res = Event.Dispatch(Game, event_name, ...)
	if res ~= nil then
		return res
    end
    
	return nil
end

-- 功能
function mt:IsAlive()
    return self:get "生命" > 0.3
end

function Unit.IsHero(unit)
    return cj.IsUnitType(unit, cj.UNIT_TYPE_HERO)
end

function Unit.RemoveUnit(unit)
    local RemoveUnit = require 'jass_tool'.RemoveUnit
    RemoveUnit(unit)
end

function Unit.Create(player, id, loc, facing)
    return cj.CreateUnit(player, S2Id(id), loc.x_, loc.y_, facing)
end

-- assert
local type = type

function mt:AbilityDisable(id)
    -- 把id轉換成ASCII格式
    local id_ASCII = (type(id) == "number") and id or S2Id(id)

    cj.SetPlayerAbilityAvailable(self.owner_.object_, id_ASCII, false)
end

function mt:AbilityEnable(id)
    local id_ASCII = (type(id) == "number") and id or S2Id(id)
    cj.SetPlayerAbilityAvailable(self.owner_.object_, id_ASCII, true)
end

function mt:AddAbility(id, lv)
    lv = lv or 1 -- 初始值

    local id_ASCII = (type(id) == "number") and id or S2Id(id)

    cj.UnitAddAbility(self.object_, id_ASCII)
    cj.SetUnitAbilityLevel(self.object_, id_ASCII, lv)
end

function mt:RemoveAbility(id)
    local id_ASCII = (type(id) == "number") and id or S2Id(id)
    cj.UnitRemoveAbility(self.object_, id_ASCII)
end

function mt:HasAbility(id)
    local id_ASCII = (type(id) == "number") and id or S2Id(id)
    return cj.GetUnitAbilityLevel(self.object_, id_ASCII) > 0
end

function mt:ResetAbility(id)
    self:RemoveAbility(id)
    self:AddAbility(id)
end

return Unit