local require = require
local Equipment = require 'util.class'(require 'lib.item')


function Equipment:__new()
    local Attributes = require 'lib.attribute'

    local instance = self:super():__new()
    instance._level_ = 0
    instance._color_ = nil
    instance._attributes_ = Attributes()
    instance._stack_behavior_ = nil
    instance._activate_behavior_ = nil
    instance._extend_hole_ = nil
    instance._enchant_ = nil
    instance._alchemy_ = nil
    instance._intensity_ = nil

    return instance
end

function Equipment:getAttributes()
    return self._attributes_
end

function Equipment:getLevel()
    return self._level_
end

function Equipment:getGearScore()
    local attribute_db = require 'data.attribute_db'
    local score, weight = 0

    for i = 1, self._attributes_:size() do
        weight = attribute_db:query(self._attributes_:getName(i))
        score = score + self._attributes_:getValue() * weight
    end

    return score
end

function Equipment:update()
    self._attributes_:sort()
    -- 設定詞綴
end

function Equipment:print()
end

function Equipment:getName()
    return self._name_
end

function Equipment:intensify()
    self._intensity_:invoke()
end

function Equipment:extendHole()
    self._extend_hole_:invoke()
end

function Equipment:enchanting()
    self._enchant_:invoke()
end

function Equipment:alcheming()
    self._alchemy_:invoke()
end

return Equipment
