globals
    // User-defined
integer udg_a= 0
    // Generated
sound gg_snd_FlameStrikeTargetWaveNonLoop1= null
sound gg_snd_FlameStrikeBirth1= null
sound gg_snd_FlareTarget1= null
sound gg_snd_FrostArmorTarget1= null
sound gg_snd_ImmolationDecay1= null
sound gg_snd_ImmolationTarget1= null
sound gg_snd_ThunderClapCaster= null
sound gg_snd_FragBombs= null
sound gg_snd_QuestNew= null
sound gg_snd_QuestCompleted= null
sound gg_snd_QuestLog= null
sound gg_snd_ResurrectTarget= null
sound gg_snd_CityBuildingDeath1= null
sound gg_snd_op= null
sound gg_snd_DarkRitualTarget1= null
sound gg_snd_DarkSummoningTarget1= null
sound gg_snd_DeathAndDecayTarget1= null
sound gg_snd_AltarOfDarknessWhat= null
sound gg_snd_BoneyardWhat1= null
sound gg_snd_SpiritWolfWhat1= null
sound gg_snd_SpiritWolfYesAttack1= null
sound gg_snd_FireBallMissileDeath= null
sound gg_snd_TrollBatriderMissile3= null
sound gg_snd_Genn_Wolf_Attack_Impact06= null
sound gg_snd_Genn_Wolf_Transform_Launch01= null
sound gg_snd_Genn_Wolf_GoForTheThroat_Launch01= null
sound gg_snd_Illidan_Evasion_Launch03= null
sound gg_snd_Rehgar_LightningShield_Mid03= null
sound gg_snd_HealTarget= null
sound gg_snd_Arthas_DeathCoil_Heal01= null
sound gg_snd_Arthas_FrostStrike_Impact02= null
sound gg_snd_Arthas_HowlingBlast_Cast04= null
sound gg_snd_QuestFailed= null
trigger gg_trg_init= null
trigger gg_trg_base= null
trigger gg_trg_main= null
trigger gg_trg_api= null
trigger gg_trg_id= null
trigger gg_trg_stack= null
trigger gg_trg_node= null
trigger gg_trg_array= null
trigger gg_trg_list= null
trigger gg_trg_greatest_common_factor= null
trigger gg_trg_quick_sort= null
trigger gg_trg_random_number_generator= null
trigger gg_trg_general_bonus_system= null
trigger gg_trg_custom_tool= null
trigger gg_trg_jass_tool= null
trigger gg_trg_color= null
trigger gg_trg_point= null
trigger gg_trg_timer= null
trigger gg_trg_group= null
trigger gg_trg_texttag= null
trigger gg_trg_object= null
trigger gg_trg_combat= null


//JASSHelper struct globals:

endglobals


//===========================================================================
// 
// 傾斜的時鐘塔 v0.1.0
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Date: Mon Oct 01 17:45:40 2018
//   Map Author: 今夕歸鄉
// 
//===========================================================================
//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************
function InitGlobals takes nothing returns nothing
    set udg_a=0
endfunction
//***************************************************************************
//*
//*  Sounds
//*
//***************************************************************************
function InitSounds takes nothing returns nothing
    set gg_snd_FlameStrikeTargetWaveNonLoop1=CreateSound("Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeTargetWaveNonLoop1.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_FlameStrikeTargetWaveNonLoop1, "FlameStrikeTarget")
    call SetSoundDuration(gg_snd_FlameStrikeTargetWaveNonLoop1, 1927)
    set gg_snd_FlameStrikeBirth1=CreateSound("Abilities\\Spells\\Human\\FlameStrike\\FlameStrikeBirth1.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_FlameStrikeBirth1, "FlameStrike")
    call SetSoundDuration(gg_snd_FlameStrikeBirth1, 5213)
    set gg_snd_FlareTarget1=CreateSound("Abilities\\Spells\\Human\\Flare\\FlareTarget1.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_FlareTarget1, "Flare1")
    call SetSoundDuration(gg_snd_FlareTarget1, 3582)
    set gg_snd_FrostArmorTarget1=CreateSound("Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorTarget1.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_FrostArmorTarget1, "FrostArmor")
    call SetSoundDuration(gg_snd_FrostArmorTarget1, 2995)
    set gg_snd_ImmolationDecay1=CreateSound("Abilities\\Spells\\NightElf\\Immolation\\ImmolationDecay1.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_ImmolationDecay1, "ImmolationDecay")
    call SetSoundDuration(gg_snd_ImmolationDecay1, 2369)
    set gg_snd_ImmolationTarget1=CreateSound("Abilities\\Spells\\NightElf\\Immolation\\ImmolationTarget1.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_ImmolationTarget1, "ImmolationTarget")
    call SetSoundDuration(gg_snd_ImmolationTarget1, 3204)
    set gg_snd_ThunderClapCaster=CreateSound("Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_ThunderClapCaster, "ThunderClap")
    call SetSoundDuration(gg_snd_ThunderClapCaster, 3451)
    set gg_snd_FragBombs=CreateSound("Abilities\\Spells\\Human\\FragmentationShards\\FragBombs.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_FragBombs, "FragShards")
    call SetSoundDuration(gg_snd_FragBombs, 1663)
    set gg_snd_QuestNew=CreateSound("Sound\\Interface\\QuestNew.wav", false, false, false, 10, 10, "")
    call SetSoundParamsFromLabel(gg_snd_QuestNew, "QuestNew")
    call SetSoundDuration(gg_snd_QuestNew, 3750)
    set gg_snd_QuestCompleted=CreateSound("Sound\\Interface\\QuestCompleted.wav", false, false, false, 10, 10, "")
    call SetSoundParamsFromLabel(gg_snd_QuestCompleted, "QuestCompleted")
    call SetSoundDuration(gg_snd_QuestCompleted, 5155)
    set gg_snd_QuestLog=CreateSound("Sound\\Interface\\QuestLog.wav", false, false, false, 10, 10, "")
    call SetSoundParamsFromLabel(gg_snd_QuestLog, "QuestUpdate")
    call SetSoundDuration(gg_snd_QuestLog, 2276)
    set gg_snd_ResurrectTarget=CreateSound("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_ResurrectTarget, "Resurrect")
    call SetSoundDuration(gg_snd_ResurrectTarget, 3506)
    set gg_snd_CityBuildingDeath1=CreateSound("Sound\\Buildings\\Death\\CityBuildingDeath1.wav", false, true, true, 10, 10, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_CityBuildingDeath1, "DeathCityBuilding")
    call SetSoundDuration(gg_snd_CityBuildingDeath1, 3505)
    set gg_snd_op=CreateSound("war3mapImported\\op.mp3", false, false, false, 10, 10, "")
    call SetSoundChannel(gg_snd_op, 0)
    call SetSoundVolume(gg_snd_op, 127)
    call SetSoundPitch(gg_snd_op, 1.0)
    set gg_snd_DarkRitualTarget1=CreateSound("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget1.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_DarkRitualTarget1, "DarkRitual")
    call SetSoundDuration(gg_snd_DarkRitualTarget1, 3007)
    set gg_snd_DarkSummoningTarget1=CreateSound("Abilities\\Spells\\Undead\\DarkSummoning\\DarkSummoningTarget1.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_DarkSummoningTarget1, "DarkSummoningTarget")
    call SetSoundDuration(gg_snd_DarkSummoningTarget1, 3320)
    set gg_snd_DeathAndDecayTarget1=CreateSound("Abilities\\Spells\\Undead\\DeathandDecay\\DeathAndDecayTarget1.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_DeathAndDecayTarget1, "DeathAndDecayTarget")
    call SetSoundDuration(gg_snd_DeathAndDecayTarget1, 1268)
    set gg_snd_AltarOfDarknessWhat=CreateSound("Buildings\\Undead\\AltarOfDarkness\\AltarOfDarknessWhat.wav", false, true, true, 10, 10, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_AltarOfDarknessWhat, "AltarOfDarknessWhat")
    call SetSoundDuration(gg_snd_AltarOfDarknessWhat, 5523)
    set gg_snd_BoneyardWhat1=CreateSound("Buildings\\Undead\\Boneyard\\BoneyardWhat1.wav", false, true, true, 10, 10, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_BoneyardWhat1, "BoneyardWhat")
    call SetSoundDuration(gg_snd_BoneyardWhat1, 3506)
    set gg_snd_SpiritWolfWhat1=CreateSound("Units\\Orc\\Spiritwolf\\SpiritWolfWhat1.wav", false, true, true, 10, 10, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_SpiritWolfWhat1, "SpiritWolfWhat")
    call SetSoundDuration(gg_snd_SpiritWolfWhat1, 1028)
    set gg_snd_SpiritWolfYesAttack1=CreateSound("Units\\Orc\\Spiritwolf\\SpiritWolfYesAttack1.wav", false, true, true, 10, 10, "DefaultEAXON")
    call SetSoundParamsFromLabel(gg_snd_SpiritWolfYesAttack1, "SpiritWolfYesAttack")
    call SetSoundDuration(gg_snd_SpiritWolfYesAttack1, 1393)
    set gg_snd_FireBallMissileDeath=CreateSound("Abilities\\Weapons\\FireBallMissile\\FireBallMissileDeath.wav", false, true, true, 10, 10, "MissilesEAX")
    call SetSoundParamsFromLabel(gg_snd_FireBallMissileDeath, "Fireball")
    call SetSoundDuration(gg_snd_FireBallMissileDeath, 1477)
    set gg_snd_TrollBatriderMissile3=CreateSound("Abilities\\Weapons\\BatTrollMissile\\TrollBatriderMissile3.wav", false, true, true, 10, 10, "MissilesEAX")
    call SetSoundParamsFromLabel(gg_snd_TrollBatriderMissile3, "TrollBatriderMissileLaunch")
    call SetSoundDuration(gg_snd_TrollBatriderMissile3, 1146)
    set gg_snd_Genn_Wolf_Attack_Impact06=CreateSound("war3mapImported\\Genn_Wolf_Attack_Impact06.wav", false, false, false, 10, 10, "")
    call SetSoundChannel(gg_snd_Genn_Wolf_Attack_Impact06, 0)
    call SetSoundVolume(gg_snd_Genn_Wolf_Attack_Impact06, 127)
    call SetSoundPitch(gg_snd_Genn_Wolf_Attack_Impact06, 1.0)
    set gg_snd_Genn_Wolf_Transform_Launch01=CreateSound("war3mapImported\\Genn_Wolf_Transform_Launch01.wav", false, false, false, 10, 10, "")
    call SetSoundChannel(gg_snd_Genn_Wolf_Transform_Launch01, 0)
    call SetSoundVolume(gg_snd_Genn_Wolf_Transform_Launch01, 127)
    call SetSoundPitch(gg_snd_Genn_Wolf_Transform_Launch01, 1.0)
    set gg_snd_Genn_Wolf_GoForTheThroat_Launch01=CreateSound("war3mapImported\\Genn_Wolf_GoForTheThroat_Launch01.wav", false, false, false, 10, 10, "")
    call SetSoundChannel(gg_snd_Genn_Wolf_GoForTheThroat_Launch01, 0)
    call SetSoundVolume(gg_snd_Genn_Wolf_GoForTheThroat_Launch01, 127)
    call SetSoundPitch(gg_snd_Genn_Wolf_GoForTheThroat_Launch01, 1.0)
    set gg_snd_Illidan_Evasion_Launch03=CreateSound("war3mapImported\\Illidan_Evasion_Launch03.wav", false, false, false, 10, 10, "")
    call SetSoundChannel(gg_snd_Illidan_Evasion_Launch03, 0)
    call SetSoundVolume(gg_snd_Illidan_Evasion_Launch03, 127)
    call SetSoundPitch(gg_snd_Illidan_Evasion_Launch03, 1.0)
    set gg_snd_Rehgar_LightningShield_Mid03=CreateSound("war3mapImported\\Rehgar_LightningShield_Mid03.wav", false, false, false, 10, 10, "")
    call SetSoundChannel(gg_snd_Rehgar_LightningShield_Mid03, 0)
    call SetSoundVolume(gg_snd_Rehgar_LightningShield_Mid03, 127)
    call SetSoundPitch(gg_snd_Rehgar_LightningShield_Mid03, 1.0)
    set gg_snd_HealTarget=CreateSound("Abilities\\Spells\\Human\\Heal\\HealTarget.wav", false, true, true, 10, 10, "SpellsEAX")
    call SetSoundParamsFromLabel(gg_snd_HealTarget, "Heal")
    call SetSoundDuration(gg_snd_HealTarget, 1399)
    set gg_snd_Arthas_DeathCoil_Heal01=CreateSound("war3mapImported\\Arthas_DeathCoil_Heal01.wav", false, false, false, 10, 10, "")
    call SetSoundChannel(gg_snd_Arthas_DeathCoil_Heal01, 0)
    call SetSoundVolume(gg_snd_Arthas_DeathCoil_Heal01, 127)
    call SetSoundPitch(gg_snd_Arthas_DeathCoil_Heal01, 1.0)
    set gg_snd_Arthas_FrostStrike_Impact02=CreateSound("war3mapImported\\Arthas_FrostStrike_Impact02.wav", false, false, false, 10, 10, "")
    call SetSoundChannel(gg_snd_Arthas_FrostStrike_Impact02, 0)
    call SetSoundVolume(gg_snd_Arthas_FrostStrike_Impact02, 127)
    call SetSoundPitch(gg_snd_Arthas_FrostStrike_Impact02, 1.0)
    set gg_snd_Arthas_HowlingBlast_Cast04=CreateSound("war3mapImported\\Arthas_HowlingBlast_Cast04.wav", false, false, false, 10, 10, "")
    call SetSoundChannel(gg_snd_Arthas_HowlingBlast_Cast04, 0)
    call SetSoundVolume(gg_snd_Arthas_HowlingBlast_Cast04, 127)
    call SetSoundPitch(gg_snd_Arthas_HowlingBlast_Cast04, 1.0)
    set gg_snd_QuestFailed=CreateSound("Sound\\Interface\\QuestFailed.wav", false, false, false, 10, 10, "")
    call SetSoundParamsFromLabel(gg_snd_QuestFailed, "QuestFailed")
    call SetSoundDuration(gg_snd_QuestFailed, 4690)
endfunction
//***************************************************************************
//*
//*  Unit Creation
//*
//***************************************************************************
//===========================================================================
function CreateUnitsForPlayer0 takes nothing returns nothing
    local player p= Player(0)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'Hamg', 15015.0, 9852.9, 54.219)
    set u=CreateUnit(p, 'Hamg', - 2235.7, 5107.1, 136.597)
    set u=CreateUnit(p, 'Hamg', - 380.7, 276.4, 197.441)
    set u=CreateUnit(p, 'Hamg', 2471.2, - 3051.1, 49.704)
    set u=CreateUnit(p, 'Hamg', 10501.8, - 2119.3, 222.502)
    set u=CreateUnit(p, 'Hamg', 9820.6, 5035.2, 352.980)
    set u=CreateUnit(p, 'Hamg', - 3215.6, 1146.6, 71.249)
    set u=CreateUnit(p, 'Hamg', 25.8, - 2636.8, 135.169)
    set u=CreateUnit(p, 'Hamg', 4426.6, - 1311.7, 296.102)
    set u=CreateUnit(p, 'Hamg', 6229.6, - 3085.3, 5.076)
    set u=CreateUnit(p, 'Hamg', 8873.5, - 256.6, 105.197)
    set u=CreateUnit(p, 'Hamg', 1638.9, 3088.9, 352.287)
    set u=CreateUnit(p, 'Hamg', 1930.1, 5220.5, 338.708)
    set u=CreateUnit(p, 'Hamg', 3904.0, 3857.4, 54.725)
    set u=CreateUnit(p, 'Hamg', 6400.0, 2643.3, 238.268)
    set u=CreateUnit(p, 'Hamg', 10381.6, 1606.3, 114.042)
    set u=CreateUnit(p, 'Hamg', 4974.3, 6090.7, 110.932)
    set u=CreateUnit(p, 'Hamg', 8274.5, 3696.9, 103.209)
endfunction
//===========================================================================
function CreateUnitsForPlayer1 takes nothing returns nothing
    local player p= Player(1)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'Hamg', - 3267.3, - 3314.3, 149.310)
    set u=CreateUnit(p, 'Hamg', 2321.6, 569.6, 22.130)
endfunction
//===========================================================================
function CreateNeutralHostile takes nothing returns nothing
    local player p= Player(PLAYER_NEUTRAL_AGGRESSIVE)
    local unit u
    local integer unitID
    local trigger t
    local real life
    set u=CreateUnit(p, 'nbrg', 15334.7, 9836.5, 132.840)
endfunction
//===========================================================================
function CreatePlayerBuildings takes nothing returns nothing
endfunction
//===========================================================================
function CreatePlayerUnits takes nothing returns nothing
    call CreateUnitsForPlayer0()
    call CreateUnitsForPlayer1()
endfunction
//===========================================================================
function CreateAllUnits takes nothing returns nothing
    call CreatePlayerBuildings()
    call CreateNeutralHostile()
    call CreatePlayerUnits()
endfunction
//***************************************************************************
//*
//*  Custom Script Code
//*
//***************************************************************************
//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************
//===========================================================================
// Trigger: init
//===========================================================================
function Trig_InitActions takes nothing returns nothing
    call Cheat("exec-lua:base")
endfunction
function InitTrig_init takes nothing returns nothing
    set gg_trg_init=CreateTrigger()
    call TriggerAddAction(gg_trg_init, function Trig_InitActions)
endfunction
//===========================================================================
// Trigger: base
//===========================================================================
//===========================================================================
// Trigger: main
//===========================================================================
//===========================================================================
// Trigger: api
//===========================================================================
//===========================================================================
// Trigger: id
//===========================================================================
//===========================================================================
// Trigger: stack
//===========================================================================
//===========================================================================
// Trigger: node
//===========================================================================
//===========================================================================
// Trigger: array
//===========================================================================
//===========================================================================
// Trigger: list
//===========================================================================
//===========================================================================
// Trigger: greatest_common_factor
//===========================================================================
//===========================================================================
// Trigger: quick_sort
//===========================================================================
//===========================================================================
// Trigger: random_number_generator
//===========================================================================
//===========================================================================
// Trigger: general_bonus_system
//===========================================================================
//===========================================================================
// Trigger: custom_tool
//===========================================================================
//===========================================================================
// Trigger: jass_tool
//===========================================================================
//===========================================================================
// Trigger: color
//===========================================================================
//===========================================================================
// Trigger: point
//===========================================================================
//===========================================================================
// Trigger: timer
//===========================================================================
//===========================================================================
// Trigger: group
//===========================================================================
//===========================================================================
// Trigger: texttag
//===========================================================================
//===========================================================================
// Trigger: object
//===========================================================================
//===========================================================================
// Trigger: combat
//===========================================================================

    //===========================================================================
function InitCustomTriggers takes nothing returns nothing
    call InitTrig_init()
    //Function not found: call InitTrig_base()
    //Function not found: call InitTrig_main()
    //Function not found: call InitTrig_api()
    //Function not found: call InitTrig_id()
    //Function not found: call InitTrig_stack()
    //Function not found: call InitTrig_node()
    //Function not found: call InitTrig_array()
    //Function not found: call InitTrig_list()
    //Function not found: call InitTrig_greatest_common_factor()
    //Function not found: call InitTrig_quick_sort()
    //Function not found: call InitTrig_random_number_generator()
    //Function not found: call InitTrig_general_bonus_system()
    //Function not found: call InitTrig_custom_tool()
    //Function not found: call InitTrig_jass_tool()
    //Function not found: call InitTrig_color()
    //Function not found: call InitTrig_point()
    //Function not found: call InitTrig_timer()
    //Function not found: call InitTrig_group()
    //Function not found: call InitTrig_texttag()
    //Function not found: call InitTrig_object()
    //Function not found: call InitTrig_combat()
endfunction
//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_init)
endfunction
//***************************************************************************
//*
//*  Players
//*
//***************************************************************************
function InitCustomPlayerSlots takes nothing returns nothing
    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)
    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_ORC)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)
    // Player 2
    call SetPlayerStartLocation(Player(2), 2)
    call SetPlayerColor(Player(2), ConvertPlayerColor(2))
    call SetPlayerRacePreference(Player(2), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(2), false)
    call SetPlayerController(Player(2), MAP_CONTROL_USER)
    // Player 3
    call SetPlayerStartLocation(Player(3), 3)
    call SetPlayerColor(Player(3), ConvertPlayerColor(3))
    call SetPlayerRacePreference(Player(3), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(3), false)
    call SetPlayerController(Player(3), MAP_CONTROL_USER)
    // Player 4
    call SetPlayerStartLocation(Player(4), 4)
    call SetPlayerColor(Player(4), ConvertPlayerColor(4))
    call SetPlayerRacePreference(Player(4), RACE_PREF_HUMAN)
    call SetPlayerRaceSelectable(Player(4), false)
    call SetPlayerController(Player(4), MAP_CONTROL_USER)
    // Player 10
    call SetPlayerStartLocation(Player(10), 5)
    call ForcePlayerStartLocation(Player(10), 5)
    call SetPlayerColor(Player(10), ConvertPlayerColor(10))
    call SetPlayerRacePreference(Player(10), RACE_PREF_UNDEAD)
    call SetPlayerRaceSelectable(Player(10), false)
    call SetPlayerController(Player(10), MAP_CONTROL_COMPUTER)
    // Player 11
    call SetPlayerStartLocation(Player(11), 6)
    call ForcePlayerStartLocation(Player(11), 6)
    call SetPlayerColor(Player(11), ConvertPlayerColor(11))
    call SetPlayerRacePreference(Player(11), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(11), false)
    call SetPlayerController(Player(11), MAP_CONTROL_COMPUTER)
endfunction
function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_008
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(2), 0)
    call SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(3), 0)
    call SetPlayerState(Player(3), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(4), 0)
    call SetPlayerState(Player(4), PLAYER_STATE_ALLIED_VICTORY, 1)
    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(3), true)
    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(3), true)
    // Force: TRIGSTR_009
    call SetPlayerTeam(Player(10), 1)
    call SetPlayerTeam(Player(11), 1)
    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(11), true)
    call SetPlayerAllianceStateAllyBJ(Player(11), Player(10), true)
    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(11), true)
    call SetPlayerAllianceStateVisionBJ(Player(11), Player(10), true)
endfunction
function InitAllyPriorities takes nothing returns nothing
    call SetStartLocPrioCount(0, 1)
    call SetStartLocPrio(0, 0, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(1, 2)
    call SetStartLocPrio(1, 0, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(1, 1, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(2, 2)
    call SetStartLocPrio(2, 0, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(2, 1, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrioCount(3, 2)
    call SetStartLocPrio(3, 0, 0, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(3, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(4, 2)
    call SetStartLocPrio(4, 0, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(4, 1, 3, MAP_LOC_PRIO_HIGH)
endfunction
//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************
//===========================================================================
function main takes nothing returns nothing
    call SetCameraBounds(- 4096.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 4096.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 28672.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 28672.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 4096.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 28672.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 28672.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 4096.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCAshenvale\\DNCAshenvaleTerrain\\DNCAshenvaleTerrain.mdl", "Environment\\DNC\\DNCAshenvale\\DNCAshenvaleUnit\\DNCAshenvaleUnit.mdl")
    call SetWaterBaseColor(0, 128, 128, 255)
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("AshenvaleDay")
    call SetAmbientNightSound("AshenvaleNight")
    call SetMapMusic("Music", true, 0)
    call InitSounds()
    call CreateAllUnits()
    call InitBlizzard()


    set udg_a=0 // INLINED!!
    call InitTrig_init() // INLINED!!
    call ConditionalTriggerExecute(gg_trg_init) // INLINED!!
endfunction
//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************
function config takes nothing returns nothing
    call SetMapName("傾斜的時鐘塔 v0.1.0")
    call SetMapDescription("時鐘塔，一個致力抵禦黑淵惡魔的奧術師組織，已在皮爾提屹立千年之久，如今卻抵擋不住同族的貪婪，化成一片廢墟。\n現在，你必須從這片斷垣殘壁中拼湊犯罪的證據，還原歷史的真相！")
    call SetPlayers(7)
    call SetTeams(7)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    call DefineStartLocation(0, 15104.0, 10240.0)
    call DefineStartLocation(1, - 2368.0, 25664.0)
    call DefineStartLocation(2, - 1728.0, 11456.0)
    call DefineStartLocation(3, 6016.0, 11584.0)
    call DefineStartLocation(4, - 1728.0, 384.0)
    call DefineStartLocation(5, 4288.0, 11264.0)
    call DefineStartLocation(6, 20544.0, 2368.0)
    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:

