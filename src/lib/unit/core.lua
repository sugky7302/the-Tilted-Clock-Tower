-- 創建unit結構，擴展we的單位的功能
-- 依賴
--   jass.common
--   jass.slk
--   player
--   jass_tool
--   point
--   unit.operator
--   event
--   game


-- package
local require = require
local cj = require 'jass.common'
local js = require 'jass_tool'
local Player = require 'player'


local Unit = require 'class'("Unit", require 'unit.operator')

-- constants
-- 這樣寫是因為局部變量讀取比較快
local RACE     = {'龍族', '元素', '靈魂', '動物', '人形', '人造', '惡魔'}
local ELEMENTS = {"無", "地", "水", "火", "風"}
local LEVEL    = {"普通", "菁英", "稀有菁英", "頭目"}
Unit.RACE = RACE
Unit.ELEMENTS = ELEMENTS
Unit.LEVEL = LEVEL


-- assert
local Id2S, concat = Base.Id2String, table.concat
local GetBodySize, InitUnitState

function Unit:_new(unit)
    if js.H2I(unit) == 0 then
        return false
    end

    local GetUnitLoc = require 'point'.GetUnitLoc

    self.object_           = unit
    self.id_               = Id2S(js.U2Id(unit))
    self.handle_           = js.H2I(unit)
    self.name_             = cj.GetUnitName(unit)
    self.owner_            = Player(cj.GetOwningPlayer(unit))
    self.revive_point_     = GetUnitLoc(unit)
    self.is_spell_damaged_ = false
    
    Unit:setInstance(concat({js.H2I(unit), ""}), self)

    -- 初始化單位狀態
    InitUnitState(self)
end

InitUnitState = function(self)
    local slk_unit = require 'jass.slk'.unit
    
    local data = slk_unit[Id2S(cj.GetUnitTypeId(self.object_))]
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
    self['種族'] = RACE[data.goldcost]
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

    if self.type == 'Unit' then
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

function Unit:_delete()
    js.RemoveUnit(self.object_)

    Unit:deleteInstance(self.handle_)
end 

function Unit:getInstance(unit)
    local instance = self[concat({"instance_", js.H2I(unit)})]
    return instance
end


-- package
local Event = require 'event'

function Unit:Event(event_name)
    return Event(Unit, event_name)
end

function Unit:EventDispatch(event_name, ...)
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
function Unit:IsAlive()
    return self:get "生命" > 0.3
end

function Unit.IsHero(unit)
    return cj.IsUnitType(unit, cj.UNIT_TYPE_HERO)
end

-- assert
local S2Id = Base.String2Id
local type = type

-- 直接寫return cj.CreateUnit會沒有返回單位
function Unit.Create(player, unit_type, loc, facing)
    unit_type = (type(unit_type) == 'number') and unit_type or S2Id(unit_type)
    local unit = cj.CreateUnit(player, unit_type, loc.x_, loc.y_, facing)
    return unit
end

function Unit:AbilityDisable(id)
    -- 把id轉換成ASCII格式
    local id_ASCII = (type(id) == "number") and id or S2Id(id)

    cj.SetPlayerAbilityAvailable(self.owner_.object_, id_ASCII, false)
end

function Unit:AbilityEnable(id)
    local id_ASCII = (type(id) == "number") and id or S2Id(id)
    cj.SetPlayerAbilityAvailable(self.owner_.object_, id_ASCII, true)
end

function Unit:AddAbility(id, lv)
    lv = lv or 1 -- 初始值

    local id_ASCII = (type(id) == "number") and id or S2Id(id)

    cj.UnitAddAbility(self.object_, id_ASCII)
    cj.SetUnitAbilityLevel(self.object_, id_ASCII, lv)
end

function Unit:RemoveAbility(id)
    local id_ASCII = (type(id) == "number") and id or S2Id(id)
    cj.UnitRemoveAbility(self.object_, id_ASCII)
end

function Unit:HasAbility(id)
    local id_ASCII = (type(id) == "number") and id or S2Id(id)
    return cj.GetUnitAbilityLevel(self.object_, id_ASCII) > 0
end

function Unit:ResetAbility(id)
    self:RemoveAbility(id)
    self:AddAbility(id)
end

return Unit