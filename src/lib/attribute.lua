local require = require
local table = table
local type = type
local Attribute_db = require 'data.attribute_db'


local Attribute = require'util.class'("Attribute", require 'util.stl.array')
local Query, GetFormattedText, Comparison, IsFull, Exist


function Attribute:_new(limit)
    local instance = self:super():_new()
    instance.limit_ = limit or 0
    instance._message_ = nil
    return instance
end

function Attribute:__tostring()
    local print_tb = {"["}
    local single, length

    for i = 1, self._end_-1 do
        single = {}

        for j = 1, #self[i] do
            single[#single+1] = self[i][j]
        end
        
        -- boolean無法被轉換成字串，要自己手動改
        length = #single
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

function Attribute:getMessage()
    return self._message_
end

function Attribute:getName(index)
    if type(index) == "string" then
        return nil
    end

    local attribute = self[index]
    if attribute then
        return attribute[2]
    end

    return nil
end

function Attribute:isLocked(index)
    if type(index) == "string" then
        return nil
    end

    local attribute = self[index]
    if attribute then
        return attribute[5]
    end

    return nil
end

function Attribute:sort()
    table.sort(self, function(a, b)
        return a[1] < b[1]
    end)
end

function Attribute:insert(name, value, is_locked)
    local attribute = Attribute_db:query(name)

    if not attribute then
        self._message_ = "none"
        return false
    end

    if IsFull(self) then
        self._message_ = "full"
        return false
    end

    if Exist(self, name) then
        self._message_ = "duplicate"
        return false
    end

    self:super().push_back(self, {
        attribute[1], -- 優先級
        name,
        value or 0,
        GetFormattedText(attribute[3], value), -- 將格式文字套入數字
        is_locked or false,
    })

    self._message_ = "success"
end

IsFull = function(self)
    return (self.limit_ > 0) and (self:size() >= self.limit_)
end

Exist = function(self, name)
    return self:super().exist(self, name, function(attribute, data)
        return attribute[2] == data
    end)
end

function Attribute:addValue(key, value)
    self:setValue(key, self:getValue(key) + value)
end

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
        return nil
    end

    attribute[3] = value
    
    local formatter = Attribute_db:query(key)[3]
    attribute[4] = GetFormattedText(formatter, value)
end

GetFormattedText = function(formatter, value)
    local value_tostring = table.concat{value, ""}
    return string.gsub(formatter, "N", value_tostring)
end

function Attribute:erase(name)
    if type(name) == "number" then
        return false
    end

    local attribute = Query(self, name)
    if not attribute then
        return false
    end

    -- 沒有被鎖住的屬性才會執行
    if attribute[5] == false then
        self:super().erase(self, name, Comparison)
    end
end

Query = function(self, key)
    if type(key) == "number" then
        return self[key]
    end

    local index = self:super().exist(self, key, Comparison)
    return self[index]
end

Comparison = function(element, data)
    return element[2] == data
end

return Attribute