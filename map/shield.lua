        local setmetatable = setmetatable
        local cj = require 'jass.common'
        local Object = require 'object'
        local Shield = {}
        setmetatable(Shield, Shield)
        function Shield:__call(object, shieldValue, dur)
            local obj = Object{
                object = object,
                shieldValue = shieldValue, 
                timeout = dur
            }
            return obj
        end
        return Shield
    