local require = require


local Equipment = require 'util.class'("Equipment", require 'lib.item')
local LoadConfigFromDatabase


function Equipment:_new(tb)
    local Attributes = require 'lib.attribute'
    local Intensity = require 'lib.intensity'
    local Enchant = require 'lib.enchant'
    local Prefix = require 'lib.prefix'

    local instance = self:super():_new(tb)
    instance._level_ = tb.level or 1
    instance._color_ = nil
    instance._attributes_ = Attributes()
    instance._stack_behavior_ = nil
    instance._activate_behavior_ = nil
    instance._extend_hole_ = nil
    instance._enchant_ = Enchant(instance._attributes_)
    instance._alchemy_ = nil
    instance._intensity_ = Intensity(instance)
    instance._printer_ = nil
    instance._prefix_ = Prefix(instance._attributes_)

    LoadConfigFromDatabase(instance)

    return instance
end

LoadConfigFromDatabase = function(self)
    local Equipment_db = require 'data.equipment_db'
    
    local data = Equipment_db:query(self._type_)
    if not data then
        return false
    end

    self._level_ = data[3]

    if data[5] then
        for name, value in pairs(data[5]) do
            self._attributes_:insert(name, value, true)
        end
    end

    self._attributes_.limit_ = self._attributes_:size() + (data[4] or 0)
end

function Equipment:getAttributes()
    return self._attributes_
end

function Equipment:getLevel()
    return self._level_
end

function Equipment:getName()
    return table.concat{"+", self._intensity_:getLevel(), " ",
        self._prefix_:getPrefix(), self._name_}
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
    self._prefix_:generate()
end

function Equipment:print()
end


function Equipment:intensify()
    self._intensity_:invoke()
    return self._intensity_:getMessage()
end

function Equipment:extendHole()
    self._extend_hole_:invoke()
    return self._extend_hole_:getMessage()
end

function Equipment:enchanting(secrets)
    self._enchant_:invoke(secrets)
    return self._enchant_:getMessage()
end

function Equipment:alcheming()
    self._alchemy_:invoke()
    return self._alchemy_:getMessage()
end

return Equipment
