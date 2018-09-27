        local cj = require 'jass.common'
        return {
            H2I = function(h) return cj.GetHandleId(h) end,
            SH2I = function(s) return cj.StringHash(s) end,
            H2S = function(h) return cj.I2S(H2I(h)) end,
            U2PlayerId = function(u) return cj.GetPlayerId(cj.GetOwningPlayer(u)) end,
            Debug = function(s) cj.DisplayTimedTextToPlayer(cj.Player(0), 0, 0, 5, s) end,
            U2Id = function(u) return cj.GetUnitTypeId(u) end
        }
    