local require = require
local table = table
local Attribute_db = require 'data.attribute_db'


local Attribute = require'util.class'("Attribute", require 'util.stl.array')


function Attribute:__tostring()
    local print_tb = {"["}
    local single

    for i = 1, self._end_-1 do
        single = {}
        for j = 1, #self[i] do
            single[#single+1] = self[i][j]
        end
        
        -- boolean無法被轉換成字串，要自己手動改
        local length = #single
        if single[length] then
            single[length] = "true"
        else
            single[length] = "false"
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

local GetFormattedText

function Attribute:insert(name, value, is_fixed)
    local attribute = Attribute_db:query(name)

    if #attribute < 2 then
        return false
    end

    self:super().push_back(self, {
        attribute[1], -- 優先級
        name,
        value or 0,
        GetFormattedText(attribute[3], value), -- 將格式文字套入數字
        is_fixed or false
    })
end

function Attribute:addValue(key, value)
    self:setValue(key, self:getValue(key) + value)
end

local Query

-- BUG: 如果key是整數，有可能是索引或是優先級，這部分還沒處理
function Attribute:getValue(key)
    local attribute = Query(self, key)

    if attribute then
        return attribute[3]
    end

    return nil
end

function Attribute:setValue(key, value)
    local attribute = Query(self, key)

    if not attribute then
        return false
    end

    attribute[3] = value
    
    local formatter = Attribute_db:query(key)[3]
    attribute[4] = GetFormattedText(formatter, value)
end

GetFormattedText = function(formatter, value)
    local value_tostring = table.concat{value, ""}
    return string.gsub(formatter, "N", value_tostring)
end

function Attribute:getName(index)
    local attribute = self[index]

    if attribute then
        return attribute[2]
    end

    return nil
end

local Comparison

Query = function(self, key)
    if type(key) == "number" then
        return self[key]
    end

    local index = self:super().exist(self, key, Comparison)
    return self[index]
end

function Attribute:erase(name)
    self:super().erase(self, name, Comparison)
end

Comparison = function(element, data)
    return element[2] == data
end

return Attribute

