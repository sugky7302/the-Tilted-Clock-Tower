//! import "jass/A.j"
//! import "jass/B.j"
globals
    // Generated
    trigger                 gg_trg_Melee_Initialization = null
endglobals

function InitGlobals takes nothing returns nothing
endfunction

//***************************************************************************
//*
//*  Unit Item Tables
//*
//***************************************************************************

function Unit000022_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 4 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000027_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_CHARGED, 3 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

        // Item set 1
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 1 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000037_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000038_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_CHARGED, 3 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

        // Item set 1
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 1 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000041_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 3 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

        // Item set 1
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 1 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000043_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 3 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

        // Item set 1
        call RandomDistReset(  )
        call RandomDistAddItem( 'rwat', 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000046_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 4 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000047_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 4 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000048_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000051_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 3 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

        // Item set 1
        call RandomDistReset(  )
        call RandomDistAddItem( 'rwat', 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000059_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 4 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000061_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 1 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000063_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 1 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000065_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 1 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000068_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000073_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000078_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_CHARGED, 3 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

        // Item set 1
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 1 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000081_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000086_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 5 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

        // Item set 1
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000088_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 1 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000089_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 5 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

        // Item set 1
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000090_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_CHARGED, 3 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

        // Item set 1
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 1 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000092_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000093_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( 'rhe2', 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000094_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000098_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000103_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000106_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 2 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000110_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_PERMANENT, 3 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

        // Item set 1
        call RandomDistReset(  )
        call RandomDistAddItem( ChooseRandomItemEx( ITEM_TYPE_POWERUP, 1 ), 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction

function Unit000114_DropItems takes nothing returns nothing
    local widget  trigWidget = null
    local unit    trigUnit   = null
    local integer itemID     = 0
    local boolean canDrop    = true

    set trigWidget = bj_lastDyingWidget
    if (trigWidget == null) then
        set trigUnit = GetTriggerUnit()
    endif

    if (trigUnit != null) then
        set canDrop = not IsUnitHidden(trigUnit)
        if (canDrop and GetChangingUnit() != null) then
            set canDrop = (GetChangingUnitPrevOwner() == Player(PLAYER_NEUTRAL_AGGRESSIVE))
        endif
    endif

    if (canDrop) then
        // Item set 0
        call RandomDistReset(  )
        call RandomDistAddItem( 'rhe2', 100 )
        set itemID = RandomDistChoose(  )
        if (trigUnit != null) then
            call UnitDropItem( trigUnit, itemID )
        else
            call WidgetDropItem( trigWidget, itemID )
        endif

    endif

    set bj_lastDyingWidget = null
    call DestroyTrigger(GetTriggeringTrigger())
endfunction


//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************

//===========================================================================
function CreateNeutralHostile takes nothing returns nothing
    local player p = Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u = CreateUnit( p, 'nmrr', 4084.1, -3575.0, 154.804 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nogl', 4621.4, 4324.2, 233.760 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000089_DropItems )
    set u = CreateUnit( p, 'ntrg', -3976.1, 3593.6, 311.370 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000041_DropItems )
    set u = CreateUnit( p, 'nftb', 4535.7, 4627.7, 255.283 )
    set u = CreateUnit( p, 'nftb', 4828.3, 4297.5, 191.098 )
    set u = CreateUnit( p, 'nogr', 4690.8, 4124.2, 225.468 )
    set u = CreateUnit( p, 'nogr', 4443.7, 4281.5, 221.065 )
    set u = CreateUnit( p, 'nomg', -2789.3, -3501.1, 44.490 )
    call SetUnitState( u, UNIT_STATE_MANA, 0 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000043_DropItems )
    set u = CreateUnit( p, 'nomg', -3852.7, -4890.5, 57.770 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000093_DropItems )
    set u = CreateUnit( p, 'nftt', -2703.1, -3706.6, 51.115 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftt', -2989.1, -3409.7, 20.930 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000098_DropItems )
    set u = CreateUnit( p, 'ntrg', 137.3, -2685.8, 130.730 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000038_DropItems )
    set u = CreateUnit( p, 'ntrt', -20.7, -2876.7, 154.031 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nmrm', -3799.5, 3698.2, 333.420 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrg', 2800.7, -58.3, 145.500 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000078_DropItems )
    set u = CreateUnit( p, 'nmrm', 4242.8, -3593.9, 165.819 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nmrr', 3964.6, -3748.6, 129.869 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nomg', 3124.9, 2733.6, 227.390 )
    call SetUnitState( u, UNIT_STATE_MANA, 0 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000051_DropItems )
    set u = CreateUnit( p, 'nmrm', 4065.5, -3916.4, 165.819 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrg', 4275.6, -3814.7, 163.070 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000110_DropItems )
    set u = CreateUnit( p, 'ntrt', 3881.2, -732.1, 0.000 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000061_DropItems )
    set u = CreateUnit( p, 'ntrh', 3759.8, -819.5, 254.169 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftt', 3018.4, 2930.2, 223.180 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000048_DropItems )
    set u = CreateUnit( p, 'nmrm', -4103.5, 3374.9, 333.420 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nmrr', -3722.5, 3502.1, 297.471 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nogr', 2973.2, 2765.5, 241.220 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nogr', 3235.3, 2573.2, 220.447 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nomg', 4414.0, 4481.8, 244.580 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000114_DropItems )
    set u = CreateUnit( p, 'ntrg', 336.1, 2010.8, 322.840 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000027_DropItems )
    set u = CreateUnit( p, 'ntrt', 373.5, 2246.8, 332.000 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrg', -2299.5, -751.2, 322.840 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000090_DropItems )
    set u = CreateUnit( p, 'ntrt', 2775.2, -290.0, 174.368 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftt', 3327.8, 2716.8, 223.180 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nmrr', -4113.2, 3168.9, 322.405 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrt', 2982.1, 69.8, 104.946 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrt', 142.8, 1960.2, 262.573 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrt', -2283.4, -502.1, 350.835 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nogr', -2838.2, -3291.4, 33.151 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrt', -2405.4, -914.1, 281.412 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nogl', -4081.5, -4687.7, 61.750 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000086_DropItems )
    set u = CreateUnit( p, 'nogr', -2642.6, -3575.1, 71.262 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrh', 3876.0, -593.1, 23.262 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nogr', -1183.1, -5382.3, 87.270 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000081_DropItems )
    set u = CreateUnit( p, 'nogr', -986.1, -5452.0, 79.122 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftr', -1215.4, -5596.4, 59.813 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftr', -1028.1, -5637.2, 83.329 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrt', 1064.6, -3659.8, 0.000 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000088_DropItems )
    set u = CreateUnit( p, 'nogr', 5190.2, 1437.3, 145.910 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000073_DropItems )
    set u = CreateUnit( p, 'nogr', 5210.5, 1662.2, 171.938 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftr', 5335.6, 1429.7, 152.630 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrt', 337.2, -2580.7, 84.609 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftr', 5321.7, 1687.8, 176.146 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrh', 984.8, -3780.4, 238.626 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nogr', 1572.9, 5482.1, 287.590 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000037_DropItems )
    set u = CreateUnit( p, 'nogr', 1296.0, 5473.7, 273.680 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftr', 1545.9, 5653.9, 254.371 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftr', 1364.1, 5623.6, 277.888 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nogr', -5202.7, -2150.2, 359.310 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000068_DropItems )
    set u = CreateUnit( p, 'nftk', -5445.2, 1890.3, 303.390 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000022_DropItems )
    set u = CreateUnit( p, 'nogr', -5154.5, -2437.2, 7.669 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftr', -5337.9, -2247.4, 348.360 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftr', -5254.6, -2492.1, 11.877 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'nftb', -4006.9, -4906.4, 93.427 )
    set u = CreateUnit( p, 'nftb', -4291.4, -4696.6, 29.242 )
    set u = CreateUnit( p, 'nogr', -4231.2, -4500.9, 63.612 )
    set u = CreateUnit( p, 'nogr', -3892.9, -4689.1, 59.209 )
    set u = CreateUnit( p, 'nftk', -2361.6, 4873.3, 303.390 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000047_DropItems )
    set u = CreateUnit( p, 'nftb', -2540.7, 4867.8, 326.670 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000092_DropItems )
    set u = CreateUnit( p, 'nftk', 2789.3, -5502.6, 114.870 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000059_DropItems )
    set u = CreateUnit( p, 'nftb', -5624.3, 1884.8, 326.670 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000094_DropItems )
    set u = CreateUnit( p, 'nftb', -5437.1, 2135.7, 301.627 )
    set u = CreateUnit( p, 'nogr', -5500.0, 1652.6, 327.682 )
    set u = CreateUnit( p, 'nogr', -5244.8, 1932.7, 300.611 )
    set u = CreateUnit( p, 'nftk', 5477.2, -2364.2, 114.870 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000046_DropItems )
    set u = CreateUnit( p, 'nftb', 5655.2, -2385.3, 138.154 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000103_DropItems )
    set u = CreateUnit( p, 'nftb', -2316.6, 5090.0, 301.627 )
    set u = CreateUnit( p, 'nogr', -2379.5, 4606.9, 327.682 )
    set u = CreateUnit( p, 'nogr', -2124.4, 4887.0, 300.611 )
    set u = CreateUnit( p, 'nftb', 2967.2, -5523.7, 138.154 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000106_DropItems )
    set u = CreateUnit( p, 'nftb', 5372.3, -2546.5, 120.105 )
    set u = CreateUnit( p, 'nogr', 5448.0, -2065.3, 146.160 )
    set u = CreateUnit( p, 'nogr', 5185.5, -2338.5, 119.089 )
    set u = CreateUnit( p, 'nftb', 2745.6, -5705.0, 120.105 )
    set u = CreateUnit( p, 'nogr', 2821.3, -5223.8, 146.160 )
    set u = CreateUnit( p, 'nogr', 2558.9, -5497.0, 119.089 )
    set u = CreateUnit( p, 'ntrh', 1177.4, -3557.9, 345.607 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrt', -3412.4, 20.0, 141.088 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000063_DropItems )
    set u = CreateUnit( p, 'ntrh', -3514.8, -119.0, 209.689 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrh', -3333.5, 129.5, 57.040 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrt', -384.0, 3071.4, 140.886 )
    call SetUnitAcquireRange( u, 200.0 )
    set t = CreateTrigger(  )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_DEATH )
    call TriggerRegisterUnitEvent( t, u, EVENT_UNIT_CHANGE_OWNER )
    call TriggerAddAction( t, function Unit000065_DropItems )
    set u = CreateUnit( p, 'ntrh', -447.4, 2967.9, 217.359 )
    call SetUnitAcquireRange( u, 200.0 )
    set u = CreateUnit( p, 'ntrh', -295.8, 3159.1, 348.891 )
    call SetUnitAcquireRange( u, 200.0 )
endfunction

//===========================================================================
function CreateNeutralPassiveBuildings takes nothing returns nothing
    local player p = Player(PLAYER_NEUTRAL_PASSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life

    set u = CreateUnit( p, 'ngol', -5760.0, 2176.0, 270.000 )
    call SetResourceAmount( u, 12500 )
    set u = CreateUnit( p, 'ngol', 5888.0, -2688.0, 270.000 )
    call SetResourceAmount( u, 12500 )
    set u = CreateUnit( p, 'ngol', -2560.0, 5248.0, 270.000 )
    call SetResourceAmount( u, 12500 )
    set u = CreateUnit( p, 'ngol', 3072.0, -5888.0, 270.000 )
    call SetResourceAmount( u, 12500 )
    set u = CreateUnit( p, 'ngol', 3072.0, -256.0, 270.000 )
    call SetResourceAmount( u, 15000 )
    set u = CreateUnit( p, 'ngol', 256.0, -2944.0, 270.000 )
    call SetResourceAmount( u, 15000 )
    set u = CreateUnit( p, 'ngol', 4800.0, 4544.0, 270.000 )
    call SetResourceAmount( u, 10000 )
    set u = CreateUnit( p, 'nmh0', -4256.0, 3232.0, 270.000 )
    set u = CreateUnit( p, 'ngol', -4288.0, -4928.0, 270.000 )
    call SetResourceAmount( u, 10000 )
    set u = CreateUnit( p, 'nmh1', 4192.0, -4128.0, 270.000 )
    set u = CreateUnit( p, 'nmh0', -3872.0, 3936.0, 270.000 )
    set u = CreateUnit( p, 'ngme', -2944.0, -3712.0, 270.000 )
    set u = CreateUnit( p, 'nmh0', 4512.0, -3552.0, 270.000 )
    set u = CreateUnit( p, 'nmh0', 4512.0, -3936.0, 270.000 )
    set u = CreateUnit( p, 'ngme', 3264.0, 2944.0, 270.000 )
    set u = CreateUnit( p, 'nmh1', -4192.0, 3616.0, 270.000 )
    set u = CreateUnit( p, 'ntav', 512.0, -256.0, 270.000 )
    call SetUnitColor( u, ConvertPlayerColor(0) )
    set u = CreateUnit( p, 'ngol', 128.0, 2240.0, 270.000 )
    call SetResourceAmount( u, 15000 )
    set u = CreateUnit( p, 'ngol', -2560.0, -640.0, 270.000 )
    call SetResourceAmount( u, 15000 )
endfunction

//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction

//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
endfunction

//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreateNeutralPassiveBuildings(  )
    call CreatePlayerBuildings(  )
    call CreateNeutralHostile(  )
    call CreatePlayerUnits(  )
endfunction

//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************

//===========================================================================
// Trigger: Melee Initialization
//
// Default melee game initialization for all players
//===========================================================================
function Trig_Melee_Initialization_Actions takes nothing returns nothing
    call MeleeStartingVisibility(  )
    call MeleeStartingHeroLimit(  )
    call MeleeGrantHeroItems(  )
    call MeleeStartingResources(  )
    call MeleeClearExcessUnits(  )
    call MeleeStartingUnits(  )
    call MeleeStartingAI(  )
    call MeleeInitVictoryDefeat(  )
endfunction

//===========================================================================
function InitTrig_Melee_Initialization takes nothing returns nothing
    set gg_trg_Melee_Initialization = CreateTrigger(  )
    call TriggerAddAction( gg_trg_Melee_Initialization, function Trig_Melee_Initialization_Actions )
endfunction

//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_Melee_Initialization(  )
endfunction

//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute( gg_trg_Melee_Initialization )
endfunction

//***************************************************************************
//*
//*  Players
//*
//***************************************************************************

function InitCustomPlayerSlots takes nothing returns nothing

    // Player 0
    call SetPlayerStartLocation( Player(0), 0 )
    call SetPlayerColor( Player(0), ConvertPlayerColor(0) )
    call SetPlayerRacePreference( Player(0), RACE_PREF_HUMAN )
    call SetPlayerRaceSelectable( Player(0), true )
    call SetPlayerController( Player(0), MAP_CONTROL_USER )

    // Player 1
    call SetPlayerStartLocation( Player(1), 1 )
    call SetPlayerColor( Player(1), ConvertPlayerColor(1) )
    call SetPlayerRacePreference( Player(1), RACE_PREF_ORC )
    call SetPlayerRaceSelectable( Player(1), true )
    call SetPlayerController( Player(1), MAP_CONTROL_USER )

    // Player 2
    call SetPlayerStartLocation( Player(2), 2 )
    call SetPlayerColor( Player(2), ConvertPlayerColor(2) )
    call SetPlayerRacePreference( Player(2), RACE_PREF_UNDEAD )
    call SetPlayerRaceSelectable( Player(2), true )
    call SetPlayerController( Player(2), MAP_CONTROL_USER )

    // Player 3
    call SetPlayerStartLocation( Player(3), 3 )
    call SetPlayerColor( Player(3), ConvertPlayerColor(3) )
    call SetPlayerRacePreference( Player(3), RACE_PREF_NIGHTELF )
    call SetPlayerRaceSelectable( Player(3), true )
    call SetPlayerController( Player(3), MAP_CONTROL_USER )

endfunction

function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_014
    call SetPlayerTeam( Player(0), 0 )
    call SetPlayerTeam( Player(1), 0 )
    call SetPlayerTeam( Player(2), 0 )
    call SetPlayerTeam( Player(3), 0 )

endfunction

function InitAllyPriorities takes nothing returns nothing

    call SetStartLocPrioCount( 0, 1 )
    call SetStartLocPrio( 0, 0, 3, MAP_LOC_PRIO_HIGH )

    call SetStartLocPrioCount( 1, 1 )
    call SetStartLocPrio( 1, 0, 2, MAP_LOC_PRIO_HIGH )

    call SetStartLocPrioCount( 2, 1 )
    call SetStartLocPrio( 2, 0, 1, MAP_LOC_PRIO_HIGH )

    call SetStartLocPrioCount( 3, 1 )
    call SetStartLocPrio( 3, 0, 0, MAP_LOC_PRIO_HIGH )
endfunction

//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************

//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds( -6656.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -6784.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 6656.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 6528.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -6656.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 6528.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 6656.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -6784.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM) )
    call SetDayNightModels( "Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl" )
    call NewSoundEnvironment( "Default" )
    call SetAmbientDaySound( "LordaeronSummerDay" )
    call SetAmbientNightSound( "LordaeronSummerNight" )
    call SetMapMusic( "Music", true, 0 )
    call CreateAllUnits(  )
    call InitBlizzard(  )
    call InitGlobals(  )
    call InitCustomTriggers(  )
    call RunInitializationTriggers(  )

endfunction

//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************

function config takes nothing returns nothing
    call SetMapName( "TRIGSTR_020" )
    call SetMapDescription( "TRIGSTR_022" )
    call SetPlayers( 4 )
    call SetTeams( 4 )
    call SetGamePlacement( MAP_PLACEMENT_TEAMS_TOGETHER )

    call DefineStartLocation( 0, -2112.0, 4608.0 )
    call DefineStartLocation( 1, 5376.0, -2112.0 )
    call DefineStartLocation( 2, 2624.0, -5248.0 )
    call DefineStartLocation( 3, -5248.0, 1600.0 )

    // Player setup
    call InitCustomPlayerSlots(  )
    call SetPlayerSlotAvailable( Player(0), MAP_CONTROL_USER )
    call SetPlayerSlotAvailable( Player(1), MAP_CONTROL_USER )
    call SetPlayerSlotAvailable( Player(2), MAP_CONTROL_USER )
    call SetPlayerSlotAvailable( Player(3), MAP_CONTROL_USER )
    call InitGenericPlayerSlots(  )
    call InitAllyPriorities(  )
endfunction
//! zinc
library gg
    {
        function maomaomao()
        {
             BJDebugMsg("Hello World");
        }
    }
//! endzinc
