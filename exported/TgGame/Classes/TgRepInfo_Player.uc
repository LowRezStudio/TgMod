class TgRepInfo_Player extends PlayerReplicationInfo
    native(Game)
    nativereplication
    hidecategories(Navigation,Movement,Collision);

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

enum SCORE_TYPE
{
    STYPE_REPPTS,                   // 0
    STYPE_KILLS,                    // 1
    STYPE_ASSISTS,                  // 2
    STYPE_DAMAGETAKEN,              // 3
    STYPE_DAMAGE,                   // 4
    STYPE_BUFFVALUE,                // 5
    STYPE_HEALING,                  // 6
    STYPE_DEFENSE,                  // 7
    STYPE_DEATHS,                   // 8
    STYPE_OBJS,                     // 9
    STYPE_KILLS_BOT,                // 10
    STYPE_EARNED_XP,                // 11
    STYPE_EARNED_GOLD,              // 12
    STYPE_CURRENT_GOLD,             // 13
    STYPE_GOLD_PER_MIN,             // 14
    STYPE_XP_PER_MIN,               // 15
    STYPE_PLAYER_DMG,               // 16
    STYPE_BOT_DMG,                  // 17
    STYPE_STRUCT_DMG,               // 18
    STYPE_OBJ_ASSISTS,              // 19
    STYPE_KILLS_SOLO,               // 20
    STYPE_DMG_MITIGATED,            // 21
    STYPE_MAX                       // 22
};

enum DEVICE_STATS
{
    DS_ID,                          // 0
    DS_DAMAGE,                      // 1
    DS_HEALING,                     // 2
    DS_PLAYER_KILLS,                // 3
    DS_BOT_KILLS,                   // 4
    DS_DPM,                         // 5
    DS_HPM,                         // 6
    DS_MODE_COUNT,                  // 7
    DS_BUFF_VALUE,                  // 8
    DS_MAX                          // 9
};

enum GAME_MODE_INSTRUCTION
{
    GMI_NONE,                       // 0
    GMI_CAPTURE_POINT,              // 1
    GMI_PUSH_PAYLOAD,               // 2
    GMI_DEFEND_AGAINST_PAYLOAD,     // 3
    GMI_MAX                         // 4
};

struct native DeviceTeamInfo
{
    var int Power;
    var int CurrentDeviceId;
    var int LastKnownDeviceId[TgMapTeam];
    var int CurrentDeviceCount;
    var int LastKnownDeviceCount[TgMapTeam];

    structdefaultproperties
    {
        Power=0
        CurrentDeviceId=0
        LastKnownDeviceId[0]=0
        LastKnownDeviceId[1]=0
        LastKnownDeviceId[2]=0
        CurrentDeviceCount=0
        LastKnownDeviceCount[0]=0
        LastKnownDeviceCount[1]=0
        LastKnownDeviceCount[2]=0
    }
};

struct native SimulatedProjectileOverrides
{
    var int FireModeID;
    var float RemoteProximityDist;
    var float Range;
    var float Speed;
    var float GravityScale;
    var float FireAngle;

    structdefaultproperties
    {
        FireModeID=0
        RemoteProximityDist=0.0000000
        Range=0.0000000
        Speed=0.0000000
        GravityScale=1.0000000
        FireAngle=0.0000000
    }
};

struct native MarkedTargetInfo
{
    var int PawnId;
    var int Count;

    structdefaultproperties
    {
        PawnId=0
        Count=0
    }
};

struct native DeckCardData
{
    var int nDeviceId;
    var int nPlayerId;

    structdefaultproperties
    {
        nDeviceId=0
        nPlayerId=0
    }
};

struct native PlayOfTheGameEventData
{
    var TgObject.EPlayOfTheGameEventType EventType;
    var float TimeStamp;
    var float WeightedRating;

    structdefaultproperties
    {
        EventType=EPlayOfTheGameEventType.POTG_ScoreKill
        TimeStamp=0.0000000
        WeightedRating=0.0000000
    }
};

struct native PlayOfTheGameEventCounter
{
    var TgObject.EPlayOfTheGameEventType EventType;
    var float Threshold;
    var float Counter;
    var float TimeOut;
    var float Timer;

    structdefaultproperties
    {
        EventType=EPlayOfTheGameEventType.POTG_ScoreKill
        Threshold=0.0000000
        Counter=0.0000000
        TimeOut=0.0000000
        Timer=0.0000000
    }
};

struct native TrackedProjectileInitData
{
    var int FireModeID;
    var int ProjectileId;
    var Vector SpawnLocation;
    var Vector SpawnRotation;
    var Vector SpawnVelocity;
    var float SpawnServerTime;

    structdefaultproperties
    {
        FireModeID=0
        ProjectileId=0
        SpawnLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        SpawnRotation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        SpawnVelocity=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        SpawnServerTime=0.0000000
    }
};

struct native TrackedProjectileUpdateData
{
    var Vector Location;
    var Vector Velocity;
    var float UpdateServerTime;

    structdefaultproperties
    {
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Velocity=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        UpdateServerTime=0.0000000
    }
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

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_ArmorAbilityInfo, r_ClanTag, 
        r_GeneralAbilityInfo, r_IsRevealed, 
        r_MarkedTargets, r_MasterPrep, 
        r_PawnOwner, r_PingInfo, 
        r_PlayerDeviceAmmo, r_PlayerDevices, 
        r_Scores, r_SimProjOverrides, 
        r_SpawnPoint, r_TaskForce, 
        r_bCanUpgradeLegendary, r_bDisconnected, 
        r_bDropped, r_bExtendedSilhouetteRange, 
        r_bForceNotBot, r_bHasBeenSeenByEnemyTeam, 
        r_bHasFlag, r_bIsStealthed, 
        r_bMapHasLoaded, r_bSilhouettesBlocked, 
        r_bUltimateIsReady, r_bVisibleOnMap, 
        r_eCurrentGameModeInstruction, r_eDeployableOverlayIcon, 
        r_eDeployableOverlayState, r_fDeployableOverlayEnemyViewDist, 
        r_fReviveSecs, r_fUltReadyInSecs, 
        r_fVisionRange, r_nAssistScore, 
        r_nCardDamage, r_nCardHealth, 
        r_nCardsToDraw, r_nCredits, 
        r_nDeployableOverlayDisplayMask, r_nDrawnCards, 
        r_nDrawnPlayer, r_nEarnedCredits, 
        r_nEquippedTitleId, r_nFlashUpdateAmmo, 
        r_nHeadSkinId, r_nHealthCurrent, 
        r_nHealthMaximum, r_nKillstreak, 
        r_nLaneId, r_nLevel, 
        r_nMountSkinId, r_nPacingType, 
        r_nPassiveMode, r_nPawnId, 
        r_nPerkCountArmor, r_nPerkCountGeneral, 
        r_nPerkCountKit, r_nPerkCountWeapon, 
        r_nPlayerId, r_nPlayerScore, 
        r_nPowerCurrent, r_nPowerLevel, 
        r_nPowerLevelCount, r_nPowerMaximum, 
        r_nProfileId, r_nShieldCurrent, 
        r_nShieldMaximum, r_nSkinId, 
        r_nSurrenderVote, r_nUltimateCharge, 
        r_nVisibilityMask, r_nVoicePackId, 
        r_nWeaponSkinId, r_nXp;

    // Pos:0x011
    if(((int(Role) == int(ROLE_Authority)) && !bNetInitial) && (bDemoOwner || bNetTimelapseInit) || bNetTimelapsePost)
        r_TrackedProjectileIds, r_TrackedProjectilesInitData, 
        r_TrackedProjectilesUpdateData;
}

// Export UTgRepInfo_Player::execIsFriendlyWithLocalPlayer(FFrame&, void* const)
native function bool IsFriendlyWithLocalPlayer();

// Export UTgRepInfo_Player::execIsBot(FFrame&, void* const)
native function bool IsBot();

// Export UTgRepInfo_Player::execIsGod(FFrame&, void* const)
native function bool IsGod();

// Export UTgRepInfo_Player::execIsGodDecoy(FFrame&, void* const)
native function bool IsGodDecoy();

// Export UTgRepInfo_Player::execIsMinionOf(FFrame&, void* const)
native final function bool IsMinionOf(const TgRepInfo_Player PossibleOwner);

// Export UTgRepInfo_Player::execGetPlayerId(FFrame&, void* const)
native function int GetPlayerId();

// Export UTgRepInfo_Player::execUpdateScoreboard(FFrame&, void* const)
native function UpdateScoreboard();

// Export UTgRepInfo_Player::execUpdateLevel(FFrame&, void* const)
native function UpdateLevel();

// Export UTgRepInfo_Player::execUpdateBroadcastedItems(FFrame&, void* const)
native function UpdateBroadcastedItems(TgInventoryManager InvMgr);

// Export UTgRepInfo_Player::execSetTeam(FFrame&, void* const)
native function SetTeam(TgRepInfo_TaskForce pNewTeamRep);

// Export UTgRepInfo_Player::execAddMinion(FFrame&, void* const)
native function AddMinion(ReplicationInfo pRepInfo);

// Export UTgRepInfo_Player::execRemoveMinion(FFrame&, void* const)
native function RemoveMinion(ReplicationInfo pRepInfo);

// Export UTgRepInfo_Player::execCheckMembership(FFrame&, void* const)
native function CheckMembership();

// Export UTgRepInfo_Player::execGetCurrentHealth(FFrame&, void* const)
native function int GetCurrentHealth();

// Export UTgRepInfo_Player::execGetCurrentMaxHealth(FFrame&, void* const)
native function int GetCurrentMaxHealth();

// Export UTgRepInfo_Player::execGetCurrentPower(FFrame&, void* const)
native function int GetCurrentPower();

// Export UTgRepInfo_Player::execGetCurrentMaxPower(FFrame&, void* const)
native function int GetCurrentMaxPower();

// Export UTgRepInfo_Player::execGetCurrentShield(FFrame&, void* const)
native function int GetCurrentShield();

// Export UTgRepInfo_Player::execGetCurrentMaxShield(FFrame&, void* const)
native function int GetCurrentMaxShield();

// Export UTgRepInfo_Player::execGetCurrentLocation(FFrame&, void* const)
native function Vector GetCurrentLocation();

// Export UTgRepInfo_Player::execGetCurrentRotation(FFrame&, void* const)
native function Rotator GetCurrentRotation();

// Export UTgRepInfo_Player::execIsStealthedClient(FFrame&, void* const)
native function bool IsStealthedClient();

// Export UTgRepInfo_Player::execIsHardStealthedClient(FFrame&, void* const)
native function bool IsHardStealthedClient();

// Export UTgRepInfo_Player::execUpdateUltimateIsReady(FFrame&, void* const)
native function UpdateUltimateIsReady(float fCooldownSecs);

// Export UTgRepInfo_Player::execGetPlayerNameForMsgDisplay(FFrame&, void* const)
native function string GetPlayerNameForMsgDisplay(optional bool bBaseNameOnly = false);

// Export UTgRepInfo_Player::execUpdateSpectatorUI(FFrame&, void* const)
native function UpdateSpectatorUI();

// Export UTgRepInfo_Player::execUpdatePlayerInfoUI(FFrame&, void* const)
native function UpdatePlayerInfoUI();

// Export UTgRepInfo_Player::execUpdatePlayerTaskforceUI(FFrame&, void* const)
native function UpdatePlayerTaskforceUI();

// Export UTgRepInfo_Player::execUpdateFX(FFrame&, void* const)
native function UpdateFX();

// Export UTgRepInfo_Player::execHasBeenSeenByEnemyTeam(FFrame&, void* const)
native function bool HasBeenSeenByEnemyTeam();

// Export UTgRepInfo_Player::execIsVisibleToAnEnemyTeam(FFrame&, void* const)
native function bool IsVisibleToAnEnemyTeam();

// Export UTgRepInfo_Player::execIsVisibleToMapTeam(FFrame&, void* const)
native function bool IsVisibleToMapTeam(TgObject.TgMapTeam MAPTEAM);

// Export UTgRepInfo_Player::execIsVisibleToPlayer(FFrame&, void* const)
native function bool IsVisibleToPlayer(TgRepInfo_Player PRI);

// Export UTgRepInfo_Player::execIsVisibleToLocalPlayer(FFrame&, void* const)
native function bool IsVisibleToLocalPlayer();

// Export UTgRepInfo_Player::execCheckPingingList(FFrame&, void* const)
native function CheckPingingList();

// Export UTgRepInfo_Player::execUpdatePingInfo(FFrame&, void* const)
native function UpdatePingInfo(TgRepInfo_Player pingedPri, Vector pingedLoc, TgObject.PING_TYPE Type);

// Export UTgRepInfo_Player::execUpdateMapVisibility(FFrame&, void* const)
native function UpdateMapVisibility(TgObject.TgMapTeam MAPTEAM, byte bVisible, float fVisionRange, bool bDetected);

// Export UTgRepInfo_Player::execSetTaskForceNumber(FFrame&, void* const)
native function bool SetTaskForceNumber(byte nTaskForce, optional bool bForce = false);

// Export UTgRepInfo_Player::execClientUpdateItemStoreItems(FFrame&, void* const)
native function ClientUpdateItemStoreItems();

// Export UTgRepInfo_Player::execUpdateSurrenderVoting(FFrame&, void* const)
native function UpdateSurrenderVoting();

// Export UTgRepInfo_Player::execUpdatePlayerReady(FFrame&, void* const)
native function UpdatePlayerReady();

// Export UTgRepInfo_Player::execUpdatePlayerNameWithTag(FFrame&, void* const)
native function UpdatePlayerNameWithTag();

// Export UTgRepInfo_Player::execLoadCardDeck(FFrame&, void* const)
native function bool LoadCardDeck(optional bool bDefault = false);

// Export UTgRepInfo_Player::execDrawNewCards(FFrame&, void* const)
native function DrawNewCards(optional int nPrevPower = -1);

// Export UTgRepInfo_Player::execAddPlayOfTheGameEvent(FFrame&, void* const)
native function AddPlayOfTheGameEvent(TgObject.EPlayOfTheGameEventType Type, optional float Amount = 1.0000000);

// Export UTgRepInfo_Player::execAddMarkedTarget(FFrame&, void* const)
native function AddMarkedTarget(int nPawnId, optional int nCount = 1);

// Export UTgRepInfo_Player::execRemoveMarkedTarget(FFrame&, void* const)
native function RemoveMarkedTarget(int nPawnId, optional int nCount = 0);

// Export UTgRepInfo_Player::execGetMarkedTargetCount(FFrame&, void* const)
native function int GetMarkedTargetCount(int nPawnId);

simulated function PostBeginPlay()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x42 [Loop If]
    if(I < 15)
    {
        r_TrackedProjectileIds[I] = -1;
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    super.PostBeginPlay();
    SetTimer(0.5000000, true);
    UpdatePlayerInfoUI();
    UpdateFX();
    // End:0x84
    if(LoadCardDeck())
    {
        DrawNewCards();
    }
    //return;    
}

function PopulateGeneralAbilities()
{
    r_GeneralAbilityInfo.DeviceIds[3] = 10534;
    r_GeneralAbilityInfo.DeviceIds[4] = 10672;
    r_GeneralAbilityInfo.DeviceIds[5] = 10698;
    r_GeneralAbilityInfo.DeviceIds[6] = 10671;
    r_GeneralAbilityInfo.DeviceIds[7] = 10686;
    r_GeneralAbilityInfo.DeviceIds[8] = 10678;
    r_GeneralAbilityInfo.DeviceIds[9] = 10688;
    //return;    
}

simulated function ClientInitialize(Controller C)
{
    local TgSpectatorController SpectatorController;

    super.ClientInitialize(C);
    UpdatePlayerInfoUI();
    RecalculateTeamColor();
    // End:0x93
    if(WorldInfo.IsPlayingDemo())
    {
        SpectatorController = TgSpectatorController(C);
        // End:0x93
        if(SpectatorController != none)
        {
            SpectatorController.UpdateBroadcastChannels();
        }
    }
    //return;    
}

simulated function RecalculateTeamColor()
{
    local Actor A;

    // End:0x39
    foreach AllActors(Class'Engine.Actor', A)
    {
        A.NotifyLocalPlayerTeamReceived();        
    }    
    //return;    
}

event Timer()
{
    UpdatePlayerLocation();
    UpdateIdAndProfile();
    //return;    
}

event UpdateIdAndProfile()
{
    local TgPawn TgPawn;

    // End:0x52
    if(Controller(Owner) != none)
    {
        TgPawn = TgPawn(Controller(Owner).Pawn);
    }
    // End:0x184
    if(TgPawn != none)
    {
        r_nProfileId = TgPawn.r_nProfileId;
        r_nSkinId = TgPawn.r_nSkinId;
        r_nVoicePackId = TgPawn.r_nVoicePackId;
        r_nHeadSkinId = TgPawn.r_nHeadSkinId;
        r_nWeaponSkinId = TgPawn.r_nWeaponSkinId;
        r_nMountSkinId = TgPawn.r_nMountSkinId;
        // End:0x184
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            UpdatePlayerInfoUI();
        }
    }
    //return;    
}

function UpdatePlayerLocation()
{
    //return;    
}

event UpdateHealth(int nCurrentHealth, int nMaxHealth)
{
    local Pawn P;

    r_nHealthCurrent = nCurrentHealth;
    r_nHealthMaximum = nMaxHealth;
    // End:0xE0
    if(Controller(Owner) != none)
    {
        P = Controller(Owner).Pawn;
        // End:0xE0
        if((P != none) && Controller(Owner).IsInState('Dead') || P.IsInState('Dying'))
        {
            r_nHealthCurrent = 0;
        }
    }
    // End:0x113
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        UpdatedHealthCurrent();
    }
    //return;    
}

event UpdatePower(int nCurrentPower, int nMaxPower)
{
    local TgPawn P;

    r_nPowerCurrent = nCurrentPower;
    r_nPowerMaximum = nMaxPower;
    // End:0x10F
    if(Controller(Owner) != none)
    {
        P = TgPawn(Controller(Owner).Pawn);
        // End:0x10F
        if(P != none)
        {
            r_nPacingType = P.r_nPacingType;
            // End:0x10F
            if(Controller(Owner).IsInState('Dead') || P.IsInState('Dying'))
            {
                r_nPowerCurrent = 0;
            }
        }
    }
    //return;    
}

event UpdateShield(int nCurrentShield, int nMaxShield)
{
    local TgPawn P;

    r_nShieldCurrent = nCurrentShield;
    r_nShieldMaximum = nMaxShield;
    // End:0x10F
    if(Controller(Owner) != none)
    {
        P = TgPawn(Controller(Owner).Pawn);
        // End:0x10F
        if(P != none)
        {
            r_nPacingType = P.r_nPacingType;
            // End:0x10F
            if(Controller(Owner).IsInState('Dead') || P.IsInState('Dying'))
            {
                r_nShieldCurrent = 0;
            }
        }
    }
    //return;    
}

simulated function byte GetTaskForceNumber()
{
    // End:0x2E
    if(r_TaskForce != none)
    {
        return r_TaskForce.r_nTaskForce;
    }
    return 0;
    //return ReturnValue;    
}

simulated function UpdatedHealthCurrent()
{
    // End:0x32
    if(r_nHealthCurrent == 0)
    {
        c_bIsDying = true;
        c_DeathLocation = GetCurrentLocation();        
    }
    else
    {
        c_bIsDying = false;
    }
    // End:0x8E
    if((r_nHealthCurrent < c_fLastHealth) && !c_bIsDying)
    {
        c_fLastDamageTime = WorldInfo.TimeSeconds;
    }
    c_fLastHealth = r_nHealthCurrent;
    UpdateFX();
    //return;    
}

simulated function UpdatedApproxLocation()
{
    //return;    
}

simulated event UpdatedTaskForce()
{
    local TgPlayerController localPC;

    CheckMembership();
    UpdatePlayerTaskforceUI();
    localPC = TgPlayerController(Owner);
    // End:0x49
    if(localPC != none)
    {
        RecalculateTeamColor();
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    local TgPawn TgP;

    // End:0x23
    if(VarName == 'r_nHealthCurrent')
    {
        UpdatedHealthCurrent();
        return;
    }
    // End:0x6A
    if(VarName == 'r_nFlashUpdateAmmo')
    {
        // End:0x68
        if(r_PawnOwner != none)
        {
            r_PawnOwner.ForceUpdateAmmoAnim();
        }
        return;
    }
    // End:0x8D
    if(VarName == 'r_TaskForce')
    {
        UpdatedTaskForce();
        return;
    }
    // End:0xB0
    if(VarName == 'r_MasterPrep')
    {
        CheckMembership();
        return;
    }
    // End:0xD3
    if(VarName == 'r_PlayerDevices')
    {
        ClientUpdateItemStoreItems();
        return;
    }
    // End:0x18C
    if(((((((VarName == 'r_nProfileId') || VarName == 'r_nLevel') || VarName == 'r_nPowerLevel') || VarName == 'r_nPowerLevelCount') || VarName == 'r_nVoicePackId') || VarName == 'r_nSkinId') || VarName == 'r_nAssistScore')
    {
        UpdatePlayerInfoUI();
        return;
    }
    // End:0x1AF
    if(VarName == 'r_nXp')
    {
        UpdateSpectatorUI();
        return;
    }
    // End:0x1D2
    if(VarName == 'r_nPlayerScore')
    {
        UpdateSpectatorUI();
        return;
    }
    // End:0x1F5
    if(VarName == 'r_nSurrenderVote')
    {
        UpdateSurrenderVoting();
        return;
    }
    // End:0x218
    if(VarName == 'r_bMapHasLoaded')
    {
        UpdatePlayerReady();
        return;
    }
    // End:0x23B
    if(VarName == 'r_ClanTag')
    {
        UpdatePlayerInfoUI();
        return;
    }
    // End:0x2AE
    if(VarName == 'r_bVisibleOnMap')
    {
        // End:0x2AC
        if((r_PawnOwner != none) && int(r_PawnOwner.r_eIsStealthed) != int(0))
        {
            r_PawnOwner.ApplyStealthClient();
        }
        return;
    }
    // End:0x2C7
    if(VarName == 'r_eCurrentGameModeInstruction')
    {
        return;
    }
    // End:0x2EC
    if(VarName == 'r_TrackedProjectileIds')
    {
        c_bTrackedProjectileIdsJustChanged = true;
        return;
    }
    // End:0x37F
    if(VarName == 'r_bSilhouettesBlocked')
    {
        // End:0x37D
        if(r_PawnOwner != none)
        {
            // End:0x37D
            if(r_bSilhouettesBlocked)
            {
                // End:0x37C
                foreach AllActors(Class'TgGame.TgPawn', TgP)
                {
                    // End:0x37B
                    if(TgP.m_bSilhouettesVisible)
                    {
                        TgP.ToggleSilhouetteVisibility(false);
                    }                    
                }                
            }
        }
        return;
    }
    // End:0x3A0
    if(VarName == 'PlayerName')
    {
        UpdatePlayerInfoUI();
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated function PlayerController FindLocalController()
{
    local PlayerController PC;

    // End:0x40
    foreach WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
    {        
        return PC;        
    }    
    return none;
    //return ReturnValue;    
}

simulated function TgPawn FindLocalPlayerPawn()
{
    local PlayerController PC;

    // End:0x38
    foreach WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
    {
        // End:0x38
        break;        
    }    
    // End:0x70
    if(PC != none)
    {
        return TgPawn(PC.Pawn);
    }
    return none;
    //return ReturnValue;    
}

simulated function bool ShouldBroadCastWelcomeMessage(optional bool bExiting)
{
    return false;
    //return ReturnValue;    
}

function PlayerReplicationInfo Duplicate()
{
    local PlayerReplicationInfo NewPRI;

    NewPRI = Spawn(Class);
    CopyProperties(NewPRI);
    return NewPRI;
    //return ReturnValue;    
}

function OverrideWith(PlayerReplicationInfo PRI)
{
    super.OverrideWith(PRI);
    //return;    
}

function CopyProperties(PlayerReplicationInfo PRI)
{
    local int I;
    local TgRepInfo_Player TgPRI;

    super.CopyProperties(PRI);
    TgPRI = TgRepInfo_Player(PRI);
    TgPRI.r_nPlayerId = r_nPlayerId;
    TgPRI.r_nProfileId = r_nProfileId;
    TgPRI.r_nPawnId = r_nPawnId;
    TgPRI.r_MasterPrep = r_MasterPrep;
    TgPRI.r_nLevel = r_nLevel;
    TgPRI.r_nCredits = r_nCredits;
    TgPRI.r_nPlayerScore = r_nPlayerScore;
    TgPRI.r_nPowerLevel = r_nPowerLevel;
    TgPRI.r_nPowerLevelCount = r_nPowerLevelCount;
    TgPRI.r_nAssistScore = r_nAssistScore;
    TgPRI.r_PawnOwner = r_PawnOwner;
    TgPRI.r_nPowerMaximum = r_nPowerMaximum;
    TgPRI.r_nHealthMaximum = r_nHealthMaximum;
    TgPRI.r_nShieldMaximum = r_nShieldMaximum;
    TgPRI.r_ClanTag = r_ClanTag;
    TgPRI.r_nVisibilityMask = r_nVisibilityMask;
    TgPRI.r_bCanUpgradeLegendary = r_bCanUpgradeLegendary;
    TgPRI.r_nCardsToDraw = r_nCardsToDraw;
    TgPRI.r_nXp = r_nXp;
    TgPRI.SetSpawnPoint(r_SpawnPoint);
    I = 0;
    J0x35C:

    // End:0x3B6 [Loop If]
    if(I < 22)
    {
        TgPRI.r_Scores[I] = r_Scores[I];
        I++;
        // [Loop Continue]
        goto J0x35C;
    }
    // End:0x41B
    if(TgPRI.s_CardDeckTier1.Length > 0)
    {
        TgPRI.s_CardDeckTier1.Remove(0, TgPRI.s_CardDeckTier1.Length);
    }
    // End:0x480
    if(TgPRI.s_CardDeckTier2.Length > 0)
    {
        TgPRI.s_CardDeckTier2.Remove(0, TgPRI.s_CardDeckTier2.Length);
    }
    // End:0x4E5
    if(TgPRI.s_CardDeckTier3.Length > 0)
    {
        TgPRI.s_CardDeckTier3.Remove(0, TgPRI.s_CardDeckTier3.Length);
    }
    // End:0x54A
    if(TgPRI.s_CardDeckTier4.Length > 0)
    {
        TgPRI.s_CardDeckTier4.Remove(0, TgPRI.s_CardDeckTier4.Length);
    }
    // End:0x5AF
    if(TgPRI.s_CardDeckTier5.Length > 0)
    {
        TgPRI.s_CardDeckTier5.Remove(0, TgPRI.s_CardDeckTier5.Length);
    }
    I = 0;
    J0x5BA:

    // End:0x615 [Loop If]
    if(I < s_CardDeckTier1.Length)
    {
        TgPRI.s_CardDeckTier1.AddItem(s_CardDeckTier1[I]);
        I++;
        // [Loop Continue]
        goto J0x5BA;
    }
    I = 0;
    J0x620:

    // End:0x67B [Loop If]
    if(I < s_CardDeckTier2.Length)
    {
        TgPRI.s_CardDeckTier2.AddItem(s_CardDeckTier2[I]);
        I++;
        // [Loop Continue]
        goto J0x620;
    }
    I = 0;
    J0x686:

    // End:0x6E1 [Loop If]
    if(I < s_CardDeckTier3.Length)
    {
        TgPRI.s_CardDeckTier3.AddItem(s_CardDeckTier3[I]);
        I++;
        // [Loop Continue]
        goto J0x686;
    }
    I = 0;
    J0x6EC:

    // End:0x747 [Loop If]
    if(I < s_CardDeckTier4.Length)
    {
        TgPRI.s_CardDeckTier4.AddItem(s_CardDeckTier4[I]);
        I++;
        // [Loop Continue]
        goto J0x6EC;
    }
    I = 0;
    J0x752:

    // End:0x7AD [Loop If]
    if(I < s_CardDeckTier5.Length)
    {
        TgPRI.s_CardDeckTier5.AddItem(s_CardDeckTier5[I]);
        I++;
        // [Loop Continue]
        goto J0x752;
    }
    I = 0;
    J0x7B8:

    // End:0x84E [Loop If]
    if(I < 5)
    {
        TgPRI.r_nDrawnCards[I] = r_nDrawnCards[I];
        TgPRI.r_nDrawnPlayer[I] = r_nDrawnPlayer[I];
        I++;
        // [Loop Continue]
        goto J0x7B8;
    }
    I = 0;
    J0x859:

    // End:0x8B3 [Loop If]
    if(I < 8)
    {
        TgPRI.r_SimProjOverrides[I] = r_SimProjOverrides[I];
        I++;
        // [Loop Continue]
        goto J0x859;
    }
    //return;    
}

function TransferMinionOwnershipTo(TgRepInfo_Player NewOwner)
{
    local TgRepInfo_Deployable DRI;
    local TgRepInfo_Player PRI;

    J0x00:
    // End:0x82 [Loop If]
    if(m_DRIArray.Length > 0)
    {
        DRI = m_DRIArray[0];
        // End:0x72
        if(DRI != none)
        {
            RemoveMinion(DRI);
            NewOwner.AddMinion(DRI);            
        }
        else
        {
            m_DRIArray.Remove(0, 1);
        }
        // [Loop Continue]
        goto J0x00;
    }
    J0x82:

    // End:0x104 [Loop If]
    if(m_PRIArray.Length > 0)
    {
        PRI = m_PRIArray[0];
        // End:0xF4
        if(PRI != none)
        {
            RemoveMinion(PRI);
            NewOwner.AddMinion(PRI);            
        }
        else
        {
            m_PRIArray.Remove(0, 1);
        }
        // [Loop Continue]
        goto J0x82;
    }
    //return;    
}

function OnDeath()
{
    // End:0x1D
    if(s_KillOrDeathStreakModifier > 0)
    {
        s_KillOrDeathStreakModifier = 0;        
    }
    else
    {
        --s_KillOrDeathStreakModifier;
    }
    //return;    
}

function SetFlag(TgCarriedFlag NewFlag)
{
    s_CarriedFlag = NewFlag;
    r_bHasFlag = s_CarriedFlag != none;
    //return;    
}

event SetSpawnPoint(TgTeamPlayerStart SpawnPoint)
{
    // End:0x19
    if(r_SpawnPoint == SpawnPoint)
    {
        return;
    }
    // End:0x4B
    if(r_SpawnPoint != none)
    {
        r_SpawnPoint.s_AssignedPlayers.RemoveItem(self);
    }
    r_SpawnPoint = SpawnPoint;
    // End:0xBF
    if((r_SpawnPoint != none) && r_SpawnPoint.s_AssignedPlayers.Find(self) == -1)
    {
        r_SpawnPoint.s_AssignedPlayers.AddItem(self);
    }
    //return;    
}

// Export UTgRepInfo_Player::execSetSimProjSpeed(FFrame&, void* const)
native function SetSimProjSpeed(int nFireModeId, float fSpeed);

// Export UTgRepInfo_Player::execSetSimProjRemoteProximity(FFrame&, void* const)
native function SetSimProjRemoteProximity(int nFireModeId, float fRemoteProximity);

// Export UTgRepInfo_Player::execSetSimProjDist(FFrame&, void* const)
native function SetSimProjDist(int nFireModeId, float fDist);

// Export UTgRepInfo_Player::execSetSimProjGravityScale(FFrame&, void* const)
native function SetSimProjGravityScale(int nFireModeId, float fGravityScale);

// Export UTgRepInfo_Player::execSetSimProjFireAngle(FFrame&, void* const)
native function SetSimProjFireAngle(int nFireModeId, float fFireAngle);

// Export UTgRepInfo_Player::execFindSimProjOverrideIndex(FFrame&, void* const)
native function int FindSimProjOverrideIndex(int nFireModeId);

// Export UTgRepInfo_Player::execValidateSimProj(FFrame&, void* const)
native function ValidateSimProj(int nIndex);

// Export UTgRepInfo_Player::execGetSimProjOverrides(FFrame&, void* const)
native function bool GetSimProjOverrides(int nFireModeId, out float fRange, out float fRemoteProximity, out float fSpeed, out float fGravityScale, out float fFireAngle);

event SetHUDOverlayDisplayMask(int dodm)
{
    // End:0x36
    if(dodm != r_nDeployableOverlayDisplayMask)
    {
        r_nDeployableOverlayDisplayMask = dodm;
        bNetDirty = true;
    }
    //return;    
}

event SetHUDOverlayIcon(TgObject.DeployableOverlayIcon doi)
{
    // End:0x3A
    if(int(doi) != int(r_eDeployableOverlayIcon))
    {
        r_eDeployableOverlayIcon = doi;
        bNetDirty = true;
    }
    //return;    
}

event SetHUDOverlayState(TgObject.DeployableOverlayState dos)
{
    // End:0x3A
    if(int(dos) != int(r_eDeployableOverlayState))
    {
        r_eDeployableOverlayState = dos;
        bNetDirty = true;
    }
    //return;    
}

event SetHUDOverlayEnemyViewDist(float enemyViewDist)
{
    // End:0x36
    if(enemyViewDist != r_fDeployableOverlayEnemyViewDist)
    {
        r_fDeployableOverlayEnemyViewDist = enemyViewDist;
        bNetDirty = true;
    }
    //return;    
}

// Export UTgRepInfo_Player::execGetDeployableOverlayDisplayMask(FFrame&, void* const)
native simulated function int GetDeployableOverlayDisplayMask();

// Export UTgRepInfo_Player::execGetDeployableOverlayIcon(FFrame&, void* const)
native simulated function TgObject.DeployableOverlayIcon GetDeployableOverlayIcon();

// Export UTgRepInfo_Player::execGetDeployableOverlayState(FFrame&, void* const)
native simulated function TgObject.DeployableOverlayState GetDeployableOverlayState();

// Export UTgRepInfo_Player::execGetDeployableOverlayEnemyViewDist(FFrame&, void* const)
native simulated function float GetDeployableOverlayEnemyViewDist();

defaultproperties
{
    r_eDeployableOverlayIcon=DeployableOverlayIcon.DOI_TURRET
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