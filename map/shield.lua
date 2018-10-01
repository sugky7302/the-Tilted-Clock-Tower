        local setmetatable = setmetatable
        local cj = require 'jass.common'
        local Object = require 'object'
        local List = require 'list'
        local Texttag = require 'texttag'

        local Shield = {}
        local mt = {}
        setmetatable(Shield, Shield)
        Shield.__index = mt

        -- variables
        Shield.executingOrder = List()

        -- constants
        Shiled.PERIOD = 0.03125

        function Shield:__call(object, shieldValue, dur)
            local obj = Object{
                object = object,
                shieldValue = shieldValue, 
                timeout = dur,
                texttag = TextToAttachUnit(object, shieldValue, dur)
            }
            setmetatable(obj, self)
            self.executingOrder:PushBack(obj)
            Texttag.RunTimer(self)
            return obj
        end
        
        return Shield