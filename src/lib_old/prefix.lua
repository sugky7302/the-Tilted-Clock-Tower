local require = require
local table = table


local Prefix = require 'util.class'("Prefix")
local GetAttributePrefix, GetBSOPrefix, GetIntensityPrefix, GetSSOPrefix

function Prefix:_new(equipment, attribute, intensity, big_secret_order, small_secret_order)
    return {
        _object_ = equipment,
        _attributes_ = attribute,
        _big_secret_order_ = big_secret_order or nil,
        _small_secret_order_ = small_secret_order or nil,
        _intensity_ = intensity,
        _prefix_ = prefix,
    }
end

function Prefix:getPrefix()
    return self._prefix_
end

function Prefix:invoke()
    self._prefix_ = table.concat{
        GetBSOPrefix(self),
        GetSSOPrefix(self),
        GetIntensityPrefix(self),
        self._object_.color_,
        GetAttributePrefix(self),
        self._object_:getName(),
        "|r|n"
    }
end

GetBSOPrefix = function(self)
    if self._big_secret_order_ then
        return table.concat{"|cff804000", "|r|n"}
    else
        return ""
    end
end

GetSSOPrefix = function(self)
    if self._small_secret_order_ then
        return table.concat{"|cffff8d00", "|r|n"}
    else
        return ""
    end
end

GetIntensityPrefix = function(self)
    return table.concat{"|cff00ff00+", self._intensity_:getLevel(), "|r "}
end

GetAttributePrefix = function(self)
    local attribute_db = require 'data.attribute_db'
    local unlocked_attributes = {}

    for i = 1, self._attributes_:size() do
        if not self._attributes_:isLocked(i) then
            local attribute = attribute_db:query(self._attributes_:getName(i))
            
            unlocked_attributes[#unlocked_attributes + 1] = {
                attribute[0],
                attribute[5],
                self._attributes_:getValue(i)
            }
        end
    end

    table.sort(unlocked_attributes, function(a, b)
        if a[3] > b[3] then
            return true
        elseif (a[3] == b[3]) and (a[1] < b[1]) then
            return true
        else
            return false
        end
    end)
    
    local count = #unlocked_attributes

    if count > 1 then
        return table.concat{
            unlocked_attributes[1][2],
            "之",
            unlocked_attributes[2][2],
            "的"
        }
    elseif count == 1 then
        return table.concat{
            unlocked_attributes[1][2],
            "的"
        }
    else
        return ""
    end
end

return Prefix