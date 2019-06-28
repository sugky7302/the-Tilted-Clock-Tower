local require = require


local Equipment = require 'util.class'("Equipment", require 'lib.item')
local LoadConfigFromDatabase


function Equipment:_new(tb)
    local instance = self:super():_new(tb)
    instance._level_ = tb.level or 1
    instance.color_ = "|cffffffff"
    instance._attributes_ = require 'lib.attribute':new()
    instance._stack_behavior_ = nil
    instance._activate_behavior_ = nil
    instance._extend_hole_ = require 'lib.extend_hole':new(instance, instance._attributes_)
    instance._enchant_ = require 'lib.enchant':new(instance._attributes_)
    instance._alchemy_ = nil
    instance._intensity_ = require 'lib.intensity':new(instance, instance._attributes_)
    instance._prefix_ = require 'lib.prefix':new(instance, instance._attributes_, instance._intensity_)
    instance._printer_ = require 'lib.printer':new(
        instance,
        instance._attributes_,
        instance._intensity_,
        instance._prefix_
    )

    LoadConfigFromDatabase(instance)

    return instance
end

LoadConfigFromDatabase = function(self)
    local Equipment_db = require 'data.equipment_db'
    
    local data = Equipment_db:query(self._type_)
    if not data then
        return false
    end

    self._level_ = data[2]

    if data[4] then
        for name, value in pairs(data[4]) do
            self._attributes_:insert(name, value, true)
        end
    end

    self._attributes_.limit_ = self._attributes_:size() + (data[3] or 0)
end

function Equipment:getAttributes()
    return self._attributes_
end

function Equipment:getLevel()
    return self._level_ + self._intensity_:getLevel()
end

function Equipment:getName()
    return self._name_
end

function Equipment:getGearScore()
    local attribute_db = require 'data.attribute_db'
    local score, weight = 0

    for i = 1, self._attributes_:size() do
        weight = attribute_db:query(self._attributes_:getName(i))[3]
        score = score + self._attributes_:getValue() * weight
    end

    return score
end

function Equipment:update()
    self._attributes_:sort()
    self._prefix_:invoke()
    self._printer_:invoke()
end

function Equipment:print(is_expend)
    local msg = {self._prefix_:getPrefix()}

    if is_expend then
        msg[#msg + 1] = self._printer_:getInfo()
    end

    return table.concat(msg)
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
