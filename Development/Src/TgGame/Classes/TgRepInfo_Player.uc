class TgRepInfo_Player extends PlayerReplicationInfo
    native(Game)
    nativereplication
    hidecategories(Navigation,Movement,Collision)
    config(Engine)
    dependson(TgObject);

const MAX_DRAWN_CARDS = 5;

const BASE_DRAWN_CARDS = 3;

const MAX_DECK_SLOTS = 5;

const MAX_MARKED_TARGETS = 5;

const CARD_PROPERTY_START = 1710;

const MAX_TRACKED_PROJECTILES = 15;

const TG_EQP_POINT_MAX = 33;

const TG_MAX_PING_INFO = 4;

const TG_ITEM_STORE_MAX = 6;

const TG_ACTIVE_ITEMS_MAX = 3;

const TG_CONSUMABLE_MAX = 2;

const TG_GENERAL_STATS_MAX = 4;

const TG_PROPS_MAX = 20;

const TG_ITEM_COUNT_MAX = 4;

const TG_SURRENDER_VOTE_NONE = 0x00;

const TG_SURRENDER_VOTE_YES = 0x01;

const TG_SURRENDER_VOTE_NO = 0x02;

const MAX_SIM_PROJ_OVERRIDES = 8;

const MAX_CORE_STATS = 18;

const MAX_STATS_DEVICES = 9;

const NUM_SCORE_TYPES = 22;

enum SCORE_TYPE {
    STYPE_REPPTS,  // 0
    STYPE_KILLS,  // 1
    STYPE_ASSISTS,  // 2
    STYPE_DAMAGETAKEN,  // 3
    STYPE_DAMAGE,  // 4
    STYPE_BUFFVALUE,  // 5
    STYPE_HEALING,  // 6
    STYPE_DEFENSE,  // 7
    STYPE_DEATHS,  // 8
    STYPE_OBJS,  // 9
    STYPE_KILLS_BOT,  // 10
    STYPE_EARNED_XP,  // 11
    STYPE_EARNED_GOLD,  // 12
    STYPE_CURRENT_GOLD,  // 13
    STYPE_GOLD_PER_MIN,  // 14
    STYPE_XP_PER_MIN,  // 15
    STYPE_PLAYER_DMG,  // 16
    STYPE_BOT_DMG,  // 17
    STYPE_STRUCT_DMG,  // 18
    STYPE_OBJ_ASSISTS,  // 19
    STYPE_KILLS_SOLO,  // 20
    STYPE_DMG_MITIGATED,  // 21
};

enum DEVICE_STATS {
    DS_ID,  // 0
    DS_DAMAGE,  // 1
    DS_HEALING,  // 2
    DS_PLAYER_KILLS,  // 3
    DS_BOT_KILLS,  // 4
    DS_DPM,  // 5
    DS_HPM,  // 6
    DS_MODE_COUNT,  // 7
    DS_BUFF_VALUE,  // 8
};

enum GAME_MODE_INSTRUCTION {
    GMI_NONE,  // 0
    GMI_CAPTURE_POINT,  // 1
    GMI_PUSH_PAYLOAD,  // 2
    GMI_DEFEND_AGAINST_PAYLOAD,  // 3
};

struct DeviceTeamInfo {
    var int Power;
    var int CurrentDeviceId;
    var int LastKnownDeviceId[TgMapTeam];
    var int CurrentDeviceCount;
    var int LastKnownDeviceCount[TgMapTeam];
    structdefaultproperties {}
};

struct SimulatedProjectileOverrides {
    var int FireModeID;
    var float RemoteProximityDist;
    var float Range;
    var float Speed;
    var float GravityScale;
    var float FireAngle;
    structdefaultproperties {}
};

struct MarkedTargetInfo {
    var int PawnId;
    var int Count;
    structdefaultproperties {}
};

struct DeckCardData {
    var int nDeviceId;
    var int nPlayerId;
    structdefaultproperties {}
};

struct PlayOfTheGameEventData {
    var TgObject.EPlayOfTheGameEventType EventType;
    var float TimeStamp;
    var float WeightedRating;
    structdefaultproperties {}
};

struct PlayOfTheGameEventCounter {
    var TgObject.EPlayOfTheGameEventType EventType;
    var float Threshold;
    var float Counter;
    var float TimeOut;
    var float Timer;
    structdefaultproperties {}
};

struct TrackedProjectileInitData {
    var int FireModeID;
    var int ProjectileId;
    var Vector SpawnLocation;
    var Vector SpawnRotation;
    var Vector SpawnVelocity;
    var float SpawnServerTime;
    structdefaultproperties {}
};

struct TrackedProjectileUpdateData {
    var Vector Location;
    var Vector Velocity;
    var float UpdateServerTime;
    structdefaultproperties {}
};

var int r_nPlayerId;
var int r_nPawnId;
var int m_nUIDisplayIndex;
var float c_fLastUpdateTime;
var int r_nEquippedTitleId;
var repnotify int r_nHealthCurrent;
var int r_nHealthMaximum;
var int r_nPowerCurrent;
var int r_nPowerMaximum;
var int r_nPacingType;
var int r_nShieldCurrent;
var int r_nShieldMaximum;
var repnotify TgRepInfo_Player r_MasterPrep;
var repnotify TgRepInfo_TaskForce r_TaskForce;
var TgTeamPlayerStart r_SpawnPoint;
var float r_fReviveSecs;
var repnotify bool r_bMapHasLoaded;
var bool r_bHasBeenSeenByEnemyTeam;
var transient bool r_bHasFlag;
var repnotify bool r_bSilhouettesBlocked;
var bool r_bExtendedSilhouetteRange;
var bool c_bSpeaking;
var bool r_bDropped;
var bool r_bForceNotBot;
var bool r_bDisconnected;
var bool c_bIsDying;
var bool r_IsRevealed;
var bool r_bIsStealthed;
var bool r_bIsVolumeStealthed;
var bool r_bUltimateIsReady;
var bool r_bCanUpgradeLegendary;
var bool s_bAutoSelectCards;
var bool c_bTrackedProjectileIdsJustChanged;
var repnotify byte r_nSurrenderVote;
var repnotify byte r_bVisibleOnMap[TgMapTeam];
var repnotify byte r_nVisibilityMask;
var repnotify byte r_nFlashUpdateAmmo;
var TgObject.DeployableOverlayIcon r_eDeployableOverlayIcon;
var TgObject.DeployableOverlayState r_eDeployableOverlayState;
var TgObject.DeployableOverlayIcon c_eDeployableOverlayIconOverride;
var TgObject.DeployableOverlayState c_eDeployableOverlayStateOverride;
var TgRepInfo_Player.GAME_MODE_INSTRUCTION r_eCurrentGameModeInstruction;
var array<TgRepInfo_Player> m_PRIArray;
var array<TgRepInfo_Deployable> m_DRIArray;
var TgRepInfo_Player c_PriorMasterPrep;
var TgRepInfo_TaskForce c_PriorTaskForce;
var int c_fLastHealth;
var float c_fLastDamageTime;
var float r_fVisionRange;
var transient TgCarriedFlag s_CarriedFlag;
var init repnotify string r_ClanTag;
var init string c_PlayerNameWithTag;
var float c_fBarragePercent;
var repnotify SimulatedProjectileOverrides r_SimProjOverrides[8];
var int r_Scores[22];
var repnotify DeviceTeamInfo r_PlayerDevices[33];
var int r_PlayerDeviceAmmo[33];
var MarkedTargetInfo r_MarkedTargets[5];
var float c_fLastSpeakingTime;
var repnotify int r_nCredits;
var repnotify int r_nEarnedCredits;
var repnotify int r_nXp;
var repnotify int r_nLevel;
var repnotify int r_nPlayerScore;
var repnotify int r_nCardHealth;
var repnotify int r_nCardDamage;
var repnotify int r_nPowerLevel;
var repnotify int r_nPowerLevelCount;
var repnotify int r_nProfileId;
var repnotify int r_nSkinId;
var repnotify int r_nVoicePackId;
var repnotify int r_nKillstreak;
var int r_nHeadSkinId;
var int r_nWeaponSkinId;
var int r_nMountSkinId;
var repnotify int r_nAssistScore;
var TgPawn r_PawnOwner;
var int r_nLaneId;
var int s_KillOrDeathStreakModifier;
var sPingInfo r_PingInfo[4];
var Vector c_DeathLocation;
var TG_HUD_INFO c_HudInfo;
var float r_fUltReadyInSecs;
var int r_nUltimateCharge;
var int r_nPassiveMode;
var repnotify int r_nPerkCountKit;
var repnotify int r_nPerkCountArmor;
var repnotify int r_nPerkCountWeapon;
var repnotify int r_nPerkCountGeneral;
var int r_nCardsToDraw;
var int r_nDrawnCards[5];
var int r_nDrawnPlayer[5];
var float s_fScoreTakenPool;
var float s_fScoreDamagePool;
var float s_fScoreCapturePool;
var float s_fScoreHealingPool;
var float s_fScoreMitigatedPool;
var float s_fScoreTakenThreshold;
var float s_fScoreDamageThreshold;
var float s_fScoreCaptureThreshold;
var float s_fScoreHealingThreshold;
var float s_fScoreMitigatedThreshold;
var array<DeckCardData> s_CardDeckTier1;
var array<DeckCardData> s_CardDeckTier2;
var array<DeckCardData> s_CardDeckTier3;
var array<DeckCardData> s_CardDeckTier4;
var array<DeckCardData> s_CardDeckTier5;
var TgAbilityInfo r_GeneralAbilityInfo;
var TgAbilityInfo r_ArmorAbilityInfo;
var TgRepInfo_Player s_LastKillerPRI;
var array<PlayOfTheGameEventData> s_PlayOfTheGameEventList;
var array<PlayOfTheGameEventCounter> s_PlayOfTheGameEventCounters;
var int r_nDeployableOverlayDisplayMask;
var float r_fDeployableOverlayEnemyViewDist;
var int c_nDeployableOverlayDisplayMaskOverride;
var float c_fDeployableOverlayEnemyViewDistOverride;
var repnotify int r_TrackedProjectileIds[15];
var TrackedProjectileInitData r_TrackedProjectilesInitData[15];
var TrackedProjectileUpdateData r_TrackedProjectilesUpdateData[15];

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_ArmorAbilityInfo, r_ClanTag, r_GeneralAbilityInfo, r_IsRevealed, r_MarkedTargets, r_MasterPrep, r_PawnOwner, r_PingInfo, r_PlayerDeviceAmmo, r_PlayerDevices, r_Scores, r_SimProjOverrides, r_SpawnPoint, r_TaskForce, r_bCanUpgradeLegendary, r_bDisconnected, r_bDropped, r_bExtendedSilhouetteRange, r_bForceNotBot, r_bHasBeenSeenByEnemyTeam, r_bHasFlag, r_bIsStealthed, r_bMapHasLoaded, r_bSilhouettesBlocked, r_bUltimateIsReady, r_bVisibleOnMap, r_eCurrentGameModeInstruction, r_eDeployableOverlayIcon, r_eDeployableOverlayState, r_fDeployableOverlayEnemyViewDist, r_fReviveSecs, r_fUltReadyInSecs, r_fVisionRange, r_nAssistScore, r_nCardDamage, r_nCardHealth, r_nCardsToDraw, r_nCredits, r_nDeployableOverlayDisplayMask, r_nDrawnCards, r_nDrawnPlayer, r_nEarnedCredits, r_nEquippedTitleId, r_nFlashUpdateAmmo, r_nHeadSkinId, r_nHealthCurrent, r_nHealthMaximum, r_nKillstreak, r_nLaneId, r_nLevel, r_nMountSkinId, r_nPacingType, r_nPassiveMode, r_nPawnId, r_nPerkCountArmor, r_nPerkCountGeneral, r_nPerkCountKit, r_nPerkCountWeapon, r_nPlayerId, r_nPlayerScore, r_nPowerCurrent, r_nPowerLevel, r_nPowerLevelCount, r_nPowerMaximum, r_nProfileId, r_nShieldCurrent, r_nShieldMaximum, r_nSkinId, r_nSurrenderVote, r_nUltimateCharge, r_nVisibilityMask, r_nVoicePackId, r_nWeaponSkinId, r_nXp;
}

native function bool IsFriendlyWithLocalPlayer();  // Export UTgRepInfo_Player::execIsFriendlyWithLocalPlayer(FFrame&, void* const)

native function bool IsBot();  // Export UTgRepInfo_Player::execIsBot(FFrame&, void* const)

native function bool IsGod();  // Export UTgRepInfo_Player::execIsGod(FFrame&, void* const)

native function bool IsGodDecoy();  // Export UTgRepInfo_Player::execIsGodDecoy(FFrame&, void* const)

native function bool IsMinionOf(const TgRepInfo_Player PossibleOwner);  // Export UTgRepInfo_Player::execIsMinionOf(FFrame&, void* const)

native function int GetPlayerId();  // Export UTgRepInfo_Player::execGetPlayerId(FFrame&, void* const)

native function UpdateScoreboard();  // Export UTgRepInfo_Player::execUpdateScoreboard(FFrame&, void* const)

native function UpdateLevel();  // Export UTgRepInfo_Player::execUpdateLevel(FFrame&, void* const)

native function UpdateBroadcastedItems(TgInventoryManager InvMgr);  // Export UTgRepInfo_Player::execUpdateBroadcastedItems(FFrame&, void* const)

native function SetTeam(TgRepInfo_TaskForce pNewTeamRep);  // Export UTgRepInfo_Player::execSetTeam(FFrame&, void* const)

native function AddMinion(ReplicationInfo pRepInfo);  // Export UTgRepInfo_Player::execAddMinion(FFrame&, void* const)

native function RemoveMinion(ReplicationInfo pRepInfo);  // Export UTgRepInfo_Player::execRemoveMinion(FFrame&, void* const)

native function CheckMembership();  // Export UTgRepInfo_Player::execCheckMembership(FFrame&, void* const)

native function int GetCurrentHealth();  // Export UTgRepInfo_Player::execGetCurrentHealth(FFrame&, void* const)

native function int GetCurrentMaxHealth();  // Export UTgRepInfo_Player::execGetCurrentMaxHealth(FFrame&, void* const)

native function int GetCurrentPower();  // Export UTgRepInfo_Player::execGetCurrentPower(FFrame&, void* const)

native function int GetCurrentMaxPower();  // Export UTgRepInfo_Player::execGetCurrentMaxPower(FFrame&, void* const)

native function int GetCurrentShield();  // Export UTgRepInfo_Player::execGetCurrentShield(FFrame&, void* const)

native function int GetCurrentMaxShield();  // Export UTgRepInfo_Player::execGetCurrentMaxShield(FFrame&, void* const)

native function Vector GetCurrentLocation();  // Export UTgRepInfo_Player::execGetCurrentLocation(FFrame&, void* const)

native function Rotator GetCurrentRotation();  // Export UTgRepInfo_Player::execGetCurrentRotation(FFrame&, void* const)

native function bool IsStealthedClient();  // Export UTgRepInfo_Player::execIsStealthedClient(FFrame&, void* const)

native function bool IsHardStealthedClient();  // Export UTgRepInfo_Player::execIsHardStealthedClient(FFrame&, void* const)

native function UpdateUltimateIsReady(float fCooldownSecs);  // Export UTgRepInfo_Player::execUpdateUltimateIsReady(FFrame&, void* const)

native function string GetPlayerNameForMsgDisplay(optional bool bBaseNameOnly=false);  // Export UTgRepInfo_Player::execGetPlayerNameForMsgDisplay(FFrame&, void* const)

native function UpdateSpectatorUI();  // Export UTgRepInfo_Player::execUpdateSpectatorUI(FFrame&, void* const)

native function UpdatePlayerInfoUI();  // Export UTgRepInfo_Player::execUpdatePlayerInfoUI(FFrame&, void* const)

native function UpdatePlayerTaskforceUI();  // Export UTgRepInfo_Player::execUpdatePlayerTaskforceUI(FFrame&, void* const)

native function UpdateFX();  // Export UTgRepInfo_Player::execUpdateFX(FFrame&, void* const)

native function bool HasBeenSeenByEnemyTeam();  // Export UTgRepInfo_Player::execHasBeenSeenByEnemyTeam(FFrame&, void* const)

native function bool IsVisibleToAnEnemyTeam();  // Export UTgRepInfo_Player::execIsVisibleToAnEnemyTeam(FFrame&, void* const)

native function bool IsVisibleToMapTeam(TgObject.TgMapTeam MAPTEAM);  // Export UTgRepInfo_Player::execIsVisibleToMapTeam(FFrame&, void* const)

native function bool IsVisibleToPlayer(TgRepInfo_Player PRI);  // Export UTgRepInfo_Player::execIsVisibleToPlayer(FFrame&, void* const)

native function bool IsVisibleToLocalPlayer();  // Export UTgRepInfo_Player::execIsVisibleToLocalPlayer(FFrame&, void* const)

native function CheckPingingList();  // Export UTgRepInfo_Player::execCheckPingingList(FFrame&, void* const)

native function UpdatePingInfo(TgRepInfo_Player pingedPri, Vector pingedLoc, TgObject.PING_TYPE Type);  // Export UTgRepInfo_Player::execUpdatePingInfo(FFrame&, void* const)

native function UpdateMapVisibility(TgObject.TgMapTeam MAPTEAM, byte bVisible, float fVisionRange, bool bDetected);  // Export UTgRepInfo_Player::execUpdateMapVisibility(FFrame&, void* const)

native function bool SetTaskForceNumber(byte nTaskForce, optional bool bForce=false);  // Export UTgRepInfo_Player::execSetTaskForceNumber(FFrame&, void* const)

native function ClientUpdateItemStoreItems();  // Export UTgRepInfo_Player::execClientUpdateItemStoreItems(FFrame&, void* const)

native function UpdateSurrenderVoting();  // Export UTgRepInfo_Player::execUpdateSurrenderVoting(FFrame&, void* const)

native function UpdatePlayerReady();  // Export UTgRepInfo_Player::execUpdatePlayerReady(FFrame&, void* const)

native function UpdatePlayerNameWithTag();  // Export UTgRepInfo_Player::execUpdatePlayerNameWithTag(FFrame&, void* const)

native function bool LoadCardDeck(optional bool bDefault=false);  // Export UTgRepInfo_Player::execLoadCardDeck(FFrame&, void* const)

native function DrawNewCards(optional int nPrevPower=-1);  // Export UTgRepInfo_Player::execDrawNewCards(FFrame&, void* const)

native function AddPlayOfTheGameEvent(TgObject.EPlayOfTheGameEventType Type, optional float Amount=1.0000000);  // Export UTgRepInfo_Player::execAddPlayOfTheGameEvent(FFrame&, void* const)

native function AddMarkedTarget(int nPawnId, optional int nCount=1);  // Export UTgRepInfo_Player::execAddMarkedTarget(FFrame&, void* const)

native function RemoveMarkedTarget(int nPawnId, optional int nCount=0);  // Export UTgRepInfo_Player::execRemoveMarkedTarget(FFrame&, void* const)

native function int GetMarkedTargetCount(int nPawnId);  // Export UTgRepInfo_Player::execGetMarkedTargetCount(FFrame&, void* const)

simulated function PostBeginPlay() { }

function PopulateGeneralAbilities() { }

simulated function ClientInitialize(Controller C) { }

simulated function RecalculateTeamColor() { }

event Timer() { }

event UpdateIdAndProfile() { }

function UpdatePlayerLocation() { }

event UpdateHealth(int nCurrentHealth, int nMaxHealth) { }

event UpdatePower(int nCurrentPower, int nMaxPower) { }

event UpdateShield(int nCurrentShield, int nMaxShield) { }

simulated function byte GetTaskForceNumber() { }

simulated function UpdatedHealthCurrent() { }

simulated function UpdatedApproxLocation() { }

simulated event UpdatedTaskForce() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function PlayerController FindLocalController() { }

simulated function TgPawn FindLocalPlayerPawn() { }

simulated function bool ShouldBroadCastWelcomeMessage(optional bool bExiting) { }

function PlayerReplicationInfo Duplicate() { }

function OverrideWith(PlayerReplicationInfo PRI) { }

function CopyProperties(PlayerReplicationInfo PRI) { }

function TransferMinionOwnershipTo(TgRepInfo_Player NewOwner) { }

function OnDeath() { }

function SetFlag(TgCarriedFlag NewFlag) { }

event SetSpawnPoint(TgTeamPlayerStart SpawnPoint) { }

native function SetSimProjSpeed(int nFireModeId, float fSpeed);  // Export UTgRepInfo_Player::execSetSimProjSpeed(FFrame&, void* const)

native function SetSimProjRemoteProximity(int nFireModeId, float fRemoteProximity);  // Export UTgRepInfo_Player::execSetSimProjRemoteProximity(FFrame&, void* const)

native function SetSimProjDist(int nFireModeId, float fDist);  // Export UTgRepInfo_Player::execSetSimProjDist(FFrame&, void* const)

native function SetSimProjGravityScale(int nFireModeId, float fGravityScale);  // Export UTgRepInfo_Player::execSetSimProjGravityScale(FFrame&, void* const)

native function SetSimProjFireAngle(int nFireModeId, float fFireAngle);  // Export UTgRepInfo_Player::execSetSimProjFireAngle(FFrame&, void* const)

native function int FindSimProjOverrideIndex(int nFireModeId);  // Export UTgRepInfo_Player::execFindSimProjOverrideIndex(FFrame&, void* const)

native function ValidateSimProj(int nIndex);  // Export UTgRepInfo_Player::execValidateSimProj(FFrame&, void* const)

native function bool GetSimProjOverrides(int nFireModeId, out float fRange, out float fRemoteProximity, out float fSpeed, out float fGravityScale, out float fFireAngle);  // Export UTgRepInfo_Player::execGetSimProjOverrides(FFrame&, void* const)

event SetHUDOverlayDisplayMask(int dodm) { }

event SetHUDOverlayIcon(TgObject.DeployableOverlayIcon doi) { }

event SetHUDOverlayState(TgObject.DeployableOverlayState dos) { }

event SetHUDOverlayEnemyViewDist(float enemyViewDist) { }

native simulated function int GetDeployableOverlayDisplayMask();  // Export UTgRepInfo_Player::execGetDeployableOverlayDisplayMask(FFrame&, void* const)

native simulated function TgObject.DeployableOverlayIcon GetDeployableOverlayIcon();  // Export UTgRepInfo_Player::execGetDeployableOverlayIcon(FFrame&, void* const)

native simulated function TgObject.DeployableOverlayState GetDeployableOverlayState();  // Export UTgRepInfo_Player::execGetDeployableOverlayState(FFrame&, void* const)

native simulated function float GetDeployableOverlayEnemyViewDist();  // Export UTgRepInfo_Player::execGetDeployableOverlayEnemyViewDist(FFrame&, void* const)

defaultproperties
{
    r_eDeployableOverlayIcon=DOI_TURRET
    c_fBarragePercent=-1.0000000
    r_SimProjOverrides[0]=(FireModeID=0,RemoteProximityDist=0.0000000,Range=0.0000000,Speed=0.0000000,GravityScale=1.0000000,FireAngle=0.0000000)
    r_SimProjOverrides[1]=(FireModeID=0,RemoteProximityDist=0.0000000,Range=0.0000000,Speed=0.0000000,GravityScale=1.0000000,FireAngle=0.0000000)
    r_SimProjOverrides[2]=(FireModeID=0,RemoteProximityDist=0.0000000,Range=0.0000000,Speed=0.0000000,GravityScale=1.0000000,FireAngle=0.0000000)
    r_SimProjOverrides[3]=(FireModeID=0,RemoteProximityDist=0.0000000,Range=0.0000000,Speed=0.0000000,GravityScale=1.0000000,FireAngle=0.0000000)
    r_SimProjOverrides[4]=(FireModeID=0,RemoteProximityDist=0.0000000,Range=0.0000000,Speed=0.0000000,GravityScale=1.0000000,FireAngle=0.0000000)
    r_SimProjOverrides[5]=(FireModeID=0,RemoteProximityDist=0.0000000,Range=0.0000000,Speed=0.0000000,GravityScale=1.0000000,FireAngle=0.0000000)
    r_SimProjOverrides[6]=(FireModeID=0,RemoteProximityDist=0.0000000,Range=0.0000000,Speed=0.0000000,GravityScale=1.0000000,FireAngle=0.0000000)
    r_SimProjOverrides[7]=(FireModeID=0,RemoteProximityDist=0.0000000,Range=0.0000000,Speed=0.0000000,GravityScale=1.0000000,FireAngle=0.0000000)
    r_nLevel=1
    r_nPassiveMode=-1
    r_nCardsToDraw=3
    s_fScoreTakenThreshold=6000.0000000
    s_fScoreDamageThreshold=6000.0000000
    s_fScoreCaptureThreshold=4.0000000
    s_fScoreHealingThreshold=6000.0000000
    s_fScoreMitigatedThreshold=6000.0000000
    r_fDeployableOverlayEnemyViewDist=1600.0000000
    bReplicateInstigator=true
    bReplicateMovement=false
}
