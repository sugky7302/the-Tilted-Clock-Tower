local require = require
local concat = table.concat

local ExtendHole = require 'util.class'("ExtendHole")
local MAX_HOLE_COUNT = 5
local CanExtend, IsNotEnough, GetCost

function ExtendHole:_new(equipment, attributes)
    return {
        _object_ = equipment,
        _attributes_ = attributes,
        _message_ = nil,
    }
end

function ExtendHole:getMessage()
    return self._message_
end

function ExtendHole:invoke()
    if IsFullHole(self) then
        self._message_ = concat{"|cff00ff00提示|r - ", self._object_:getName(), " 的環數已達上限。"}
        return false
    end

    if IsNotEnough(self) then
        self._message_ = concat{"|cff00ff00提示|r - 你還缺少", GetCost(self) - 100, "。"}
        return false 
    end

    -- 扣錢
    
    self._attributes_.limit_ = self._attributes_.limit_ + 1
    self._message_ = concat{"|cff00ff00提示|r - ", self._object_:getName(), " 鑲環成功。"}
    return true
end

IsFullHole = function(self)
    return self._attributes_.limit_ >= MAX_HOLE_COUNT
end

IsNotEnough = function(self)
    return 12000 < GetCost(self)
end

GetCost = function(self)
    local e = require 'util.math_lib'.e
    local hole_count = self._attributes_:size()
    local level = self._object_:getLevel()
    return 100 * e^hole_count  * level * (math.modf((level-1) / 8) + 1)
end

return ExtendHole

