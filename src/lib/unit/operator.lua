-- 提供單位屬性操作
-- 大多數的單位屬性實際是由四個個數值合併而成
-- 實際值 = min(最大值, max(最小值, 基礎值 * (1 + 百分比 / 100)))


local Operator = {}

-- assert
local IsCallMax, IsCallMin, IsCallPercent, InitAttribute, GetRealValue, Error
local string_sub, type, concat = string.sub, type, table.concat
local set, get = {}, {} -- 無特殊條件
local on_add, on_set, on_get = {}, {}, {} -- 有特殊條件

function Operator.Register(name, reg_tb)
    set[name] = reg_tb.set or nil
    get[name] = reg_tb.get or nil
    on_add[name] = reg_tb.on_add or nil
    on_set[name] = reg_tb.on_set or nil
    on_get[name] = reg_tb.on_get or nil
    
    reg_tb = nil
end

-- 可修改基礎值、百分比
-- 無法修改最大值、最小值
function Operator.add(self, name, value)
    -- 不可修改最大值或最小值
    if IsCallMax(name) or IsCallMin(name) then
        Error(name)
        return false
    end

    local v1, v2 = 0, nil

    -- 獲取最尾端字符，判斷是否為定值
	if string_sub(name, -1, -1) == '%' then
        v2 = value
        
        -- 截去尾端，讀取屬性名
		name = string_sub(name, 1, -2)
	else
		v1 = value
    end

    -- 特殊屬性不得修改
    if type(self[name]) == 'string' or type(self[name]) == 'table' then
        return false
    end

	if not self[name] then
        InitAttribute(self, name)
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
		self[name] = self[name] + v1
    end

    -- 加百分比
	if v2 then
		self[concat({name, "%"})] = self[concat({name, "%"})] + v2
    end
    
    if set[name] then
		set[name](self, GetRealValue(self, name))
    end
    
	if f then
		f()
	end
end

-- 可修改基礎值
-- 百分比歸零
-- 無法修改最大值、最小值
function Operator.set(self, name, value)
    -- 不可修改最大值或最小值
    -- 不可修改百分比
    if IsCallMin(name) or IsCallMax(name) or IsCallPercent(name) then
        Error(name)
        return false
    end

    if not self[name] then
        InitAttribute(self, name)
    end

	local f
	if on_set[name] then
		f = on_set[name](self)
    end
    
	-- 只加基礎值，不加百分比
    self[name] = value
    self[concat({name, "%"})] = 0

	if set[name] then
		set[name](self, GetRealValue(self, name))
    end
    
	if f then
		f()
	end
end

function Operator.setMax(self, name, value)
    if IsCallMax(name) then
        self[concat({name, "_max"})] = value
    end

    Error(name)
    return false
end

function Operator.setMin(self, name, value)
    if IsCallMin(name) then
        self[concat({name, "_min"})] = value
    end

    Error(name)
    return false
end

-- 只能用一般屬性索引調用，加 _max _min都無法調用
function Operator.get(self, name)
    -- 不可獲取最大值或最小值
    if IsCallMax(name) or IsCallMin(name) then
        Error(name)
        return false
    end

    -- type1 = 0(定值) or 1(百分比)
	local type1 = 0
	if string_sub(name, -1, -1) == '%' then
		name = string_sub(name, 1, -2)
		type1 = 1
    end

    -- 特殊屬性直接回傳
    if type(self[name]) == 'string' or type(self[name]) == 'table' then
        return self[name]
    end

    if not self[name] then
        InitAttribute(self, name)
    end

	if type1 == 1 then
		return self[concat({name, '%'})]
    end

	if on_get[name] then
		return on_get[name](self, GetRealValue(self, name))
    end

	return GetRealValue(self, name)
end

IsCallMax = function(name)
    if string_sub(name, -1, -4) == "_max" then
        return true
    end

    return false
end

IsCallMin = function(name)
    if string_sub(name, -1, -4) == "_min" then
        return true
    end

    return false
end

IsCallPercent = function(name)
    if string_sub(name, -1, -1) == '%' then
        return true
    end

    return false
end

Error = function(name)
    error(concat({'錯誤的屬性名:', tostring(name)}))
end

-- assert
local MAX_VALUE, MIN_VALUE, PERCENT = 1000000, -1000000, 0

InitAttribute = function(self, name)
    local key1 = name                   -- 數值
    local key2 = concat({name, '%'})    -- 百分比
    local key3 = concat({name, '_max'}) -- 最大值
    local key4 = concat({name, '_min'}) -- 最小值

	self[key1] = get[name] and get[name](self) or 0
    self[key2] = PERCENT
    self[key3] = MAX_VALUE -- 隨便設定一個極高的值，才不怕 self[key1] 超過它
    self[key4] = MIN_VALUE -- 隨便設定一個極低的值，才不怕 self[key1] 小過它
end

GetRealValue = function(self, name)
    local key1 = name                   -- 數值
    local key2 = concat({name, '%'})    -- 百分比
    local key3 = concat({name, '_max'}) -- 最大值
    local key4 = concat({name, '_min'}) -- 最小值

    local Bound = require 'math_lib'.BoundValue
    return Bound(self[key4] or MIN_VALUE, self[key1] * (1 + (self[key2] or PERCENT) / 100), self[key3] or MAX_VALUE)
end

return Operator
