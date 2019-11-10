local Enchant = require 'util.class'("Enchant")


function Enchant:_new(attribute)
    return {
        _object_ = attribute,
        _message_ = nil,
    }
end

function Enchant:getMessage()
    return self._message_
end

function Enchant:invoke(secrets)
    local name, value = secrets:getAttribute()
    self._object_:insert(name, value, false)

    local message = self._object_:getMessage()
    if message == "full" then
        self._message_ = "|cff00ff00提示|r - 沒有空的秘環可以附魔。"
        -- secrets:addCount()
    elseif message == "duplicate" then
        self._message_ = "|cff00ff00提示|r - 已附魔相同屬性的秘物。"
    else
        self._message_ = "|cff00ff00提示|r - 附魔成功。"
    end
end

return Enchant