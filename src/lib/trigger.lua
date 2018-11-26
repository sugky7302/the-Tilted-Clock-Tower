local setmetatable = setmetatable
local Object = require 'object'
local Timer = require 'timer'
local remove = table.remove
local insert = table.insert

local Trigger = {}
local mt = {}
setmetatable(Trigger, Trigger)
Trigger.__index = mt

function Trigger:__call(event, callback)
    local obj = Object{
        event = event,
        callback = callback,
        enableFlag = true,
    }
    insert(event, obj)
    setmetatable(obj, self)
    return obj
end

function mt:Disable()
    self.enableFlag = false
end

function mt:Enable()
    self.enableFlag = true
end

function mt:IsEnable()
    return self.enableFlag
end

function mt:Run(...)
    if self.enableFlag then
        return self:callback(...)
    end
    return 
end

function mt:Remove()
    if not self.event then
        return 
    end
    local event = self.event
    self.event = nil
    Timer(0, false, function()
        for i, trg in ipairs(event) do
            if trg == self then
                remove(event, i)
                self = nil
                break
            end
        end
    end)
end

return Trigger