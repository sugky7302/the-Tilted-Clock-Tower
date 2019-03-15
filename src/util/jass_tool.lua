-- 自寫的jass工具
-- 依賴
--   jass.common


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
        if Base.debug_mode then
            cj.DisplayTimedTextToPlayer(cj.Player(0), 0, 0, 5, s)
        end
    end,
    U2Id = function(u)
        return cj.GetUnitTypeId(u)
    end,
    RemoveUnit = function(unit)
        cj.UnitApplyTimedLife(unit, Base.String2Id('BHwe'), 0.03)
    end,
    SetTimedLife = function(unit, timeout)
        cj.UnitApplyTimedLife(unit, Base.String2Id('BHwe'), timeout)
    end,
    -- 設定生命週期利用war3機制自動刪除，會比用RemoveUnit乾淨，內存絕不會漏掉
    Item2Id = function(item)
        return cj.GetItemTypeId(item)
    end,
    Item2Str = function(item)
        return Base.Id2String(cj.GetItemTypeId(item))
    end,
    PressHotkey = function(player, hotkey)
        if cj.GetLocalPlayer() == player then
            cj.ForceUIKey(hotkey)
        end
    end,
    Sound = function(handle)
        local gg = require 'jass.globals'
        cj.StartSound(gg[handle])
    end,
    -- TODO: 之後要移到Effect結構
    TimeEffect = function(effect, timeout)
        local Timer = require 'timer.core'
        Timer(timeout, false, function()
            cj.DestroyEffect(effect)
        end)
    end,
    SelectUnitRemoveForPlayer = function(unit, player)
        if cj.GetLocalPlayer() == player then
            cj.SelectUnit(unit, false)
        end
    end,
    SelectUnitAddForPlayer = function(unit, player)
        if cj.GetLocalPlayer() == player then
            cj.SelectUnit(unit, true)
        end
    end,
    ClearMessage = function(player)
        local force = cj.CreateForce()
        cj.ForceAddPlayer(force, player)
        
        if cj.IsPlayerInForce(cj.GetLocalPlayer(), force) then
            cj.ClearTextMessages()
        end
        
        cj.ForceClear(force)
        cj.DestroyForce(force)
    end,
    Tip = function(player, string_tb)
        local table_concat = table.concat
        local type = type
        string_tb = type(string_tb) == 'string' and string_tb or table_concat(string_tb)
        cj.DisplayTimedTextToPlayer(player, 0., 0., 6., string_tb)
    end,
    Ping = function(player, x, y, dur)
        local force = cj.CreateForce()
        cj.ForceAddPlayer(force, player)
        
        if cj.IsPlayerInForce(cj.GetLocalPlayer(), force) then
            cj.PingMinimap(x, y, dur)
        end

        cj.ForceClear(force)
        cj.DestroyForce(force)
    end,
}
    