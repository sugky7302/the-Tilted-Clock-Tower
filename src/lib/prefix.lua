local require = require


local Prefix = require 'util.class'("Prefix")


function Prefix:_new(attributes)
    return {
        _object_ = attributes,
        _prefix_ = "",
    }
end

function Prefix:getPrefix()
    return self._prefix_
end

function Prefix:generate()
    local table = table
    local attribute_db = require 'data.attribute_db'
    local unlocked_attributes = {}
    
    for i = 1, self._object_:size() do
        if not self._object_:isLocked(i) then
            unlocked_attributes[#unlocked_attributes + 1] = {
                attribute_db:query(self._object_:getName(i))[6],
                self._object_:getValue(i)
            }
        end
    end

    table.sort(unlocked_attributes, function(a, b)
        return a[2] > b[2]
    end)
    
    local count = #unlocked_attributes

    if count > 1 then
        self._prefix_ = table.concat{
            unlocked_attributes[1][1],
            "之",
            unlocked_attributes[2][1],
            "的"
        }
    elseif count == 1 then
        self._prefix_ = table.concat{
            unlocked_attributes[1][1],
            "的"
        }
    else
        self._prefix_ = ""
    end
end

return Prefix