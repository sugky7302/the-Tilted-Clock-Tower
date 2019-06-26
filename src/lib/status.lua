local require = require
local type = type

local Status = require 'util.class'("Status")
local SetStatus

function Status:_new()
    local Status_db = require 'data.status_db'
    
    local instance = {}
    Status_db:queryAll(function(data)
        instance[data[1]] = data[2] or false
    end)

    return instance
end

function Status:enable(label)
    SetStatus(self, label, true)
end

function Status:disable(label)
    SetStatus(self, label, false)
end

SetStatus = function(self, label, status)
    if self[label] == nil then
        return false
    end

    if type(self[label]) == 'boolean' then
        self[label] = status
        return true
    elseif type(self[label]) == 'table' then
        for _, v in ipairs(self[label]) do
            SetStatus(self, v, status)
        end
    end
end

function Status:isEnable(label, status)
    if self[label] == nil then
        return false
    end

    status = status or true

    if type(self[label]) == 'boolean' then
        return (status and self[label])
    elseif type(self[label]) == 'table' then
        for _, v in ipairs(self[label]) do
            status = status and self:isEnable(v, status)
        end

        return status
    end
end

function Status:compose(name, labels)
    for _, v in ipairs(labels) do
        if self[v] == nil then
            return false
        end
    end

    self[name] = labels
end

return Status