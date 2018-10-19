local setmetatable = setmetatable
local cj = require 'jass.common'
local Object = require 'object'
local Timer = require 'timer'

local Shield = {}
setmetatable(Shield, Shield)

-- constants
local _PULSE = 0.05

function Shield:__call(object, shieldValue, dur)
    local obj = Object{
        object = object,
        shieldValue = shieldValue, 
        timeout = dur
    }
    obj.timer = Timer(_PULSE, timeout/_PULSE, function()
        if obj.shieldValue < 0 then
            obj.timer:Remove()
        end
    end)
    return obj
end

return Shield
    