local require = require
local table = table
local _, ATTRIBUTE_INDEX, ATTRIBUTE_STATE, _ = require 'data.attributes'()


local Attribute = require'util.class'("Attribute", require 'util.stl.array')


function Attribute:__tostring()
    local print_tb = {"["}
    local single

    for i = 1, self._end_-1 do
        single = {}
        for j = 1, 4 do
            single[#single+1] = self[i][j]
        end
        
        -- boolean無法被轉換成字串，要自己手動改
        if single[4] then
            single[4] = "true"
        else
            single[4] = "false"
        end

        print_tb[#print_tb+1] = table.concat(single, " ")
    end

    print_tb[#print_tb+1] = "]"

    return table.concat(print_tb, "\n")
end

function Attribute:sort()
    table.sort(self, function(a, b)
        return a[1] < b[1]
    end)
end

function Attribute:push_back(name, value, description, is_fixed)
    self:super().push_back(self, {
        ATTRIBUTE_INDEX[name],
        value or 0,
        description or "",
        is_fixed or false
    })
end

local Comparison

function Attribute:erase(name)
    self:super().erase(self, ATTRIBUTE_INDEX[name], Comparison)
end

function Attribute:exist(name)
    return self:super().exist(self, ATTRIBUTE_INDEX[name], Comparison)
end

Comparison = function(element, data)
    return element[1] == data
end

return Attribute

