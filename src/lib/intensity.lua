local require = require
local concat = table.concat
local rand = require 'util.math_lib'.rand


local Intensity = require 'util.class'("Intensity")
local GetUpvalue, AttributeCanIncrease, Success, Fail, CanIntensify, IsLimited, GetCost, IsNotEnough


function Intensity:_new(equipment)
    return {
        _object_ = equipment,
        _message_ = nil,
        _level_ = 0,
        _fail_times_ = 0,
    }
end

function Intensity:getLevel()
    return self._level_
end

function Intensity:getMessage()
    return self._message_
end

function Intensity:invoke()
    if IsLimited(self) then
        self._message_ = concat{"|cff00ff00提示|r - ", self._object_:getName(), " 的精煉值已達上限。"}
        return false
    end

    if IsNotEnough(self) then
        self._message_ = concat{"|cff00ff00提示|r - 你還缺少", GetCost(self) - 100, "。"}
        return false 
    end

    if not CanIntensify(self) then
        self._message_ = concat{"|cff00ff00提示|r - ", self._object_:getName(), " 精煉失敗。"}
        Fail(self)
        return false
    end

    Success(self)
    self._message_ = concat{"|cff00ff00提示|r - ", self._object_:getName(), " 精煉成功。"}
    return true
end

IsLimited = function(self)
    return self._level_ > 9
end

-- HACK: 目前只是暫時設定
IsNotEnough = function(self)
    local cost = GetCost(self)
    return GetCost(self) > 100 
end

GetCost = function(self)
    local PRICE_MAGNIFICATION = {[0] = 1, 2, 3, 4, 6, 8, 10, 14, 18, 22, 31}

    local base = 50 * (2 + math.modf(self._object_:getLevel() + self._level_ - 1) / 8)
    local punish_proc = 1 + 0.2 * self._fail_times_
    
    return base * self._object_:getGearScore() * PRICE_MAGNIFICATION[self._level_] * punish_proc
end

CanIntensify = function(self)
    local p
    if self._level_ < 4 then
        p = 100 - 16 * self._level_
    else
        p = 100 / self._level_
    end

    return rand(100) <= p
end

Fail = function(self)
    self._fail_times_ = self._fail_times_ + 1
end

Success = function(self)
    -- 精鍊成功會重置失敗次數
    self._fail_times_ = 0
    self._level_ = self._level_ + 1

    local fix, random_max = GetUpvalue(self._level_)
    local attribute = self._object_:getAttributes()
    local name

    for i = 1, attribute:size() do
        name = attribute:getName(i)

        if AttributeCanIncrease(name) then
            attribute:addValue(name, fix + rand(rnadom_max))
        end
    end
    
end

GetUpvalue = function(level)
    local UPVALUE = { -- 奇數元素是固定提升值，偶數是隨機提升值
        1, 0,
        1, 0,
        1, 0,
        1, 1,
        1, 1,
        1, 1,
        2, 2,
        2, 2,
        2, 2,
        4, 5
    }
    
    return UPVALUE[2*level], UPVALUE[2*level + 1]
end

AttributeCanIncrease = function(name)
    local Attribute_db = require 'data.attribute_db'
    return Attribute_db:query(name)[5]
end

return Intensity