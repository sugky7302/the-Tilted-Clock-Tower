local require = require
local concat = table.concat


local Printer = require 'util.class'("Printer")
local GetAttributeInfo, GetBSOInfo, GetBaseInfo, GetSSOInfo

function Printer:_new(equipment,attribute, intensity, prefix, big_secret_order, small_secret_order)
    return {
        _info_ = "",
        _object_ = equipment,
        _attribute_ = attribute,
        _big_secret_order_ = big_secret_order,
        _small_secret_order_ = small_secret_order,
        _intensity_ = intensity,
        _prefix_ = prefix,
    }
end

function Printer:getInfo()
    return self._info_
end

function Printer:invoke()
    self._info_ = concat{
        GetBaseInfo(self),
        GetAttributeInfo(self),
        GetSSOInfo(self),
        GetBSOInfo(self)
    }
end

GetBaseInfo = function(self)
    return concat{
        "|cff808080Lv ",
        self._object_:getLevel(),
        " / Gs ",
        self._object_:getGearScore(),
        "|r|n"
    }
end

GetAttributeInfo = function(self)
    local info = {}

    for i = 1, self._attribute_.limit_ do
        if self._attribute_[i] then
            info[#info + 1] = "|cff3366ff◆|r|cff99ccff"
            info[#info + 1] = self._attribute_[i][4]
        else
            info[#info + 1] = "|cff3366ff◇"
        end

        info[#info + 1] = "|r|n"
    end

    return concat(info)
end

GetSSOInfo = function(self)
    if self._small_secret_order_ then
        return concat{
            "|cffff8d00",
            "|r|n"
        }
    end

    return ""
end

GetBSOInfo = function(self)
    if self._big_secret_order_ then
        return concat{
            "|cff804000",
            "|r|n"
        }
    end

    return ""
end

return Printer