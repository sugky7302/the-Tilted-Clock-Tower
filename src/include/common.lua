function ConvertRace(i) end
function ConvertAllianceType(i) end
function ConvertRacePref(i) end
function ConvertIGameState(i) end
function ConvertFGameState(i) end
function ConvertPlayerState(i) end
function ConvertPlayerScore(i) end
function ConvertPlayerGameResult(i) end
function ConvertUnitState(i) end
function ConvertAIDifficulty(i) end
function ConvertGameEvent(i) end
function ConvertPlayerEvent(i) end
function ConvertPlayerUnitEvent(i) end
function ConvertWidgetEvent(i) end
function ConvertDialogEvent(i) end
function ConvertUnitEvent(i) end
function ConvertLimitOp(i) end
function ConvertUnitType(i) end
function ConvertGameSpeed(i) end
function ConvertPlacement(i) end
function ConvertStartLocPrio(i) end
function ConvertGameDifficulty(i) end
function ConvertGameType(i) end
function ConvertMapFlag(i) end
function ConvertMapVisibility(i) end
function ConvertMapSetting(i) end
function ConvertMapDensity(i) end
function ConvertMapControl(i) end
function ConvertPlayerColor(i) end
function ConvertPlayerSlotState(i) end
function ConvertVolumeGroup(i) end
function ConvertCameraField(i) end
function ConvertBlendMode(i) end
function ConvertRarityControl(i) end
function ConvertTexMapFlags(i) end
function ConvertFogState(i) end
function ConvertEffectType(i) end
function ConvertVersion(i) end
function ConvertItemType(i) end
function ConvertAttackType(i) end
function ConvertDamageType(i) end
function ConvertWeaponType(i) end
function ConvertSoundType(i) end
function ConvertPathingType(i) end
function ConvertMouseButtonType(i) end
function ConvertAnimType(i) end
function ConvertSubAnimType(i) end
function ConvertOriginFrameType(i) end
function ConvertFramePointType(i) end
function ConvertTextAlignType(i) end
function ConvertFrameEventType(i) end
function ConvertOsKeyType(i) end
function ConvertAbilityIntegerField(i) end
function ConvertAbilityRealField(i) end
function ConvertAbilityBooleanField(i) end
function ConvertAbilityStringField(i) end
function ConvertAbilityIntegerLevelField(i) end
function ConvertAbilityRealLevelField(i) end
function ConvertAbilityBooleanLevelField(i) end
function ConvertAbilityStringLevelField(i) end
function ConvertAbilityIntegerLevelArrayField(i) end
function ConvertAbilityRealLevelArrayField(i) end
function ConvertAbilityBooleanLevelArrayField(i) end
function ConvertAbilityStringLevelArrayField(i) end
function ConvertUnitIntegerField(i) end
function ConvertUnitRealField(i) end
function ConvertUnitBooleanField(i) end
function ConvertUnitStringField(i) end
function ConvertUnitWeaponIntegerField(i) end
function ConvertUnitWeaponRealField(i) end
function ConvertUnitWeaponBooleanField(i) end
function ConvertUnitWeaponStringField(i) end
function ConvertItemIntegerField(i) end
function ConvertItemRealField(i) end
function ConvertItemBooleanField(i) end
function ConvertItemStringField(i) end
function ConvertMoveType(i) end
function ConvertTargetFlag(i) end
function ConvertArmorType(i) end
function ConvertHeroAttribute(i) end
function ConvertDefenseType(i) end
function ConvertRegenType(i) end
function ConvertUnitCategory(i) end
function ConvertPathingFlag(i) end
function OrderId(orderIdString) end
function OrderId2String(orderId) end
function UnitId(unitIdString) end
function UnitId2String(unitId) end
function AbilityId(abilityIdString) end
function AbilityId2String(abilityId) end
function GetObjectName(objectId) end
function GetBJMaxPlayers() end
function GetBJPlayerNeutralVictim() end
function GetBJPlayerNeutralExtra() end
function GetBJMaxPlayerSlots() end
function GetPlayerNeutralPassive() end
function GetPlayerNeutralAggressive() end
FALSE = false
TRUE = true
JASS_MAX_ARRAY_SIZE = 32768
PLAYER_NEUTRAL_PASSIVE = GetPlayerNeutralPassive()
PLAYER_NEUTRAL_AGGRESSIVE = GetPlayerNeutralAggressive()
PLAYER_COLOR_RED = ConvertPlayerColor(0)
PLAYER_COLOR_BLUE = ConvertPlayerColor(1)
PLAYER_COLOR_CYAN = ConvertPlayerColor(2)
PLAYER_COLOR_PURPLE = ConvertPlayerColor(3)
PLAYER_COLOR_YELLOW = ConvertPlayerColor(4)
PLAYER_COLOR_ORANGE = ConvertPlayerColor(5)
PLAYER_COLOR_GREEN = ConvertPlayerColor(6)
PLAYER_COLOR_PINK = ConvertPlayerColor(7)
PLAYER_COLOR_LIGHT_GRAY = ConvertPlayerColor(8)
PLAYER_COLOR_LIGHT_BLUE = ConvertPlayerColor(9)
PLAYER_COLOR_AQUA = ConvertPlayerColor(10)
PLAYER_COLOR_BROWN = ConvertPlayerColor(11)
PLAYER_COLOR_MAROON = ConvertPlayerColor(12)
PLAYER_COLOR_NAVY = ConvertPlayerColor(13)
PLAYER_COLOR_TURQUOISE = ConvertPlayerColor(14)
PLAYER_COLOR_VIOLET = ConvertPlayerColor(15)
PLAYER_COLOR_WHEAT = ConvertPlayerColor(16)
PLAYER_COLOR_PEACH = ConvertPlayerColor(17)
PLAYER_COLOR_MINT = ConvertPlayerColor(18)
PLAYER_COLOR_LAVENDER = ConvertPlayerColor(19)
PLAYER_COLOR_COAL = ConvertPlayerColor(20)
PLAYER_COLOR_SNOW = ConvertPlayerColor(21)
PLAYER_COLOR_EMERALD = ConvertPlayerColor(22)
PLAYER_COLOR_PEANUT = ConvertPlayerColor(23)
RACE_HUMAN = ConvertRace(1)
RACE_ORC = ConvertRace(2)
RACE_UNDEAD = ConvertRace(3)
RACE_NIGHTELF = ConvertRace(4)
RACE_DEMON = ConvertRace(5)
RACE_OTHER = ConvertRace(7)
PLAYER_GAME_RESULT_VICTORY = ConvertPlayerGameResult(0)
PLAYER_GAME_RESULT_DEFEAT = ConvertPlayerGameResult(1)
PLAYER_GAME_RESULT_TIE = ConvertPlayerGameResult(2)
PLAYER_GAME_RESULT_NEUTRAL = ConvertPlayerGameResult(3)
ALLIANCE_PASSIVE = ConvertAllianceType(0)
ALLIANCE_HELP_REQUEST = ConvertAllianceType(1)
ALLIANCE_HELP_RESPONSE = ConvertAllianceType(2)
ALLIANCE_SHARED_XP = ConvertAllianceType(3)
ALLIANCE_SHARED_SPELLS = ConvertAllianceType(4)
ALLIANCE_SHARED_VISION = ConvertAllianceType(5)
ALLIANCE_SHARED_CONTROL = ConvertAllianceType(6)
ALLIANCE_SHARED_ADVANCED_CONTROL= ConvertAllianceType(7)
ALLIANCE_RESCUABLE = ConvertAllianceType(8)
ALLIANCE_SHARED_VISION_FORCED = ConvertAllianceType(9)
VERSION_REIGN_OF_CHAOS = ConvertVersion(0)
VERSION_FROZEN_THRONE = ConvertVersion(1)
ATTACK_TYPE_NORMAL = ConvertAttackType(0)
ATTACK_TYPE_MELEE = ConvertAttackType(1)
ATTACK_TYPE_PIERCE = ConvertAttackType(2)
ATTACK_TYPE_SIEGE = ConvertAttackType(3)
ATTACK_TYPE_MAGIC = ConvertAttackType(4)
ATTACK_TYPE_CHAOS = ConvertAttackType(5)
ATTACK_TYPE_HERO = ConvertAttackType(6)
DAMAGE_TYPE_UNKNOWN = ConvertDamageType(0)
DAMAGE_TYPE_NORMAL = ConvertDamageType(4)
DAMAGE_TYPE_ENHANCED = ConvertDamageType(5)
DAMAGE_TYPE_FIRE = ConvertDamageType(8)
DAMAGE_TYPE_COLD = ConvertDamageType(9)
DAMAGE_TYPE_LIGHTNING = ConvertDamageType(10)
DAMAGE_TYPE_POISON = ConvertDamageType(11)
DAMAGE_TYPE_DISEASE = ConvertDamageType(12)
DAMAGE_TYPE_DIVINE = ConvertDamageType(13)
DAMAGE_TYPE_MAGIC = ConvertDamageType(14)
DAMAGE_TYPE_SONIC = ConvertDamageType(15)
DAMAGE_TYPE_ACID = ConvertDamageType(16)
DAMAGE_TYPE_FORCE = ConvertDamageType(17)
DAMAGE_TYPE_DEATH = ConvertDamageType(18)
DAMAGE_TYPE_MIND = ConvertDamageType(19)
DAMAGE_TYPE_PLANT = ConvertDamageType(20)
DAMAGE_TYPE_DEFENSIVE = ConvertDamageType(21)
DAMAGE_TYPE_DEMOLITION = ConvertDamageType(22)
DAMAGE_TYPE_SLOW_POISON = ConvertDamageType(23)
DAMAGE_TYPE_SPIRIT_LINK = ConvertDamageType(24)
DAMAGE_TYPE_SHADOW_STRIKE = ConvertDamageType(25)
DAMAGE_TYPE_UNIVERSAL = ConvertDamageType(26)
WEAPON_TYPE_WHOKNOWS = ConvertWeaponType(0)
WEAPON_TYPE_METAL_LIGHT_CHOP = ConvertWeaponType(1)
WEAPON_TYPE_METAL_MEDIUM_CHOP = ConvertWeaponType(2)
WEAPON_TYPE_METAL_HEAVY_CHOP = ConvertWeaponType(3)
WEAPON_TYPE_METAL_LIGHT_SLICE = ConvertWeaponType(4)
WEAPON_TYPE_METAL_MEDIUM_SLICE = ConvertWeaponType(5)
WEAPON_TYPE_METAL_HEAVY_SLICE = ConvertWeaponType(6)
WEAPON_TYPE_METAL_MEDIUM_BASH = ConvertWeaponType(7)
WEAPON_TYPE_METAL_HEAVY_BASH = ConvertWeaponType(8)
WEAPON_TYPE_METAL_MEDIUM_STAB = ConvertWeaponType(9)
WEAPON_TYPE_METAL_HEAVY_STAB = ConvertWeaponType(10)
WEAPON_TYPE_WOOD_LIGHT_SLICE = ConvertWeaponType(11)
WEAPON_TYPE_WOOD_MEDIUM_SLICE = ConvertWeaponType(12)
WEAPON_TYPE_WOOD_HEAVY_SLICE = ConvertWeaponType(13)
WEAPON_TYPE_WOOD_LIGHT_BASH = ConvertWeaponType(14)
WEAPON_TYPE_WOOD_MEDIUM_BASH = ConvertWeaponType(15)
WEAPON_TYPE_WOOD_HEAVY_BASH = ConvertWeaponType(16)
WEAPON_TYPE_WOOD_LIGHT_STAB = ConvertWeaponType(17)
WEAPON_TYPE_WOOD_MEDIUM_STAB = ConvertWeaponType(18)
WEAPON_TYPE_CLAW_LIGHT_SLICE = ConvertWeaponType(19)
WEAPON_TYPE_CLAW_MEDIUM_SLICE = ConvertWeaponType(20)
WEAPON_TYPE_CLAW_HEAVY_SLICE = ConvertWeaponType(21)
WEAPON_TYPE_AXE_MEDIUM_CHOP = ConvertWeaponType(22)
WEAPON_TYPE_ROCK_HEAVY_BASH = ConvertWeaponType(23)
PATHING_TYPE_ANY = ConvertPathingType(0)
PATHING_TYPE_WALKABILITY = ConvertPathingType(1)
PATHING_TYPE_FLYABILITY = ConvertPathingType(2)
PATHING_TYPE_BUILDABILITY = ConvertPathingType(3)
PATHING_TYPE_PEONHARVESTPATHING = ConvertPathingType(4)
PATHING_TYPE_BLIGHTPATHING = ConvertPathingType(5)
PATHING_TYPE_FLOATABILITY = ConvertPathingType(6)
PATHING_TYPE_AMPHIBIOUSPATHING = ConvertPathingType(7)
MOUSE_BUTTON_TYPE_LEFT = ConvertMouseButtonType(1)
MOUSE_BUTTON_TYPE_MIDDLE = ConvertMouseButtonType(2)
MOUSE_BUTTON_TYPE_RIGHT = ConvertMouseButtonType(3)
ANIM_TYPE_BIRTH = ConvertAnimType(0)
ANIM_TYPE_DEATH = ConvertAnimType(1)
ANIM_TYPE_DECAY = ConvertAnimType(2)
ANIM_TYPE_DISSIPATE = ConvertAnimType(3)
ANIM_TYPE_STAND = ConvertAnimType(4)
ANIM_TYPE_WALK = ConvertAnimType(5)
ANIM_TYPE_ATTACK = ConvertAnimType(6)
ANIM_TYPE_MORPH = ConvertAnimType(7)
ANIM_TYPE_SLEEP = ConvertAnimType(8)
ANIM_TYPE_SPELL = ConvertAnimType(9)
ANIM_TYPE_PORTRAIT = ConvertAnimType(10)
SUBANIM_TYPE_ROOTED = ConvertSubAnimType(11)
SUBANIM_TYPE_ALTERNATE_EX = ConvertSubAnimType(12)
SUBANIM_TYPE_LOOPING = ConvertSubAnimType(13)
SUBANIM_TYPE_SLAM = ConvertSubAnimType(14)
SUBANIM_TYPE_THROW = ConvertSubAnimType(15)
SUBANIM_TYPE_SPIKED = ConvertSubAnimType(16)
SUBANIM_TYPE_FAST = ConvertSubAnimType(17)
SUBANIM_TYPE_SPIN = ConvertSubAnimType(18)
SUBANIM_TYPE_READY = ConvertSubAnimType(19)
SUBANIM_TYPE_CHANNEL = ConvertSubAnimType(20)
SUBANIM_TYPE_DEFEND = ConvertSubAnimType(21)
SUBANIM_TYPE_VICTORY = ConvertSubAnimType(22)
SUBANIM_TYPE_TURN = ConvertSubAnimType(23)
SUBANIM_TYPE_LEFT = ConvertSubAnimType(24)
SUBANIM_TYPE_RIGHT = ConvertSubAnimType(25)
SUBANIM_TYPE_FIRE = ConvertSubAnimType(26)
SUBANIM_TYPE_FLESH = ConvertSubAnimType(27)
SUBANIM_TYPE_HIT = ConvertSubAnimType(28)
SUBANIM_TYPE_WOUNDED = ConvertSubAnimType(29)
SUBANIM_TYPE_LIGHT = ConvertSubAnimType(30)
SUBANIM_TYPE_MODERATE = ConvertSubAnimType(31)
SUBANIM_TYPE_SEVERE = ConvertSubAnimType(32)
SUBANIM_TYPE_CRITICAL = ConvertSubAnimType(33)
SUBANIM_TYPE_COMPLETE = ConvertSubAnimType(34)
SUBANIM_TYPE_GOLD = ConvertSubAnimType(35)
SUBANIM_TYPE_LUMBER = ConvertSubAnimType(36)
SUBANIM_TYPE_WORK = ConvertSubAnimType(37)
SUBANIM_TYPE_TALK = ConvertSubAnimType(38)
SUBANIM_TYPE_FIRST = ConvertSubAnimType(39)
SUBANIM_TYPE_SECOND = ConvertSubAnimType(40)
SUBANIM_TYPE_THIRD = ConvertSubAnimType(41)
SUBANIM_TYPE_FOURTH = ConvertSubAnimType(42)
SUBANIM_TYPE_FIFTH = ConvertSubAnimType(43)
SUBANIM_TYPE_ONE = ConvertSubAnimType(44)
SUBANIM_TYPE_TWO = ConvertSubAnimType(45)
SUBANIM_TYPE_THREE = ConvertSubAnimType(46)
SUBANIM_TYPE_FOUR = ConvertSubAnimType(47)
SUBANIM_TYPE_FIVE = ConvertSubAnimType(48)
SUBANIM_TYPE_SMALL = ConvertSubAnimType(49)
SUBANIM_TYPE_MEDIUM = ConvertSubAnimType(50)
SUBANIM_TYPE_LARGE = ConvertSubAnimType(51)
SUBANIM_TYPE_UPGRADE = ConvertSubAnimType(52)
SUBANIM_TYPE_DRAIN = ConvertSubAnimType(53)
SUBANIM_TYPE_FILL = ConvertSubAnimType(54)
SUBANIM_TYPE_CHAINLIGHTNING = ConvertSubAnimType(55)
SUBANIM_TYPE_EATTREE = ConvertSubAnimType(56)
SUBANIM_TYPE_PUKE = ConvertSubAnimType(57)
SUBANIM_TYPE_FLAIL = ConvertSubAnimType(58)
SUBANIM_TYPE_OFF = ConvertSubAnimType(59)
SUBANIM_TYPE_SWIM = ConvertSubAnimType(60)
SUBANIM_TYPE_ENTANGLE = ConvertSubAnimType(61)
SUBANIM_TYPE_BERSERK = ConvertSubAnimType(62)
RACE_PREF_HUMAN = ConvertRacePref(1)
RACE_PREF_ORC = ConvertRacePref(2)
RACE_PREF_NIGHTELF = ConvertRacePref(4)
RACE_PREF_UNDEAD = ConvertRacePref(8)
RACE_PREF_DEMON = ConvertRacePref(16)
RACE_PREF_RANDOM = ConvertRacePref(32)
RACE_PREF_USER_SELECTABLE = ConvertRacePref(64)
MAP_CONTROL_USER = ConvertMapControl(0)
MAP_CONTROL_COMPUTER = ConvertMapControl(1)
MAP_CONTROL_RESCUABLE = ConvertMapControl(2)
MAP_CONTROL_NEUTRAL = ConvertMapControl(3)
MAP_CONTROL_CREEP = ConvertMapControl(4)
MAP_CONTROL_NONE = ConvertMapControl(5)
GAME_TYPE_MELEE = ConvertGameType(1)
GAME_TYPE_FFA = ConvertGameType(2)
GAME_TYPE_USE_MAP_SETTINGS = ConvertGameType(4)
GAME_TYPE_BLIZ = ConvertGameType(8)
GAME_TYPE_ONE_ON_ONE = ConvertGameType(16)
GAME_TYPE_TWO_TEAM_PLAY = ConvertGameType(32)
GAME_TYPE_THREE_TEAM_PLAY = ConvertGameType(64)
GAME_TYPE_FOUR_TEAM_PLAY = ConvertGameType(128)
MAP_FOG_HIDE_TERRAIN = ConvertMapFlag(1)
MAP_FOG_MAP_EXPLORED = ConvertMapFlag(2)
MAP_FOG_ALWAYS_VISIBLE = ConvertMapFlag(4)
MAP_USE_HANDICAPS = ConvertMapFlag(8)
MAP_OBSERVERS = ConvertMapFlag(16)
MAP_OBSERVERS_ON_DEATH = ConvertMapFlag(32)
MAP_FIXED_COLORS = ConvertMapFlag(128)
MAP_LOCK_RESOURCE_TRADING = ConvertMapFlag(256)
MAP_RESOURCE_TRADING_ALLIES_ONLY = ConvertMapFlag(512)
MAP_LOCK_ALLIANCE_CHANGES = ConvertMapFlag(1024)
MAP_ALLIANCE_CHANGES_HIDDEN = ConvertMapFlag(2048)
MAP_CHEATS = ConvertMapFlag(4096)
MAP_CHEATS_HIDDEN = ConvertMapFlag(8192)
MAP_LOCK_SPEED = ConvertMapFlag(8192*2)
MAP_LOCK_RANDOM_SEED = ConvertMapFlag(8192*4)
MAP_SHARED_ADVANCED_CONTROL = ConvertMapFlag(8192*8)
MAP_RANDOM_HERO = ConvertMapFlag(8192*16)
MAP_RANDOM_RACES = ConvertMapFlag(8192*32)
MAP_RELOADED = ConvertMapFlag(8192*64)
MAP_PLACEMENT_RANDOM = ConvertPlacement(0)
MAP_PLACEMENT_FIXED = ConvertPlacement(1)
MAP_PLACEMENT_USE_MAP_SETTINGS = ConvertPlacement(2)
MAP_PLACEMENT_TEAMS_TOGETHER = ConvertPlacement(3)
MAP_LOC_PRIO_LOW = ConvertStartLocPrio(0)
MAP_LOC_PRIO_HIGH = ConvertStartLocPrio(1)
MAP_LOC_PRIO_NOT = ConvertStartLocPrio(2)
MAP_DENSITY_NONE = ConvertMapDensity(0)
MAP_DENSITY_LIGHT = ConvertMapDensity(1)
MAP_DENSITY_MEDIUM = ConvertMapDensity(2)
MAP_DENSITY_HEAVY = ConvertMapDensity(3)
MAP_DIFFICULTY_EASY = ConvertGameDifficulty(0)
MAP_DIFFICULTY_NORMAL = ConvertGameDifficulty(1)
MAP_DIFFICULTY_HARD = ConvertGameDifficulty(2)
MAP_DIFFICULTY_INSANE = ConvertGameDifficulty(3)
MAP_SPEED_SLOWEST = ConvertGameSpeed(0)
MAP_SPEED_SLOW = ConvertGameSpeed(1)
MAP_SPEED_NORMAL = ConvertGameSpeed(2)
MAP_SPEED_FAST = ConvertGameSpeed(3)
MAP_SPEED_FASTEST = ConvertGameSpeed(4)
PLAYER_SLOT_STATE_EMPTY = ConvertPlayerSlotState(0)
PLAYER_SLOT_STATE_PLAYING = ConvertPlayerSlotState(1)
PLAYER_SLOT_STATE_LEFT = ConvertPlayerSlotState(2)
SOUND_VOLUMEGROUP_UNITMOVEMENT = ConvertVolumeGroup(0)
SOUND_VOLUMEGROUP_UNITSOUNDS = ConvertVolumeGroup(1)
SOUND_VOLUMEGROUP_COMBAT = ConvertVolumeGroup(2)
SOUND_VOLUMEGROUP_SPELLS = ConvertVolumeGroup(3)
SOUND_VOLUMEGROUP_UI = ConvertVolumeGroup(4)
SOUND_VOLUMEGROUP_MUSIC = ConvertVolumeGroup(5)
SOUND_VOLUMEGROUP_AMBIENTSOUNDS = ConvertVolumeGroup(6)
SOUND_VOLUMEGROUP_FIRE = ConvertVolumeGroup(7)
GAME_STATE_DIVINE_INTERVENTION = ConvertIGameState(0)
GAME_STATE_DISCONNECTED = ConvertIGameState(1)
GAME_STATE_TIME_OF_DAY = ConvertFGameState(2)
PLAYER_STATE_GAME_RESULT = ConvertPlayerState(0)
PLAYER_STATE_RESOURCE_GOLD = ConvertPlayerState(1)
PLAYER_STATE_RESOURCE_LUMBER = ConvertPlayerState(2)
PLAYER_STATE_RESOURCE_HERO_TOKENS = ConvertPlayerState(3)
PLAYER_STATE_RESOURCE_FOOD_CAP = ConvertPlayerState(4)
PLAYER_STATE_RESOURCE_FOOD_USED = ConvertPlayerState(5)
PLAYER_STATE_FOOD_CAP_CEILING = ConvertPlayerState(6)
PLAYER_STATE_GIVES_BOUNTY = ConvertPlayerState(7)
PLAYER_STATE_ALLIED_VICTORY = ConvertPlayerState(8)
PLAYER_STATE_PLACED = ConvertPlayerState(9)
PLAYER_STATE_OBSERVER_ON_DEATH = ConvertPlayerState(10)
PLAYER_STATE_OBSERVER = ConvertPlayerState(11)
PLAYER_STATE_UNFOLLOWABLE = ConvertPlayerState(12)
PLAYER_STATE_GOLD_UPKEEP_RATE = ConvertPlayerState(13)
PLAYER_STATE_LUMBER_UPKEEP_RATE = ConvertPlayerState(14)
PLAYER_STATE_GOLD_GATHERED = ConvertPlayerState(15)
PLAYER_STATE_LUMBER_GATHERED = ConvertPlayerState(16)
PLAYER_STATE_NO_CREEP_SLEEP = ConvertPlayerState(25)
UNIT_STATE_LIFE = ConvertUnitState(0)
UNIT_STATE_MAX_LIFE = ConvertUnitState(1)
UNIT_STATE_MANA = ConvertUnitState(2)
UNIT_STATE_MAX_MANA = ConvertUnitState(3)
AI_DIFFICULTY_NEWBIE = ConvertAIDifficulty(0)
AI_DIFFICULTY_NORMAL = ConvertAIDifficulty(1)
AI_DIFFICULTY_INSANE = ConvertAIDifficulty(2)
PLAYER_SCORE_UNITS_TRAINED = ConvertPlayerScore(0)
PLAYER_SCORE_UNITS_KILLED = ConvertPlayerScore(1)
PLAYER_SCORE_STRUCT_BUILT = ConvertPlayerScore(2)
PLAYER_SCORE_STRUCT_RAZED = ConvertPlayerScore(3)
PLAYER_SCORE_TECH_PERCENT = ConvertPlayerScore(4)
PLAYER_SCORE_FOOD_MAXPROD = ConvertPlayerScore(5)
PLAYER_SCORE_FOOD_MAXUSED = ConvertPlayerScore(6)
PLAYER_SCORE_HEROES_KILLED = ConvertPlayerScore(7)
PLAYER_SCORE_ITEMS_GAINED = ConvertPlayerScore(8)
PLAYER_SCORE_MERCS_HIRED = ConvertPlayerScore(9)
PLAYER_SCORE_GOLD_MINED_TOTAL = ConvertPlayerScore(10)
PLAYER_SCORE_GOLD_MINED_UPKEEP = ConvertPlayerScore(11)
PLAYER_SCORE_GOLD_LOST_UPKEEP = ConvertPlayerScore(12)
PLAYER_SCORE_GOLD_LOST_TAX = ConvertPlayerScore(13)
PLAYER_SCORE_GOLD_GIVEN = ConvertPlayerScore(14)
PLAYER_SCORE_GOLD_RECEIVED = ConvertPlayerScore(15)
PLAYER_SCORE_LUMBER_TOTAL = ConvertPlayerScore(16)
PLAYER_SCORE_LUMBER_LOST_UPKEEP = ConvertPlayerScore(17)
PLAYER_SCORE_LUMBER_LOST_TAX = ConvertPlayerScore(18)
PLAYER_SCORE_LUMBER_GIVEN = ConvertPlayerScore(19)
PLAYER_SCORE_LUMBER_RECEIVED = ConvertPlayerScore(20)
PLAYER_SCORE_UNIT_TOTAL = ConvertPlayerScore(21)
PLAYER_SCORE_HERO_TOTAL = ConvertPlayerScore(22)
PLAYER_SCORE_RESOURCE_TOTAL = ConvertPlayerScore(23)
PLAYER_SCORE_TOTAL = ConvertPlayerScore(24)
EVENT_GAME_VICTORY = ConvertGameEvent(0)
EVENT_GAME_END_LEVEL = ConvertGameEvent(1)
EVENT_GAME_VARIABLE_LIMIT = ConvertGameEvent(2)
EVENT_GAME_STATE_LIMIT = ConvertGameEvent(3)
EVENT_GAME_TIMER_EXPIRED = ConvertGameEvent(4)
EVENT_GAME_ENTER_REGION = ConvertGameEvent(5)
EVENT_GAME_LEAVE_REGION = ConvertGameEvent(6)
EVENT_GAME_TRACKABLE_HIT = ConvertGameEvent(7)
EVENT_GAME_TRACKABLE_TRACK = ConvertGameEvent(8)
EVENT_GAME_SHOW_SKILL = ConvertGameEvent(9)
EVENT_GAME_BUILD_SUBMENU = ConvertGameEvent(10)
EVENT_PLAYER_STATE_LIMIT = ConvertPlayerEvent(11)
EVENT_PLAYER_ALLIANCE_CHANGED = ConvertPlayerEvent(12)
EVENT_PLAYER_DEFEAT = ConvertPlayerEvent(13)
EVENT_PLAYER_VICTORY = ConvertPlayerEvent(14)
EVENT_PLAYER_LEAVE = ConvertPlayerEvent(15)
EVENT_PLAYER_CHAT = ConvertPlayerEvent(16)
EVENT_PLAYER_END_CINEMATIC = ConvertPlayerEvent(17)
EVENT_PLAYER_UNIT_ATTACKED = ConvertPlayerUnitEvent(18)
EVENT_PLAYER_UNIT_RESCUED = ConvertPlayerUnitEvent(19)
EVENT_PLAYER_UNIT_DEATH = ConvertPlayerUnitEvent(20)
EVENT_PLAYER_UNIT_DECAY = ConvertPlayerUnitEvent(21)
EVENT_PLAYER_UNIT_DETECTED = ConvertPlayerUnitEvent(22)
EVENT_PLAYER_UNIT_HIDDEN = ConvertPlayerUnitEvent(23)
EVENT_PLAYER_UNIT_SELECTED = ConvertPlayerUnitEvent(24)
EVENT_PLAYER_UNIT_DESELECTED = ConvertPlayerUnitEvent(25)
EVENT_PLAYER_UNIT_CONSTRUCT_START = ConvertPlayerUnitEvent(26)
EVENT_PLAYER_UNIT_CONSTRUCT_CANCEL = ConvertPlayerUnitEvent(27)
EVENT_PLAYER_UNIT_CONSTRUCT_FINISH = ConvertPlayerUnitEvent(28)
EVENT_PLAYER_UNIT_UPGRADE_START = ConvertPlayerUnitEvent(29)
EVENT_PLAYER_UNIT_UPGRADE_CANCEL = ConvertPlayerUnitEvent(30)
EVENT_PLAYER_UNIT_UPGRADE_FINISH = ConvertPlayerUnitEvent(31)
EVENT_PLAYER_UNIT_TRAIN_START = ConvertPlayerUnitEvent(32)
EVENT_PLAYER_UNIT_TRAIN_CANCEL = ConvertPlayerUnitEvent(33)
EVENT_PLAYER_UNIT_TRAIN_FINISH = ConvertPlayerUnitEvent(34)
EVENT_PLAYER_UNIT_RESEARCH_START = ConvertPlayerUnitEvent(35)
EVENT_PLAYER_UNIT_RESEARCH_CANCEL = ConvertPlayerUnitEvent(36)
EVENT_PLAYER_UNIT_RESEARCH_FINISH = ConvertPlayerUnitEvent(37)
EVENT_PLAYER_UNIT_ISSUED_ORDER = ConvertPlayerUnitEvent(38)
EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER = ConvertPlayerUnitEvent(39)
EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER = ConvertPlayerUnitEvent(40)
EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER = ConvertPlayerUnitEvent(40)
EVENT_PLAYER_HERO_LEVEL = ConvertPlayerUnitEvent(41)
EVENT_PLAYER_HERO_SKILL = ConvertPlayerUnitEvent(42)
EVENT_PLAYER_HERO_REVIVABLE = ConvertPlayerUnitEvent(43)
EVENT_PLAYER_HERO_REVIVE_START = ConvertPlayerUnitEvent(44)
EVENT_PLAYER_HERO_REVIVE_CANCEL = ConvertPlayerUnitEvent(45)
EVENT_PLAYER_HERO_REVIVE_FINISH = ConvertPlayerUnitEvent(46)
EVENT_PLAYER_UNIT_SUMMON = ConvertPlayerUnitEvent(47)
EVENT_PLAYER_UNIT_DROP_ITEM = ConvertPlayerUnitEvent(48)
EVENT_PLAYER_UNIT_PICKUP_ITEM = ConvertPlayerUnitEvent(49)
EVENT_PLAYER_UNIT_USE_ITEM = ConvertPlayerUnitEvent(50)
EVENT_PLAYER_UNIT_LOADED = ConvertPlayerUnitEvent(51)
EVENT_PLAYER_UNIT_DAMAGED = ConvertPlayerUnitEvent(308)
EVENT_PLAYER_UNIT_DAMAGING = ConvertPlayerUnitEvent(315)
EVENT_UNIT_DAMAGED = ConvertUnitEvent(52)
EVENT_UNIT_DAMAGING = ConvertUnitEvent(314)
EVENT_UNIT_DEATH = ConvertUnitEvent(53)
EVENT_UNIT_DECAY = ConvertUnitEvent(54)
EVENT_UNIT_DETECTED = ConvertUnitEvent(55)
EVENT_UNIT_HIDDEN = ConvertUnitEvent(56)
EVENT_UNIT_SELECTED = ConvertUnitEvent(57)
EVENT_UNIT_DESELECTED = ConvertUnitEvent(58)
EVENT_UNIT_STATE_LIMIT = ConvertUnitEvent(59)
EVENT_UNIT_ACQUIRED_TARGET = ConvertUnitEvent(60)
EVENT_UNIT_TARGET_IN_RANGE = ConvertUnitEvent(61)
EVENT_UNIT_ATTACKED = ConvertUnitEvent(62)
EVENT_UNIT_RESCUED = ConvertUnitEvent(63)
EVENT_UNIT_CONSTRUCT_CANCEL = ConvertUnitEvent(64)
EVENT_UNIT_CONSTRUCT_FINISH = ConvertUnitEvent(65)
EVENT_UNIT_UPGRADE_START = ConvertUnitEvent(66)
EVENT_UNIT_UPGRADE_CANCEL = ConvertUnitEvent(67)
EVENT_UNIT_UPGRADE_FINISH = ConvertUnitEvent(68)
EVENT_UNIT_TRAIN_START = ConvertUnitEvent(69)
EVENT_UNIT_TRAIN_CANCEL = ConvertUnitEvent(70)
EVENT_UNIT_TRAIN_FINISH = ConvertUnitEvent(71)
EVENT_UNIT_RESEARCH_START = ConvertUnitEvent(72)
EVENT_UNIT_RESEARCH_CANCEL = ConvertUnitEvent(73)
EVENT_UNIT_RESEARCH_FINISH = ConvertUnitEvent(74)
EVENT_UNIT_ISSUED_ORDER = ConvertUnitEvent(75)
EVENT_UNIT_ISSUED_POINT_ORDER = ConvertUnitEvent(76)
EVENT_UNIT_ISSUED_TARGET_ORDER = ConvertUnitEvent(77)
EVENT_UNIT_HERO_LEVEL = ConvertUnitEvent(78)
EVENT_UNIT_HERO_SKILL = ConvertUnitEvent(79)
EVENT_UNIT_HERO_REVIVABLE = ConvertUnitEvent(80)
EVENT_UNIT_HERO_REVIVE_START = ConvertUnitEvent(81)
EVENT_UNIT_HERO_REVIVE_CANCEL = ConvertUnitEvent(82)
EVENT_UNIT_HERO_REVIVE_FINISH = ConvertUnitEvent(83)
EVENT_UNIT_SUMMON = ConvertUnitEvent(84)
EVENT_UNIT_DROP_ITEM = ConvertUnitEvent(85)
EVENT_UNIT_PICKUP_ITEM = ConvertUnitEvent(86)
EVENT_UNIT_USE_ITEM = ConvertUnitEvent(87)
EVENT_UNIT_LOADED = ConvertUnitEvent(88)
EVENT_WIDGET_DEATH = ConvertWidgetEvent(89)
EVENT_DIALOG_BUTTON_CLICK = ConvertDialogEvent(90)
EVENT_DIALOG_CLICK = ConvertDialogEvent(91)
EVENT_GAME_LOADED = ConvertGameEvent(256)
EVENT_GAME_TOURNAMENT_FINISH_SOON = ConvertGameEvent(257)
EVENT_GAME_TOURNAMENT_FINISH_NOW = ConvertGameEvent(258)
EVENT_GAME_SAVE = ConvertGameEvent(259)
EVENT_GAME_CUSTOM_UI_FRAME = ConvertGameEvent(310)
EVENT_PLAYER_ARROW_LEFT_DOWN = ConvertPlayerEvent(261)
EVENT_PLAYER_ARROW_LEFT_UP = ConvertPlayerEvent(262)
EVENT_PLAYER_ARROW_RIGHT_DOWN = ConvertPlayerEvent(263)
EVENT_PLAYER_ARROW_RIGHT_UP = ConvertPlayerEvent(264)
EVENT_PLAYER_ARROW_DOWN_DOWN = ConvertPlayerEvent(265)
EVENT_PLAYER_ARROW_DOWN_UP = ConvertPlayerEvent(266)
EVENT_PLAYER_ARROW_UP_DOWN = ConvertPlayerEvent(267)
EVENT_PLAYER_ARROW_UP_UP = ConvertPlayerEvent(268)
EVENT_PLAYER_MOUSE_DOWN = ConvertPlayerEvent(305)
EVENT_PLAYER_MOUSE_UP = ConvertPlayerEvent(306)
EVENT_PLAYER_MOUSE_MOVE = ConvertPlayerEvent(307)
EVENT_PLAYER_SYNC_DATA = ConvertPlayerEvent(309)
EVENT_PLAYER_KEY = ConvertPlayerEvent(311)
EVENT_PLAYER_KEY_DOWN = ConvertPlayerEvent(312)
EVENT_PLAYER_KEY_UP = ConvertPlayerEvent(313)
EVENT_PLAYER_UNIT_SELL = ConvertPlayerUnitEvent(269)
EVENT_PLAYER_UNIT_CHANGE_OWNER = ConvertPlayerUnitEvent(270)
EVENT_PLAYER_UNIT_SELL_ITEM = ConvertPlayerUnitEvent(271)
EVENT_PLAYER_UNIT_SPELL_CHANNEL = ConvertPlayerUnitEvent(272)
EVENT_PLAYER_UNIT_SPELL_CAST = ConvertPlayerUnitEvent(273)
EVENT_PLAYER_UNIT_SPELL_EFFECT = ConvertPlayerUnitEvent(274)
EVENT_PLAYER_UNIT_SPELL_FINISH = ConvertPlayerUnitEvent(275)
EVENT_PLAYER_UNIT_SPELL_ENDCAST = ConvertPlayerUnitEvent(276)
EVENT_PLAYER_UNIT_PAWN_ITEM = ConvertPlayerUnitEvent(277)
EVENT_UNIT_SELL = ConvertUnitEvent(286)
EVENT_UNIT_CHANGE_OWNER = ConvertUnitEvent(287)
EVENT_UNIT_SELL_ITEM = ConvertUnitEvent(288)
EVENT_UNIT_SPELL_CHANNEL = ConvertUnitEvent(289)
EVENT_UNIT_SPELL_CAST = ConvertUnitEvent(290)
EVENT_UNIT_SPELL_EFFECT = ConvertUnitEvent(291)
EVENT_UNIT_SPELL_FINISH = ConvertUnitEvent(292)
EVENT_UNIT_SPELL_ENDCAST = ConvertUnitEvent(293)
EVENT_UNIT_PAWN_ITEM = ConvertUnitEvent(294)
LESS_THAN = ConvertLimitOp(0)
LESS_THAN_OR_EQUAL = ConvertLimitOp(1)
EQUAL = ConvertLimitOp(2)
GREATER_THAN_OR_EQUAL = ConvertLimitOp(3)
GREATER_THAN = ConvertLimitOp(4)
NOT_EQUAL = ConvertLimitOp(5)
UNIT_TYPE_HERO = ConvertUnitType(0)
UNIT_TYPE_DEAD = ConvertUnitType(1)
UNIT_TYPE_STRUCTURE = ConvertUnitType(2)
UNIT_TYPE_FLYING = ConvertUnitType(3)
UNIT_TYPE_GROUND = ConvertUnitType(4)
UNIT_TYPE_ATTACKS_FLYING = ConvertUnitType(5)
UNIT_TYPE_ATTACKS_GROUND = ConvertUnitType(6)
UNIT_TYPE_MELEE_ATTACKER = ConvertUnitType(7)
UNIT_TYPE_RANGED_ATTACKER = ConvertUnitType(8)
UNIT_TYPE_GIANT = ConvertUnitType(9)
UNIT_TYPE_SUMMONED = ConvertUnitType(10)
UNIT_TYPE_STUNNED = ConvertUnitType(11)
UNIT_TYPE_PLAGUED = ConvertUnitType(12)
UNIT_TYPE_SNARED = ConvertUnitType(13)
UNIT_TYPE_UNDEAD = ConvertUnitType(14)
UNIT_TYPE_MECHANICAL = ConvertUnitType(15)
UNIT_TYPE_PEON = ConvertUnitType(16)
UNIT_TYPE_SAPPER = ConvertUnitType(17)
UNIT_TYPE_TOWNHALL = ConvertUnitType(18)
UNIT_TYPE_ANCIENT = ConvertUnitType(19)
UNIT_TYPE_TAUREN = ConvertUnitType(20)
UNIT_TYPE_POISONED = ConvertUnitType(21)
UNIT_TYPE_POLYMORPHED = ConvertUnitType(22)
UNIT_TYPE_SLEEPING = ConvertUnitType(23)
UNIT_TYPE_RESISTANT = ConvertUnitType(24)
UNIT_TYPE_ETHEREAL = ConvertUnitType(25)
UNIT_TYPE_MAGIC_IMMUNE = ConvertUnitType(26)
ITEM_TYPE_PERMANENT = ConvertItemType(0)
ITEM_TYPE_CHARGED = ConvertItemType(1)
ITEM_TYPE_POWERUP = ConvertItemType(2)
ITEM_TYPE_ARTIFACT = ConvertItemType(3)
ITEM_TYPE_PURCHASABLE = ConvertItemType(4)
ITEM_TYPE_CAMPAIGN = ConvertItemType(5)
ITEM_TYPE_MISCELLANEOUS = ConvertItemType(6)
ITEM_TYPE_UNKNOWN = ConvertItemType(7)
ITEM_TYPE_ANY = ConvertItemType(8)
ITEM_TYPE_TOME = ConvertItemType(2)
CAMERA_FIELD_TARGET_DISTANCE = ConvertCameraField(0)
CAMERA_FIELD_FARZ = ConvertCameraField(1)
CAMERA_FIELD_ANGLE_OF_ATTACK = ConvertCameraField(2)
CAMERA_FIELD_FIELD_OF_VIEW = ConvertCameraField(3)
CAMERA_FIELD_ROLL = ConvertCameraField(4)
CAMERA_FIELD_ROTATION = ConvertCameraField(5)
CAMERA_FIELD_ZOFFSET = ConvertCameraField(6)
CAMERA_FIELD_NEARZ = ConvertCameraField(7)
CAMERA_FIELD_LOCAL_PITCH = ConvertCameraField(8)
CAMERA_FIELD_LOCAL_YAW = ConvertCameraField(9)
CAMERA_FIELD_LOCAL_ROLL = ConvertCameraField(10)
BLEND_MODE_NONE = ConvertBlendMode(0)
BLEND_MODE_DONT_CARE = ConvertBlendMode(0)
BLEND_MODE_KEYALPHA = ConvertBlendMode(1)
BLEND_MODE_BLEND = ConvertBlendMode(2)
BLEND_MODE_ADDITIVE = ConvertBlendMode(3)
BLEND_MODE_MODULATE = ConvertBlendMode(4)
BLEND_MODE_MODULATE_2X = ConvertBlendMode(5)
RARITY_FREQUENT = ConvertRarityControl(0)
RARITY_RARE = ConvertRarityControl(1)
TEXMAP_FLAG_NONE = ConvertTexMapFlags(0)
TEXMAP_FLAG_WRAP_U = ConvertTexMapFlags(1)
TEXMAP_FLAG_WRAP_V = ConvertTexMapFlags(2)
TEXMAP_FLAG_WRAP_UV = ConvertTexMapFlags(3)
FOG_OF_WAR_MASKED = ConvertFogState(1)
FOG_OF_WAR_FOGGED = ConvertFogState(2)
FOG_OF_WAR_VISIBLE = ConvertFogState(4)
CAMERA_MARGIN_LEFT = 0
CAMERA_MARGIN_RIGHT = 1
CAMERA_MARGIN_TOP = 2
CAMERA_MARGIN_BOTTOM = 3
EFFECT_TYPE_EFFECT = ConvertEffectType(0)
EFFECT_TYPE_TARGET = ConvertEffectType(1)
EFFECT_TYPE_CASTER = ConvertEffectType(2)
EFFECT_TYPE_SPECIAL = ConvertEffectType(3)
EFFECT_TYPE_AREA_EFFECT = ConvertEffectType(4)
EFFECT_TYPE_MISSILE = ConvertEffectType(5)
EFFECT_TYPE_LIGHTNING = ConvertEffectType(6)
SOUND_TYPE_EFFECT = ConvertSoundType(0)
SOUND_TYPE_EFFECT_LOOPED = ConvertSoundType(1)
ORIGIN_FRAME_GAME_UI = ConvertOriginFrameType(0)
ORIGIN_FRAME_COMMAND_BUTTON = ConvertOriginFrameType(1)
ORIGIN_FRAME_HERO_BAR = ConvertOriginFrameType(2)
ORIGIN_FRAME_HERO_BUTTON = ConvertOriginFrameType(3)
ORIGIN_FRAME_HERO_HP_BAR = ConvertOriginFrameType(4)
ORIGIN_FRAME_HERO_MANA_BAR = ConvertOriginFrameType(5)
ORIGIN_FRAME_HERO_BUTTON_INDICATOR = ConvertOriginFrameType(6)
ORIGIN_FRAME_ITEM_BUTTON = ConvertOriginFrameType(7)
ORIGIN_FRAME_MINIMAP = ConvertOriginFrameType(8)
ORIGIN_FRAME_MINIMAP_BUTTON = ConvertOriginFrameType(9)
ORIGIN_FRAME_SYSTEM_BUTTON = ConvertOriginFrameType(10)
ORIGIN_FRAME_TOOLTIP = ConvertOriginFrameType(11)
ORIGIN_FRAME_UBERTOOLTIP = ConvertOriginFrameType(12)
ORIGIN_FRAME_CHAT_MSG = ConvertOriginFrameType(13)
ORIGIN_FRAME_UNIT_MSG = ConvertOriginFrameType(14)
ORIGIN_FRAME_TOP_MSG = ConvertOriginFrameType(15)
ORIGIN_FRAME_PORTRAIT = ConvertOriginFrameType(16)
ORIGIN_FRAME_WORLD_FRAME = ConvertOriginFrameType(17)
FRAMEPOINT_TOPLEFT = ConvertFramePointType(0)
FRAMEPOINT_TOP = ConvertFramePointType(1)
FRAMEPOINT_TOPRIGHT = ConvertFramePointType(2)
FRAMEPOINT_LEFT = ConvertFramePointType(3)
FRAMEPOINT_CENTER = ConvertFramePointType(4)
FRAMEPOINT_RIGHT = ConvertFramePointType(5)
FRAMEPOINT_BOTTOMLEFT = ConvertFramePointType(6)
FRAMEPOINT_BOTTOM = ConvertFramePointType(7)
FRAMEPOINT_BOTTOMRIGHT = ConvertFramePointType(8)
TEXT_JUSTIFY_TOP = ConvertTextAlignType(0)
TEXT_JUSTIFY_MIDDLE = ConvertTextAlignType(1)
TEXT_JUSTIFY_BOTTOM = ConvertTextAlignType(2)
TEXT_JUSTIFY_LEFT = ConvertTextAlignType(3)
TEXT_JUSTIFY_CENTER = ConvertTextAlignType(4)
TEXT_JUSTIFY_RIGHT = ConvertTextAlignType(5)
FRAMEEVENT_CONTROL_CLICK = ConvertFrameEventType(1)
FRAMEEVENT_MOUSE_ENTER = ConvertFrameEventType(2)
FRAMEEVENT_MOUSE_LEAVE = ConvertFrameEventType(3)
FRAMEEVENT_MOUSE_UP = ConvertFrameEventType(4)
FRAMEEVENT_MOUSE_DOWN = ConvertFrameEventType(5)
FRAMEEVENT_MOUSE_WHEEL = ConvertFrameEventType(6)
FRAMEEVENT_CHECKBOX_CHECKED = ConvertFrameEventType(7)
FRAMEEVENT_CHECKBOX_UNCHECKED = ConvertFrameEventType(8)
FRAMEEVENT_EDITBOX_TEXT_CHANGED = ConvertFrameEventType(9)
FRAMEEVENT_POPUPMENU_ITEM_CHANGED = ConvertFrameEventType(10)
FRAMEEVENT_MOUSE_DOUBLECLICK = ConvertFrameEventType(11)
FRAMEEVENT_SPRITE_ANIM_UPDATE = ConvertFrameEventType(12)
FRAMEEVENT_SLIDER_VALUE_CHANGED = ConvertFrameEventType(13)
FRAMEEVENT_DIALOG_CANCEL = ConvertFrameEventType(14)
FRAMEEVENT_DIALOG_ACCEPT = ConvertFrameEventType(15)
FRAMEEVENT_EDITBOX_ENTER = ConvertFrameEventType(16)
OSKEY_BACKSPACE = ConvertOsKeyType("$08")
OSKEY_TAB = ConvertOsKeyType("$09")
OSKEY_CLEAR = ConvertOsKeyType("$0C")
OSKEY_RETURN = ConvertOsKeyType("$0D")
OSKEY_SHIFT = ConvertOsKeyType("$10")
OSKEY_CONTROL = ConvertOsKeyType("$11")
OSKEY_ALT = ConvertOsKeyType("$12")
OSKEY_PAUSE = ConvertOsKeyType("$13")
OSKEY_CAPSLOCK = ConvertOsKeyType("$14")
OSKEY_KANA = ConvertOsKeyType("$15")
OSKEY_HANGUL = ConvertOsKeyType("$15")
OSKEY_JUNJA = ConvertOsKeyType("$17")
OSKEY_FINAL = ConvertOsKeyType("$18")
OSKEY_HANJA = ConvertOsKeyType("$19")
OSKEY_KANJI = ConvertOsKeyType("$19")
OSKEY_ESCAPE = ConvertOsKeyType("$1B")
OSKEY_CONVERT = ConvertOsKeyType("$1C")
OSKEY_NONCONVERT = ConvertOsKeyType("$1D")
OSKEY_ACCEPT = ConvertOsKeyType("$1E")
OSKEY_MODECHANGE = ConvertOsKeyType("$1F")
OSKEY_SPACE = ConvertOsKeyType("$20")
OSKEY_PAGEUP = ConvertOsKeyType("$21")
OSKEY_PAGEDOWN = ConvertOsKeyType("$22")
OSKEY_END = ConvertOsKeyType("$23")
OSKEY_HOME = ConvertOsKeyType("$24")
OSKEY_LEFT = ConvertOsKeyType("$25")
OSKEY_UP = ConvertOsKeyType("$26")
OSKEY_RIGHT = ConvertOsKeyType("$27")
OSKEY_DOWN = ConvertOsKeyType("$28")
OSKEY_SELECT = ConvertOsKeyType("$29")
OSKEY_PRINT = ConvertOsKeyType("$2A")
OSKEY_EXECUTE = ConvertOsKeyType("$2B")
OSKEY_PRINTSCREEN = ConvertOsKeyType("$2C")
OSKEY_INSERT = ConvertOsKeyType("$2D")
OSKEY_DELETE = ConvertOsKeyType("$2E")
OSKEY_HELP = ConvertOsKeyType("$2F")
OSKEY_0 = ConvertOsKeyType("$30")
OSKEY_1 = ConvertOsKeyType("$31")
OSKEY_2 = ConvertOsKeyType("$32")
OSKEY_3 = ConvertOsKeyType("$33")
OSKEY_4 = ConvertOsKeyType("$34")
OSKEY_5 = ConvertOsKeyType("$35")
OSKEY_6 = ConvertOsKeyType("$36")
OSKEY_7 = ConvertOsKeyType("$37")
OSKEY_8 = ConvertOsKeyType("$38")
OSKEY_9 = ConvertOsKeyType("$39")
OSKEY_A = ConvertOsKeyType("$41")
OSKEY_B = ConvertOsKeyType("$42")
OSKEY_C = ConvertOsKeyType("$43")
OSKEY_D = ConvertOsKeyType("$44")
OSKEY_E = ConvertOsKeyType("$45")
OSKEY_F = ConvertOsKeyType("$46")
OSKEY_G = ConvertOsKeyType("$47")
OSKEY_H = ConvertOsKeyType("$48")
OSKEY_I = ConvertOsKeyType("$49")
OSKEY_J = ConvertOsKeyType("$4A")
OSKEY_K = ConvertOsKeyType("$4B")
OSKEY_L = ConvertOsKeyType("$4C")
OSKEY_M = ConvertOsKeyType("$4D")
OSKEY_N = ConvertOsKeyType("$4E")
OSKEY_O = ConvertOsKeyType("$4F")
OSKEY_P = ConvertOsKeyType("$50")
OSKEY_Q = ConvertOsKeyType("$51")
OSKEY_R = ConvertOsKeyType("$52")
OSKEY_S = ConvertOsKeyType("$53")
OSKEY_T = ConvertOsKeyType("$54")
OSKEY_U = ConvertOsKeyType("$55")
OSKEY_V = ConvertOsKeyType("$56")
OSKEY_W = ConvertOsKeyType("$57")
OSKEY_X = ConvertOsKeyType("$58")
OSKEY_Y = ConvertOsKeyType("$59")
OSKEY_Z = ConvertOsKeyType("$5A")
OSKEY_LMETA = ConvertOsKeyType("$5B")
OSKEY_RMETA = ConvertOsKeyType("$5C")
OSKEY_APPS = ConvertOsKeyType("$5D")
OSKEY_SLEEP = ConvertOsKeyType("$5F")
OSKEY_NUMPAD0 = ConvertOsKeyType("$60")
OSKEY_NUMPAD1 = ConvertOsKeyType("$61")
OSKEY_NUMPAD2 = ConvertOsKeyType("$62")
OSKEY_NUMPAD3 = ConvertOsKeyType("$63")
OSKEY_NUMPAD4 = ConvertOsKeyType("$64")
OSKEY_NUMPAD5 = ConvertOsKeyType("$65")
OSKEY_NUMPAD6 = ConvertOsKeyType("$66")
OSKEY_NUMPAD7 = ConvertOsKeyType("$67")
OSKEY_NUMPAD8 = ConvertOsKeyType("$68")
OSKEY_NUMPAD9 = ConvertOsKeyType("$69")
OSKEY_MULTIPLY = ConvertOsKeyType("$6A")
OSKEY_ADD = ConvertOsKeyType("$6B")
OSKEY_SEPARATOR = ConvertOsKeyType("$6C")
OSKEY_SUBTRACT = ConvertOsKeyType("$6D")
OSKEY_DECIMAL = ConvertOsKeyType("$6E")
OSKEY_DIVIDE = ConvertOsKeyType("$6F")
OSKEY_F1 = ConvertOsKeyType("$70")
OSKEY_F2 = ConvertOsKeyType("$71")
OSKEY_F3 = ConvertOsKeyType("$72")
OSKEY_F4 = ConvertOsKeyType("$73")
OSKEY_F5 = ConvertOsKeyType("$74")
OSKEY_F6 = ConvertOsKeyType("$75")
OSKEY_F7 = ConvertOsKeyType("$76")
OSKEY_F8 = ConvertOsKeyType("$77")
OSKEY_F9 = ConvertOsKeyType("$78")
OSKEY_F10 = ConvertOsKeyType("$79")
OSKEY_F11 = ConvertOsKeyType("$7A")
OSKEY_F12 = ConvertOsKeyType("$7B")
OSKEY_F13 = ConvertOsKeyType("$7C")
OSKEY_F14 = ConvertOsKeyType("$7D")
OSKEY_F15 = ConvertOsKeyType("$7E")
OSKEY_F16 = ConvertOsKeyType("$7F")
OSKEY_F17 = ConvertOsKeyType("$80")
OSKEY_F18 = ConvertOsKeyType("$81")
OSKEY_F19 = ConvertOsKeyType("$82")
OSKEY_F20 = ConvertOsKeyType("$83")
OSKEY_F21 = ConvertOsKeyType("$84")
OSKEY_F22 = ConvertOsKeyType("$85")
OSKEY_F23 = ConvertOsKeyType("$86")
OSKEY_F24 = ConvertOsKeyType("$87")
OSKEY_NUMLOCK = ConvertOsKeyType("$90")
OSKEY_SCROLLLOCK = ConvertOsKeyType("$91")
OSKEY_OEM_NEC_EQUAL = ConvertOsKeyType("$92")
OSKEY_OEM_FJ_JISHO = ConvertOsKeyType("$92")
OSKEY_OEM_FJ_MASSHOU = ConvertOsKeyType("$93")
OSKEY_OEM_FJ_TOUROKU = ConvertOsKeyType("$94")
OSKEY_OEM_FJ_LOYA = ConvertOsKeyType("$95")
OSKEY_OEM_FJ_ROYA = ConvertOsKeyType("$96")
OSKEY_LSHIFT = ConvertOsKeyType("$A0")
OSKEY_RSHIFT = ConvertOsKeyType("$A1")
OSKEY_LCONTROL = ConvertOsKeyType("$A2")
OSKEY_RCONTROL = ConvertOsKeyType("$A3")
OSKEY_LALT = ConvertOsKeyType("$A4")
OSKEY_RALT = ConvertOsKeyType("$A5")
OSKEY_BROWSER_BACK = ConvertOsKeyType("$A6")
OSKEY_BROWSER_FORWARD = ConvertOsKeyType("$A7")
OSKEY_BROWSER_REFRESH = ConvertOsKeyType("$A8")
OSKEY_BROWSER_STOP = ConvertOsKeyType("$A9")
OSKEY_BROWSER_SEARCH = ConvertOsKeyType("$AA")
OSKEY_BROWSER_FAVORITES = ConvertOsKeyType("$AB")
OSKEY_BROWSER_HOME = ConvertOsKeyType("$AC")
OSKEY_VOLUME_MUTE = ConvertOsKeyType("$AD")
OSKEY_VOLUME_DOWN = ConvertOsKeyType("$AE")
OSKEY_VOLUME_UP = ConvertOsKeyType("$AF")
OSKEY_MEDIA_NEXT_TRACK = ConvertOsKeyType("$B0")
OSKEY_MEDIA_PREV_TRACK = ConvertOsKeyType("$B1")
OSKEY_MEDIA_STOP = ConvertOsKeyType("$B2")
OSKEY_MEDIA_PLAY_PAUSE = ConvertOsKeyType("$B3")
OSKEY_LAUNCH_MAIL = ConvertOsKeyType("$B4")
OSKEY_LAUNCH_MEDIA_SELECT = ConvertOsKeyType("$B5")
OSKEY_LAUNCH_APP1 = ConvertOsKeyType("$B6")
OSKEY_LAUNCH_APP2 = ConvertOsKeyType("$B7")
OSKEY_OEM_1 = ConvertOsKeyType("$BA")
OSKEY_OEM_PLUS = ConvertOsKeyType("$BB")
OSKEY_OEM_COMMA = ConvertOsKeyType("$BC")
OSKEY_OEM_MINUS = ConvertOsKeyType("$BD")
OSKEY_OEM_PERIOD = ConvertOsKeyType("$BE")
OSKEY_OEM_2 = ConvertOsKeyType("$BF")
OSKEY_OEM_3 = ConvertOsKeyType("$C0")
OSKEY_OEM_4 = ConvertOsKeyType("$DB")
OSKEY_OEM_5 = ConvertOsKeyType("$DC")
OSKEY_OEM_6 = ConvertOsKeyType("$DD")
OSKEY_OEM_7 = ConvertOsKeyType("$DE")
OSKEY_OEM_8 = ConvertOsKeyType("$DF")
OSKEY_OEM_AX = ConvertOsKeyType("$E1")
OSKEY_OEM_102 = ConvertOsKeyType("$E2")
OSKEY_ICO_HELP = ConvertOsKeyType("$E3")
OSKEY_ICO_00 = ConvertOsKeyType("$E4")
OSKEY_PROCESSKEY = ConvertOsKeyType("$E5")
OSKEY_ICO_CLEAR = ConvertOsKeyType("$E6")
OSKEY_PACKET = ConvertOsKeyType("$E7")
OSKEY_OEM_RESET = ConvertOsKeyType("$E9")
OSKEY_OEM_JUMP = ConvertOsKeyType("$EA")
OSKEY_OEM_PA1 = ConvertOsKeyType("$EB")
OSKEY_OEM_PA2 = ConvertOsKeyType("$EC")
OSKEY_OEM_PA3 = ConvertOsKeyType("$ED")
OSKEY_OEM_WSCTRL = ConvertOsKeyType("$EE")
OSKEY_OEM_CUSEL = ConvertOsKeyType("$EF")
OSKEY_OEM_ATTN = ConvertOsKeyType("$F0")
OSKEY_OEM_FINISH = ConvertOsKeyType("$F1")
OSKEY_OEM_COPY = ConvertOsKeyType("$F2")
OSKEY_OEM_AUTO = ConvertOsKeyType("$F3")
OSKEY_OEM_ENLW = ConvertOsKeyType("$F4")
OSKEY_OEM_BACKTAB = ConvertOsKeyType("$F5")
OSKEY_ATTN = ConvertOsKeyType("$F6")
OSKEY_CRSEL = ConvertOsKeyType("$F7")
OSKEY_EXSEL = ConvertOsKeyType("$F8")
OSKEY_EREOF = ConvertOsKeyType("$F9")
OSKEY_PLAY = ConvertOsKeyType("$FA")
OSKEY_ZOOM = ConvertOsKeyType("$FB")
OSKEY_NONAME = ConvertOsKeyType("$FC")
OSKEY_PA1 = ConvertOsKeyType("$FD")
OSKEY_OEM_CLEAR = ConvertOsKeyType("$FE")
ABILITY_IF_BUTTON_POSITION_NORMAL_X = ConvertAbilityIntegerField('abpx')
ABILITY_IF_BUTTON_POSITION_NORMAL_Y = ConvertAbilityIntegerField('abpy')
ABILITY_IF_BUTTON_POSITION_ACTIVATED_X = ConvertAbilityIntegerField('aubx')
ABILITY_IF_BUTTON_POSITION_ACTIVATED_Y = ConvertAbilityIntegerField('auby')
ABILITY_IF_BUTTON_POSITION_RESEARCH_X = ConvertAbilityIntegerField('arpx')
ABILITY_IF_BUTTON_POSITION_RESEARCH_Y = ConvertAbilityIntegerField('arpy')
ABILITY_IF_MISSILE_SPEED = ConvertAbilityIntegerField('amsp')
ABILITY_IF_TARGET_ATTACHMENTS = ConvertAbilityIntegerField('atac')
ABILITY_IF_CASTER_ATTACHMENTS = ConvertAbilityIntegerField('acac')
ABILITY_IF_PRIORITY = ConvertAbilityIntegerField('apri')
ABILITY_IF_LEVELS = ConvertAbilityIntegerField('alev')
ABILITY_IF_REQUIRED_LEVEL = ConvertAbilityIntegerField('arlv')
ABILITY_IF_LEVEL_SKIP_REQUIREMENT = ConvertAbilityIntegerField('alsk')
ABILITY_BF_HERO_ABILITY = ConvertAbilityBooleanField('aher')
ABILITY_BF_ITEM_ABILITY = ConvertAbilityBooleanField('aite')
ABILITY_BF_CHECK_DEPENDENCIES = ConvertAbilityBooleanField('achd')
ABILITY_RF_ARF_MISSILE_ARC = ConvertAbilityRealField('amac')
ABILITY_SF_NAME = ConvertAbilityStringField('anam')
ABILITY_SF_ICON_ACTIVATED = ConvertAbilityStringField('auar')
ABILITY_SF_ICON_RESEARCH = ConvertAbilityStringField('arar')
ABILITY_SF_EFFECT_SOUND = ConvertAbilityStringField('aefs')
ABILITY_SF_EFFECT_SOUND_LOOPING = ConvertAbilityStringField('aefl')
ABILITY_ILF_MANA_COST = ConvertAbilityIntegerLevelField('amcs')
ABILITY_ILF_NUMBER_OF_WAVES = ConvertAbilityIntegerLevelField('Hbz1')
ABILITY_ILF_NUMBER_OF_SHARDS = ConvertAbilityIntegerLevelField('Hbz3')
ABILITY_ILF_NUMBER_OF_UNITS_TELEPORTED = ConvertAbilityIntegerLevelField('Hmt1')
ABILITY_ILF_SUMMONED_UNIT_COUNT_HWE2 = ConvertAbilityIntegerLevelField('Hwe2')
ABILITY_ILF_NUMBER_OF_IMAGES = ConvertAbilityIntegerLevelField('Omi1')
ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_UAN1 = ConvertAbilityIntegerLevelField('Uan1')
ABILITY_ILF_MORPHING_FLAGS = ConvertAbilityIntegerLevelField('Eme2')
ABILITY_ILF_STRENGTH_BONUS_NRG5 = ConvertAbilityIntegerLevelField('Nrg5')
ABILITY_ILF_DEFENSE_BONUS_NRG6 = ConvertAbilityIntegerLevelField('Nrg6')
ABILITY_ILF_NUMBER_OF_TARGETS_HIT = ConvertAbilityIntegerLevelField('Ocl2')
ABILITY_ILF_DETECTION_TYPE_OFS1 = ConvertAbilityIntegerLevelField('Ofs1')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_OSF2 = ConvertAbilityIntegerLevelField('Osf2')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_EFN1 = ConvertAbilityIntegerLevelField('Efn1')
ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_HRE1 = ConvertAbilityIntegerLevelField('Hre1')
ABILITY_ILF_STACK_FLAGS = ConvertAbilityIntegerLevelField('Hca4')
ABILITY_ILF_MINIMUM_NUMBER_OF_UNITS = ConvertAbilityIntegerLevelField('Ndp2')
ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_NDP3 = ConvertAbilityIntegerLevelField('Ndp3')
ABILITY_ILF_NUMBER_OF_UNITS_CREATED_NRC2 = ConvertAbilityIntegerLevelField('Nrc2')
ABILITY_ILF_SHIELD_LIFE = ConvertAbilityIntegerLevelField('Ams3')
ABILITY_ILF_MANA_LOSS_AMS4 = ConvertAbilityIntegerLevelField('Ams4')
ABILITY_ILF_GOLD_PER_INTERVAL_BGM1 = ConvertAbilityIntegerLevelField('Bgm1')
ABILITY_ILF_MAX_NUMBER_OF_MINERS = ConvertAbilityIntegerLevelField('Bgm3')
ABILITY_ILF_CARGO_CAPACITY = ConvertAbilityIntegerLevelField('Car1')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_DEV3 = ConvertAbilityIntegerLevelField('Dev3')
ABILITY_ILF_MAX_CREEP_LEVEL_DEV1 = ConvertAbilityIntegerLevelField('Dev1')
ABILITY_ILF_GOLD_PER_INTERVAL_EGM1 = ConvertAbilityIntegerLevelField('Egm1')
ABILITY_ILF_DEFENSE_REDUCTION = ConvertAbilityIntegerLevelField('Fae1')
ABILITY_ILF_DETECTION_TYPE_FLA1 = ConvertAbilityIntegerLevelField('Fla1')
ABILITY_ILF_FLARE_COUNT = ConvertAbilityIntegerLevelField('Fla3')
ABILITY_ILF_MAX_GOLD = ConvertAbilityIntegerLevelField('Gld1')
ABILITY_ILF_MINING_CAPACITY = ConvertAbilityIntegerLevelField('Gld3')
ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_GYD1 = ConvertAbilityIntegerLevelField('Gyd1')
ABILITY_ILF_DAMAGE_TO_TREE = ConvertAbilityIntegerLevelField('Har1')
ABILITY_ILF_LUMBER_CAPACITY = ConvertAbilityIntegerLevelField('Har2')
ABILITY_ILF_GOLD_CAPACITY = ConvertAbilityIntegerLevelField('Har3')
ABILITY_ILF_DEFENSE_INCREASE_INF2 = ConvertAbilityIntegerLevelField('Inf2')
ABILITY_ILF_INTERACTION_TYPE = ConvertAbilityIntegerLevelField('Neu2')
ABILITY_ILF_GOLD_COST_NDT1 = ConvertAbilityIntegerLevelField('Ndt1')
ABILITY_ILF_LUMBER_COST_NDT2 = ConvertAbilityIntegerLevelField('Ndt2')
ABILITY_ILF_DETECTION_TYPE_NDT3 = ConvertAbilityIntegerLevelField('Ndt3')
ABILITY_ILF_STACKING_TYPE_POI4 = ConvertAbilityIntegerLevelField('Poi4')
ABILITY_ILF_STACKING_TYPE_POA5 = ConvertAbilityIntegerLevelField('Poa5')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_PLY1 = ConvertAbilityIntegerLevelField('Ply1')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_POS1 = ConvertAbilityIntegerLevelField('Pos1')
ABILITY_ILF_MOVEMENT_UPDATE_FREQUENCY_PRG1 = ConvertAbilityIntegerLevelField('Prg1')
ABILITY_ILF_ATTACK_UPDATE_FREQUENCY_PRG2 = ConvertAbilityIntegerLevelField('Prg2')
ABILITY_ILF_MANA_LOSS_PRG6 = ConvertAbilityIntegerLevelField('Prg6')
ABILITY_ILF_UNITS_SUMMONED_TYPE_ONE = ConvertAbilityIntegerLevelField('Rai1')
ABILITY_ILF_UNITS_SUMMONED_TYPE_TWO = ConvertAbilityIntegerLevelField('Rai2')
ABILITY_ILF_MAX_UNITS_SUMMONED = ConvertAbilityIntegerLevelField('Ucb5')
ABILITY_ILF_ALLOW_WHEN_FULL_REJ3 = ConvertAbilityIntegerLevelField('Rej3')
ABILITY_ILF_MAXIMUM_UNITS_CHARGED_TO_CASTER = ConvertAbilityIntegerLevelField('Rpb5')
ABILITY_ILF_MAXIMUM_UNITS_AFFECTED = ConvertAbilityIntegerLevelField('Rpb6')
ABILITY_ILF_DEFENSE_INCREASE_ROA2 = ConvertAbilityIntegerLevelField('Roa2')
ABILITY_ILF_MAX_UNITS_ROA7 = ConvertAbilityIntegerLevelField('Roa7')
ABILITY_ILF_ROOTED_WEAPONS = ConvertAbilityIntegerLevelField('Roo1')
ABILITY_ILF_UPROOTED_WEAPONS = ConvertAbilityIntegerLevelField('Roo2')
ABILITY_ILF_UPROOTED_DEFENSE_TYPE = ConvertAbilityIntegerLevelField('Roo4')
ABILITY_ILF_ACCUMULATION_STEP = ConvertAbilityIntegerLevelField('Sal2')
ABILITY_ILF_NUMBER_OF_OWLS = ConvertAbilityIntegerLevelField('Esn4')
ABILITY_ILF_STACKING_TYPE_SPO4 = ConvertAbilityIntegerLevelField('Spo4')
ABILITY_ILF_NUMBER_OF_UNITS = ConvertAbilityIntegerLevelField('Sod1')
ABILITY_ILF_SPIDER_CAPACITY = ConvertAbilityIntegerLevelField('Spa1')
ABILITY_ILF_INTERVALS_BEFORE_CHANGING_TREES = ConvertAbilityIntegerLevelField('Wha2')
ABILITY_ILF_AGILITY_BONUS = ConvertAbilityIntegerLevelField('Iagi')
ABILITY_ILF_INTELLIGENCE_BONUS = ConvertAbilityIntegerLevelField('Iint')
ABILITY_ILF_STRENGTH_BONUS_ISTR = ConvertAbilityIntegerLevelField('Istr')
ABILITY_ILF_ATTACK_BONUS = ConvertAbilityIntegerLevelField('Iatt')
ABILITY_ILF_DEFENSE_BONUS_IDEF = ConvertAbilityIntegerLevelField('Idef')
ABILITY_ILF_SUMMON_1_AMOUNT = ConvertAbilityIntegerLevelField('Isn1')
ABILITY_ILF_SUMMON_2_AMOUNT = ConvertAbilityIntegerLevelField('Isn2')
ABILITY_ILF_EXPERIENCE_GAINED = ConvertAbilityIntegerLevelField('Ixpg')
ABILITY_ILF_HIT_POINTS_GAINED_IHPG = ConvertAbilityIntegerLevelField('Ihpg')
ABILITY_ILF_MANA_POINTS_GAINED_IMPG = ConvertAbilityIntegerLevelField('Impg')
ABILITY_ILF_HIT_POINTS_GAINED_IHP2 = ConvertAbilityIntegerLevelField('Ihp2')
ABILITY_ILF_MANA_POINTS_GAINED_IMP2 = ConvertAbilityIntegerLevelField('Imp2')
ABILITY_ILF_DAMAGE_BONUS_DICE = ConvertAbilityIntegerLevelField('Idic')
ABILITY_ILF_ARMOR_PENALTY_IARP = ConvertAbilityIntegerLevelField('Iarp')
ABILITY_ILF_ENABLED_ATTACK_INDEX_IOB5 = ConvertAbilityIntegerLevelField('Iob5')
ABILITY_ILF_LEVELS_GAINED = ConvertAbilityIntegerLevelField('Ilev')
ABILITY_ILF_MAX_LIFE_GAINED = ConvertAbilityIntegerLevelField('Ilif')
ABILITY_ILF_MAX_MANA_GAINED = ConvertAbilityIntegerLevelField('Iman')
ABILITY_ILF_GOLD_GIVEN = ConvertAbilityIntegerLevelField('Igol')
ABILITY_ILF_LUMBER_GIVEN = ConvertAbilityIntegerLevelField('Ilum')
ABILITY_ILF_DETECTION_TYPE_IFA1 = ConvertAbilityIntegerLevelField('Ifa1')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_ICRE = ConvertAbilityIntegerLevelField('Icre')
ABILITY_ILF_MOVEMENT_SPEED_BONUS = ConvertAbilityIntegerLevelField('Imvb')
ABILITY_ILF_HIT_POINTS_REGENERATED_PER_SECOND = ConvertAbilityIntegerLevelField('Ihpr')
ABILITY_ILF_SIGHT_RANGE_BONUS = ConvertAbilityIntegerLevelField('Isib')
ABILITY_ILF_DAMAGE_PER_DURATION = ConvertAbilityIntegerLevelField('Icfd')
ABILITY_ILF_MANA_USED_PER_SECOND = ConvertAbilityIntegerLevelField('Icfm')
ABILITY_ILF_EXTRA_MANA_REQUIRED = ConvertAbilityIntegerLevelField('Icfx')
ABILITY_ILF_DETECTION_RADIUS_IDET = ConvertAbilityIntegerLevelField('Idet')
ABILITY_ILF_MANA_LOSS_PER_UNIT_IDIM = ConvertAbilityIntegerLevelField('Idim')
ABILITY_ILF_DAMAGE_TO_SUMMONED_UNITS_IDID = ConvertAbilityIntegerLevelField('Idid')
ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_IREC = ConvertAbilityIntegerLevelField('Irec')
ABILITY_ILF_DELAY_AFTER_DEATH_SECONDS = ConvertAbilityIntegerLevelField('Ircd')
ABILITY_ILF_RESTORED_LIFE = ConvertAbilityIntegerLevelField('irc2')
ABILITY_ILF_RESTORED_MANA__1_FOR_CURRENT = ConvertAbilityIntegerLevelField('irc3')
ABILITY_ILF_HIT_POINTS_RESTORED = ConvertAbilityIntegerLevelField('Ihps')
ABILITY_ILF_MANA_POINTS_RESTORED = ConvertAbilityIntegerLevelField('Imps')
ABILITY_ILF_MAXIMUM_NUMBER_OF_UNITS_ITPM = ConvertAbilityIntegerLevelField('Itpm')
ABILITY_ILF_NUMBER_OF_CORPSES_RAISED_CAD1 = ConvertAbilityIntegerLevelField('Cad1')
ABILITY_ILF_TERRAIN_DEFORMATION_DURATION_MS = ConvertAbilityIntegerLevelField('Wrs3')
ABILITY_ILF_MAXIMUM_UNITS = ConvertAbilityIntegerLevelField('Uds1')
ABILITY_ILF_DETECTION_TYPE_DET1 = ConvertAbilityIntegerLevelField('Det1')
ABILITY_ILF_GOLD_COST_PER_STRUCTURE = ConvertAbilityIntegerLevelField('Nsp1')
ABILITY_ILF_LUMBER_COST_PER_USE = ConvertAbilityIntegerLevelField('Nsp2')
ABILITY_ILF_DETECTION_TYPE_NSP3 = ConvertAbilityIntegerLevelField('Nsp3')
ABILITY_ILF_NUMBER_OF_SWARM_UNITS = ConvertAbilityIntegerLevelField('Uls1')
ABILITY_ILF_MAX_SWARM_UNITS_PER_TARGET = ConvertAbilityIntegerLevelField('Uls3')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NBA2 = ConvertAbilityIntegerLevelField('Nba2')
ABILITY_ILF_MAXIMUM_CREEP_LEVEL_NCH1 = ConvertAbilityIntegerLevelField('Nch1')
ABILITY_ILF_ATTACKS_PREVENTED = ConvertAbilityIntegerLevelField('Nsi1')
ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_EFK3 = ConvertAbilityIntegerLevelField('Efk3')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_ESV1 = ConvertAbilityIntegerLevelField('Esv1')
ABILITY_ILF_MAXIMUM_NUMBER_OF_CORPSES_EXH1 = ConvertAbilityIntegerLevelField('exh1')
ABILITY_ILF_ITEM_CAPACITY = ConvertAbilityIntegerLevelField('inv1')
ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_SPL2 = ConvertAbilityIntegerLevelField('spl2')
ABILITY_ILF_ALLOW_WHEN_FULL_IRL3 = ConvertAbilityIntegerLevelField('irl3')
ABILITY_ILF_MAXIMUM_DISPELLED_UNITS = ConvertAbilityIntegerLevelField('idc3')
ABILITY_ILF_NUMBER_OF_LURES = ConvertAbilityIntegerLevelField('imo1')
ABILITY_ILF_NEW_TIME_OF_DAY_HOUR = ConvertAbilityIntegerLevelField('ict1')
ABILITY_ILF_NEW_TIME_OF_DAY_MINUTE = ConvertAbilityIntegerLevelField('ict2')
ABILITY_ILF_NUMBER_OF_UNITS_CREATED_MEC1 = ConvertAbilityIntegerLevelField('mec1')
ABILITY_ILF_MINIMUM_SPELLS = ConvertAbilityIntegerLevelField('spb3')
ABILITY_ILF_MAXIMUM_SPELLS = ConvertAbilityIntegerLevelField('spb4')
ABILITY_ILF_DISABLED_ATTACK_INDEX = ConvertAbilityIntegerLevelField('gra3')
ABILITY_ILF_ENABLED_ATTACK_INDEX_GRA4 = ConvertAbilityIntegerLevelField('gra4')
ABILITY_ILF_MAXIMUM_ATTACKS = ConvertAbilityIntegerLevelField('gra5')
ABILITY_ILF_BUILDING_TYPES_ALLOWED_NPR1 = ConvertAbilityIntegerLevelField('Npr1')
ABILITY_ILF_BUILDING_TYPES_ALLOWED_NSA1 = ConvertAbilityIntegerLevelField('Nsa1')
ABILITY_ILF_ATTACK_MODIFICATION = ConvertAbilityIntegerLevelField('Iaa1')
ABILITY_ILF_SUMMONED_UNIT_COUNT_NPA5 = ConvertAbilityIntegerLevelField('Npa5')
ABILITY_ILF_UPGRADE_LEVELS = ConvertAbilityIntegerLevelField('Igl1')
ABILITY_ILF_NUMBER_OF_SUMMONED_UNITS_NDO2 = ConvertAbilityIntegerLevelField('Ndo2')
ABILITY_ILF_BEASTS_PER_SECOND = ConvertAbilityIntegerLevelField('Nst1')
ABILITY_ILF_TARGET_TYPE = ConvertAbilityIntegerLevelField('Ncl2')
ABILITY_ILF_OPTIONS = ConvertAbilityIntegerLevelField('Ncl3')
ABILITY_ILF_ARMOR_PENALTY_NAB3 = ConvertAbilityIntegerLevelField('Nab3')
ABILITY_ILF_WAVE_COUNT_NHS6 = ConvertAbilityIntegerLevelField('Nhs6')
ABILITY_ILF_MAX_CREEP_LEVEL_NTM3 = ConvertAbilityIntegerLevelField('Ntm3')
ABILITY_ILF_MISSILE_COUNT = ConvertAbilityIntegerLevelField('Ncs3')
ABILITY_ILF_SPLIT_ATTACK_COUNT = ConvertAbilityIntegerLevelField('Nlm3')
ABILITY_ILF_GENERATION_COUNT = ConvertAbilityIntegerLevelField('Nlm6')
ABILITY_ILF_ROCK_RING_COUNT = ConvertAbilityIntegerLevelField('Nvc1')
ABILITY_ILF_WAVE_COUNT_NVC2 = ConvertAbilityIntegerLevelField('Nvc2')
ABILITY_ILF_PREFER_HOSTILES_TAU1 = ConvertAbilityIntegerLevelField('Tau1')
ABILITY_ILF_PREFER_FRIENDLIES_TAU2 = ConvertAbilityIntegerLevelField('Tau2')
ABILITY_ILF_MAX_UNITS_TAU3 = ConvertAbilityIntegerLevelField('Tau3')
ABILITY_ILF_NUMBER_OF_PULSES = ConvertAbilityIntegerLevelField('Tau4')
ABILITY_ILF_SUMMONED_UNIT_TYPE_HWE1 = ConvertAbilityIntegerLevelField('Hwe1')
ABILITY_ILF_SUMMONED_UNIT_UIN4 = ConvertAbilityIntegerLevelField('Uin4')
ABILITY_ILF_SUMMONED_UNIT_OSF1 = ConvertAbilityIntegerLevelField('Osf1')
ABILITY_ILF_SUMMONED_UNIT_TYPE_EFNU = ConvertAbilityIntegerLevelField('Efnu')
ABILITY_ILF_SUMMONED_UNIT_TYPE_NBAU = ConvertAbilityIntegerLevelField('Nbau')
ABILITY_ILF_SUMMONED_UNIT_TYPE_NTOU = ConvertAbilityIntegerLevelField('Ntou')
ABILITY_ILF_SUMMONED_UNIT_TYPE_ESVU = ConvertAbilityIntegerLevelField('Esvu')
ABILITY_ILF_SUMMONED_UNIT_TYPES = ConvertAbilityIntegerLevelField('Nef1')
ABILITY_ILF_SUMMONED_UNIT_TYPE_NDOU = ConvertAbilityIntegerLevelField('Ndou')
ABILITY_ILF_ALTERNATE_FORM_UNIT_EMEU = ConvertAbilityIntegerLevelField('Emeu')
ABILITY_ILF_PLAGUE_WARD_UNIT_TYPE = ConvertAbilityIntegerLevelField('Aplu')
ABILITY_ILF_ALLOWED_UNIT_TYPE_BTL1 = ConvertAbilityIntegerLevelField('Btl1')
ABILITY_ILF_NEW_UNIT_TYPE = ConvertAbilityIntegerLevelField('Cha1')
ABILITY_ILF_RESULTING_UNIT_TYPE_ENT1 = ConvertAbilityIntegerLevelField('ent1')
ABILITY_ILF_CORPSE_UNIT_TYPE = ConvertAbilityIntegerLevelField('Gydu')
ABILITY_ILF_ALLOWED_UNIT_TYPE_LOA1 = ConvertAbilityIntegerLevelField('Loa1')
ABILITY_ILF_UNIT_TYPE_FOR_LIMIT_CHECK = ConvertAbilityIntegerLevelField('Raiu')
ABILITY_ILF_WARD_UNIT_TYPE_STAU = ConvertAbilityIntegerLevelField('Stau')
ABILITY_ILF_EFFECT_ABILITY = ConvertAbilityIntegerLevelField('Iobu')
ABILITY_ILF_CONVERSION_UNIT = ConvertAbilityIntegerLevelField('Ndc2')
ABILITY_ILF_UNIT_TO_PRESERVE = ConvertAbilityIntegerLevelField('Nsl1')
ABILITY_ILF_UNIT_TYPE_ALLOWED = ConvertAbilityIntegerLevelField('Chl1')
ABILITY_ILF_SWARM_UNIT_TYPE = ConvertAbilityIntegerLevelField('Ulsu')
ABILITY_ILF_RESULTING_UNIT_TYPE_COAU = ConvertAbilityIntegerLevelField('coau')
ABILITY_ILF_UNIT_TYPE_EXHU = ConvertAbilityIntegerLevelField('exhu')
ABILITY_ILF_WARD_UNIT_TYPE_HWDU = ConvertAbilityIntegerLevelField('hwdu')
ABILITY_ILF_LURE_UNIT_TYPE = ConvertAbilityIntegerLevelField('imou')
ABILITY_ILF_UNIT_TYPE_IPMU = ConvertAbilityIntegerLevelField('ipmu')
ABILITY_ILF_FACTORY_UNIT_ID = ConvertAbilityIntegerLevelField('Nsyu')
ABILITY_ILF_SPAWN_UNIT_ID_NFYU = ConvertAbilityIntegerLevelField('Nfyu')
ABILITY_ILF_DESTRUCTIBLE_ID = ConvertAbilityIntegerLevelField('Nvcu')
ABILITY_ILF_UPGRADE_TYPE = ConvertAbilityIntegerLevelField('Iglu')
ABILITY_RLF_CASTING_TIME = ConvertAbilityRealLevelField('acas')
ABILITY_RLF_DURATION_NORMAL = ConvertAbilityRealLevelField('adur')
ABILITY_RLF_DURATION_HERO = ConvertAbilityRealLevelField('ahdu')
ABILITY_RLF_COOLDOWN = ConvertAbilityRealLevelField('acdn')
ABILITY_RLF_AREA_OF_EFFECT = ConvertAbilityRealLevelField('aare')
ABILITY_RLF_CAST_RANGE = ConvertAbilityRealLevelField('aran')
ABILITY_RLF_DAMAGE_HBZ2 = ConvertAbilityRealLevelField('Hbz2')
ABILITY_RLF_BUILDING_REDUCTION_HBZ4 = ConvertAbilityRealLevelField('Hbz4')
ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5 = ConvertAbilityRealLevelField('Hbz5')
ABILITY_RLF_MAXIMUM_DAMAGE_PER_WAVE = ConvertAbilityRealLevelField('Hbz6')
ABILITY_RLF_MANA_REGENERATION_INCREASE = ConvertAbilityRealLevelField('Hab1')
ABILITY_RLF_CASTING_DELAY = ConvertAbilityRealLevelField('Hmt2')
ABILITY_RLF_DAMAGE_PER_SECOND_OWW1 = ConvertAbilityRealLevelField('Oww1')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_OWW2 = ConvertAbilityRealLevelField('Oww2')
ABILITY_RLF_CHANCE_TO_CRITICAL_STRIKE = ConvertAbilityRealLevelField('Ocr1')
ABILITY_RLF_DAMAGE_MULTIPLIER_OCR2 = ConvertAbilityRealLevelField('Ocr2')
ABILITY_RLF_DAMAGE_BONUS_OCR3 = ConvertAbilityRealLevelField('Ocr3')
ABILITY_RLF_CHANCE_TO_EVADE_OCR4 = ConvertAbilityRealLevelField('Ocr4')
ABILITY_RLF_DAMAGE_DEALT_PERCENT_OMI2 = ConvertAbilityRealLevelField('Omi2')
ABILITY_RLF_DAMAGE_TAKEN_PERCENT_OMI3 = ConvertAbilityRealLevelField('Omi3')
ABILITY_RLF_ANIMATION_DELAY = ConvertAbilityRealLevelField('Omi4')
ABILITY_RLF_TRANSITION_TIME = ConvertAbilityRealLevelField('Owk1')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OWK2 = ConvertAbilityRealLevelField('Owk2')
ABILITY_RLF_BACKSTAB_DAMAGE = ConvertAbilityRealLevelField('Owk3')
ABILITY_RLF_AMOUNT_HEALED_DAMAGED_UDC1 = ConvertAbilityRealLevelField('Udc1')
ABILITY_RLF_LIFE_CONVERTED_TO_MANA = ConvertAbilityRealLevelField('Udp1')
ABILITY_RLF_LIFE_CONVERTED_TO_LIFE = ConvertAbilityRealLevelField('Udp2')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_UAU1 = ConvertAbilityRealLevelField('Uau1')
ABILITY_RLF_LIFE_REGENERATION_INCREASE_PERCENT = ConvertAbilityRealLevelField('Uau2')
ABILITY_RLF_CHANCE_TO_EVADE_EEV1 = ConvertAbilityRealLevelField('Eev1')
ABILITY_RLF_DAMAGE_PER_INTERVAL = ConvertAbilityRealLevelField('Eim1')
ABILITY_RLF_MANA_DRAINED_PER_SECOND_EIM2 = ConvertAbilityRealLevelField('Eim2')
ABILITY_RLF_BUFFER_MANA_REQUIRED = ConvertAbilityRealLevelField('Eim3')
ABILITY_RLF_MAX_MANA_DRAINED = ConvertAbilityRealLevelField('Emb1')
ABILITY_RLF_BOLT_DELAY = ConvertAbilityRealLevelField('Emb2')
ABILITY_RLF_BOLT_LIFETIME = ConvertAbilityRealLevelField('Emb3')
ABILITY_RLF_ALTITUDE_ADJUSTMENT_DURATION = ConvertAbilityRealLevelField('Eme3')
ABILITY_RLF_LANDING_DELAY_TIME = ConvertAbilityRealLevelField('Eme4')
ABILITY_RLF_ALTERNATE_FORM_HIT_POINT_BONUS = ConvertAbilityRealLevelField('Eme5')
ABILITY_RLF_MOVE_SPEED_BONUS_INFO_PANEL_ONLY = ConvertAbilityRealLevelField('Ncr5')
ABILITY_RLF_ATTACK_SPEED_BONUS_INFO_PANEL_ONLY = ConvertAbilityRealLevelField('Ncr6')
ABILITY_RLF_LIFE_REGENERATION_RATE_PER_SECOND = ConvertAbilityRealLevelField('ave5')
ABILITY_RLF_STUN_DURATION_USL1 = ConvertAbilityRealLevelField('Usl1')
ABILITY_RLF_ATTACK_DAMAGE_STOLEN_PERCENT = ConvertAbilityRealLevelField('Uav1')
ABILITY_RLF_DAMAGE_UCS1 = ConvertAbilityRealLevelField('Ucs1')
ABILITY_RLF_MAX_DAMAGE_UCS2 = ConvertAbilityRealLevelField('Ucs2')
ABILITY_RLF_DISTANCE_UCS3 = ConvertAbilityRealLevelField('Ucs3')
ABILITY_RLF_FINAL_AREA_UCS4 = ConvertAbilityRealLevelField('Ucs4')
ABILITY_RLF_DAMAGE_UIN1 = ConvertAbilityRealLevelField('Uin1')
ABILITY_RLF_DURATION = ConvertAbilityRealLevelField('Uin2')
ABILITY_RLF_IMPACT_DELAY = ConvertAbilityRealLevelField('Uin3')
ABILITY_RLF_DAMAGE_PER_TARGET_OCL1 = ConvertAbilityRealLevelField('Ocl1')
ABILITY_RLF_DAMAGE_REDUCTION_PER_TARGET = ConvertAbilityRealLevelField('Ocl3')
ABILITY_RLF_EFFECT_DELAY_OEQ1 = ConvertAbilityRealLevelField('Oeq1')
ABILITY_RLF_DAMAGE_PER_SECOND_TO_BUILDINGS = ConvertAbilityRealLevelField('Oeq2')
ABILITY_RLF_UNITS_SLOWED_PERCENT = ConvertAbilityRealLevelField('Oeq3')
ABILITY_RLF_FINAL_AREA_OEQ4 = ConvertAbilityRealLevelField('Oeq4')
ABILITY_RLF_DAMAGE_PER_SECOND_EER1 = ConvertAbilityRealLevelField('Eer1')
ABILITY_RLF_DAMAGE_DEALT_TO_ATTACKERS = ConvertAbilityRealLevelField('Eah1')
ABILITY_RLF_LIFE_HEALED = ConvertAbilityRealLevelField('Etq1')
ABILITY_RLF_HEAL_INTERVAL = ConvertAbilityRealLevelField('Etq2')
ABILITY_RLF_BUILDING_REDUCTION_ETQ3 = ConvertAbilityRealLevelField('Etq3')
ABILITY_RLF_INITIAL_IMMUNITY_DURATION = ConvertAbilityRealLevelField('Etq4')
ABILITY_RLF_MAX_LIFE_DRAINED_PER_SECOND_PERCENT = ConvertAbilityRealLevelField('Udd1')
ABILITY_RLF_BUILDING_REDUCTION_UDD2 = ConvertAbilityRealLevelField('Udd2')
ABILITY_RLF_ARMOR_DURATION = ConvertAbilityRealLevelField('Ufa1')
ABILITY_RLF_ARMOR_BONUS_UFA2 = ConvertAbilityRealLevelField('Ufa2')
ABILITY_RLF_AREA_OF_EFFECT_DAMAGE = ConvertAbilityRealLevelField('Ufn1')
ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2 = ConvertAbilityRealLevelField('Ufn2')
ABILITY_RLF_DAMAGE_BONUS_HFA1 = ConvertAbilityRealLevelField('Hfa1')
ABILITY_RLF_DAMAGE_DEALT_ESF1 = ConvertAbilityRealLevelField('Esf1')
ABILITY_RLF_DAMAGE_INTERVAL_ESF2 = ConvertAbilityRealLevelField('Esf2')
ABILITY_RLF_BUILDING_REDUCTION_ESF3 = ConvertAbilityRealLevelField('Esf3')
ABILITY_RLF_DAMAGE_BONUS_PERCENT = ConvertAbilityRealLevelField('Ear1')
ABILITY_RLF_DEFENSE_BONUS_HAV1 = ConvertAbilityRealLevelField('Hav1')
ABILITY_RLF_HIT_POINT_BONUS = ConvertAbilityRealLevelField('Hav2')
ABILITY_RLF_DAMAGE_BONUS_HAV3 = ConvertAbilityRealLevelField('Hav3')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_HAV4 = ConvertAbilityRealLevelField('Hav4')
ABILITY_RLF_CHANCE_TO_BASH = ConvertAbilityRealLevelField('Hbh1')
ABILITY_RLF_DAMAGE_MULTIPLIER_HBH2 = ConvertAbilityRealLevelField('Hbh2')
ABILITY_RLF_DAMAGE_BONUS_HBH3 = ConvertAbilityRealLevelField('Hbh3')
ABILITY_RLF_CHANCE_TO_MISS_HBH4 = ConvertAbilityRealLevelField('Hbh4')
ABILITY_RLF_DAMAGE_HTB1 = ConvertAbilityRealLevelField('Htb1')
ABILITY_RLF_AOE_DAMAGE = ConvertAbilityRealLevelField('Htc1')
ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_HTC2 = ConvertAbilityRealLevelField('Htc2')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HTC3 = ConvertAbilityRealLevelField('Htc3')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HTC4 = ConvertAbilityRealLevelField('Htc4')
ABILITY_RLF_ARMOR_BONUS_HAD1 = ConvertAbilityRealLevelField('Had1')
ABILITY_RLF_AMOUNT_HEALED_DAMAGED_HHB1 = ConvertAbilityRealLevelField('Hhb1')
ABILITY_RLF_EXTRA_DAMAGE_HCA1 = ConvertAbilityRealLevelField('Hca1')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_HCA2 = ConvertAbilityRealLevelField('Hca2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_HCA3 = ConvertAbilityRealLevelField('Hca3')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_OAE1 = ConvertAbilityRealLevelField('Oae1')
ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_OAE2 = ConvertAbilityRealLevelField('Oae2')
ABILITY_RLF_REINCARNATION_DELAY = ConvertAbilityRealLevelField('Ore1')
ABILITY_RLF_DAMAGE_OSH1 = ConvertAbilityRealLevelField('Osh1')
ABILITY_RLF_MAXIMUM_DAMAGE_OSH2 = ConvertAbilityRealLevelField('Osh2')
ABILITY_RLF_DISTANCE_OSH3 = ConvertAbilityRealLevelField('Osh3')
ABILITY_RLF_FINAL_AREA_OSH4 = ConvertAbilityRealLevelField('Osh4')
ABILITY_RLF_GRAPHIC_DELAY_NFD1 = ConvertAbilityRealLevelField('Nfd1')
ABILITY_RLF_GRAPHIC_DURATION_NFD2 = ConvertAbilityRealLevelField('Nfd2')
ABILITY_RLF_DAMAGE_NFD3 = ConvertAbilityRealLevelField('Nfd3')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_AMS1 = ConvertAbilityRealLevelField('Ams1')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_AMS2 = ConvertAbilityRealLevelField('Ams2')
ABILITY_RLF_AURA_DURATION = ConvertAbilityRealLevelField('Apl1')
ABILITY_RLF_DAMAGE_PER_SECOND_APL2 = ConvertAbilityRealLevelField('Apl2')
ABILITY_RLF_DURATION_OF_PLAGUE_WARD = ConvertAbilityRealLevelField('Apl3')
ABILITY_RLF_AMOUNT_OF_HIT_POINTS_REGENERATED = ConvertAbilityRealLevelField('Oar1')
ABILITY_RLF_ATTACK_DAMAGE_INCREASE_AKB1 = ConvertAbilityRealLevelField('Akb1')
ABILITY_RLF_MANA_LOSS_ADM1 = ConvertAbilityRealLevelField('Adm1')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_ADM2 = ConvertAbilityRealLevelField('Adm2')
ABILITY_RLF_EXPANSION_AMOUNT = ConvertAbilityRealLevelField('Bli1')
ABILITY_RLF_INTERVAL_DURATION_BGM2 = ConvertAbilityRealLevelField('Bgm2')
ABILITY_RLF_RADIUS_OF_MINING_RING = ConvertAbilityRealLevelField('Bgm4')
ABILITY_RLF_ATTACK_SPEED_INCREASE_PERCENT_BLO1 = ConvertAbilityRealLevelField('Blo1')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_PERCENT_BLO2 = ConvertAbilityRealLevelField('Blo2')
ABILITY_RLF_SCALING_FACTOR = ConvertAbilityRealLevelField('Blo3')
ABILITY_RLF_HIT_POINTS_PER_SECOND_CAN1 = ConvertAbilityRealLevelField('Can1')
ABILITY_RLF_MAX_HIT_POINTS = ConvertAbilityRealLevelField('Can2')
ABILITY_RLF_DAMAGE_PER_SECOND_DEV2 = ConvertAbilityRealLevelField('Dev2')
ABILITY_RLF_MOVEMENT_UPDATE_FREQUENCY_CHD1 = ConvertAbilityRealLevelField('Chd1')
ABILITY_RLF_ATTACK_UPDATE_FREQUENCY_CHD2 = ConvertAbilityRealLevelField('Chd2')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_CHD3 = ConvertAbilityRealLevelField('Chd3')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_CRI1 = ConvertAbilityRealLevelField('Cri1')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_CRI2 = ConvertAbilityRealLevelField('Cri2')
ABILITY_RLF_DAMAGE_REDUCTION_CRI3 = ConvertAbilityRealLevelField('Cri3')
ABILITY_RLF_CHANCE_TO_MISS_CRS = ConvertAbilityRealLevelField('Crs1')
ABILITY_RLF_FULL_DAMAGE_RADIUS_DDA1 = ConvertAbilityRealLevelField('Dda1')
ABILITY_RLF_FULL_DAMAGE_AMOUNT_DDA2 = ConvertAbilityRealLevelField('Dda2')
ABILITY_RLF_PARTIAL_DAMAGE_RADIUS = ConvertAbilityRealLevelField('Dda3')
ABILITY_RLF_PARTIAL_DAMAGE_AMOUNT = ConvertAbilityRealLevelField('Dda4')
ABILITY_RLF_BUILDING_DAMAGE_FACTOR_SDS1 = ConvertAbilityRealLevelField('Sds1')
ABILITY_RLF_MAX_DAMAGE_UCO5 = ConvertAbilityRealLevelField('Uco5')
ABILITY_RLF_MOVE_SPEED_BONUS_UCO6 = ConvertAbilityRealLevelField('Uco6')
ABILITY_RLF_DAMAGE_TAKEN_PERCENT_DEF1 = ConvertAbilityRealLevelField('Def1')
ABILITY_RLF_DAMAGE_DEALT_PERCENT_DEF2 = ConvertAbilityRealLevelField('Def2')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_DEF3 = ConvertAbilityRealLevelField('Def3')
ABILITY_RLF_ATTACK_SPEED_FACTOR_DEF4 = ConvertAbilityRealLevelField('Def4')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_DEF5 = ConvertAbilityRealLevelField('Def5')
ABILITY_RLF_CHANCE_TO_DEFLECT = ConvertAbilityRealLevelField('Def6')
ABILITY_RLF_DEFLECT_DAMAGE_TAKEN_PIERCING = ConvertAbilityRealLevelField('Def7')
ABILITY_RLF_DEFLECT_DAMAGE_TAKEN_SPELLS = ConvertAbilityRealLevelField('Def8')
ABILITY_RLF_RIP_DELAY = ConvertAbilityRealLevelField('Eat1')
ABILITY_RLF_EAT_DELAY = ConvertAbilityRealLevelField('Eat2')
ABILITY_RLF_HIT_POINTS_GAINED_EAT3 = ConvertAbilityRealLevelField('Eat3')
ABILITY_RLF_AIR_UNIT_LOWER_DURATION = ConvertAbilityRealLevelField('Ens1')
ABILITY_RLF_AIR_UNIT_HEIGHT = ConvertAbilityRealLevelField('Ens2')
ABILITY_RLF_MELEE_ATTACK_RANGE = ConvertAbilityRealLevelField('Ens3')
ABILITY_RLF_INTERVAL_DURATION_EGM2 = ConvertAbilityRealLevelField('Egm2')
ABILITY_RLF_EFFECT_DELAY_FLA2 = ConvertAbilityRealLevelField('Fla2')
ABILITY_RLF_MINING_DURATION = ConvertAbilityRealLevelField('Gld2')
ABILITY_RLF_RADIUS_OF_GRAVESTONES = ConvertAbilityRealLevelField('Gyd2')
ABILITY_RLF_RADIUS_OF_CORPSES = ConvertAbilityRealLevelField('Gyd3')
ABILITY_RLF_HIT_POINTS_GAINED_HEA1 = ConvertAbilityRealLevelField('Hea1')
ABILITY_RLF_DAMAGE_INCREASE_PERCENT_INF1 = ConvertAbilityRealLevelField('Inf1')
ABILITY_RLF_AUTOCAST_RANGE = ConvertAbilityRealLevelField('Inf3')
ABILITY_RLF_LIFE_REGEN_RATE = ConvertAbilityRealLevelField('Inf4')
ABILITY_RLF_GRAPHIC_DELAY_LIT1 = ConvertAbilityRealLevelField('Lit1')
ABILITY_RLF_GRAPHIC_DURATION_LIT2 = ConvertAbilityRealLevelField('Lit2')
ABILITY_RLF_DAMAGE_PER_SECOND_LSH1 = ConvertAbilityRealLevelField('Lsh1')
ABILITY_RLF_MANA_GAINED = ConvertAbilityRealLevelField('Mbt1')
ABILITY_RLF_HIT_POINTS_GAINED_MBT2 = ConvertAbilityRealLevelField('Mbt2')
ABILITY_RLF_AUTOCAST_REQUIREMENT = ConvertAbilityRealLevelField('Mbt3')
ABILITY_RLF_WATER_HEIGHT = ConvertAbilityRealLevelField('Mbt4')
ABILITY_RLF_ACTIVATION_DELAY_MIN1 = ConvertAbilityRealLevelField('Min1')
ABILITY_RLF_INVISIBILITY_TRANSITION_TIME = ConvertAbilityRealLevelField('Min2')
ABILITY_RLF_ACTIVATION_RADIUS = ConvertAbilityRealLevelField('Neu1')
ABILITY_RLF_AMOUNT_REGENERATED = ConvertAbilityRealLevelField('Arm1')
ABILITY_RLF_DAMAGE_PER_SECOND_POI1 = ConvertAbilityRealLevelField('Poi1')
ABILITY_RLF_ATTACK_SPEED_FACTOR_POI2 = ConvertAbilityRealLevelField('Poi2')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_POI3 = ConvertAbilityRealLevelField('Poi3')
ABILITY_RLF_EXTRA_DAMAGE_POA1 = ConvertAbilityRealLevelField('Poa1')
ABILITY_RLF_DAMAGE_PER_SECOND_POA2 = ConvertAbilityRealLevelField('Poa2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_POA3 = ConvertAbilityRealLevelField('Poa3')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_POA4 = ConvertAbilityRealLevelField('Poa4')
ABILITY_RLF_DAMAGE_AMPLIFICATION = ConvertAbilityRealLevelField('Pos2')
ABILITY_RLF_CHANCE_TO_STOMP_PERCENT = ConvertAbilityRealLevelField('War1')
ABILITY_RLF_DAMAGE_DEALT_WAR2 = ConvertAbilityRealLevelField('War2')
ABILITY_RLF_FULL_DAMAGE_RADIUS_WAR3 = ConvertAbilityRealLevelField('War3')
ABILITY_RLF_HALF_DAMAGE_RADIUS_WAR4 = ConvertAbilityRealLevelField('War4')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_PRG3 = ConvertAbilityRealLevelField('Prg3')
ABILITY_RLF_UNIT_PAUSE_DURATION = ConvertAbilityRealLevelField('Prg4')
ABILITY_RLF_HERO_PAUSE_DURATION = ConvertAbilityRealLevelField('Prg5')
ABILITY_RLF_HIT_POINTS_GAINED_REJ1 = ConvertAbilityRealLevelField('Rej1')
ABILITY_RLF_MANA_POINTS_GAINED_REJ2 = ConvertAbilityRealLevelField('Rej2')
ABILITY_RLF_MINIMUM_LIFE_REQUIRED = ConvertAbilityRealLevelField('Rpb3')
ABILITY_RLF_MINIMUM_MANA_REQUIRED = ConvertAbilityRealLevelField('Rpb4')
ABILITY_RLF_REPAIR_COST_RATIO = ConvertAbilityRealLevelField('Rep1')
ABILITY_RLF_REPAIR_TIME_RATIO = ConvertAbilityRealLevelField('Rep2')
ABILITY_RLF_POWERBUILD_COST = ConvertAbilityRealLevelField('Rep3')
ABILITY_RLF_POWERBUILD_RATE = ConvertAbilityRealLevelField('Rep4')
ABILITY_RLF_NAVAL_RANGE_BONUS = ConvertAbilityRealLevelField('Rep5')
ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1 = ConvertAbilityRealLevelField('Roa1')
ABILITY_RLF_LIFE_REGENERATION_RATE = ConvertAbilityRealLevelField('Roa3')
ABILITY_RLF_MANA_REGEN = ConvertAbilityRealLevelField('Roa4')
ABILITY_RLF_DAMAGE_INCREASE = ConvertAbilityRealLevelField('Nbr1')
ABILITY_RLF_SALVAGE_COST_RATIO = ConvertAbilityRealLevelField('Sal1')
ABILITY_RLF_IN_FLIGHT_SIGHT_RADIUS = ConvertAbilityRealLevelField('Esn1')
ABILITY_RLF_HOVERING_SIGHT_RADIUS = ConvertAbilityRealLevelField('Esn2')
ABILITY_RLF_HOVERING_HEIGHT = ConvertAbilityRealLevelField('Esn3')
ABILITY_RLF_DURATION_OF_OWLS = ConvertAbilityRealLevelField('Esn5')
ABILITY_RLF_FADE_DURATION = ConvertAbilityRealLevelField('Shm1')
ABILITY_RLF_DAY_NIGHT_DURATION = ConvertAbilityRealLevelField('Shm2')
ABILITY_RLF_ACTION_DURATION = ConvertAbilityRealLevelField('Shm3')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SLO1 = ConvertAbilityRealLevelField('Slo1')
ABILITY_RLF_ATTACK_SPEED_FACTOR_SLO2 = ConvertAbilityRealLevelField('Slo2')
ABILITY_RLF_DAMAGE_PER_SECOND_SPO1 = ConvertAbilityRealLevelField('Spo1')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_SPO2 = ConvertAbilityRealLevelField('Spo2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_SPO3 = ConvertAbilityRealLevelField('Spo3')
ABILITY_RLF_ACTIVATION_DELAY_STA1 = ConvertAbilityRealLevelField('Sta1')
ABILITY_RLF_DETECTION_RADIUS_STA2 = ConvertAbilityRealLevelField('Sta2')
ABILITY_RLF_DETONATION_RADIUS = ConvertAbilityRealLevelField('Sta3')
ABILITY_RLF_STUN_DURATION_STA4 = ConvertAbilityRealLevelField('Sta4')
ABILITY_RLF_ATTACK_SPEED_BONUS_PERCENT = ConvertAbilityRealLevelField('Uhf1')
ABILITY_RLF_DAMAGE_PER_SECOND_UHF2 = ConvertAbilityRealLevelField('Uhf2')
ABILITY_RLF_LUMBER_PER_INTERVAL = ConvertAbilityRealLevelField('Wha1')
ABILITY_RLF_ART_ATTACHMENT_HEIGHT = ConvertAbilityRealLevelField('Wha3')
ABILITY_RLF_TELEPORT_AREA_WIDTH = ConvertAbilityRealLevelField('Wrp1')
ABILITY_RLF_TELEPORT_AREA_HEIGHT = ConvertAbilityRealLevelField('Wrp2')
ABILITY_RLF_LIFE_STOLEN_PER_ATTACK = ConvertAbilityRealLevelField('Ivam')
ABILITY_RLF_DAMAGE_BONUS_IDAM = ConvertAbilityRealLevelField('Idam')
ABILITY_RLF_CHANCE_TO_HIT_UNITS_PERCENT = ConvertAbilityRealLevelField('Iob2')
ABILITY_RLF_CHANCE_TO_HIT_HEROS_PERCENT = ConvertAbilityRealLevelField('Iob3')
ABILITY_RLF_CHANCE_TO_HIT_SUMMONS_PERCENT = ConvertAbilityRealLevelField('Iob4')
ABILITY_RLF_DELAY_FOR_TARGET_EFFECT = ConvertAbilityRealLevelField('Idel')
ABILITY_RLF_DAMAGE_DEALT_PERCENT_OF_NORMAL = ConvertAbilityRealLevelField('Iild')
ABILITY_RLF_DAMAGE_RECEIVED_MULTIPLIER = ConvertAbilityRealLevelField('Iilw')
ABILITY_RLF_MANA_REGENERATION_BONUS_AS_FRACTION_OF_NORMAL = ConvertAbilityRealLevelField('Imrp')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_ISPI = ConvertAbilityRealLevelField('Ispi')
ABILITY_RLF_DAMAGE_PER_SECOND_IDPS = ConvertAbilityRealLevelField('Idps')
ABILITY_RLF_ATTACK_DAMAGE_INCREASE_CAC1 = ConvertAbilityRealLevelField('Cac1')
ABILITY_RLF_DAMAGE_PER_SECOND_COR1 = ConvertAbilityRealLevelField('Cor1')
ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1 = ConvertAbilityRealLevelField('Isx1')
ABILITY_RLF_DAMAGE_WRS1 = ConvertAbilityRealLevelField('Wrs1')
ABILITY_RLF_TERRAIN_DEFORMATION_AMPLITUDE = ConvertAbilityRealLevelField('Wrs2')
ABILITY_RLF_DAMAGE_CTC1 = ConvertAbilityRealLevelField('Ctc1')
ABILITY_RLF_EXTRA_DAMAGE_TO_TARGET = ConvertAbilityRealLevelField('Ctc2')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_CTC3 = ConvertAbilityRealLevelField('Ctc3')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_CTC4 = ConvertAbilityRealLevelField('Ctc4')
ABILITY_RLF_DAMAGE_CTB1 = ConvertAbilityRealLevelField('Ctb1')
ABILITY_RLF_CASTING_DELAY_SECONDS = ConvertAbilityRealLevelField('Uds2')
ABILITY_RLF_MANA_LOSS_PER_UNIT_DTN1 = ConvertAbilityRealLevelField('Dtn1')
ABILITY_RLF_DAMAGE_TO_SUMMONED_UNITS_DTN2 = ConvertAbilityRealLevelField('Dtn2')
ABILITY_RLF_TRANSITION_TIME_SECONDS = ConvertAbilityRealLevelField('Ivs1')
ABILITY_RLF_MANA_DRAINED_PER_SECOND_NMR1 = ConvertAbilityRealLevelField('Nmr1')
ABILITY_RLF_CHANCE_TO_REDUCE_DAMAGE_PERCENT = ConvertAbilityRealLevelField('Ssk1')
ABILITY_RLF_MINIMUM_DAMAGE = ConvertAbilityRealLevelField('Ssk2')
ABILITY_RLF_IGNORED_DAMAGE = ConvertAbilityRealLevelField('Ssk3')
ABILITY_RLF_FULL_DAMAGE_DEALT = ConvertAbilityRealLevelField('Hfs1')
ABILITY_RLF_FULL_DAMAGE_INTERVAL = ConvertAbilityRealLevelField('Hfs2')
ABILITY_RLF_HALF_DAMAGE_DEALT = ConvertAbilityRealLevelField('Hfs3')
ABILITY_RLF_HALF_DAMAGE_INTERVAL = ConvertAbilityRealLevelField('Hfs4')
ABILITY_RLF_BUILDING_REDUCTION_HFS5 = ConvertAbilityRealLevelField('Hfs5')
ABILITY_RLF_MAXIMUM_DAMAGE_HFS6 = ConvertAbilityRealLevelField('Hfs6')
ABILITY_RLF_MANA_PER_HIT_POINT = ConvertAbilityRealLevelField('Nms1')
ABILITY_RLF_DAMAGE_ABSORBED_PERCENT = ConvertAbilityRealLevelField('Nms2')
ABILITY_RLF_WAVE_DISTANCE = ConvertAbilityRealLevelField('Uim1')
ABILITY_RLF_WAVE_TIME_SECONDS = ConvertAbilityRealLevelField('Uim2')
ABILITY_RLF_DAMAGE_DEALT_UIM3 = ConvertAbilityRealLevelField('Uim3')
ABILITY_RLF_AIR_TIME_SECONDS_UIM4 = ConvertAbilityRealLevelField('Uim4')
ABILITY_RLF_UNIT_RELEASE_INTERVAL_SECONDS = ConvertAbilityRealLevelField('Uls2')
ABILITY_RLF_DAMAGE_RETURN_FACTOR = ConvertAbilityRealLevelField('Uls4')
ABILITY_RLF_DAMAGE_RETURN_THRESHOLD = ConvertAbilityRealLevelField('Uls5')
ABILITY_RLF_RETURNED_DAMAGE_FACTOR = ConvertAbilityRealLevelField('Uts1')
ABILITY_RLF_RECEIVED_DAMAGE_FACTOR = ConvertAbilityRealLevelField('Uts2')
ABILITY_RLF_DEFENSE_BONUS_UTS3 = ConvertAbilityRealLevelField('Uts3')
ABILITY_RLF_DAMAGE_BONUS_NBA1 = ConvertAbilityRealLevelField('Nba1')
ABILITY_RLF_SUMMONED_UNIT_DURATION_SECONDS_NBA3 = ConvertAbilityRealLevelField('Nba3')
ABILITY_RLF_MANA_PER_SUMMONED_HITPOINT = ConvertAbilityRealLevelField('Cmg2')
ABILITY_RLF_CHARGE_FOR_CURRENT_LIFE = ConvertAbilityRealLevelField('Cmg3')
ABILITY_RLF_HIT_POINTS_DRAINED = ConvertAbilityRealLevelField('Ndr1')
ABILITY_RLF_MANA_POINTS_DRAINED = ConvertAbilityRealLevelField('Ndr2')
ABILITY_RLF_DRAIN_INTERVAL_SECONDS = ConvertAbilityRealLevelField('Ndr3')
ABILITY_RLF_LIFE_TRANSFERRED_PER_SECOND = ConvertAbilityRealLevelField('Ndr4')
ABILITY_RLF_MANA_TRANSFERRED_PER_SECOND = ConvertAbilityRealLevelField('Ndr5')
ABILITY_RLF_BONUS_LIFE_FACTOR = ConvertAbilityRealLevelField('Ndr6')
ABILITY_RLF_BONUS_LIFE_DECAY = ConvertAbilityRealLevelField('Ndr7')
ABILITY_RLF_BONUS_MANA_FACTOR = ConvertAbilityRealLevelField('Ndr8')
ABILITY_RLF_BONUS_MANA_DECAY = ConvertAbilityRealLevelField('Ndr9')
ABILITY_RLF_CHANCE_TO_MISS_PERCENT = ConvertAbilityRealLevelField('Nsi2')
ABILITY_RLF_MOVEMENT_SPEED_MODIFIER = ConvertAbilityRealLevelField('Nsi3')
ABILITY_RLF_ATTACK_SPEED_MODIFIER = ConvertAbilityRealLevelField('Nsi4')
ABILITY_RLF_DAMAGE_PER_SECOND_TDG1 = ConvertAbilityRealLevelField('Tdg1')
ABILITY_RLF_MEDIUM_DAMAGE_RADIUS_TDG2 = ConvertAbilityRealLevelField('Tdg2')
ABILITY_RLF_MEDIUM_DAMAGE_PER_SECOND = ConvertAbilityRealLevelField('Tdg3')
ABILITY_RLF_SMALL_DAMAGE_RADIUS_TDG4 = ConvertAbilityRealLevelField('Tdg4')
ABILITY_RLF_SMALL_DAMAGE_PER_SECOND = ConvertAbilityRealLevelField('Tdg5')
ABILITY_RLF_AIR_TIME_SECONDS_TSP1 = ConvertAbilityRealLevelField('Tsp1')
ABILITY_RLF_MINIMUM_HIT_INTERVAL_SECONDS = ConvertAbilityRealLevelField('Tsp2')
ABILITY_RLF_DAMAGE_PER_SECOND_NBF5 = ConvertAbilityRealLevelField('Nbf5')
ABILITY_RLF_MAXIMUM_RANGE = ConvertAbilityRealLevelField('Ebl1')
ABILITY_RLF_MINIMUM_RANGE = ConvertAbilityRealLevelField('Ebl2')
ABILITY_RLF_DAMAGE_PER_TARGET_EFK1 = ConvertAbilityRealLevelField('Efk1')
ABILITY_RLF_MAXIMUM_TOTAL_DAMAGE = ConvertAbilityRealLevelField('Efk2')
ABILITY_RLF_MAXIMUM_SPEED_ADJUSTMENT = ConvertAbilityRealLevelField('Efk4')
ABILITY_RLF_DECAYING_DAMAGE = ConvertAbilityRealLevelField('Esh1')
ABILITY_RLF_MOVEMENT_SPEED_FACTOR_ESH2 = ConvertAbilityRealLevelField('Esh2')
ABILITY_RLF_ATTACK_SPEED_FACTOR_ESH3 = ConvertAbilityRealLevelField('Esh3')
ABILITY_RLF_DECAY_POWER = ConvertAbilityRealLevelField('Esh4')
ABILITY_RLF_INITIAL_DAMAGE_ESH5 = ConvertAbilityRealLevelField('Esh5')
ABILITY_RLF_MAXIMUM_LIFE_ABSORBED = ConvertAbilityRealLevelField('abs1')
ABILITY_RLF_MAXIMUM_MANA_ABSORBED = ConvertAbilityRealLevelField('abs2')
ABILITY_RLF_MOVEMENT_SPEED_INCREASE_BSK1 = ConvertAbilityRealLevelField('bsk1')
ABILITY_RLF_ATTACK_SPEED_INCREASE_BSK2 = ConvertAbilityRealLevelField('bsk2')
ABILITY_RLF_DAMAGE_TAKEN_INCREASE = ConvertAbilityRealLevelField('bsk3')
ABILITY_RLF_LIFE_PER_UNIT = ConvertAbilityRealLevelField('dvm1')
ABILITY_RLF_MANA_PER_UNIT = ConvertAbilityRealLevelField('dvm2')
ABILITY_RLF_LIFE_PER_BUFF = ConvertAbilityRealLevelField('dvm3')
ABILITY_RLF_MANA_PER_BUFF = ConvertAbilityRealLevelField('dvm4')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_DVM5 = ConvertAbilityRealLevelField('dvm5')
ABILITY_RLF_DAMAGE_BONUS_FAK1 = ConvertAbilityRealLevelField('fak1')
ABILITY_RLF_MEDIUM_DAMAGE_FACTOR_FAK2 = ConvertAbilityRealLevelField('fak2')
ABILITY_RLF_SMALL_DAMAGE_FACTOR_FAK3 = ConvertAbilityRealLevelField('fak3')
ABILITY_RLF_FULL_DAMAGE_RADIUS_FAK4 = ConvertAbilityRealLevelField('fak4')
ABILITY_RLF_HALF_DAMAGE_RADIUS_FAK5 = ConvertAbilityRealLevelField('fak5')
ABILITY_RLF_EXTRA_DAMAGE_PER_SECOND = ConvertAbilityRealLevelField('liq1')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_LIQ2 = ConvertAbilityRealLevelField('liq2')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_LIQ3 = ConvertAbilityRealLevelField('liq3')
ABILITY_RLF_MAGIC_DAMAGE_FACTOR = ConvertAbilityRealLevelField('mim1')
ABILITY_RLF_UNIT_DAMAGE_PER_MANA_POINT = ConvertAbilityRealLevelField('mfl1')
ABILITY_RLF_HERO_DAMAGE_PER_MANA_POINT = ConvertAbilityRealLevelField('mfl2')
ABILITY_RLF_UNIT_MAXIMUM_DAMAGE = ConvertAbilityRealLevelField('mfl3')
ABILITY_RLF_HERO_MAXIMUM_DAMAGE = ConvertAbilityRealLevelField('mfl4')
ABILITY_RLF_DAMAGE_COOLDOWN = ConvertAbilityRealLevelField('mfl5')
ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_SPL1 = ConvertAbilityRealLevelField('spl1')
ABILITY_RLF_LIFE_REGENERATED = ConvertAbilityRealLevelField('irl1')
ABILITY_RLF_MANA_REGENERATED = ConvertAbilityRealLevelField('irl2')
ABILITY_RLF_MANA_LOSS_PER_UNIT_IDC1 = ConvertAbilityRealLevelField('idc1')
ABILITY_RLF_SUMMONED_UNIT_DAMAGE_IDC2 = ConvertAbilityRealLevelField('idc2')
ABILITY_RLF_ACTIVATION_DELAY_IMO2 = ConvertAbilityRealLevelField('imo2')
ABILITY_RLF_LURE_INTERVAL_SECONDS = ConvertAbilityRealLevelField('imo3')
ABILITY_RLF_DAMAGE_BONUS_ISR1 = ConvertAbilityRealLevelField('isr1')
ABILITY_RLF_DAMAGE_REDUCTION_ISR2 = ConvertAbilityRealLevelField('isr2')
ABILITY_RLF_DAMAGE_BONUS_IPV1 = ConvertAbilityRealLevelField('ipv1')
ABILITY_RLF_LIFE_STEAL_AMOUNT = ConvertAbilityRealLevelField('ipv2')
ABILITY_RLF_LIFE_RESTORED_FACTOR = ConvertAbilityRealLevelField('ast1')
ABILITY_RLF_MANA_RESTORED_FACTOR = ConvertAbilityRealLevelField('ast2')
ABILITY_RLF_ATTACH_DELAY = ConvertAbilityRealLevelField('gra1')
ABILITY_RLF_REMOVE_DELAY = ConvertAbilityRealLevelField('gra2')
ABILITY_RLF_HERO_REGENERATION_DELAY = ConvertAbilityRealLevelField('Nsa2')
ABILITY_RLF_UNIT_REGENERATION_DELAY = ConvertAbilityRealLevelField('Nsa3')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_NSA4 = ConvertAbilityRealLevelField('Nsa4')
ABILITY_RLF_HIT_POINTS_PER_SECOND_NSA5 = ConvertAbilityRealLevelField('Nsa5')
ABILITY_RLF_DAMAGE_TO_SUMMONED_UNITS_IXS1 = ConvertAbilityRealLevelField('Ixs1')
ABILITY_RLF_MAGIC_DAMAGE_REDUCTION_IXS2 = ConvertAbilityRealLevelField('Ixs2')
ABILITY_RLF_SUMMONED_UNIT_DURATION = ConvertAbilityRealLevelField('Npa6')
ABILITY_RLF_SHIELD_COOLDOWN_TIME = ConvertAbilityRealLevelField('Nse1')
ABILITY_RLF_DAMAGE_PER_SECOND_NDO1 = ConvertAbilityRealLevelField('Ndo1')
ABILITY_RLF_SUMMONED_UNIT_DURATION_SECONDS_NDO3 = ConvertAbilityRealLevelField('Ndo3')
ABILITY_RLF_MEDIUM_DAMAGE_RADIUS_FLK1 = ConvertAbilityRealLevelField('flk1')
ABILITY_RLF_SMALL_DAMAGE_RADIUS_FLK2 = ConvertAbilityRealLevelField('flk2')
ABILITY_RLF_FULL_DAMAGE_AMOUNT_FLK3 = ConvertAbilityRealLevelField('flk3')
ABILITY_RLF_MEDIUM_DAMAGE_AMOUNT = ConvertAbilityRealLevelField('flk4')
ABILITY_RLF_SMALL_DAMAGE_AMOUNT = ConvertAbilityRealLevelField('flk5')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_HBN1 = ConvertAbilityRealLevelField('Hbn1')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_HBN2 = ConvertAbilityRealLevelField('Hbn2')
ABILITY_RLF_MAX_MANA_DRAINED_UNITS = ConvertAbilityRealLevelField('fbk1')
ABILITY_RLF_DAMAGE_RATIO_UNITS_PERCENT = ConvertAbilityRealLevelField('fbk2')
ABILITY_RLF_MAX_MANA_DRAINED_HEROS = ConvertAbilityRealLevelField('fbk3')
ABILITY_RLF_DAMAGE_RATIO_HEROS_PERCENT = ConvertAbilityRealLevelField('fbk4')
ABILITY_RLF_SUMMONED_DAMAGE = ConvertAbilityRealLevelField('fbk5')
ABILITY_RLF_DISTRIBUTED_DAMAGE_FACTOR_NCA1 = ConvertAbilityRealLevelField('nca1')
ABILITY_RLF_INITIAL_DAMAGE_PXF1 = ConvertAbilityRealLevelField('pxf1')
ABILITY_RLF_DAMAGE_PER_SECOND_PXF2 = ConvertAbilityRealLevelField('pxf2')
ABILITY_RLF_DAMAGE_PER_SECOND_MLS1 = ConvertAbilityRealLevelField('mls1')
ABILITY_RLF_BEAST_COLLISION_RADIUS = ConvertAbilityRealLevelField('Nst2')
ABILITY_RLF_DAMAGE_AMOUNT_NST3 = ConvertAbilityRealLevelField('Nst3')
ABILITY_RLF_DAMAGE_RADIUS = ConvertAbilityRealLevelField('Nst4')
ABILITY_RLF_DAMAGE_DELAY = ConvertAbilityRealLevelField('Nst5')
ABILITY_RLF_FOLLOW_THROUGH_TIME = ConvertAbilityRealLevelField('Ncl1')
ABILITY_RLF_ART_DURATION = ConvertAbilityRealLevelField('Ncl4')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_NAB1 = ConvertAbilityRealLevelField('Nab1')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_NAB2 = ConvertAbilityRealLevelField('Nab2')
ABILITY_RLF_PRIMARY_DAMAGE = ConvertAbilityRealLevelField('Nab4')
ABILITY_RLF_SECONDARY_DAMAGE = ConvertAbilityRealLevelField('Nab5')
ABILITY_RLF_DAMAGE_INTERVAL_NAB6 = ConvertAbilityRealLevelField('Nab6')
ABILITY_RLF_GOLD_COST_FACTOR = ConvertAbilityRealLevelField('Ntm1')
ABILITY_RLF_LUMBER_COST_FACTOR = ConvertAbilityRealLevelField('Ntm2')
ABILITY_RLF_MOVE_SPEED_BONUS_NEG1 = ConvertAbilityRealLevelField('Neg1')
ABILITY_RLF_DAMAGE_BONUS_NEG2 = ConvertAbilityRealLevelField('Neg2')
ABILITY_RLF_DAMAGE_AMOUNT_NCS1 = ConvertAbilityRealLevelField('Ncs1')
ABILITY_RLF_DAMAGE_INTERVAL_NCS2 = ConvertAbilityRealLevelField('Ncs2')
ABILITY_RLF_MAX_DAMAGE_NCS4 = ConvertAbilityRealLevelField('Ncs4')
ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NCS5 = ConvertAbilityRealLevelField('Ncs5')
ABILITY_RLF_EFFECT_DURATION = ConvertAbilityRealLevelField('Ncs6')
ABILITY_RLF_SPAWN_INTERVAL_NSY1 = ConvertAbilityRealLevelField('Nsy1')
ABILITY_RLF_SPAWN_UNIT_DURATION = ConvertAbilityRealLevelField('Nsy3')
ABILITY_RLF_SPAWN_UNIT_OFFSET = ConvertAbilityRealLevelField('Nsy4')
ABILITY_RLF_LEASH_RANGE_NSY5 = ConvertAbilityRealLevelField('Nsy5')
ABILITY_RLF_SPAWN_INTERVAL_NFY1 = ConvertAbilityRealLevelField('Nfy1')
ABILITY_RLF_LEASH_RANGE_NFY2 = ConvertAbilityRealLevelField('Nfy2')
ABILITY_RLF_CHANCE_TO_DEMOLISH = ConvertAbilityRealLevelField('Nde1')
ABILITY_RLF_DAMAGE_MULTIPLIER_BUILDINGS = ConvertAbilityRealLevelField('Nde2')
ABILITY_RLF_DAMAGE_MULTIPLIER_UNITS = ConvertAbilityRealLevelField('Nde3')
ABILITY_RLF_DAMAGE_MULTIPLIER_HEROES = ConvertAbilityRealLevelField('Nde4')
ABILITY_RLF_BONUS_DAMAGE_MULTIPLIER = ConvertAbilityRealLevelField('Nic1')
ABILITY_RLF_DEATH_DAMAGE_FULL_AMOUNT = ConvertAbilityRealLevelField('Nic2')
ABILITY_RLF_DEATH_DAMAGE_FULL_AREA = ConvertAbilityRealLevelField('Nic3')
ABILITY_RLF_DEATH_DAMAGE_HALF_AMOUNT = ConvertAbilityRealLevelField('Nic4')
ABILITY_RLF_DEATH_DAMAGE_HALF_AREA = ConvertAbilityRealLevelField('Nic5')
ABILITY_RLF_DEATH_DAMAGE_DELAY = ConvertAbilityRealLevelField('Nic6')
ABILITY_RLF_DAMAGE_AMOUNT_NSO1 = ConvertAbilityRealLevelField('Nso1')
ABILITY_RLF_DAMAGE_PERIOD = ConvertAbilityRealLevelField('Nso2')
ABILITY_RLF_DAMAGE_PENALTY = ConvertAbilityRealLevelField('Nso3')
ABILITY_RLF_MOVEMENT_SPEED_REDUCTION_PERCENT_NSO4 = ConvertAbilityRealLevelField('Nso4')
ABILITY_RLF_ATTACK_SPEED_REDUCTION_PERCENT_NSO5 = ConvertAbilityRealLevelField('Nso5')
ABILITY_RLF_SPLIT_DELAY = ConvertAbilityRealLevelField('Nlm2')
ABILITY_RLF_MAX_HITPOINT_FACTOR = ConvertAbilityRealLevelField('Nlm4')
ABILITY_RLF_LIFE_DURATION_SPLIT_BONUS = ConvertAbilityRealLevelField('Nlm5')
ABILITY_RLF_WAVE_INTERVAL = ConvertAbilityRealLevelField('Nvc3')
ABILITY_RLF_BUILDING_DAMAGE_FACTOR_NVC4 = ConvertAbilityRealLevelField('Nvc4')
ABILITY_RLF_FULL_DAMAGE_AMOUNT_NVC5 = ConvertAbilityRealLevelField('Nvc5')
ABILITY_RLF_HALF_DAMAGE_FACTOR = ConvertAbilityRealLevelField('Nvc6')
ABILITY_RLF_INTERVAL_BETWEEN_PULSES = ConvertAbilityRealLevelField('Tau5')
ABILITY_BLF_PERCENT_BONUS_HAB2 = ConvertAbilityBooleanLevelField('Hab2')
ABILITY_BLF_USE_TELEPORT_CLUSTERING_HMT3 = ConvertAbilityBooleanLevelField('Hmt3')
ABILITY_BLF_NEVER_MISS_OCR5 = ConvertAbilityBooleanLevelField('Ocr5')
ABILITY_BLF_EXCLUDE_ITEM_DAMAGE = ConvertAbilityBooleanLevelField('Ocr6')
ABILITY_BLF_BACKSTAB_DAMAGE = ConvertAbilityBooleanLevelField('Owk4')
ABILITY_BLF_INHERIT_UPGRADES_UAN3 = ConvertAbilityBooleanLevelField('Uan3')
ABILITY_BLF_MANA_CONVERSION_AS_PERCENT = ConvertAbilityBooleanLevelField('Udp3')
ABILITY_BLF_LIFE_CONVERSION_AS_PERCENT = ConvertAbilityBooleanLevelField('Udp4')
ABILITY_BLF_LEAVE_TARGET_ALIVE = ConvertAbilityBooleanLevelField('Udp5')
ABILITY_BLF_PERCENT_BONUS_UAU3 = ConvertAbilityBooleanLevelField('Uau3')
ABILITY_BLF_DAMAGE_IS_PERCENT_RECEIVED = ConvertAbilityBooleanLevelField('Eah2')
ABILITY_BLF_MELEE_BONUS = ConvertAbilityBooleanLevelField('Ear2')
ABILITY_BLF_RANGED_BONUS = ConvertAbilityBooleanLevelField('Ear3')
ABILITY_BLF_FLAT_BONUS = ConvertAbilityBooleanLevelField('Ear4')
ABILITY_BLF_NEVER_MISS_HBH5 = ConvertAbilityBooleanLevelField('Hbh5')
ABILITY_BLF_PERCENT_BONUS_HAD2 = ConvertAbilityBooleanLevelField('Had2')
ABILITY_BLF_CAN_DEACTIVATE = ConvertAbilityBooleanLevelField('Hds1')
ABILITY_BLF_RAISED_UNITS_ARE_INVULNERABLE = ConvertAbilityBooleanLevelField('Hre2')
ABILITY_BLF_PERCENTAGE_OAR2 = ConvertAbilityBooleanLevelField('Oar2')
ABILITY_BLF_SUMMON_BUSY_UNITS = ConvertAbilityBooleanLevelField('Btl2')
ABILITY_BLF_CREATES_BLIGHT = ConvertAbilityBooleanLevelField('Bli2')
ABILITY_BLF_EXPLODES_ON_DEATH = ConvertAbilityBooleanLevelField('Sds6')
ABILITY_BLF_ALWAYS_AUTOCAST_FAE2 = ConvertAbilityBooleanLevelField('Fae2')
ABILITY_BLF_REGENERATE_ONLY_AT_NIGHT = ConvertAbilityBooleanLevelField('Mbt5')
ABILITY_BLF_SHOW_SELECT_UNIT_BUTTON = ConvertAbilityBooleanLevelField('Neu3')
ABILITY_BLF_SHOW_UNIT_INDICATOR = ConvertAbilityBooleanLevelField('Neu4')
ABILITY_BLF_CHARGE_OWNING_PLAYER = ConvertAbilityBooleanLevelField('Ans6')
ABILITY_BLF_PERCENTAGE_ARM2 = ConvertAbilityBooleanLevelField('Arm2')
ABILITY_BLF_TARGET_IS_INVULNERABLE = ConvertAbilityBooleanLevelField('Pos3')
ABILITY_BLF_TARGET_IS_MAGIC_IMMUNE = ConvertAbilityBooleanLevelField('Pos4')
ABILITY_BLF_KILL_ON_CASTER_DEATH = ConvertAbilityBooleanLevelField('Ucb6')
ABILITY_BLF_NO_TARGET_REQUIRED_REJ4 = ConvertAbilityBooleanLevelField('Rej4')
ABILITY_BLF_ACCEPTS_GOLD = ConvertAbilityBooleanLevelField('Rtn1')
ABILITY_BLF_ACCEPTS_LUMBER = ConvertAbilityBooleanLevelField('Rtn2')
ABILITY_BLF_PREFER_HOSTILES_ROA5 = ConvertAbilityBooleanLevelField('Roa5')
ABILITY_BLF_PREFER_FRIENDLIES_ROA6 = ConvertAbilityBooleanLevelField('Roa6')
ABILITY_BLF_ROOTED_TURNING = ConvertAbilityBooleanLevelField('Roo3')
ABILITY_BLF_ALWAYS_AUTOCAST_SLO3 = ConvertAbilityBooleanLevelField('Slo3')
ABILITY_BLF_HIDE_BUTTON = ConvertAbilityBooleanLevelField('Ihid')
ABILITY_BLF_USE_TELEPORT_CLUSTERING_ITP2 = ConvertAbilityBooleanLevelField('Itp2')
ABILITY_BLF_IMMUNE_TO_MORPH_EFFECTS = ConvertAbilityBooleanLevelField('Eth1')
ABILITY_BLF_DOES_NOT_BLOCK_BUILDINGS = ConvertAbilityBooleanLevelField('Eth2')
ABILITY_BLF_AUTO_ACQUIRE_ATTACK_TARGETS = ConvertAbilityBooleanLevelField('Gho1')
ABILITY_BLF_IMMUNE_TO_MORPH_EFFECTS_GHO2 = ConvertAbilityBooleanLevelField('Gho2')
ABILITY_BLF_DO_NOT_BLOCK_BUILDINGS = ConvertAbilityBooleanLevelField('Gho3')
ABILITY_BLF_INCLUDE_RANGED_DAMAGE = ConvertAbilityBooleanLevelField('Ssk4')
ABILITY_BLF_INCLUDE_MELEE_DAMAGE = ConvertAbilityBooleanLevelField('Ssk5')
ABILITY_BLF_MOVE_TO_PARTNER = ConvertAbilityBooleanLevelField('coa2')
ABILITY_BLF_CAN_BE_DISPELLED = ConvertAbilityBooleanLevelField('cyc1')
ABILITY_BLF_IGNORE_FRIENDLY_BUFFS = ConvertAbilityBooleanLevelField('dvm6')
ABILITY_BLF_DROP_ITEMS_ON_DEATH = ConvertAbilityBooleanLevelField('inv2')
ABILITY_BLF_CAN_USE_ITEMS = ConvertAbilityBooleanLevelField('inv3')
ABILITY_BLF_CAN_GET_ITEMS = ConvertAbilityBooleanLevelField('inv4')
ABILITY_BLF_CAN_DROP_ITEMS = ConvertAbilityBooleanLevelField('inv5')
ABILITY_BLF_REPAIRS_ALLOWED = ConvertAbilityBooleanLevelField('liq4')
ABILITY_BLF_CASTER_ONLY_SPLASH = ConvertAbilityBooleanLevelField('mfl6')
ABILITY_BLF_NO_TARGET_REQUIRED_IRL4 = ConvertAbilityBooleanLevelField('irl4')
ABILITY_BLF_DISPEL_ON_ATTACK = ConvertAbilityBooleanLevelField('irl5')
ABILITY_BLF_AMOUNT_IS_RAW_VALUE = ConvertAbilityBooleanLevelField('ipv3')
ABILITY_BLF_SHARED_SPELL_COOLDOWN = ConvertAbilityBooleanLevelField('spb2')
ABILITY_BLF_SLEEP_ONCE = ConvertAbilityBooleanLevelField('sla1')
ABILITY_BLF_ALLOW_ON_ANY_PLAYER_SLOT = ConvertAbilityBooleanLevelField('sla2')
ABILITY_BLF_DISABLE_OTHER_ABILITIES = ConvertAbilityBooleanLevelField('Ncl5')
ABILITY_BLF_ALLOW_BOUNTY = ConvertAbilityBooleanLevelField('Ntm4')
ABILITY_SLF_ICON_NORMAL = ConvertAbilityStringLevelField('aart')
ABILITY_SLF_CASTER = ConvertAbilityStringLevelField('acat')
ABILITY_SLF_TARGET = ConvertAbilityStringLevelField('atat')
ABILITY_SLF_SPECIAL = ConvertAbilityStringLevelField('asat')
ABILITY_SLF_EFFECT = ConvertAbilityStringLevelField('aeat')
ABILITY_SLF_AREA_EFFECT = ConvertAbilityStringLevelField('aaea')
ABILITY_SLF_LIGHTNING_EFFECTS = ConvertAbilityStringLevelField('alig')
ABILITY_SLF_MISSILE_ART = ConvertAbilityStringLevelField('amat')
ABILITY_SLF_TOOLTIP_LEARN = ConvertAbilityStringLevelField('aret')
ABILITY_SLF_TOOLTIP_LEARN_EXTENDED = ConvertAbilityStringLevelField('arut')
ABILITY_SLF_TOOLTIP_NORMAL = ConvertAbilityStringLevelField('atp1')
ABILITY_SLF_TOOLTIP_TURN_OFF = ConvertAbilityStringLevelField('aut1')
ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED = ConvertAbilityStringLevelField('aub1')
ABILITY_SLF_TOOLTIP_TURN_OFF_EXTENDED = ConvertAbilityStringLevelField('auu1')
ABILITY_SLF_NORMAL_FORM_UNIT_EME1 = ConvertAbilityStringLevelField('Eme1')
ABILITY_SLF_SPAWNED_UNITS = ConvertAbilityStringLevelField('Ndp1')
ABILITY_SLF_ABILITY_FOR_UNIT_CREATION = ConvertAbilityStringLevelField('Nrc1')
ABILITY_SLF_NORMAL_FORM_UNIT_MIL1 = ConvertAbilityStringLevelField('Mil1')
ABILITY_SLF_ALTERNATE_FORM_UNIT_MIL2 = ConvertAbilityStringLevelField('Mil2')
ABILITY_SLF_BASE_ORDER_ID_ANS5 = ConvertAbilityStringLevelField('Ans5')
ABILITY_SLF_MORPH_UNITS_GROUND = ConvertAbilityStringLevelField('Ply2')
ABILITY_SLF_MORPH_UNITS_AIR = ConvertAbilityStringLevelField('Ply3')
ABILITY_SLF_MORPH_UNITS_AMPHIBIOUS = ConvertAbilityStringLevelField('Ply4')
ABILITY_SLF_MORPH_UNITS_WATER = ConvertAbilityStringLevelField('Ply5')
ABILITY_SLF_UNIT_TYPE_ONE = ConvertAbilityStringLevelField('Rai3')
ABILITY_SLF_UNIT_TYPE_TWO = ConvertAbilityStringLevelField('Rai4')
ABILITY_SLF_UNIT_TYPE_SOD2 = ConvertAbilityStringLevelField('Sod2')
ABILITY_SLF_SUMMON_1_UNIT_TYPE = ConvertAbilityStringLevelField('Ist1')
ABILITY_SLF_SUMMON_2_UNIT_TYPE = ConvertAbilityStringLevelField('Ist2')
ABILITY_SLF_RACE_TO_CONVERT = ConvertAbilityStringLevelField('Ndc1')
ABILITY_SLF_PARTNER_UNIT_TYPE = ConvertAbilityStringLevelField('coa1')
ABILITY_SLF_PARTNER_UNIT_TYPE_ONE = ConvertAbilityStringLevelField('dcp1')
ABILITY_SLF_PARTNER_UNIT_TYPE_TWO = ConvertAbilityStringLevelField('dcp2')
ABILITY_SLF_REQUIRED_UNIT_TYPE = ConvertAbilityStringLevelField('tpi1')
ABILITY_SLF_CONVERTED_UNIT_TYPE = ConvertAbilityStringLevelField('tpi2')
ABILITY_SLF_SPELL_LIST = ConvertAbilityStringLevelField('spb1')
ABILITY_SLF_BASE_ORDER_ID_SPB5 = ConvertAbilityStringLevelField('spb5')
ABILITY_SLF_BASE_ORDER_ID_NCL6 = ConvertAbilityStringLevelField('Ncl6')
ABILITY_SLF_ABILITY_UPGRADE_1 = ConvertAbilityStringLevelField('Neg3')
ABILITY_SLF_ABILITY_UPGRADE_2 = ConvertAbilityStringLevelField('Neg4')
ABILITY_SLF_ABILITY_UPGRADE_3 = ConvertAbilityStringLevelField('Neg5')
ABILITY_SLF_ABILITY_UPGRADE_4 = ConvertAbilityStringLevelField('Neg6')
ABILITY_SLF_SPAWN_UNIT_ID_NSY2 = ConvertAbilityStringLevelField('Nsy2')
ITEM_IF_LEVEL = ConvertItemIntegerField('ilev')
ITEM_IF_NUMBER_OF_CHARGES = ConvertItemIntegerField('iuse')
ITEM_IF_COOLDOWN_GROUP = ConvertItemIntegerField('icid')
ITEM_IF_MAX_HIT_POINTS = ConvertItemIntegerField('ihtp')
ITEM_IF_HIT_POINTS = ConvertItemIntegerField('ihpc')
ITEM_IF_PRIORITY = ConvertItemIntegerField('ipri')
ITEM_IF_ARMOR_TYPE = ConvertItemIntegerField('iarm')
ITEM_IF_TINTING_COLOR_RED = ConvertItemIntegerField('iclr')
ITEM_IF_TINTING_COLOR_GREEN = ConvertItemIntegerField('iclg')
ITEM_IF_TINTING_COLOR_BLUE = ConvertItemIntegerField('iclb')
ITEM_IF_TINTING_COLOR_ALPHA = ConvertItemIntegerField('ical')
ITEM_RF_SCALING_VALUE = ConvertItemRealField('isca')
ITEM_BF_DROPPED_WHEN_CARRIER_DIES = ConvertItemBooleanField('idrp')
ITEM_BF_CAN_BE_DROPPED = ConvertItemBooleanField('idro')
ITEM_BF_PERISHABLE = ConvertItemBooleanField('iper')
ITEM_BF_INCLUDE_AS_RANDOM_CHOICE = ConvertItemBooleanField('iprn')
ITEM_BF_USE_AUTOMATICALLY_WHEN_ACQUIRED = ConvertItemBooleanField('ipow')
ITEM_BF_CAN_BE_SOLD_TO_MERCHANTS = ConvertItemBooleanField('ipaw')
ITEM_BF_ACTIVELY_USED = ConvertItemBooleanField('iusa')
ITEM_SF_MODEL_USED = ConvertItemStringField('ifil')
UNIT_IF_DEFENSE_TYPE = ConvertUnitIntegerField('udty')
UNIT_IF_ARMOR_TYPE = ConvertUnitIntegerField('uarm')
UNIT_IF_LOOPING_FADE_IN_RATE = ConvertUnitIntegerField('ulfi')
UNIT_IF_LOOPING_FADE_OUT_RATE = ConvertUnitIntegerField('ulfo')
UNIT_IF_AGILITY = ConvertUnitIntegerField('uagc')
UNIT_IF_INTELLIGENCE = ConvertUnitIntegerField('uinc')
UNIT_IF_STRENGTH = ConvertUnitIntegerField('ustc')
UNIT_IF_AGILITY_PERMANENT = ConvertUnitIntegerField('uagm')
UNIT_IF_INTELLIGENCE_PERMANENT = ConvertUnitIntegerField('uinm')
UNIT_IF_STRENGTH_PERMANENT = ConvertUnitIntegerField('ustm')
UNIT_IF_AGILITY_WITH_BONUS = ConvertUnitIntegerField('uagb')
UNIT_IF_INTELLIGENCE_WITH_BONUS = ConvertUnitIntegerField('uinb')
UNIT_IF_STRENGTH_WITH_BONUS = ConvertUnitIntegerField('ustb')
UNIT_IF_GOLD_BOUNTY_AWARDED_NUMBER_OF_DICE = ConvertUnitIntegerField('ubdi')
UNIT_IF_GOLD_BOUNTY_AWARDED_BASE = ConvertUnitIntegerField('ubba')
UNIT_IF_GOLD_BOUNTY_AWARDED_SIDES_PER_DIE = ConvertUnitIntegerField('ubsi')
UNIT_IF_LUMBER_BOUNTY_AWARDED_NUMBER_OF_DICE = ConvertUnitIntegerField('ulbd')
UNIT_IF_LUMBER_BOUNTY_AWARDED_BASE = ConvertUnitIntegerField('ulba')
UNIT_IF_LUMBER_BOUNTY_AWARDED_SIDES_PER_DIE = ConvertUnitIntegerField('ulbs')
UNIT_IF_LEVEL = ConvertUnitIntegerField('ulev')
UNIT_IF_FORMATION_RANK = ConvertUnitIntegerField('ufor')
UNIT_IF_ORIENTATION_INTERPOLATION = ConvertUnitIntegerField('uori')
UNIT_IF_ELEVATION_SAMPLE_POINTS = ConvertUnitIntegerField('uept')
UNIT_IF_TINTING_COLOR_RED = ConvertUnitIntegerField('uclr')
UNIT_IF_TINTING_COLOR_GREEN = ConvertUnitIntegerField('uclg')
UNIT_IF_TINTING_COLOR_BLUE = ConvertUnitIntegerField('uclb')
UNIT_IF_TINTING_COLOR_ALPHA = ConvertUnitIntegerField('ucal')
UNIT_IF_MOVE_TYPE = ConvertUnitIntegerField('umvt')
UNIT_IF_TARGETED_AS = ConvertUnitIntegerField('utar')
UNIT_IF_UNIT_CLASSIFICATION = ConvertUnitIntegerField('utyp')
UNIT_IF_HIT_POINTS_REGENERATION_TYPE = ConvertUnitIntegerField('uhrt')
UNIT_IF_PLACEMENT_PREVENTED_BY = ConvertUnitIntegerField('upar')
UNIT_IF_PRIMARY_ATTRIBUTE = ConvertUnitIntegerField('upra')
UNIT_RF_STRENGTH_PER_LEVEL = ConvertUnitRealField('ustp')
UNIT_RF_AGILITY_PER_LEVEL = ConvertUnitRealField('uagp')
UNIT_RF_INTELLIGENCE_PER_LEVEL = ConvertUnitRealField('uinp')
UNIT_RF_HIT_POINTS_REGENERATION_RATE = ConvertUnitRealField('uhpr')
UNIT_RF_MANA_REGENERATION = ConvertUnitRealField('umpr')
UNIT_RF_DEATH_TIME = ConvertUnitRealField('udtm')
UNIT_RF_FLY_HEIGHT = ConvertUnitRealField('ufyh')
UNIT_RF_TURN_RATE = ConvertUnitRealField('umvr')
UNIT_RF_ELEVATION_SAMPLE_RADIUS = ConvertUnitRealField('uerd')
UNIT_RF_FOG_OF_WAR_SAMPLE_RADIUS = ConvertUnitRealField('ufrd')
UNIT_RF_MAXIMUM_PITCH_ANGLE_DEGREES = ConvertUnitRealField('umxp')
UNIT_RF_MAXIMUM_ROLL_ANGLE_DEGREES = ConvertUnitRealField('umxr')
UNIT_RF_SCALING_VALUE = ConvertUnitRealField('usca')
UNIT_RF_ANIMATION_RUN_SPEED = ConvertUnitRealField('urun')
UNIT_RF_SELECTION_SCALE = ConvertUnitRealField('ussc')
UNIT_RF_SELECTION_CIRCLE_HEIGHT = ConvertUnitRealField('uslz')
UNIT_RF_SHADOW_IMAGE_HEIGHT = ConvertUnitRealField('ushh')
UNIT_RF_SHADOW_IMAGE_WIDTH = ConvertUnitRealField('ushw')
UNIT_RF_SHADOW_IMAGE_CENTER_X = ConvertUnitRealField('ushx')
UNIT_RF_SHADOW_IMAGE_CENTER_Y = ConvertUnitRealField('ushy')
UNIT_RF_ANIMATION_WALK_SPEED = ConvertUnitRealField('uwal')
UNIT_RF_DEFENSE = ConvertUnitRealField('udfc')
UNIT_RF_SIGHT_RADIUS = ConvertUnitRealField('usir')
UNIT_RF_PRIORITY = ConvertUnitRealField('upri')
UNIT_RF_SPEED = ConvertUnitRealField('umvc')
UNIT_RF_OCCLUDER_HEIGHT = ConvertUnitRealField('uocc')
UNIT_RF_HP = ConvertUnitRealField('uhpc')
UNIT_RF_MANA = ConvertUnitRealField('umpc')
UNIT_RF_ACQUISITION_RANGE = ConvertUnitRealField('uacq')
UNIT_RF_CAST_BACK_SWING = ConvertUnitRealField('ucbs')
UNIT_RF_CAST_POINT = ConvertUnitRealField('ucpt')
UNIT_RF_MINIMUM_ATTACK_RANGE = ConvertUnitRealField('uamn')
UNIT_BF_RAISABLE = ConvertUnitBooleanField('urai')
UNIT_BF_DECAYABLE = ConvertUnitBooleanField('udec')
UNIT_BF_IS_A_BUILDING = ConvertUnitBooleanField('ubdg')
UNIT_BF_USE_EXTENDED_LINE_OF_SIGHT = ConvertUnitBooleanField('ulos')
UNIT_BF_NEUTRAL_BUILDING_SHOWS_MINIMAP_ICON = ConvertUnitBooleanField('unbm')
UNIT_BF_HERO_HIDE_HERO_INTERFACE_ICON = ConvertUnitBooleanField('uhhb')
UNIT_BF_HERO_HIDE_HERO_MINIMAP_DISPLAY = ConvertUnitBooleanField('uhhm')
UNIT_BF_HERO_HIDE_HERO_DEATH_MESSAGE = ConvertUnitBooleanField('uhhd')
UNIT_BF_HIDE_MINIMAP_DISPLAY = ConvertUnitBooleanField('uhom')
UNIT_BF_SCALE_PROJECTILES = ConvertUnitBooleanField('uscb')
UNIT_BF_SELECTION_CIRCLE_ON_WATER = ConvertUnitBooleanField('usew')
UNIT_BF_HAS_WATER_SHADOW = ConvertUnitBooleanField('ushr')
UNIT_SF_NAME = ConvertUnitStringField('unam')
UNIT_SF_PROPER_NAMES = ConvertUnitStringField('upro')
UNIT_SF_GROUND_TEXTURE = ConvertUnitStringField('uubs')
UNIT_SF_SHADOW_IMAGE_UNIT = ConvertUnitStringField('ushu')
UNIT_WEAPON_IF_ATTACK_DAMAGE_NUMBER_OF_DICE = ConvertUnitWeaponIntegerField('ua1d')
UNIT_WEAPON_IF_ATTACK_DAMAGE_BASE = ConvertUnitWeaponIntegerField('ua1b')
UNIT_WEAPON_IF_ATTACK_DAMAGE_SIDES_PER_DIE = ConvertUnitWeaponIntegerField('ua1s')
UNIT_WEAPON_IF_ATTACK_MAXIMUM_NUMBER_OF_TARGETS = ConvertUnitWeaponIntegerField('utc1')
UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE = ConvertUnitWeaponIntegerField('ua1t')
UNIT_WEAPON_IF_ATTACK_WEAPON_SOUND = ConvertUnitWeaponIntegerField('ucs1')
UNIT_WEAPON_IF_ATTACK_AREA_OF_EFFECT_TARGETS = ConvertUnitWeaponIntegerField('ua1p')
UNIT_WEAPON_IF_ATTACK_TARGETS_ALLOWED = ConvertUnitWeaponIntegerField('ua1g')
UNIT_WEAPON_RF_ATTACK_BACKSWING_POINT = ConvertUnitWeaponRealField('ubs1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_POINT = ConvertUnitWeaponRealField('udp1')
UNIT_WEAPON_RF_ATTACK_BASE_COOLDOWN = ConvertUnitWeaponRealField('ua1c')
UNIT_WEAPON_RF_ATTACK_DAMAGE_LOSS_FACTOR = ConvertUnitWeaponRealField('udl1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_MEDIUM = ConvertUnitWeaponRealField('uhd1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_FACTOR_SMALL = ConvertUnitWeaponRealField('uqd1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_DISTANCE = ConvertUnitWeaponRealField('usd1')
UNIT_WEAPON_RF_ATTACK_DAMAGE_SPILL_RADIUS = ConvertUnitWeaponRealField('usr1')
UNIT_WEAPON_RF_ATTACK_PROJECTILE_SPEED = ConvertUnitWeaponRealField('ua1z')
UNIT_WEAPON_RF_ATTACK_PROJECTILE_ARC = ConvertUnitWeaponRealField('uma1')
UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_FULL_DAMAGE = ConvertUnitWeaponRealField('ua1f')
UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_MEDIUM_DAMAGE = ConvertUnitWeaponRealField('ua1h')
UNIT_WEAPON_RF_ATTACK_AREA_OF_EFFECT_SMALL_DAMAGE = ConvertUnitWeaponRealField('ua1q')
UNIT_WEAPON_RF_ATTACK_RANGE = ConvertUnitWeaponRealField('ua1r')
UNIT_WEAPON_BF_ATTACK_SHOW_UI = ConvertUnitWeaponBooleanField('uwu1')
UNIT_WEAPON_BF_ATTACKS_ENABLED = ConvertUnitWeaponBooleanField('uaen')
UNIT_WEAPON_BF_ATTACK_PROJECTILE_HOMING_ENABLED = ConvertUnitWeaponBooleanField('umh1')
UNIT_WEAPON_SF_ATTACK_PROJECTILE_ART = ConvertUnitWeaponStringField('ua1m')
MOVE_TYPE_UNKNOWN = ConvertMoveType(0)
MOVE_TYPE_FOOT = ConvertMoveType(1)
MOVE_TYPE_FLY = ConvertMoveType(2)
MOVE_TYPE_HORSE = ConvertMoveType(4)
MOVE_TYPE_HOVER = ConvertMoveType(8)
MOVE_TYPE_FLOAT = ConvertMoveType(16)
MOVE_TYPE_AMPHIBIOUS = ConvertMoveType(32)
MOVE_TYPE_UNBUILDABLE = ConvertMoveType(64)
TARGET_FLAG_NONE = ConvertTargetFlag(1)
TARGET_FLAG_GROUND = ConvertTargetFlag(2)
TARGET_FLAG_AIR = ConvertTargetFlag(4)
TARGET_FLAG_STRUCTURE = ConvertTargetFlag(8)
TARGET_FLAG_WARD = ConvertTargetFlag(16)
TARGET_FLAG_ITEM = ConvertTargetFlag(32)
TARGET_FLAG_TREE = ConvertTargetFlag(64)
TARGET_FLAG_WALL = ConvertTargetFlag(128)
TARGET_FLAG_DEBRIS = ConvertTargetFlag(256)
TARGET_FLAG_DECORATION = ConvertTargetFlag(512)
TARGET_FLAG_BRIDGE = ConvertTargetFlag(1024)
DEFENSE_TYPE_LIGHT = ConvertDefenseType(0)
DEFENSE_TYPE_MEDIUM = ConvertDefenseType(1)
DEFENSE_TYPE_LARGE = ConvertDefenseType(2)
DEFENSE_TYPE_FORT = ConvertDefenseType(3)
DEFENSE_TYPE_NORMAL = ConvertDefenseType(4)
DEFENSE_TYPE_HERO = ConvertDefenseType(5)
DEFENSE_TYPE_DIVINE = ConvertDefenseType(6)
DEFENSE_TYPE_NONE = ConvertDefenseType(7)
HERO_ATTRIBUTE_STR = ConvertHeroAttribute(1)
HERO_ATTRIBUTE_INT = ConvertHeroAttribute(2)
HERO_ATTRIBUTE_AGI = ConvertHeroAttribute(3)
ARMOR_TYPE_WHOKNOWS = ConvertArmorType(0)
ARMOR_TYPE_FLESH = ConvertArmorType(1)
ARMOR_TYPE_METAL = ConvertArmorType(2)
ARMOR_TYPE_WOOD = ConvertArmorType(3)
ARMOR_TYPE_ETHREAL = ConvertArmorType(4)
ARMOR_TYPE_STONE = ConvertArmorType(5)
REGENERATION_TYPE_NONE = ConvertRegenType(0)
REGENERATION_TYPE_ALWAYS = ConvertRegenType(1)
REGENERATION_TYPE_BLIGHT = ConvertRegenType(2)
REGENERATION_TYPE_DAY = ConvertRegenType(3)
REGENERATION_TYPE_NIGHT = ConvertRegenType(4)
UNIT_CATEGORY_GIANT = ConvertUnitCategory(1)
UNIT_CATEGORY_UNDEAD = ConvertUnitCategory(2)
UNIT_CATEGORY_SUMMONED = ConvertUnitCategory(4)
UNIT_CATEGORY_MECHANICAL = ConvertUnitCategory(8)
UNIT_CATEGORY_PEON = ConvertUnitCategory(16)
UNIT_CATEGORY_SAPPER = ConvertUnitCategory(32)
UNIT_CATEGORY_TOWNHALL = ConvertUnitCategory(64)
UNIT_CATEGORY_ANCIENT = ConvertUnitCategory(128)
UNIT_CATEGORY_NEUTRAL = ConvertUnitCategory(256)
UNIT_CATEGORY_WARD = ConvertUnitCategory(512)
UNIT_CATEGORY_STANDON = ConvertUnitCategory(1024)
UNIT_CATEGORY_TAUREN = ConvertUnitCategory(2048)
PATHING_FLAG_UNWALKABLE = ConvertPathingFlag(2)
PATHING_FLAG_UNFLYABLE = ConvertPathingFlag(4)
PATHING_FLAG_UNBUILDABLE = ConvertPathingFlag(8)
PATHING_FLAG_UNPEONHARVEST = ConvertPathingFlag(16)
PATHING_FLAG_BLIGHTED = ConvertPathingFlag(32)
PATHING_FLAG_UNFLOATABLE = ConvertPathingFlag(64)
PATHING_FLAG_UNAMPHIBIOUS = ConvertPathingFlag(128)
PATHING_FLAG_UNITEMPLACABLE = ConvertPathingFlag(256)

function Deg2Rad(degrees) end
function Rad2Deg(radians) end
function Sin(radians) end
function Cos(radians) end
function Tan(radians) end
function Asin(y) end
function Acos(x) end
function Atan(x) end
function Atan2(y, x) end
function SquareRoot(x) end
function Pow(x, power) end
function I2R(i) end
function R2I(r) end
function I2S(i) end
function R2S(r) end
function R2SW(r, width, precision) end
function S2I(s) end
function S2R(s) end
function GetHandleId(h) end
function SubString(source, startPos, endPos) end
function StringLength(s) end
function StringCase(source, upper) end
function StringHash(s) end
function GetLocalizedString(source) end
function GetLocalizedHotkey(source) end
function SetMapName(name) end
function SetMapDescription(description) end
function SetTeams(teamcount) end
function SetPlayers(playercount) end
function DefineStartLocation(whichStartLoc, x, y) end
function DefineStartLocationLoc(whichStartLoc, whichLocation) end
function SetStartLocPrioCount(whichStartLoc, prioSlotCount) end
function SetStartLocPrio(whichStartLoc, prioSlotIndex, otherStartLocIndex, priority) end
function GetStartLocPrioSlot(whichStartLoc, prioSlotIndex) end
function GetStartLocPrio(whichStartLoc, prioSlotIndex) end
function SetGameTypeSupported(whichGameType, value) end
function SetMapFlag(whichMapFlag, value) end
function SetGamePlacement(whichPlacementType) end
function SetGameSpeed(whichspeed) end
function SetGameDifficulty(whichdifficulty) end
function SetResourceDensity(whichdensity) end
function SetCreatureDensity(whichdensity) end
function GetTeams() end
function GetPlayers() end
function IsGameTypeSupported(whichGameType) end
function GetGameTypeSelected() end
function IsMapFlagSet(whichMapFlag) end
function GetGamePlacement() end
function GetGameSpeed() end
function GetGameDifficulty() end
function GetResourceDensity() end
function GetCreatureDensity() end
function GetStartLocationX(whichStartLocation) end
function GetStartLocationY(whichStartLocation) end
function GetStartLocationLoc(whichStartLocation) end
function SetPlayerTeam(whichPlayer, whichTeam) end
function SetPlayerStartLocation(whichPlayer, startLocIndex) end
function ForcePlayerStartLocation(whichPlayer, startLocIndex) end
function SetPlayerColor(whichPlayer, color) end
function SetPlayerAlliance(sourcePlayer, otherPlayer, whichAllianceSetting, value) end
function SetPlayerTaxRate(sourcePlayer, otherPlayer, whichResource, rate) end
function SetPlayerRacePreference(whichPlayer, whichRacePreference) end
function SetPlayerRaceSelectable(whichPlayer, value) end
function SetPlayerController(whichPlayer, controlType) end
function SetPlayerName(whichPlayer, name) end
function SetPlayerOnScoreScreen(whichPlayer, flag) end
function GetPlayerTeam(whichPlayer) end
function GetPlayerStartLocation(whichPlayer) end
function GetPlayerColor(whichPlayer) end
function GetPlayerSelectable(whichPlayer) end
function GetPlayerController(whichPlayer) end
function GetPlayerSlotState(whichPlayer) end
function GetPlayerTaxRate(sourcePlayer, otherPlayer, whichResource) end
function IsPlayerRacePrefSet(whichPlayer, pref) end
function GetPlayerName(whichPlayer) end
function CreateTimer() end
function DestroyTimer(whichTimer) end
function TimerStart(whichTimer, timeout, periodic, handlerFunc) end
function TimerGetElapsed(whichTimer) end
function TimerGetRemaining(whichTimer) end
function TimerGetTimeout(whichTimer) end
function PauseTimer(whichTimer) end
function ResumeTimer(whichTimer) end
function GetExpiredTimer() end
function CreateGroup() end
function DestroyGroup(whichGroup) end
function GroupAddUnit(whichGroup, whichUnit) end
function GroupRemoveUnit(whichGroup, whichUnit) end
function BlzGroupAddGroupFast(whichGroup, addGroup) end
function BlzGroupRemoveGroupFast(whichGroup, removeGroup) end
function GroupClear(whichGroup) end
function BlzGroupGetSize(whichGroup) end
function BlzGroupUnitAt(whichGroup, index) end
function GroupEnumUnitsOfType(whichGroup, unitname, filter) end
function GroupEnumUnitsOfPlayer(whichGroup, whichPlayer, filter) end
function GroupEnumUnitsOfTypeCounted(whichGroup, unitname, filter, countLimit) end
function GroupEnumUnitsInRect(whichGroup, r, filter) end
function GroupEnumUnitsInRectCounted(whichGroup, r, filter, countLimit) end
function GroupEnumUnitsInRange(whichGroup, x, y, radius, filter) end
function GroupEnumUnitsInRangeOfLoc(whichGroup, whichLocation, radius, filter) end
function GroupEnumUnitsInRangeCounted(whichGroup, x, y, radius, filter, countLimit) end
function GroupEnumUnitsInRangeOfLocCounted(whichGroup, whichLocation, radius, filter, countLimit) end
function GroupEnumUnitsSelected(whichGroup, whichPlayer, filter) end
function GroupImmediateOrder(whichGroup, order) end
function GroupImmediateOrderById(whichGroup, order) end
function GroupPointOrder(whichGroup, order, x, y) end
function GroupPointOrderLoc(whichGroup, order, whichLocation) end
function GroupPointOrderById(whichGroup, order, x, y) end
function GroupPointOrderByIdLoc(whichGroup, order, whichLocation) end
function GroupTargetOrder(whichGroup, order, targetWidget) end
function GroupTargetOrderById(whichGroup, order, targetWidget) end
function ForGroup(whichGroup, callback) end
function FirstOfGroup(whichGroup) end
function CreateForce() end
function DestroyForce(whichForce) end
function ForceAddPlayer(whichForce, whichPlayer) end
function ForceRemovePlayer(whichForce, whichPlayer) end
function BlzForceHasPlayer(whichForce, whichPlayer) end
function ForceClear(whichForce) end
function ForceEnumPlayers(whichForce, filter) end
function ForceEnumPlayersCounted(whichForce, filter, countLimit) end
function ForceEnumAllies(whichForce, whichPlayer, filter) end
function ForceEnumEnemies(whichForce, whichPlayer, filter) end
function ForForce(whichForce, callback) end
function Rect(minx, miny, maxx, maxy) end
function RectFromLoc(min, max) end
function RemoveRect(whichRect) end
function SetRect(whichRect, minx, miny, maxx, maxy) end
function SetRectFromLoc(whichRect, min, max) end
function MoveRectTo(whichRect, newCenterX, newCenterY) end
function MoveRectToLoc(whichRect, newCenterLoc) end
function GetRectCenterX(whichRect) end
function GetRectCenterY(whichRect) end
function GetRectMinX(whichRect) end
function GetRectMinY(whichRect) end
function GetRectMaxX(whichRect) end
function GetRectMaxY(whichRect) end
function CreateRegion() end
function RemoveRegion(whichRegion) end
function RegionAddRect(whichRegion, r) end
function RegionClearRect(whichRegion, r) end
function RegionAddCell(whichRegion, x, y) end
function RegionAddCellAtLoc(whichRegion, whichLocation) end
function RegionClearCell(whichRegion, x, y) end
function RegionClearCellAtLoc(whichRegion, whichLocation) end
function Location(x, y) end
function RemoveLocation(whichLocation) end
function MoveLocation(whichLocation, newX, newY) end
function GetLocationX(whichLocation) end
function GetLocationY(whichLocation) end
function GetLocationZ(whichLocation) end
function IsUnitInRegion(whichRegion, whichUnit) end
function IsPointInRegion(whichRegion, x, y) end
function IsLocationInRegion(whichRegion, whichLocation) end
function GetWorldBounds() end
function CreateTrigger() end
function DestroyTrigger(whichTrigger) end
function ResetTrigger(whichTrigger) end
function EnableTrigger(whichTrigger) end
function DisableTrigger(whichTrigger) end
function IsTriggerEnabled(whichTrigger) end
function TriggerWaitOnSleeps(whichTrigger, flag) end
function IsTriggerWaitOnSleeps(whichTrigger) end
function GetFilterUnit() end
function GetEnumUnit() end
function GetFilterDestructable() end
function GetEnumDestructable() end
function GetFilterItem() end
function GetEnumItem() end
function GetFilterPlayer() end
function GetEnumPlayer() end
function GetTriggeringTrigger() end
function GetTriggerEventId() end
function GetTriggerEvalCount(whichTrigger) end
function GetTriggerExecCount(whichTrigger) end
function ExecuteFunc(funcName) end
function And(operandA, operandB) end
function Or(operandA, operandB) end
function Not(operand) end
function Condition(func) end
function DestroyCondition(c) end
function Filter(func) end
function DestroyFilter(f) end
function DestroyBoolExpr(e) end
function TriggerRegisterVariableEvent(whichTrigger, varName, opcode, limitval) end
function TriggerRegisterTimerEvent(whichTrigger, timeout, periodic) end
function TriggerRegisterTimerExpireEvent(whichTrigger, t) end
function TriggerRegisterGameStateEvent(whichTrigger, whichState, opcode, limitval) end
function TriggerRegisterDialogEvent(whichTrigger, whichDialog) end
function TriggerRegisterDialogButtonEvent(whichTrigger, whichButton) end
function GetEventGameState() end
function TriggerRegisterGameEvent(whichTrigger, whichGameEvent) end
  
function GetWinningPlayer() end
function TriggerRegisterEnterRegion(whichTrigger, whichRegion, filter) end
function GetTriggeringRegion() end
function GetEnteringUnit() end
function TriggerRegisterLeaveRegion(whichTrigger, whichRegion, filter) end
function GetLeavingUnit() end
function TriggerRegisterTrackableHitEvent(whichTrigger, t) end
function TriggerRegisterTrackableTrackEvent(whichTrigger, t) end
function GetTriggeringTrackable() end
function GetClickedButton() end
function GetClickedDialog() end
function GetTournamentFinishSoonTimeRemaining() end
function GetTournamentFinishNowRule() end
function GetTournamentFinishNowPlayer() end
function GetTournamentScore(whichPlayer) end
function GetSaveBasicFilename() end
function TriggerRegisterPlayerEvent(whichTrigger, whichPlayer, whichPlayerEvent) end
function GetTriggerPlayer() end
function TriggerRegisterPlayerUnitEvent(whichTrigger, whichPlayer, whichPlayerUnitEvent, filter) end
function GetLevelingUnit() end
function GetLearningUnit() end
function GetLearnedSkill() end
function GetLearnedSkillLevel() end
function GetRevivableUnit() end
function GetRevivingUnit() end
function GetAttacker() end
function GetRescuer() end
function GetDyingUnit() end
function GetKillingUnit() end
function GetDecayingUnit() end
function GetConstructingStructure() end
function GetCancelledStructure() end
function GetConstructedStructure() end
function GetResearchingUnit() end
function GetResearched() end
function GetTrainedUnitType() end
function GetTrainedUnit() end
function GetDetectedUnit() end
function GetSummoningUnit() end
function GetSummonedUnit() end
function GetTransportUnit() end
function GetLoadedUnit() end
function GetSellingUnit() end
function GetSoldUnit() end
function GetBuyingUnit() end
function GetSoldItem() end
function GetChangingUnit() end
function GetChangingUnitPrevOwner() end
function GetManipulatingUnit() end
function GetManipulatedItem() end
function GetOrderedUnit() end
function GetIssuedOrderId() end
function GetOrderPointX() end
function GetOrderPointY() end
function GetOrderPointLoc() end
function GetOrderTarget() end
function GetOrderTargetDestructable() end
function GetOrderTargetItem() end
function GetOrderTargetUnit() end
function GetSpellAbilityUnit() end
function GetSpellAbilityId() end
function GetSpellAbility() end
function GetSpellTargetLoc() end
function GetSpellTargetX() end
function GetSpellTargetY() end
function GetSpellTargetDestructable() end
function GetSpellTargetItem() end
function GetSpellTargetUnit() end
function TriggerRegisterPlayerAllianceChange(whichTrigger, whichPlayer, whichAlliance) end
function TriggerRegisterPlayerStateEvent(whichTrigger, whichPlayer, whichState, opcode, limitval) end
function GetEventPlayerState() end
function TriggerRegisterPlayerChatEvent(whichTrigger, whichPlayer, chatMessageToDetect, exactMatchOnly) end
function GetEventPlayerChatString() end
function GetEventPlayerChatStringMatched() end
function TriggerRegisterDeathEvent(whichTrigger, whichWidget) end
function GetTriggerUnit() end
function TriggerRegisterUnitStateEvent(whichTrigger, whichUnit, whichState, opcode, limitval) end
function GetEventUnitState() end
function TriggerRegisterUnitEvent(whichTrigger, whichUnit, whichEvent) end
function GetEventDamage() end
function GetEventDamageSource() end
function GetEventDetectingPlayer() end
function TriggerRegisterFilterUnitEvent(whichTrigger, whichUnit, whichEvent, filter) end
function GetEventTargetUnit() end
function TriggerRegisterUnitInRange(whichTrigger, whichUnit, range, filter) end
function TriggerAddCondition(whichTrigger, condition) end
function TriggerRemoveCondition(whichTrigger, whichCondition) end
function TriggerClearConditions(whichTrigger) end
function TriggerAddAction(whichTrigger, actionFunc) end
function TriggerRemoveAction(whichTrigger, whichAction) end
function TriggerClearActions(whichTrigger) end
function TriggerSleepAction(timeout) end
function TriggerWaitForSound(s, offset) end
function TriggerEvaluate(whichTrigger) end
function TriggerExecute(whichTrigger) end
function TriggerExecuteWait(whichTrigger) end
function TriggerSyncStart() end
function TriggerSyncReady() end
function GetWidgetLife(whichWidget) end
function SetWidgetLife(whichWidget, newLife) end
function GetWidgetX(whichWidget) end
function GetWidgetY(whichWidget) end
function GetTriggerWidget() end
function CreateDestructable(objectid, x, y, face, scale, variation) end
function CreateDestructableZ(objectid, x, y, z, face, scale, variation) end
function CreateDeadDestructable(objectid, x, y, face, scale, variation) end
function CreateDeadDestructableZ(objectid, x, y, z, face, scale, variation) end
function RemoveDestructable(d) end
function KillDestructable(d) end
function SetDestructableInvulnerable(d, flag) end
function IsDestructableInvulnerable(d) end
function EnumDestructablesInRect(r, filter, actionFunc) end
function GetDestructableTypeId(d) end
function GetDestructableX(d) end
function GetDestructableY(d) end
function SetDestructableLife(d, life) end
function GetDestructableLife(d) end
function SetDestructableMaxLife(d, max) end
function GetDestructableMaxLife(d) end
function DestructableRestoreLife(d, life, birth) end
function QueueDestructableAnimation(d, whichAnimation) end
function SetDestructableAnimation(d, whichAnimation) end
function SetDestructableAnimationSpeed(d, speedFactor) end
function ShowDestructable(d, flag) end
function GetDestructableOccluderHeight(d) end
function SetDestructableOccluderHeight(d, height) end
function GetDestructableName(d) end
function GetTriggerDestructable() end
function CreateItem(itemid, x, y) end
function RemoveItem(whichItem) end
function GetItemPlayer(whichItem) end
function GetItemTypeId(i) end
function GetItemX(i) end
function GetItemY(i) end
function SetItemPosition(i, x, y) end
function SetItemDropOnDeath(whichItem, flag) end
function SetItemDroppable(i, flag) end
function SetItemPawnable(i, flag) end
function SetItemPlayer(whichItem, whichPlayer, changeColor) end
function SetItemInvulnerable(whichItem, flag) end
function IsItemInvulnerable(whichItem) end
function SetItemVisible(whichItem, show) end
function IsItemVisible(whichItem) end
function IsItemOwned(whichItem) end
function IsItemPowerup(whichItem) end
function IsItemSellable(whichItem) end
function IsItemPawnable(whichItem) end
function IsItemIdPowerup(itemId) end
function IsItemIdSellable(itemId) end
function IsItemIdPawnable(itemId) end
function EnumItemsInRect(r, filter, actionFunc) end
function GetItemLevel(whichItem) end
function GetItemType(whichItem) end
function SetItemDropID(whichItem, unitId) end
function GetItemName(whichItem) end
function GetItemCharges(whichItem) end
function SetItemCharges(whichItem, charges) end
function GetItemUserData(whichItem) end
function SetItemUserData(whichItem, data) end
function CreateUnit(id, unitid, x, y, face) end
function CreateUnitByName(whichPlayer, unitname, x, y, face) end
function CreateUnitAtLoc(id, unitid, whichLocation, face) end
function CreateUnitAtLocByName(id, unitname, whichLocation, face) end
function CreateCorpse(whichPlayer, unitid, x, y, face) end
function KillUnit(whichUnit) end
function RemoveUnit(whichUnit) end
function ShowUnit(whichUnit, show) end
function SetUnitState(whichUnit, whichUnitState, newVal) end
function SetUnitX(whichUnit, newX) end
function SetUnitY(whichUnit, newY) end
function SetUnitPosition(whichUnit, newX, newY) end
function SetUnitPositionLoc(whichUnit, whichLocation) end
function SetUnitFacing(whichUnit, facingAngle) end
function SetUnitFacingTimed(whichUnit, facingAngle, duration) end
function SetUnitMoveSpeed(whichUnit, newSpeed) end
function SetUnitFlyHeight(whichUnit, newHeight, rate) end
function SetUnitTurnSpeed(whichUnit, newTurnSpeed) end
function SetUnitPropWindow(whichUnit, newPropWindowAngle) end
function SetUnitAcquireRange(whichUnit, newAcquireRange) end
function SetUnitCreepGuard(whichUnit, creepGuard) end
function GetUnitAcquireRange(whichUnit) end
function GetUnitTurnSpeed(whichUnit) end
function GetUnitPropWindow(whichUnit) end
function GetUnitFlyHeight(whichUnit) end
function GetUnitDefaultAcquireRange(whichUnit) end
function GetUnitDefaultTurnSpeed(whichUnit) end
function GetUnitDefaultPropWindow(whichUnit) end
function GetUnitDefaultFlyHeight(whichUnit) end
function SetUnitOwner(whichUnit, whichPlayer, changeColor) end
function SetUnitColor(whichUnit, whichColor) end
function SetUnitScale(whichUnit, scaleX, scaleY, scaleZ) end
function SetUnitTimeScale(whichUnit, timeScale) end
function SetUnitBlendTime(whichUnit, blendTime) end
function SetUnitVertexColor(whichUnit, red, green, blue, alpha) end
function QueueUnitAnimation(whichUnit, whichAnimation) end
function SetUnitAnimation(whichUnit, whichAnimation) end
function SetUnitAnimationByIndex(whichUnit, whichAnimation) end
function SetUnitAnimationWithRarity(whichUnit, whichAnimation, rarity) end
function AddUnitAnimationProperties(whichUnit, animProperties, add) end
function SetUnitLookAt(whichUnit, whichBone, lookAtTarget, offsetX, offsetY, offsetZ) end
function ResetUnitLookAt(whichUnit) end
function SetUnitRescuable(whichUnit, byWhichPlayer, flag) end
function SetUnitRescueRange(whichUnit, range) end
function SetHeroStr(whichHero, newStr, permanent) end
function SetHeroAgi(whichHero, newAgi, permanent) end
function SetHeroInt(whichHero, newInt, permanent) end
function GetHeroStr(whichHero, includeBonuses) end
function GetHeroAgi(whichHero, includeBonuses) end
function GetHeroInt(whichHero, includeBonuses) end
function UnitStripHeroLevel(whichHero, howManyLevels) end
function GetHeroXP(whichHero) end
function SetHeroXP(whichHero, newXpVal, showEyeCandy) end
function GetHeroSkillPoints(whichHero) end
function UnitModifySkillPoints(whichHero, skillPointDelta) end
function AddHeroXP(whichHero, xpToAdd, showEyeCandy) end
function SetHeroLevel(whichHero, level, showEyeCandy) end
function GetHeroLevel(whichHero) end
function GetUnitLevel(whichUnit) end
function GetHeroProperName(whichHero) end
function SuspendHeroXP(whichHero, flag) end
function IsSuspendedXP(whichHero) end
function SelectHeroSkill(whichHero, abilcode) end
function GetUnitAbilityLevel(whichUnit, abilcode) end
function DecUnitAbilityLevel(whichUnit, abilcode) end
function IncUnitAbilityLevel(whichUnit, abilcode) end
function SetUnitAbilityLevel(whichUnit, abilcode, level) end
function ReviveHero(whichHero, x, y, doEyecandy) end
function ReviveHeroLoc(whichHero, loc, doEyecandy) end
function SetUnitExploded(whichUnit, exploded) end
function SetUnitInvulnerable(whichUnit, flag) end
function PauseUnit(whichUnit, flag) end
function IsUnitPaused(whichHero) end
function SetUnitPathing(whichUnit, flag) end
function ClearSelection() end
function SelectUnit(whichUnit, flag) end
function GetUnitPointValue(whichUnit) end
function GetUnitPointValueByType(unitType) end
function UnitAddItem(whichUnit, whichItem) end
function UnitAddItemById(whichUnit, itemId) end
function UnitAddItemToSlotById(whichUnit, itemId, itemSlot) end
function UnitRemoveItem(whichUnit, whichItem) end
function UnitRemoveItemFromSlot(whichUnit, itemSlot) end
function UnitHasItem(whichUnit, whichItem) end
function UnitItemInSlot(whichUnit, itemSlot) end
function UnitInventorySize(whichUnit) end
function UnitDropItemPoint(whichUnit, whichItem, x, y) end
function UnitDropItemSlot(whichUnit, whichItem, slot) end
function UnitDropItemTarget(whichUnit, whichItem, target) end
function UnitUseItem(whichUnit, whichItem) end
function UnitUseItemPoint(whichUnit, whichItem, x, y) end
function UnitUseItemTarget(whichUnit, whichItem, target) end
function GetUnitX(whichUnit) end
function GetUnitY(whichUnit) end
function GetUnitLoc(whichUnit) end
function GetUnitFacing(whichUnit) end
function GetUnitMoveSpeed(whichUnit) end
function GetUnitDefaultMoveSpeed(whichUnit) end
function GetUnitState(whichUnit, whichUnitState) end
function GetOwningPlayer(whichUnit) end
function GetUnitTypeId(whichUnit) end
function GetUnitRace(whichUnit) end
function GetUnitName(whichUnit) end
function GetUnitFoodUsed(whichUnit) end
function GetUnitFoodMade(whichUnit) end
function GetFoodMade(unitId) end
function GetFoodUsed(unitId) end
function SetUnitUseFood(whichUnit, useFood) end
function GetUnitRallyPoint(whichUnit) end
function GetUnitRallyUnit(whichUnit) end
function GetUnitRallyDestructable(whichUnit) end
function IsUnitInGroup(whichUnit, whichGroup) end
function IsUnitInForce(whichUnit, whichForce) end
function IsUnitOwnedByPlayer(whichUnit, whichPlayer) end
function IsUnitAlly(whichUnit, whichPlayer) end
function IsUnitEnemy(whichUnit, whichPlayer) end
function IsUnitVisible(whichUnit, whichPlayer) end
function IsUnitDetected(whichUnit, whichPlayer) end
function IsUnitInvisible(whichUnit, whichPlayer) end
function IsUnitFogged(whichUnit, whichPlayer) end
function IsUnitMasked(whichUnit, whichPlayer) end
function IsUnitSelected(whichUnit, whichPlayer) end
function IsUnitRace(whichUnit, whichRace) end
function IsUnitType(whichUnit, whichUnitType) end
function IsUnit(whichUnit, whichSpecifiedUnit) end
function IsUnitInRange(whichUnit, otherUnit, distance) end
function IsUnitInRangeXY(whichUnit, x, y, distance) end
function IsUnitInRangeLoc(whichUnit, whichLocation, distance) end
function IsUnitHidden(whichUnit) end
function IsUnitIllusion(whichUnit) end
function IsUnitInTransport(whichUnit, whichTransport) end
function IsUnitLoaded(whichUnit) end
function IsHeroUnitId(unitId) end
function IsUnitIdType(unitId, whichUnitType) end
function UnitShareVision(whichUnit, whichPlayer, share) end
function UnitSuspendDecay(whichUnit, suspend) end
function UnitAddType(whichUnit, whichUnitType) end
function UnitRemoveType(whichUnit, whichUnitType) end
function UnitAddAbility(whichUnit, abilityId) end
function UnitRemoveAbility(whichUnit, abilityId) end
function UnitMakeAbilityPermanent(whichUnit, permanent, abilityId) end
function UnitRemoveBuffs(whichUnit, removePositive, removeNegative) end
function UnitRemoveBuffsEx(whichUnit, removePositive, removeNegative, magic, physical, timedLife, aura, autoDispel) end
function UnitHasBuffsEx(whichUnit, removePositive, removeNegative, magic, physical, timedLife, aura, autoDispel) end
function UnitCountBuffsEx(whichUnit, removePositive, removeNegative, magic, physical, timedLife, aura, autoDispel) end
function UnitAddSleep(whichUnit, add) end
function UnitCanSleep(whichUnit) end
function UnitAddSleepPerm(whichUnit, add) end
function UnitCanSleepPerm(whichUnit) end
function UnitIsSleeping(whichUnit) end
function UnitWakeUp(whichUnit) end
function UnitApplyTimedLife(whichUnit, buffId, duration) end
function UnitIgnoreAlarm(whichUnit, flag) end
function UnitIgnoreAlarmToggled(whichUnit) end
function UnitResetCooldown(whichUnit) end
function UnitSetConstructionProgress(whichUnit, constructionPercentage) end
function UnitSetUpgradeProgress(whichUnit, upgradePercentage) end
function UnitPauseTimedLife(whichUnit, flag) end
function UnitSetUsesAltIcon(whichUnit, flag) end
function UnitDamagePoint(whichUnit, delay, radius, x, y, amount, attack, ranged, attackType, damageType, weaponType) end
function UnitDamageTarget(whichUnit, target, amount, attack, ranged, attackType, damageType, weaponType) end
function IssueImmediateOrder(whichUnit, order) end
function IssueImmediateOrderById(whichUnit, order) end
function IssuePointOrder(whichUnit, order, x, y) end
function IssuePointOrderLoc(whichUnit, order, whichLocation) end
function IssuePointOrderById(whichUnit, order, x, y) end
function IssuePointOrderByIdLoc(whichUnit, order, whichLocation) end
function IssueTargetOrder(whichUnit, order, targetWidget) end
function IssueTargetOrderById(whichUnit, order, targetWidget) end
function IssueInstantPointOrder(whichUnit, order, x, y, instantTargetWidget) end
function IssueInstantPointOrderById(whichUnit, order, x, y, instantTargetWidget) end
function IssueInstantTargetOrder(whichUnit, order, targetWidget, instantTargetWidget) end
function IssueInstantTargetOrderById(whichUnit, order, targetWidget, instantTargetWidget) end
function IssueBuildOrder(whichPeon, unitToBuild, x, y) end
function IssueBuildOrderById(whichPeon, unitId, x, y) end
function IssueNeutralImmediateOrder(forWhichPlayer, neutralStructure, unitToBuild) end
function IssueNeutralImmediateOrderById(forWhichPlayer, neutralStructure, unitId) end
function IssueNeutralPointOrder(forWhichPlayer, neutralStructure, unitToBuild, x, y) end
function IssueNeutralPointOrderById(forWhichPlayer, neutralStructure, unitId, x, y) end
function IssueNeutralTargetOrder(forWhichPlayer, neutralStructure, unitToBuild, target) end
function IssueNeutralTargetOrderById(forWhichPlayer, neutralStructure, unitId, target) end
function GetUnitCurrentOrder(whichUnit) end
function SetResourceAmount(whichUnit, amount) end
function AddResourceAmount(whichUnit, amount) end
function GetResourceAmount(whichUnit) end
function WaygateGetDestinationX(waygate) end
function WaygateGetDestinationY(waygate) end
function WaygateSetDestination(waygate, x, y) end
function WaygateActivate(waygate, activate) end
function WaygateIsActive(waygate) end
function AddItemToAllStock(itemId, currentStock, stockMax) end
function AddItemToStock(whichUnit, itemId, currentStock, stockMax) end
function AddUnitToAllStock(unitId, currentStock, stockMax) end
function AddUnitToStock(whichUnit, unitId, currentStock, stockMax) end
function RemoveItemFromAllStock(itemId) end
function RemoveItemFromStock(whichUnit, itemId) end
function RemoveUnitFromAllStock(unitId) end
function RemoveUnitFromStock(whichUnit, unitId) end
function SetAllItemTypeSlots(slots) end
function SetAllUnitTypeSlots(slots) end
function SetItemTypeSlots(whichUnit, slots) end
function SetUnitTypeSlots(whichUnit, slots) end
function GetUnitUserData(whichUnit) end
function SetUnitUserData(whichUnit, data) end
function Player(number) end
function GetLocalPlayer() end
function IsPlayerAlly(whichPlayer, otherPlayer) end
function IsPlayerEnemy(whichPlayer, otherPlayer) end
function IsPlayerInForce(whichPlayer, whichForce) end
function IsPlayerObserver(whichPlayer) end
function IsVisibleToPlayer(x, y, whichPlayer) end
function IsLocationVisibleToPlayer(whichLocation, whichPlayer) end
function IsFoggedToPlayer(x, y, whichPlayer) end
function IsLocationFoggedToPlayer(whichLocation, whichPlayer) end
function IsMaskedToPlayer(x, y, whichPlayer) end
function IsLocationMaskedToPlayer(whichLocation, whichPlayer) end
function GetPlayerRace(whichPlayer) end
function GetPlayerId(whichPlayer) end
function GetPlayerUnitCount(whichPlayer, includeIncomplete) end
function GetPlayerTypedUnitCount(whichPlayer, unitName, includeIncomplete, includeUpgrades) end
function GetPlayerStructureCount(whichPlayer, includeIncomplete) end
function GetPlayerState(whichPlayer, whichPlayerState) end
function GetPlayerScore(whichPlayer, whichPlayerScore) end
function GetPlayerAlliance(sourcePlayer, otherPlayer, whichAllianceSetting) end
function GetPlayerHandicap(whichPlayer) end
function GetPlayerHandicapXP(whichPlayer) end
function SetPlayerHandicap(whichPlayer, handicap) end
function SetPlayerHandicapXP(whichPlayer, handicap) end
function SetPlayerTechMaxAllowed(whichPlayer, techid, maximum) end
function GetPlayerTechMaxAllowed(whichPlayer, techid) end
function AddPlayerTechResearched(whichPlayer, techid, levels) end
function SetPlayerTechResearched(whichPlayer, techid, setToLevel) end
function GetPlayerTechResearched(whichPlayer, techid, specificonly) end
function GetPlayerTechCount(whichPlayer, techid, specificonly) end
function SetPlayerUnitsOwner(whichPlayer, newOwner) end
function CripplePlayer(whichPlayer, toWhichPlayers, flag) end
function SetPlayerAbilityAvailable(whichPlayer, abilid, avail) end
function SetPlayerState(whichPlayer, whichPlayerState, value) end
function RemovePlayer(whichPlayer, gameResult) end
function CachePlayerHeroData(whichPlayer) end
function SetFogStateRect(forWhichPlayer, whichState, where, useSharedVision) end
function SetFogStateRadius(forWhichPlayer, whichState, centerx, centerY, radius, useSharedVision) end
function SetFogStateRadiusLoc(forWhichPlayer, whichState, center, radius, useSharedVision) end
function FogMaskEnable(enable) end
function IsFogMaskEnabled() end
function FogEnable(enable) end
function IsFogEnabled() end
function CreateFogModifierRect(forWhichPlayer, whichState, where, useSharedVision, afterUnits) end
function CreateFogModifierRadius(forWhichPlayer, whichState, centerx, centerY, radius, useSharedVision, afterUnits) end
function CreateFogModifierRadiusLoc(forWhichPlayer, whichState, center, radius, useSharedVision, afterUnits) end
function DestroyFogModifier(whichFogModifier) end
function FogModifierStart(whichFogModifier) end
function FogModifierStop(whichFogModifier) end
function VersionGet() end
function VersionCompatible(whichVersion) end
function VersionSupported(whichVersion) end
function EndGame(doScoreScreen) end
function ChangeLevel(newLevel, doScoreScreen) end
function RestartGame(doScoreScreen) end
function ReloadGame() end
function SetCampaignMenuRace(r) end
function SetCampaignMenuRaceEx(campaignIndex) end
function ForceCampaignSelectScreen() end
function LoadGame(saveFileName, doScoreScreen) end
function SaveGame(saveFileName) end
function RenameSaveDirectory(sourceDirName, destDirName) end
function RemoveSaveDirectory(sourceDirName) end
function CopySaveGame(sourceSaveName, destSaveName) end
function SaveGameExists(saveName) end
function SyncSelections() end
function SetFloatGameState(whichFloatGameState, value) end
function GetFloatGameState(whichFloatGameState) end
function SetIntegerGameState(whichIntegerGameState, value) end
function GetIntegerGameState(whichIntegerGameState) end
function SetTutorialCleared(cleared) end
function SetMissionAvailable(campaignNumber, missionNumber, available) end
function SetCampaignAvailable(campaignNumber, available) end
function SetOpCinematicAvailable(campaignNumber, available) end
function SetEdCinematicAvailable(campaignNumber, available) end
function GetDefaultDifficulty() end
function SetDefaultDifficulty(g) end
function SetCustomCampaignButtonVisible(whichButton, visible) end
function GetCustomCampaignButtonVisible(whichButton) end
function DoNotSaveReplay() end
function DialogCreate() end
function DialogDestroy(whichDialog) end
function DialogClear(whichDialog) end
function DialogSetMessage(whichDialog, messageText) end
function DialogAddButton(whichDialog, buttonText, hotkey) end
function DialogAddQuitButton(whichDialog, doScoreScreen, buttonText, hotkey) end
function DialogDisplay(whichPlayer, whichDialog, flag) end
function ReloadGameCachesFromDisk() end
function InitGameCache(campaignFile) end
function SaveGameCache(whichCache) end
function StoreInteger(cache, missionKey, key, value) end
function StoreReal(cache, missionKey, key, value) end
function StoreBoolean(cache, missionKey, key, value) end
function StoreUnit(cache, missionKey, key, whichUnit) end
function StoreString(cache, missionKey, key, value) end
function SyncStoredInteger(cache, missionKey, key) end
function SyncStoredReal(cache, missionKey, key) end
function SyncStoredBoolean(cache, missionKey, key) end
function SyncStoredUnit(cache, missionKey, key) end
function SyncStoredString(cache, missionKey, key) end
function HaveStoredInteger(cache, missionKey, key) end
function HaveStoredReal(cache, missionKey, key) end
function HaveStoredBoolean(cache, missionKey, key) end
function HaveStoredUnit(cache, missionKey, key) end
function HaveStoredString(cache, missionKey, key) end
function FlushGameCache(cache) end
function FlushStoredMission(cache, missionKey) end
function FlushStoredInteger(cache, missionKey, key) end
function FlushStoredReal(cache, missionKey, key) end
function FlushStoredBoolean(cache, missionKey, key) end
function FlushStoredUnit(cache, missionKey, key) end
function FlushStoredString(cache, missionKey, key) end
function GetStoredInteger(cache, missionKey, key) end
function GetStoredReal(cache, missionKey, key) end
function GetStoredBoolean(cache, missionKey, key) end
function GetStoredString(cache, missionKey, key) end
function RestoreUnit(cache, missionKey, key, forWhichPlayer, x, y, facing) end
function InitHashtable() end
function SaveInteger(table, parentKey, childKey, value) end
function SaveReal(table, parentKey, childKey, value) end
function SaveBoolean(table, parentKey, childKey, value) end
function SaveStr(table, parentKey, childKey, value) end
function SavePlayerHandle(table, parentKey, childKey, whichPlayer) end
function SaveWidgetHandle(table, parentKey, childKey, whichWidget) end
function SaveDestructableHandle(table, parentKey, childKey, whichDestructable) end
function SaveItemHandle(table, parentKey, childKey, whichItem) end
function SaveUnitHandle(table, parentKey, childKey, whichUnit) end
function SaveAbilityHandle(table, parentKey, childKey, whichAbility) end
function SaveTimerHandle(table, parentKey, childKey, whichTimer) end
function SaveTriggerHandle(table, parentKey, childKey, whichTrigger) end
function SaveTriggerConditionHandle(table, parentKey, childKey, whichTriggercondition) end
function SaveTriggerActionHandle(table, parentKey, childKey, whichTriggeraction) end
function SaveTriggerEventHandle(table, parentKey, childKey, whichEvent) end
function SaveForceHandle(table, parentKey, childKey, whichForce) end
function SaveGroupHandle(table, parentKey, childKey, whichGroup) end
function SaveLocationHandle(table, parentKey, childKey, whichLocation) end
function SaveRectHandle(table, parentKey, childKey, whichRect) end
function SaveBooleanExprHandle(table, parentKey, childKey, whichBoolexpr) end
function SaveSoundHandle(table, parentKey, childKey, whichSound) end
function SaveEffectHandle(table, parentKey, childKey, whichEffect) end
function SaveUnitPoolHandle(table, parentKey, childKey, whichUnitpool) end
function SaveItemPoolHandle(table, parentKey, childKey, whichItempool) end
function SaveQuestHandle(table, parentKey, childKey, whichQuest) end
function SaveQuestItemHandle(table, parentKey, childKey, whichQuestitem) end
function SaveDefeatConditionHandle(table, parentKey, childKey, whichDefeatcondition) end
function SaveTimerDialogHandle(table, parentKey, childKey, whichTimerdialog) end
function SaveLeaderboardHandle(table, parentKey, childKey, whichLeaderboard) end
function SaveMultiboardHandle(table, parentKey, childKey, whichMultiboard) end
function SaveMultiboardItemHandle(table, parentKey, childKey, whichMultiboarditem) end
function SaveTrackableHandle(table, parentKey, childKey, whichTrackable) end
function SaveDialogHandle(table, parentKey, childKey, whichDialog) end
function SaveButtonHandle(table, parentKey, childKey, whichButton) end
function SaveTextTagHandle(table, parentKey, childKey, whichTexttag) end
function SaveLightningHandle(table, parentKey, childKey, whichLightning) end
function SaveImageHandle(table, parentKey, childKey, whichImage) end
function SaveUbersplatHandle(table, parentKey, childKey, whichUbersplat) end
function SaveRegionHandle(table, parentKey, childKey, whichRegion) end
function SaveFogStateHandle(table, parentKey, childKey, whichFogState) end
function SaveFogModifierHandle(table, parentKey, childKey, whichFogModifier) end
function SaveAgentHandle(table, parentKey, childKey, whichAgent) end
function SaveHashtableHandle(table, parentKey, childKey, whichHashtable) end
function SaveFrameHandle(table, parentKey, childKey, whichFrameHandle) end
function LoadInteger(table, parentKey, childKey) end
function LoadReal(table, parentKey, childKey) end
function LoadBoolean(table, parentKey, childKey) end
function LoadStr(table, parentKey, childKey) end
function LoadPlayerHandle(table, parentKey, childKey) end
function LoadWidgetHandle(table, parentKey, childKey) end
function LoadDestructableHandle(table, parentKey, childKey) end
function LoadItemHandle(table, parentKey, childKey) end
function LoadUnitHandle(table, parentKey, childKey) end
function LoadAbilityHandle(table, parentKey, childKey) end
function LoadTimerHandle(table, parentKey, childKey) end
function LoadTriggerHandle(table, parentKey, childKey) end
function LoadTriggerConditionHandle(table, parentKey, childKey) end
function LoadTriggerActionHandle(table, parentKey, childKey) end
function LoadTriggerEventHandle(table, parentKey, childKey) end
function LoadForceHandle(table, parentKey, childKey) end
function LoadGroupHandle(table, parentKey, childKey) end
function LoadLocationHandle(table, parentKey, childKey) end
function LoadRectHandle(table, parentKey, childKey) end
function LoadBooleanExprHandle(table, parentKey, childKey) end
function LoadSoundHandle(table, parentKey, childKey) end
function LoadEffectHandle(table, parentKey, childKey) end
function LoadUnitPoolHandle(table, parentKey, childKey) end
function LoadItemPoolHandle(table, parentKey, childKey) end
function LoadQuestHandle(table, parentKey, childKey) end
function LoadQuestItemHandle(table, parentKey, childKey) end
function LoadDefeatConditionHandle(table, parentKey, childKey) end
function LoadTimerDialogHandle(table, parentKey, childKey) end
function LoadLeaderboardHandle(table, parentKey, childKey) end
function LoadMultiboardHandle(table, parentKey, childKey) end
function LoadMultiboardItemHandle(table, parentKey, childKey) end
function LoadTrackableHandle(table, parentKey, childKey) end
function LoadDialogHandle(table, parentKey, childKey) end
function LoadButtonHandle(table, parentKey, childKey) end
function LoadTextTagHandle(table, parentKey, childKey) end
function LoadLightningHandle(table, parentKey, childKey) end
function LoadImageHandle(table, parentKey, childKey) end
function LoadUbersplatHandle(table, parentKey, childKey) end
function LoadRegionHandle(table, parentKey, childKey) end
function LoadFogStateHandle(table, parentKey, childKey) end
function LoadFogModifierHandle(table, parentKey, childKey) end
function LoadHashtableHandle(table, parentKey, childKey) end
function LoadFrameHandle(table, parentKey, childKey) end
function HaveSavedInteger(table, parentKey, childKey) end
function HaveSavedReal(table, parentKey, childKey) end
function HaveSavedBoolean(table, parentKey, childKey) end
function HaveSavedString(table, parentKey, childKey) end
function HaveSavedHandle(table, parentKey, childKey) end
function RemoveSavedInteger(table, parentKey, childKey) end
function RemoveSavedReal(table, parentKey, childKey) end
function RemoveSavedBoolean(table, parentKey, childKey) end
function RemoveSavedString(table, parentKey, childKey) end
function RemoveSavedHandle(table, parentKey, childKey) end
function FlushParentHashtable(table) end
function FlushChildHashtable(table, parentKey) end
function GetRandomInt(lowBound, highBound) end
function GetRandomReal(lowBound, highBound) end
function CreateUnitPool() end
function DestroyUnitPool(whichPool) end
function UnitPoolAddUnitType(whichPool, unitId, weight) end
function UnitPoolRemoveUnitType(whichPool, unitId) end
function PlaceRandomUnit(whichPool, forWhichPlayer, x, y, facing) end
function CreateItemPool() end
function DestroyItemPool(whichItemPool) end
function ItemPoolAddItemType(whichItemPool, itemId, weight) end
function ItemPoolRemoveItemType(whichItemPool, itemId) end
function PlaceRandomItem(whichItemPool, x, y) end
function ChooseRandomCreep(level) end
function ChooseRandomNPBuilding() end
function ChooseRandomItem(level) end
function ChooseRandomItemEx(whichType, level) end
function SetRandomSeed(seed) end
function SetTerrainFog(a, b, c, d, e) end
function ResetTerrainFog() end
function SetUnitFog(a, b, c, d, e) end
function SetTerrainFogEx(style, zstart, zend, density, red, green, blue) end
function DisplayTextToPlayer(toPlayer, x, y, message) end
function DisplayTimedTextToPlayer(toPlayer, x, y, duration, message) end
function DisplayTimedTextFromPlayer(toPlayer, x, y, duration, message) end
function ClearTextMessages() end
function SetDayNightModels(terrainDNCFile, unitDNCFile) end
function SetSkyModel(skyModelFile) end
function EnableUserControl(b) end
function EnableUserUI(b) end
function SuspendTimeOfDay(b) end
function SetTimeOfDayScale(r) end
function GetTimeOfDayScale() end
function ShowInterface(flag, fadeDuration) end
function PauseGame(flag) end
function UnitAddIndicator(whichUnit, red, green, blue, alpha) end
function AddIndicator(whichWidget, red, green, blue, alpha) end
function PingMinimap(x, y, duration) end
function PingMinimapEx(x, y, duration, red, green, blue, extraEffects) end
function EnableOcclusion(flag) end
function SetIntroShotText(introText) end
function SetIntroShotModel(introModelPath) end
function EnableWorldFogBoundary(b) end
function PlayModelCinematic(modelName) end
function PlayCinematic(movieName) end
function ForceUIKey(key) end
function ForceUICancel() end
function DisplayLoadDialog() end
function SetAltMinimapIcon(iconPath) end
function DisableRestartMission(flag) end
function CreateTextTag() end
function DestroyTextTag(t) end
function SetTextTagText(t, s, height) end
function SetTextTagPos(t, x, y, heightOffset) end
function SetTextTagPosUnit(t, whichUnit, heightOffset) end
function SetTextTagColor(t, red, green, blue, alpha) end
function SetTextTagVelocity(t, xvel, yvel) end
function SetTextTagVisibility(t, flag) end
function SetTextTagSuspended(t, flag) end
function SetTextTagPermanent(t, flag) end
function SetTextTagAge(t, age) end
function SetTextTagLifespan(t, lifespan) end
function SetTextTagFadepoint(t, fadepoint) end
function SetReservedLocalHeroButtons(reserved) end
function GetAllyColorFilterState() end
function SetAllyColorFilterState(state) end
function GetCreepCampFilterState() end
function SetCreepCampFilterState(state) end
function EnableMinimapFilterButtons(enableAlly, enableCreep) end
function EnableDragSelect(state, ui) end
function EnablePreSelect(state, ui) end
function EnableSelect(state, ui) end
function CreateTrackable(trackableModelPath, x, y, facing) end
function CreateQuest() end
function DestroyQuest(whichQuest) end
function QuestSetTitle(whichQuest, title) end
function QuestSetDescription(whichQuest, description) end
function QuestSetIconPath(whichQuest, iconPath) end
function QuestSetRequired(whichQuest, required) end
function QuestSetCompleted(whichQuest, completed) end
function QuestSetDiscovered(whichQuest, discovered) end
function QuestSetFailed(whichQuest, failed) end
function QuestSetEnabled(whichQuest, enabled) end
function IsQuestRequired(whichQuest) end
function IsQuestCompleted(whichQuest) end
function IsQuestDiscovered(whichQuest) end
function IsQuestFailed(whichQuest) end
function IsQuestEnabled(whichQuest) end
function QuestCreateItem(whichQuest) end
function QuestItemSetDescription(whichQuestItem, description) end
function QuestItemSetCompleted(whichQuestItem, completed) end
function IsQuestItemCompleted(whichQuestItem) end
function CreateDefeatCondition() end
function DestroyDefeatCondition(whichCondition) end
function DefeatConditionSetDescription(whichCondition, description) end
function FlashQuestDialogButton() end
function ForceQuestDialogUpdate() end
function CreateTimerDialog(t) end
function DestroyTimerDialog(whichDialog) end
function TimerDialogSetTitle(whichDialog, title) end
function TimerDialogSetTitleColor(whichDialog, red, green, blue, alpha) end
function TimerDialogSetTimeColor(whichDialog, red, green, blue, alpha) end
function TimerDialogSetSpeed(whichDialog, speedMultFactor) end
function TimerDialogDisplay(whichDialog, display) end
function IsTimerDialogDisplayed(whichDialog) end
function TimerDialogSetRealTimeRemaining(whichDialog, timeRemaining) end
function CreateLeaderboard() end
function DestroyLeaderboard(lb) end
function LeaderboardDisplay(lb, show) end
function IsLeaderboardDisplayed(lb) end
function LeaderboardGetItemCount(lb) end
function LeaderboardSetSizeByItemCount(lb, count) end
function LeaderboardAddItem(lb, label, value, p) end
function LeaderboardRemoveItem(lb, index) end
function LeaderboardRemovePlayerItem(lb, p) end
function LeaderboardClear(lb) end
function LeaderboardSortItemsByValue(lb, ascending) end
function LeaderboardSortItemsByPlayer(lb, ascending) end
function LeaderboardSortItemsByLabel(lb, ascending) end
function LeaderboardHasPlayerItem(lb, p) end
function LeaderboardGetPlayerIndex(lb, p) end
function LeaderboardSetLabel(lb, label) end
function LeaderboardGetLabelText(lb) end
function PlayerSetLeaderboard(toPlayer, lb) end
function PlayerGetLeaderboard(toPlayer) end
function LeaderboardSetLabelColor(lb, red, green, blue, alpha) end
function LeaderboardSetValueColor(lb, red, green, blue, alpha) end
function LeaderboardSetStyle(lb, showLabel, showNames, showValues, showIcons) end
function LeaderboardSetItemValue(lb, whichItem, val) end
function LeaderboardSetItemLabel(lb, whichItem, val) end
function LeaderboardSetItemStyle(lb, whichItem, showLabel, showValue, showIcon) end
function LeaderboardSetItemLabelColor(lb, whichItem, red, green, blue, alpha) end
function LeaderboardSetItemValueColor(lb, whichItem, red, green, blue, alpha) end
function CreateMultiboard() end
function DestroyMultiboard(lb) end
function MultiboardDisplay(lb, show) end
function IsMultiboardDisplayed(lb) end
function MultiboardMinimize(lb, minimize) end
function IsMultiboardMinimized(lb) end
function MultiboardClear(lb) end
function MultiboardSetTitleText(lb, label) end
function MultiboardGetTitleText(lb) end
function MultiboardSetTitleTextColor(lb, red, green, blue, alpha) end
function MultiboardGetRowCount(lb) end
function MultiboardGetColumnCount(lb) end
function MultiboardSetColumnCount(lb, count) end
function MultiboardSetRowCount(lb, count) end
function MultiboardSetItemsStyle(lb, showValues, showIcons) end
function MultiboardSetItemsValue(lb, value) end
function MultiboardSetItemsValueColor(lb, red, green, blue, alpha) end
function MultiboardSetItemsWidth(lb, width) end
function MultiboardSetItemsIcon(lb, iconPath) end
function MultiboardGetItem(lb, row, column) end
function MultiboardReleaseItem(mbi) end
function MultiboardSetItemStyle(mbi, showValue, showIcon) end
function MultiboardSetItemValue(mbi, val) end
function MultiboardSetItemValueColor(mbi, red, green, blue, alpha) end
function MultiboardSetItemWidth(mbi, width) end
function MultiboardSetItemIcon(mbi, iconFileName) end
function MultiboardSuppressDisplay(flag) end
function SetCameraPosition(x, y) end
function SetCameraQuickPosition(x, y) end
function SetCameraBounds(x1, y1, x2, y2, x3, y3, x4, y4) end
function StopCamera() end
function ResetToGameCamera(duration) end
function PanCameraTo(x, y) end
function PanCameraToTimed(x, y, duration) end
function PanCameraToWithZ(x, y, zOffsetDest) end
function PanCameraToTimedWithZ(x, y, zOffsetDest, duration) end
function SetCinematicCamera(cameraModelFile) end
function SetCameraRotateMode(x, y, radiansToSweep, duration) end
function SetCameraField(whichField, value, duration) end
function AdjustCameraField(whichField, offset, duration) end
function SetCameraTargetController(whichUnit, xoffset, yoffset, inheritOrientation) end
function SetCameraOrientController(whichUnit, xoffset, yoffset) end
function CreateCameraSetup() end
function CameraSetupSetField(whichSetup, whichField, value, duration) end
function CameraSetupGetField(whichSetup, whichField) end
function CameraSetupSetDestPosition(whichSetup, x, y, duration) end
function CameraSetupGetDestPositionLoc(whichSetup) end
function CameraSetupGetDestPositionX(whichSetup) end
function CameraSetupGetDestPositionY(whichSetup) end
function CameraSetupApply(whichSetup, doPan, panTimed) end
function CameraSetupApplyWithZ(whichSetup, zDestOffset) end
function CameraSetupApplyForceDuration(whichSetup, doPan, forceDuration) end
function CameraSetupApplyForceDurationWithZ(whichSetup, zDestOffset, forceDuration) end
function CameraSetTargetNoise(mag, velocity) end
function CameraSetSourceNoise(mag, velocity) end
function CameraSetTargetNoiseEx(mag, velocity, vertOnly) end
function CameraSetSourceNoiseEx(mag, velocity, vertOnly) end
function CameraSetSmoothingFactor(factor) end
function SetCineFilterTexture(filename) end
function SetCineFilterBlendMode(whichMode) end
function SetCineFilterTexMapFlags(whichFlags) end
function SetCineFilterStartUV(minu, minv, maxu, maxv) end
function SetCineFilterEndUV(minu, minv, maxu, maxv) end
function SetCineFilterStartColor(red, green, blue, alpha) end
function SetCineFilterEndColor(red, green, blue, alpha) end
function SetCineFilterDuration(duration) end
function DisplayCineFilter(flag) end
function IsCineFilterDisplayed() end
function SetCinematicScene(portraitUnitId, color, speakerTitle, text, sceneDuration, voiceoverDuration) end
function EndCinematicScene() end
function ForceCinematicSubtitles(flag) end
function GetCameraMargin(whichMargin) end
function GetCameraBoundMinX() end
function GetCameraBoundMinY() end
function GetCameraBoundMaxX() end
function GetCameraBoundMaxY() end
function GetCameraField(whichField) end
function GetCameraTargetPositionX() end
function GetCameraTargetPositionY() end
function GetCameraTargetPositionZ() end
function GetCameraTargetPositionLoc() end
function GetCameraEyePositionX() end
function GetCameraEyePositionY() end
function GetCameraEyePositionZ() end
function GetCameraEyePositionLoc() end
function NewSoundEnvironment(environmentName) end
function CreateSound(fileName, looping, is3D, stopwhenoutofrange, fadeInRate, fadeOutRate, eaxSetting) end
function CreateSoundFilenameWithLabel(fileName, looping, is3D, stopwhenoutofrange, fadeInRate, fadeOutRate, SLKEntryName) end
function CreateSoundFromLabel(soundLabel, looping, is3D, stopwhenoutofrange, fadeInRate, fadeOutRate) end
function CreateMIDISound(soundLabel, fadeInRate, fadeOutRate) end
function SetSoundParamsFromLabel(soundHandle, soundLabel) end
function SetSoundDistanceCutoff(soundHandle, cutoff) end
function SetSoundChannel(soundHandle, channel) end
function SetSoundVolume(soundHandle, volume) end
function SetSoundPitch(soundHandle, pitch) end
function SetSoundPlayPosition(soundHandle, millisecs) end
function SetSoundDistances(soundHandle, minDist, maxDist) end
function SetSoundConeAngles(soundHandle, inside, outside, outsideVolume) end
function SetSoundConeOrientation(soundHandle, x, y, z) end
function SetSoundPosition(soundHandle, x, y, z) end
function SetSoundVelocity(soundHandle, x, y, z) end
function AttachSoundToUnit(soundHandle, whichUnit) end
function StartSound(soundHandle) end
function StopSound(soundHandle, killWhenDone, fadeOut) end
function KillSoundWhenDone(soundHandle) end
function SetMapMusic(musicName, random, index) end
function ClearMapMusic() end
function PlayMusic(musicName) end
function PlayMusicEx(musicName, frommsecs, fadeinmsecs) end
function StopMusic(fadeOut) end
function ResumeMusic() end
function PlayThematicMusic(musicFileName) end
function PlayThematicMusicEx(musicFileName, frommsecs) end
function EndThematicMusic() end
function SetMusicVolume(volume) end
function SetMusicPlayPosition(millisecs) end
function SetThematicMusicPlayPosition(millisecs) end
function SetSoundDuration(soundHandle, duration) end
function GetSoundDuration(soundHandle) end
function GetSoundFileDuration(musicFileName) end
function VolumeGroupSetVolume(vgroup, scale) end
function VolumeGroupReset() end
function GetSoundIsPlaying(soundHandle) end
function GetSoundIsLoading(soundHandle) end
function RegisterStackedSound(soundHandle, byPosition, rectwidth, rectheight) end
function UnregisterStackedSound(soundHandle, byPosition, rectwidth, rectheight) end
function AddWeatherEffect(where, effectID) end
function RemoveWeatherEffect(whichEffect) end
function EnableWeatherEffect(whichEffect, enable) end
function TerrainDeformCrater(x, y, radius, depth, duration, permanent) end
function TerrainDeformRipple(x, y, radius, depth, duration, count, spaceWaves, timeWaves, radiusStartPct, limitNeg) end
function TerrainDeformWave(x, y, dirX, dirY, distance, speed, radius, depth, trailTime, count) end
function TerrainDeformRandom(x, y, radius, minDelta, maxDelta, duration, updateInterval) end
function TerrainDeformStop(deformation, duration) end
function TerrainDeformStopAll() end
function AddSpecialEffect(modelName, x, y) end
function AddSpecialEffectLoc(modelName, where) end
function AddSpecialEffectTarget(modelName, targetWidget, attachPointName) end
function DestroyEffect(whichEffect) end
function AddSpellEffect(abilityString, t, x, y) end
function AddSpellEffectLoc(abilityString, t, where) end
function AddSpellEffectById(abilityId, t, x, y) end
function AddSpellEffectByIdLoc(abilityId, t, where) end
function AddSpellEffectTarget(modelName, t, targetWidget, attachPoint) end
function AddSpellEffectTargetById(abilityId, t, targetWidget, attachPoint) end
function AddLightning(codeName, checkVisibility, x1, y1, x2, y2) end
function AddLightningEx(codeName, checkVisibility, x1, y1, z1, x2, y2, z2) end
function DestroyLightning(whichBolt) end
function MoveLightning(whichBolt, checkVisibility, x1, y1, x2, y2) end
function MoveLightningEx(whichBolt, checkVisibility, x1, y1, z1, x2, y2, z2) end
function GetLightningColorA(whichBolt) end
function GetLightningColorR(whichBolt) end
function GetLightningColorG(whichBolt) end
function GetLightningColorB(whichBolt) end
function SetLightningColor(whichBolt, r, g, b, a) end
function GetAbilityEffect(abilityString, t, index) end
function GetAbilityEffectById(abilityId, t, index) end
function GetAbilitySound(abilityString, t) end
function GetAbilitySoundById(abilityId, t) end
function GetTerrainCliffLevel(x, y) end
function SetWaterBaseColor(red, green, blue, alpha) end
function SetWaterDeforms(val) end
function GetTerrainType(x, y) end
function GetTerrainVariance(x, y) end
function SetTerrainType(x, y, terrainType, variation, area, shape) end
function IsTerrainPathable(x, y, t) end
function SetTerrainPathable(x, y, t, flag) end
function CreateImage(file, sizeX, sizeY, sizeZ, posX, posY, posZ, originX, originY, originZ, imageType) end
function DestroyImage(whichImage) end
function ShowImage(whichImage, flag) end
function SetImageConstantHeight(whichImage, flag, height) end
function SetImagePosition(whichImage, x, y, z) end
function SetImageColor(whichImage, red, green, blue, alpha) end
function SetImageRender(whichImage, flag) end
function SetImageRenderAlways(whichImage, flag) end
function SetImageAboveWater(whichImage, flag, useWaterAlpha) end
function SetImageType(whichImage, imageType) end
function CreateUbersplat(x, y, name, red, green, blue, alpha, forcePaused, noBirthTime) end
function DestroyUbersplat(whichSplat) end
function ResetUbersplat(whichSplat) end
function FinishUbersplat(whichSplat) end
function ShowUbersplat(whichSplat, flag) end
function SetUbersplatRender(whichSplat, flag) end
function SetUbersplatRenderAlways(whichSplat, flag) end
function SetBlight(whichPlayer, x, y, radius, addBlight) end
function SetBlightRect(whichPlayer, r, addBlight) end
function SetBlightPoint(whichPlayer, x, y, addBlight) end
function SetBlightLoc(whichPlayer, whichLocation, radius, addBlight) end
function CreateBlightedGoldmine(id, x, y, face) end
function IsPointBlighted(x, y) end
function SetDoodadAnimation(x, y, radius, doodadID, nearestOnly, animName, animRandom) end
function SetDoodadAnimationRect(r, doodadID, animName, animRandom) end
function StartMeleeAI(num, script) end
function StartCampaignAI(num, script) end
function CommandAI(num, command, data) end
function PauseCompAI(p, pause) end
function GetAIDifficulty(num) end
function RemoveGuardPosition(hUnit) end
function RecycleGuardPosition(hUnit) end
function RemoveAllGuardPositions(num) end
function Cheat(cheatStr) end
function IsNoVictoryCheat() end
function IsNoDefeatCheat() end
function Preload(filename) end
function PreloadEnd(timeout) end
function PreloadStart() end
function PreloadRefresh() end
function PreloadEndEx() end
function PreloadGenClear() end
function PreloadGenStart() end
function PreloadGenEnd(filename) end
function Preloader(filename) end
function AutomationSetTestType(testType) end
function AutomationTestStart(testName) end
function AutomationTestEnd() end
function AutomationTestingFinished() end
function BlzGetTriggerPlayerMouseX() end
function BlzGetTriggerPlayerMouseY() end
function BlzGetTriggerPlayerMousePosition() end
function BlzGetTriggerPlayerMouseButton() end
function BlzSetAbilityTooltip(abilCode, tooltip, level) end
function BlzSetAbilityActivatedTooltip(abilCode, tooltip, level) end
function BlzSetAbilityExtendedTooltip(abilCode, extendedTooltip, level) end
function BlzSetAbilityActivatedExtendedTooltip(abilCode, extendedTooltip, level) end
function BlzSetAbilityResearchTooltip(abilCode, researchTooltip, level) end
function BlzSetAbilityResearchExtendedTooltip(abilCode, researchExtendedTooltip, level) end
function BlzGetAbilityTooltip(abilCode, level) end
function BlzGetAbilityActivatedTooltip(abilCode, level) end
function BlzGetAbilityExtendedTooltip(abilCode, level) end
function BlzGetAbilityActivatedExtendedTooltip(abilCode, level) end
function BlzGetAbilityResearchTooltip(abilCode, level) end
function BlzGetAbilityResearchExtendedTooltip(abilCode, level) end
function BlzSetAbilityIcon(abilCode, iconPath) end
function BlzGetAbilityIcon(abilCode) end
function BlzSetAbilityActivatedIcon(abilCode, iconPath) end
function BlzGetAbilityActivatedIcon(abilCode) end
function BlzGetAbilityPosX(abilCode) end
function BlzGetAbilityPosY(abilCode) end
function BlzSetAbilityPosX(abilCode, x) end
function BlzSetAbilityPosY(abilCode, y) end
function BlzGetAbilityActivatedPosX(abilCode) end
function BlzGetAbilityActivatedPosY(abilCode) end
function BlzSetAbilityActivatedPosX(abilCode, x) end
function BlzSetAbilityActivatedPosY(abilCode, y) end
function BlzGetUnitMaxHP(whichUnit) end
function BlzSetUnitMaxHP(whichUnit, hp) end
function BlzGetUnitMaxMana(whichUnit) end
function BlzSetUnitMaxMana(whichUnit, mana) end
function BlzSetItemName(whichItem, name) end
function BlzSetItemDescription(whichItem, description) end
function BlzGetItemDescription(whichItem) end
function BlzSetItemTooltip(whichItem, tooltip) end
function BlzGetItemTooltip(whichItem) end
function BlzSetItemExtendedTooltip(whichItem, extendedTooltip) end
function BlzGetItemExtendedTooltip(whichItem) end
function BlzSetItemIconPath(whichItem, iconPath) end
function BlzGetItemIconPath(whichItem) end
function BlzSetUnitName(whichUnit, name) end
function BlzSetHeroProperName(whichUnit, heroProperName) end
function BlzGetUnitBaseDamage(whichUnit, weaponIndex) end
function BlzSetUnitBaseDamage(whichUnit, baseDamage, weaponIndex) end
function BlzGetUnitDiceNumber(whichUnit, weaponIndex) end
function BlzSetUnitDiceNumber(whichUnit, diceNumber, weaponIndex) end
function BlzGetUnitDiceSides(whichUnit, weaponIndex) end
function BlzSetUnitDiceSides(whichUnit, diceSides, weaponIndex) end
function BlzGetUnitAttackCooldown(whichUnit, weaponIndex) end
function BlzSetUnitAttackCooldown(whichUnit, cooldown, weaponIndex) end
function BlzSetSpecialEffectColorByPlayer(whichEffect, whichPlayer) end
function BlzSetSpecialEffectColor(whichEffect, r, g, b) end
function BlzSetSpecialEffectAlpha(whichEffect, alpha) end
function BlzSetSpecialEffectScale(whichEffect, scale) end
function BlzSetSpecialEffectPosition(whichEffect, x, y, z) end
function BlzSetSpecialEffectHeight(whichEffect, height) end
function BlzSetSpecialEffectTimeScale(whichEffect, timeScale) end
function BlzSetSpecialEffectTime(whichEffect, time) end
function BlzSetSpecialEffectOrientation(whichEffect, yaw, pitch, roll) end
function BlzSetSpecialEffectYaw(whichEffect, yaw) end
function BlzSetSpecialEffectPitch(whichEffect, pitch) end
function BlzSetSpecialEffectRoll(whichEffect, roll) end
function BlzSetSpecialEffectX(whichEffect, x) end
function BlzSetSpecialEffectY(whichEffect, y) end
function BlzSetSpecialEffectZ(whichEffect, z) end
function BlzSetSpecialEffectPositionLoc(whichEffect, loc) end
function BlzGetLocalSpecialEffectX(whichEffect) end
function BlzGetLocalSpecialEffectY(whichEffect) end
function BlzGetLocalSpecialEffectZ(whichEffect) end
function BlzSpecialEffectClearSubAnimations(whichEffect) end
function BlzSpecialEffectRemoveSubAnimation(whichEffect, whichSubAnim) end
function BlzSpecialEffectAddSubAnimation(whichEffect, whichSubAnim) end
function BlzPlaySpecialEffect(whichEffect, whichAnim) end
function BlzPlaySpecialEffectWithTimeScale(whichEffect, whichAnim, timeScale) end
function BlzGetAnimName(whichAnim) end
function BlzGetUnitArmor(whichUnit) end
function BlzSetUnitArmor(whichUnit, armorAmount) end
function BlzUnitHideAbility(whichUnit, abilId, flag) end
function BlzUnitDisableAbility(whichUnit, abilId, flag, hideUI) end
function BlzUnitCancelTimedLife(whichUnit) end
function BlzIsUnitSelectable(whichUnit) end
function BlzIsUnitInvulnerable(whichUnit) end
function BlzUnitInterruptAttack(whichUnit) end
function BlzGetUnitCollisionSize(whichUnit) end
function BlzGetAbilityManaCost(abilId, level) end
function BlzGetAbilityCooldown(abilId, level) end
function BlzSetUnitAbilityCooldown(whichUnit, abilId, level, cooldown) end
function BlzGetUnitAbilityCooldown(whichUnit, abilId, level) end
function BlzGetUnitAbilityCooldownRemaining(whichUnit, abilId) end
function BlzEndUnitAbilityCooldown(whichUnit, abilCode) end
function BlzGetUnitAbilityManaCost(whichUnit, abilId, level) end
function BlzSetUnitAbilityManaCost(whichUnit, abilId, level, manaCost) end
function BlzGetLocalUnitZ(whichUnit) end
function BlzDecPlayerTechResearched(whichPlayer, techid, levels) end
function BlzSetEventDamage(damage) end
function BlzGetEventDamageTarget() end
function BlzGetEventAttackType() end
function BlzGetEventDamageType() end
function BlzGetEventWeaponType() end
function BlzSetEventAttackType(attackType) end
function BlzSetEventDamageType(damageType) end
function BlzSetEventWeaponType(weaponType) end
function RequestExtraIntegerData(dataType, whichPlayer, param1, param2, param3, param4, param5, param6) end
function RequestExtraBooleanData(dataType, whichPlayer, param1, param2, param3, param4, param5, param6) end
function RequestExtraStringData(dataType, whichPlayer, param1, param2, param3, param4, param5, param6) end
function RequestExtraRealData(dataType, whichPlayer, param1, param2, param3, param4, param5, param6) end
function BlzGetUnitZ(whichUnit) end
function BlzEnableSelections(enableSelection, enableSelectionCircle) end
function BlzIsSelectionEnabled() end
function BlzIsSelectionCircleEnabled() end
function BlzCameraSetupApplyForceDurationSmooth(whichSetup, doPan, forcedDuration, easeInDuration, easeOutDuration, smoothFactor) end
function BlzEnableTargetIndicator(enable) end
function BlzIsTargetIndicatorEnabled() end
function BlzGetOriginFrame(frameType, index) end
function BlzEnableUIAutoPosition(enable) end
function BlzHideOriginFrames(enable) end
function BlzConvertColor(a, r, g, b) end
function BlzLoadTOCFile(TOCFile) end
function BlzCreateFrame(name, owner, priority, createContext) end
function BlzCreateSimpleFrame(name, owner, createContext) end
function BlzCreateFrameByType(typeName, name, owner, inherits, createContext) end
function BlzDestroyFrame(frame) end
function BlzFrameSetPoint(frame, point, relative, relativePoint, x, y) end
function BlzFrameSetAbsPoint(frame, point, x, y) end
function BlzFrameClearAllPoints(frame) end
function BlzFrameSetAllPoints(frame, relative) end
function BlzFrameSetVisible(frame, visible) end
function BlzFrameIsVisible(frame) end
function BlzGetFrameByName(name, createContext) end
function BlzFrameGetName(frame) end
function BlzFrameClick(frame) end
function BlzFrameSetText(frame, text) end
function BlzFrameGetText(frame) end
function BlzFrameSetTextSizeLimit(frame, size) end
function BlzFrameGetTextSizeLimit(frame) end
function BlzFrameSetTextColor(frame, color) end
function BlzFrameSetFocus(frame, flag) end
function BlzFrameSetModel(frame, modelFile, cameraIndex) end
function BlzFrameSetEnable(frame, enabled) end
function BlzFrameGetEnable(frame) end
function BlzFrameSetAlpha(frame, alpha) end
function BlzFrameGetAlpha(frame) end
function BlzFrameSetSpriteAnimate(frame, primaryProp, flags) end
function BlzFrameSetTexture(frame, texFile, flag, blend) end
function BlzFrameSetScale(frame, scale) end
function BlzFrameSetTooltip(frame, tooltip) end
function BlzFrameCageMouse(frame, enable) end
function BlzFrameSetValue(frame, value) end
function BlzFrameGetValue(frame) end
function BlzFrameSetMinMaxValue(frame, minValue, maxValue) end
function BlzFrameSetStepSize(frame, stepSize) end
function BlzFrameSetSize(frame, width, height) end
function BlzFrameSetVertexColor(frame, color) end
function BlzFrameSetLevel(frame, level) end
function BlzFrameSetParent(frame, parent) end
function BlzFrameGetParent(frame) end
function BlzFrameGetHeight(frame) end
function BlzFrameGetWidth(frame) end
function BlzFrameSetFont(frame, fileName, height, flags) end
function BlzFrameSetTextAlignment(frame, vert, horz) end
function BlzTriggerRegisterFrameEvent(whichTrigger, frame, eventId) end
function BlzGetTriggerFrame() end
function BlzGetTriggerFrameEvent() end
function BlzTriggerRegisterPlayerSyncEvent(whichTrigger, whichPlayer, prefix, fromServer) end
function BlzSendSyncData(prefix, data) end
function BlzGetTriggerSyncPrefix() end
function BlzGetTriggerSyncData() end
function BlzTriggerRegisterPlayerKeyEvent(whichTrigger, whichPlayer, key, metaKey, keyDown) end
function BlzGetTriggerPlayerKey() end
function BlzGetTriggerPlayerMetaKey() end
function BlzGetTriggerPlayerIsKeyDown() end
function BlzEnableCursor(enable) end
function BlzSetMousePos(x, y) end
function BlzGetLocalClientWidth() end
function BlzGetLocalClientHeight() end
function BlzIsLocalClientActive() end
function BlzGetMouseFocusUnit() end
function BlzChangeMinimapTerrainTex(texFile) end
function BlzGetLocale() end
function BlzGetSpecialEffectScale(whichEffect) end
function BlzSetSpecialEffectMatrixScale(whichEffect, x, y, z) end
function BlzResetSpecialEffectMatrix(whichEffect) end
function BlzGetUnitAbility(whichUnit, abilId) end
function BlzGetUnitAbilityByIndex(whichUnit, index) end
function BlzDisplayChatMessage(whichPlayer, recipient, message) end
function BlzPauseUnitEx(whichUnit, flag) end
function BlzBitOr(x, y) end
function BlzBitAnd(x, y) end
function BlzBitXor(x, y) end
function BlzGetAbilityBooleanField(whichAbility, whichField) end
function BlzGetAbilityIntegerField(whichAbility, whichField) end
function BlzGetAbilityRealField(whichAbility, whichField) end
function BlzGetAbilityStringField(whichAbility, whichField) end
function BlzGetAbilityBooleanLevelField(whichAbility, whichField, level) end
function BlzGetAbilityIntegerLevelField(whichAbility, whichField, level) end
function BlzGetAbilityRealLevelField(whichAbility, whichField, level) end
function BlzGetAbilityStringLevelField(whichAbility, whichField, level) end
function BlzGetAbilityBooleanLevelArrayField(whichAbility, whichField, level, index) end
function BlzGetAbilityIntegerLevelArrayField(whichAbility, whichField, level, index) end
function BlzGetAbilityRealLevelArrayField(whichAbility, whichField, level, index) end
function BlzGetAbilityStringLevelArrayField(whichAbility, whichField, level, index) end
function BlzSetAbilityBooleanField(whichAbility, whichField, value) end
function BlzSetAbilityIntegerField(whichAbility, whichField, value) end
function BlzSetAbilityRealField(whichAbility, whichField, value) end
function BlzSetAbilityStringField(whichAbility, whichField, value) end
function BlzSetAbilityBooleanLevelField(whichAbility, whichField, level, value) end
function BlzSetAbilityIntegerLevelField(whichAbility, whichField, level, value) end
function BlzSetAbilityRealLevelField(whichAbility, whichField, level, value) end
function BlzSetAbilityStringLevelField(whichAbility, whichField, level, value) end
function BlzSetAbilityBooleanLevelArrayField(whichAbility, whichField, level, index, value) end
function BlzSetAbilityIntegerLevelArrayField(whichAbility, whichField, level, index, value) end
function BlzSetAbilityRealLevelArrayField(whichAbility, whichField, level, index, value) end
function BlzSetAbilityStringLevelArrayField(whichAbility, whichField, level, index, value) end
function BlzAddAbilityBooleanLevelArrayField(whichAbility, whichField, level, value) end
function BlzAddAbilityIntegerLevelArrayField(whichAbility, whichField, level, value) end
function BlzAddAbilityRealLevelArrayField(whichAbility, whichField, level, value) end
function BlzAddAbilityStringLevelArrayField(whichAbility, whichField, level, value) end
function BlzRemoveAbilityBooleanLevelArrayField(whichAbility, whichField, level, value) end
function BlzRemoveAbilityIntegerLevelArrayField(whichAbility, whichField, level, value) end
function BlzRemoveAbilityRealLevelArrayField(whichAbility, whichField, level, value) end
function BlzRemoveAbilityStringLevelArrayField(whichAbility, whichField, level, value) end
function BlzGetItemAbilityByIndex(whichItem, index) end
function BlzGetItemAbility(whichItem, abilCode) end
function BlzItemAddAbility(whichItem, abilCode) end
function BlzGetItemBooleanField(whichItem, whichField) end
function BlzGetItemIntegerField(whichItem, whichField) end
function BlzGetItemRealField(whichItem, whichField) end
function BlzGetItemStringField(whichItem, whichField) end
function BlzSetItemBooleanField(whichItem, whichField, value) end
function BlzSetItemIntegerField(whichItem, whichField, value) end
function BlzSetItemRealField(whichItem, whichField, value) end
function BlzSetItemStringField(whichItem, whichField, value) end
function BlzItemRemoveAbility(whichItem, abilCode) end
function BlzGetUnitBooleanField(whichUnit, whichField) end
function BlzGetUnitIntegerField(whichUnit, whichField) end
function BlzGetUnitRealField(whichUnit, whichField) end
function BlzGetUnitStringField(whichUnit, whichField) end
function BlzSetUnitBooleanField(whichUnit, whichField, value) end
function BlzSetUnitIntegerField(whichUnit, whichField, value) end
function BlzSetUnitRealField(whichUnit, whichField, value) end
function BlzSetUnitStringField(whichUnit, whichField, value) end
function BlzGetUnitWeaponBooleanField(whichUnit, whichField, index) end
function BlzGetUnitWeaponIntegerField(whichUnit, whichField, index) end
function BlzGetUnitWeaponRealField(whichUnit, whichField, index) end
function BlzGetUnitWeaponStringField(whichUnit, whichField, index) end
function BlzSetUnitWeaponBooleanField(whichUnit, whichField, index, value) end
function BlzSetUnitWeaponIntegerField(whichUnit, whichField, index, value) end
function BlzSetUnitWeaponRealField(whichUnit, whichField, index, value) end
function BlzSetUnitWeaponStringField(whichUnit, whichField, index, value) end
