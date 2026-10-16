class TgGameTipManager extends Actor
    native(Game)
    config(GameTips)
    notplaceable
    hidecategories(Navigation);

const GT_CapturePointObjective = 99;

const GT_Dismounted = 100;

const GT_CardsOnCooldown = 101;

const GT_LeveledUp = 102;

const GT_SiegeEnginePower = 103;

const GT_CapturingPoints = 104;

const GT_Abilities = 105;

const GT_CardTypes = 106;

const GT_Level6 = 107;

const GT_HealthNugget = 108;

const GT_ChampionOverview = 109;

const GT_PushObjectiveAttack = 110;

const GT_PushObjectiveDefend = 111;

const GT_PushObjectiveEnded = 112;

const GT_FriendlySiegeEngine = 113;

const GT_EnemySiegeEngine = 114;

const GT_AssaultGameMode = 115;

const GT_CaptureThePointGameMode = 116;

const GT_ProgressPayload = 117;

const GT_ContestPayloadAttackers = 118;

const GT_ContestPayloadDefenders = 119;

const GT_PayloadTipBackwards = 120;

const GT_CheckpiointsAttackers = 121;

const GT_CheckpointsDefenders = 122;

const GT_RespawnBeacon = 123;

const GT_SurvivalMatchStarted = 124;

const GT_SurvivalFogConverging = 125;

const GT_RoundEndSurvivalOrSiege = 126;

const GT_SiegeCapturePhase = 127;

const GT_SiegeCapturedPoint = 129;

const GT_SiegeLostPoint = 130;

const GT_RoundLostSurvivalOrSiege = 131;

const GT_SiegePointSpawned = 132;

const GT_DieToCassie = 133;

const GT_DieToEvie = 134;

const GT_DieToFernando = 135;

const GT_DieToGrover = 136;

const GT_DieToKinessa = 137;

const GT_DieToPip = 138;

const GT_DieToBarikTurret = 139;

const GT_DieToRuckus = 140;

const GT_DieToSkye = 141;

const GT_DieToAndroxusDefiance = 142;

const GT_DieToAndroxusReversal = 143;

const GT_DieToBombKingSticky = 144;

const GT_DieToBombKingGrumpy = 145;

const GT_DieToBuckNetShot = 146;

const GT_DieToDrogozSalvo = 147;

const GT_DieToDrogozFireSpit = 148;

const GT_DieToGrohkChainLightning = 149;

const GT_DieToGroverAxeThrow = 150;

const GT_DieToRuckusDualFire = 151;

const GT_DieToSkyePoisonBolts = 152;

const GT_DieToYingShatter = 153;

const GT_DieToYingIllusion = 154;

const GT_DieToViktorFragGrenade = 155;

const GT_DieToUltimate = 156;

const GT_PayloadCheckpoint1ReachedAttackers = 157;

const GT_PayloadCheckpoint1ReachedDefenders = 158;

const GT_DieToDeathFog = 159;

const GT_SiegeCapturingPoint = 160;

const GT_SiegeContestingPoint = 161;

const GT_SiegeContestingPayload = 162;

const GT_SiegePayloadBackingUp = 163;

const GT_Tutorial_AimUsingMouse = 164;

const GT_Tutorial_MoveForwardsBackwards = 165;

const GT_Tutorial_MoveLeftRight = 166;

const GT_Tutorial_SpaceToJump = 167;

const GT_Tutorial_MoveOnMount = 168;

const GT_Tutorial_DismountedOnDamage = 169;

const GT_Tutorial_ChampionsRegenerateHealth = 170;

const GT_Tutorial_LMBToFire = 171;

const GT_Tutorial_RToReload = 172;

const GT_Tutorial_QToFrag = 173;

const GT_Tutorial_FToHustle = 174;

const GT_Tutorial_RMBToIronSights = 175;

const GT_Tutorial_EToUlt = 176;

const GT_Tutorial_UToLoadout = 177;

const GT_Tutorial_SelectItemTab = 178;

const GT_Tutorial_OneCardPerCategory = 179;

const GT_Tutorial_UpgradeItems = 190;

const GT_Tutorial_ItemsLastMatch = 191;

const GT_Tutorial_ActiveObjectiveMarker = 192;

const GT_Tutorial_StandToCapture = 193;

const GT_Tutorial_SuccessfulCapture = 194;

const GT_Tutorial_ProgressPayload = 195;

const GT_Tutorial_EnemiesHaltPayload = 196;

const GT_DieToAnchor = 187;

const GT_DieToMakoa = 188;

const GT_DieToMalDamba = 189;

const GT_CounteringTorvald = 198;

const GT_AutoPurchaseItems = 199;

const GT_OnslaughtGameMode = 202;

const GTP_CapturePointObjective = 1801;

const GTP_Dismounted = 1800;

const GTP_CardsOnCooldown = 1802;

const GTP_LeveledUp = 1803;

const GTP_SiegeEnginePower = 1804;

const GTP_CapturingPoints = 1805;

const GTP_Abilities = 1806;

const GTP_CardTypes = 1807;

const GTP_Level6 = 1808;

const GTP_HealthNugget = 1809;

const GTP_ChampionOverview = 1824;

const GTP_PushObjectiveAttack = 1829;

const GTP_PushObjectiveDefend = 1830;

const GTP_PushObjectiveEnded = 1831;

const GTP_FriendlySiegeEngine = 1833;

const GTP_EnemySiegeEngine = 1834;

const GTP_AssaultGameMode = 1835;

const GTP_CaptureThePointGameMode = 1836;

const GTP_ProgressPayload = 1842;

const GTP_ContestPayloadAttackers = 1843;

const GTP_ContestPayloadDefenders = 1844;

const GTP_PayloadTipBackwards = 1845;

const GTP_CheckpiointsAttackers = 1846;

const GTP_CheckpointsDefenders = 1847;

const GTP_RespawnBeacon = 1849;

const GTP_SurvivalMatchStarted = 1850;

const GTP_SurvivalFogConverging = 1851;

const GTP_RoundEndSurvivalOrSiege = 1902;

const GTP_SiegeCapturePhase = 1903;

const GTP_SiegeCapturedPoint = 1906;

const GTP_SiegeLostPoint = 1907;

const GTP_RoundLostSurvivalOrSiege = 1908;

const GTP_SiegePointSpawned = 1909;

const GTP_DieToCassie = 1910;

const GTP_DieToEvie = 1911;

const GTP_DieToFernando = 1912;

const GTP_DieToGrover = 1913;

const GTP_DieToKinessa = 1914;

const GTP_DieToPip = 1915;

const GTP_DieToBarikTurret = 1916;

const GTP_DieToRuckus = 1917;

const GTP_DieToSkye = 1918;

const GTP_DieToAndroxusDefiance = 1919;

const GTP_DieToAndroxusReversal = 1920;

const GTP_DieToBombKingSticky = 1921;

const GTP_DieToBombKingGrumpy = 1922;

const GTP_DieToBuckNetShot = 1923;

const GTP_DieToDrogozSalvo = 1924;

const GTP_DieToDrogozFireSpit = 1925;

const GTP_DieToGrohkChainLightning = 1926;

const GTP_DieToGroverAxeThrow = 1927;

const GTP_DieToRuckusDualFire = 1928;

const GTP_DieToSkyePoisonBolts = 1929;

const GTP_DieToYingShatter = 1930;

const GTP_DieToYingIllusion = 1931;

const GTP_DieToViktorFragGrenade = 1932;

const GTP_DieToUltimate = 1933;

const GTP_PayloadCheckpoint1ReachedAttackers = 1934;

const GTP_PayloadCheckpoint1ReachedDefenders = 1935;

const GTP_DieToDeathFog = 1936;

const GTP_SiegeCapturingPoint = 1937;

const GTP_SiegeContestingPoint = 1938;

const GTP_SiegeContestingPayload = 1939;

const GTP_SiegePayloadBackingUp = 1940;

const GTP_Tutorial = 1953;

const GTP_DieToAnchor = 1956;

const GTP_DieToMakoa = 1957;

const GTP_DieToMalDamba = 1958;

const GTP_CounteringTorvald = 2018;

const GTP_AutoPurchaseItems = 2021;

const GTP_OnslaughtGameMode = 2026;

const TFT_ENEMY = 10133;

const TFT_FRIENDLY = 10132;

const LOW_PRIORITY_REMINDERS_SECS = 120.f;

const MIN_TIME_ON_TOP = 5.f;

const GTT_HUD = 10634;

const GTT_HUD_POPUP = 10742;

const GTT_WORLD_TIP = 15029;

const GTT_HUD_SPECIAL = 15101;

const GTT_HUD_POPUP_NO_TITLE = 15136;

struct TipSavedState {
    var int nTipId;
    var int nMatchVisibleCount;
    var int nTotalVisibleCount;
    var float fLastVisibleTime;
    var bool nCompletedCount;
    var bool bSuppressed;
    structdefaultproperties {}
};

struct GameTipInfo {
    var int nTipId;
    var int nPriority;
    var bool bSelfSuppress;
    var float fDuration;
    var float fRemainingTime;
    var float fTimeOnTop;
    var float fMinSecondsBetweenVisible;
    var bool bRemoveOnTimer;
    var bool bDismissed;
    var bool bWaitForDismiss;
    var bool bDisplayAlways;
    var bool bPopupDisplay;
    var SoundCue PopupSoundCue;
    var TgHelpTipActor HelpTipActor;
    var int PropertyId;
    structdefaultproperties {}
};

var globalconfig array<config TipSavedState> m_TipSavedState;
var array<GameTipInfo> m_GameTipQueue;
var array<GameTipInfo> m_GameTipWorldQueue;
var array<GameTipInfo> m_GameTipSpecialQueue;
var bool m_bIsActive;
var export editinline TgAudioComponent m_AudioComponent;
var int m_nActiveTip;
var int m_nPlaySoundTip;

native function bool IsSuppressed(int nGameTipId);  // Export UTgGameTipManager::execIsSuppressed(FFrame&, void* const)

native function bool RequestHelpText(int nGameTipId, optional bool bIsFriend=true, optional bool bWaitForDismiss=false, optional Vector SpawnLocation, optional out TgHelpTipActor OutHelpTipActor);  // Export UTgGameTipManager::execRequestHelpText(FFrame&, void* const)

native function DismissHelpText(int nGameTipId, optional bool bDoNotSuppress);  // Export UTgGameTipManager::execDismissHelpText(FFrame&, void* const)

native function RemoveHelpText(int nGameTipId, bool bDoNotSuppress);  // Export UTgGameTipManager::execRemoveHelpText(FFrame&, void* const)

native function SuppressHelpText(int nGameTipId);  // Export UTgGameTipManager::execSuppressHelpText(FFrame&, void* const)

native function CompleteHelpText(int nGameTipId);  // Export UTgGameTipManager::execCompleteHelpText(FFrame&, void* const)

native function UnsuppressAllGameTips();  // Export UTgGameTipManager::execUnsuppressAllGameTips(FFrame&, void* const)

native function SetActive();  // Export UTgGameTipManager::execSetActive(FFrame&, void* const)

native function ClearSavedDataForNewRound();  // Export UTgGameTipManager::execClearSavedDataForNewRound(FFrame&, void* const)

event SortGameTipQueue(int nGameTipType) { }

function PostBeginPlay() { }

function int GameTipQueueSort(GameTipInfo A, GameTipInfo B) { }

defaultproperties
{}
