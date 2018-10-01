        local setmetatable = setmetatable
        local math = math
        local cj = require 'jass.common'
        local Texttag = require 'texttag'
        local Point = require 'point'
        
        local Combat = {}
        local mt = {}
        setmetatable(Combat, Combat)
        Combat.__index = mt
        function Combat.SetText(target, value, textType, scale)
            local text
            if textType == "治療" then
                text = "|cff00ff00" .. math.modf(value)
            elseif textType == "回魔" then
                text = "|cff3366ff" .. math.modf(value)
            else
                if value > 0 then
                    text = (textType == "法術" and "|cffffff00" or "") .. math.modf(value)
                elseif value == 0 then
                    text = "|cffff0000" .. "閃躲!"
                else
                    text = "|cffff0000" .. "忽視!"
                end
            end
            Texttag(text, Point(cj.GetUnitx(target), cj.GetUnitY(target)), scale)
        end
        
        return Combat
    