        local setmetatable = setmetatable
        local Test = {}
        setmetatable(Test, Test)
        function Test:__call()
            self:Texttag()
            -- self:TextToAttachUnit()
        end
        
        function Test:Texttag()
            local Texttag = require 'texttag'
            local Point = require 'point'
            local obj = Texttag("test", Point(15009, 9869), 1)
        end
        function Test:TextToAttachUnit()
            local TextToAttachUnit = require 'text_to_attach_unit'
            local Point = require 'point'
            local obj = TextToAttachUnit("test", Point(15009, 9869), 1)
        end
        
        return Test
    