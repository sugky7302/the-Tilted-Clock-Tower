local require = require
local Intensity = require 'util.class'("Intensity")
local rand = require 'util.math_lib'.rand


function Intensity:__new(equipment)
    return {
        _object_ = equipment,
        _level_ = 0,
        _fail_times_ = 0,
    }
end

function Intensity:getLevel()
    return self._level_
end

local GetUpvalue, AttributeCanIncrease

function Intensity:success()
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

function Intensity:fail()
    self._fail_times_ = self._fail_times_ + 1
end

function Intensity:isLimited()
    return self._level_ > 9
end

function Intensity:canIntensify()
    local p
    if self._level_ < 4 then
        p = 100 - 16 * self._level_
    else
        p = 100 / self._level_
    end

    return rand(100) <= p
end

function Intensity:getCost()
    local PRICE_MAGNIFICATION = {[0] = 1, 2, 3, 4, 6, 8, 10, 14, 18, 22, 31}

    local base = 50 * (2 + math.modf(self._object_:getLevel() + self._level_ - 1) / 8)
    local punish_proc = 1 + 0.2 * self._fail_times_
    
    return base * self._object_:getGearScore() * PRICE_MAGNIFICATION[self._level_] * punish_proc
end

return Intensity