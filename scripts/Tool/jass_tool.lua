local cj = require 'jass.common'
return {
    H2I = function(h)
        return cj.GetHandleId(h)
    end,
    SH2I = function(s)
        return cj.StringHash(s)
    end,
    H2S = function(h)
        return cj.I2S(H2I(h))
    end,
    U2PlayerId = function(u)
        return cj.GetPlayerId(cj.GetOwningPlayer(u))
    end,
    Debug = function(s)
        if Base.debugMode then
            cj.DisplayTimedTextToPlayer(cj.Player(0), 0, 0, 5, s)
        end
    end,
    U2Id = function(u)
        return cj.GetUnitTypeId(u)
    end,
    RemoveUnit = function(unit)
        cj.UnitApplyTimedLife(unit, Base.String2Id('BHwe'), 0.1)
    end,
    -- 設定生命週期利用war3機制自動刪除，會比用RemoveUnit乾淨，內存絕不會漏掉
    Item2Id = function(item)
        return cj.GetItemTypeId(item)
    end,
    Item2Str = function(item)
        return Base.Id2String(cj.GetItemTypeId(item))
    end,
}
    