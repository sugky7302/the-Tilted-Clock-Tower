function Trig_InitActions takes nothing returns nothing
    call Cheat("exec-lua:base")
endfunction

function InitTrig_init takes nothing returns nothing
    set gg_trg_init = CreateTrigger()
    call TriggerAddAction(gg_trg_init, function Trig_InitActions)
endfunction

