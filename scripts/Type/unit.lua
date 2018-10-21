local setmetatable = setmetatable
local math = math
local cj = require 'jass.common'
local slk = require 'jass.slk'
local japi = require 'jass.japi'
local js = require 'jass_tool'
local Group = require 'group'
local Point = require 'point'
local Timer = require 'timer'
local Game = require 'game'
local War3 = require 'api'
local Event = require 'event'
local Player = require 'player'

local Unit = {}
local mt = {}
setmetatable(Unit, Unit)
Unit.__index = mt

-- constants
mt._RACE = {'龍族', '元素', '靈魂', '動物', '人形', '人造', '惡魔'}
mt._ELEMENTS = {"無", "地", "水", "火", "風"}
mt._LEVEL = {"普通", "菁英", "稀有菁英", "頭目"}
mt.type = "Unit"

-- variables
local set, get, on_add, on_set, on_get = {}, {}, {}, {}, {}
local _GetBodySize

function Unit.Init()
    -- 註冊單位死亡要刷新的事件
    local trg = War3.CreateTrigger(function()
        Game:EventDispatch("單位-刷新", Unit(cj.GetTriggerUnit()))
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
        if Unit(target).type == "Unit" then
            cj.TriggerRegisterUnitEvent(trg, target, cj.EVENT_UNIT_DEATH)
        end
    end)
end

function mt.KillUnit(unit)
    cj.KillUnit(unit)
end

function Unit:__call(unit)
    local obj = Unit[js.H2I(unit) .. ""]
    if not obj then
        obj = {
            object = unit,
            owner = Player(cj.GetOwningPlayer(unit)),
            revivePoint = Point:GetUnitLoc(unit)
        }
        Unit[js.H2I(unit) .. ""] = obj -- 利用單位呼叫實例
        setmetatable(obj, self)
        obj.__index = obj
        obj:InitState() -- 初始化單位狀態
    end
    return obj
end

-- 初始化單位狀態
function mt:InitState()
    local data = slk.unit[Base.Id2String(cj.GetUnitTypeId(self.object))]
    if not data then
        return 
    end
    self['等級'] = data.level
    self['骰子面數'] = 7
    self['法術攻擊力'] = 0
    self['法術護甲'] = 0
    self['元素傷害'] = 0
    self['元素傷害%'] = 0
    self['攻擊範圍'] = data.rangeN1
    self['移動速度'] = data.spd
    self['轉身速度'] = data.turnRate
    self['魔力恢復'] = 0
    self['生命恢復'] = 0
    self['物理暴擊率'] = 0
    self['法術暴擊率'] = 0
    self['種族'] = mt._RACE[data.goldcost]
    self['物理韌性'] = 0
    self['法術韌性'] = 0
    self['施法速度'] = 0
    self['攻擊速度'] = 0
    self['物理穿透'] = 0
    self['法術穿透'] = 0
    self['物理格擋'] = 0
    self['法術格擋'] = 0
    self['閃避'] = 0
    self['命中'] = 1
    self['沉默'] = 0
    self['致盲'] = 0
    self['暈眩'] = 0
    self['定身'] = 0
    self['減速'] = 0
    self['減攻速'] = 0
    self['擊退'] = 0
    self['擊飛'] = 0
    self['嘲諷'] = 0
    self['變形'] = 0
    self['睡眠'] = 0
    self['階級'] = data.points
    self['元素屬性'] = "無"
    self['體型'] = _GetBodySize(data.collision)

    if self.type == 'Unit' then
        self['刷新時間'] = data.stockRegen
    end
end 

_GetBodySize = function(collision)
    if collision < 24 then
        return "小"
    elseif collision < 41 then
        return "中"
    else
        return "大"
    end
end

function mt:add(name, value)
    local v1, v2 = 0, 0
    -- 判斷是否為定值
	if name:sub(-1, -1) == '%' then
		v2 = value
		name = name:sub(1, -2)
	else
		v1 = value
    end
    if type(self[name]) == 'string' then
        return 
    end
	local key1 = name -- 數值
	local key2 = name .. '%' -- 百分比
	if not self[key1] then
		self[key1] = get[name] and get[name](self) or 0
		self[key2] = 0
	end
	local f
	if on_set[name] then
		f = on_set[name](self)
	end
	if on_add[name] then
		v1, v2 = on_add[name](self, v1, v2)
    end
    -- 加定值
	if v1 then
		self[key1] = self[key1] + v1
    end
    -- 加百分比
	if v2 then
		self[key2] = self[key2] + v2
	end
	if set[name] then
		set[name](self, self[key1] * (1 + (self[key2] or 0) / 100))
	end
	if f then
		f()
	end
end

function mt:set(name, value)
    local v1, v2 = 0, 0
    -- 判斷是否為定值
	if name:sub(-1, -1) == '%' then
		v2 = value
		name = name:sub(1, -2)
	else
		v1 = value
	end
	local key1 = name
	local key2 = name .. '%'
	if not self[key1] then
		self[key1] = get[name] and get[name](self) or 0
		self[key2] = 0
	end
	local f
	if on_set[name] then
		f = on_set[name](self)
	end
	-- 加定值
    if v1 then
		self[key1] = v1
    end
    -- 加百分比
	if v2 then
		self[key2] = v2
	end
	if set[name] then
		set[name](self, self[key1] * (1 + (self[key2] or 0) / 100))
	end
	if f then
		f()
	end
end

function mt:get(name)
	local type1 = 0
	if name:sub(-1, -1) == '%' then
		name = name:sub(1, -2)
		type1 = 1
    end
    if type(self[name]) == 'string' then
        return self[name]
    end
	local key1 = name
    local key2 = name .. '%'
    if not self[key1] then
		self[key1] = get[name] and get[name](self) or 0
		self[key2] = 0
	end
	if type1 == 1 then
		return self[key2]
	end
	if on_get[name] then
		return on_get[name](self, self[key1] * (1 + self[key2] / 100))
    end
	return self[key1] * (1 + (self[key2] or 0) / 100)
end

get['生命'] = function(self)
	return cj.GetWidgetLife(self.object)
end

set['生命'] = function(self, life)
	if life > 1 then
		cj.SetWidgetLife(self.object, life)
	else
		cj.SetWidgetLife(self.object, 1)
	end
end

on_get['生命'] = function(self, life)
	if life < 0 then
		return 0
	else
		local maxLife = self:get '生命上限'
		if life > maxLife then
			return maxLife
		end
	end
	return life
end

get['生命上限'] = function(self)
	return cj.GetUnitState(self.object, cj.UNIT_STATE_MAX_LIFE)
end

set['生命上限'] = function(self, maxLife)
	japi.SetUnitState(self.object, cj.UNIT_STATE_MAX_LIFE, maxLife)
end

on_set['生命上限'] = function(self)
	local rate = self:get '生命' / self:get '生命上限'
	return function()
		self:set('生命', self:get '生命上限' * rate)
	end
end

get['魔力'] = function(self)
	return cj.GetUnitState(self.object, cj.UNIT_STATE_MANA)
end

set['魔力'] = function(self, mana)
	cj.SetUnitState(self.object, cj.UNIT_STATE_MANA, math.ceil(mana))
end

on_get['魔力'] = function(self, mana)
	if mana < 0 then
		return 0
	else
		local max_mana = self:get '魔力上限'
		if mana > max_mana then
			return max_mana
		end
	end
	return mana
end

get['魔力上限'] = function(self)
	return cj.GetUnitState(self.object, cj.UNIT_STATE_MAX_MANA)
end

set['魔力上限'] = function(self, maxMana)
	japi.SetUnitState(self.object, cj.UNIT_STATE_MAX_MANA, maxMana)
end

on_set['魔力上限'] = function(self)
	local rate = self:get '魔力' / self:get '魔力上限'
	return function()
		self:set('魔力', self:get '魔力上限' * rate)
	end
end

get['最大物理攻擊力'] = function(self)
    return japi.GetUnitState(self.object, 0x12) + self["骰子面數"]
end

set['最大物理攻擊力'] = function(self, attack)
    local side = math.max(1, attack - self:get "最小物理攻擊力")
    japi.SetUnitState(self.object, 0x11, side)
    self["骰子面數"] = side
end

get['最小物理攻擊力'] = function(self)
    japi.SetUnitState(self.object, 0x10, 1)
    japi.SetUnitState(self.object, 0x11, self["骰子面數"])
	return japi.GetUnitState(self.object, 0x12) + 1
end

set['最小物理攻擊力'] = function(self, attack)
    local old = self:get "最大物理攻擊力"
    japi.SetUnitState(self.object, 0x12, attack - 1)
    if old < attack then
        old = attack
    end
    self:set("最大物理攻擊力", old)
end

get['物理攻擊力'] = function(self)
    return math.modf(self:get "最小物理攻擊力" + self:get "最大物理攻擊力")
end

set['物理攻擊力'] = function(self, attack)
    self:set("最大物理攻擊力", self:get "最大物理攻擊力" + attack)
    self:set("最小物理攻擊力", self:get "最小物理攻擊力" + attack)
end

get['增強物理攻擊力'] = function(self)
    return japi.GetUnitState(self.object, 0x13)
end

set['增強物理攻擊力'] = function(self, value)
    cj.SetUnitState(self.object, 0x13, value)
end

get['物理護甲'] = function(self)
	return japi.GetUnitState(self.object, 0x20)
end

set['物理護甲'] = function(self, defence)
	japi.SetUnitState(self.object, 0x20, defence)
end

get['攻擊間隔'] = function(self)
	return japi.GetUnitState(self.object, 0x25)
end

set['攻擊間隔'] = function(self, attackCool)
	japi.SetUnitState(self.object, 0x25, attackCool)
end

set['攻擊速度'] = function(self, attackSpeed)
	if attackSpeed >= 0 then
		japi.SetUnitState(self.object, 0x51, 1 + attackSpeed / 100)
	else
		--当物理攻擊力速度小于0的时候,每点相当于攻擊間隔增加1%
		japi.SetUnitState(self.object, 0x51, 1 + attackSpeed / (100 - attackSpeed))
	end
end

function mt:Remove()
    Unit[js.H2I(self.object) .. ""] = nil -- 清除實例
    self = nil
end 

function mt:AddAbility(id, lv)
    lv = lv or 1
    cj.UnitAddAbility(self.object, id)
    cj.SetUnitAbilityLevel(self.object, id, lv)
end

function mt:RemoveAbility(id)
    cj.UnitRemoveAbility(self.object, id)
end

function mt:HasAbility(id)
    return cj.GetUnitAbilityLevel(self.object, id) > 0
end

return Unit