class TgGame extends FrameworkGame
    abstract
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

const UNKNOWN_PROJECTILE_INSTANCE_ID = 0;
const FIRST_VALID_PROJECTILE_INSTANCE_ID = 1;
const BASE_RESPAWN_TIME_SEC = 5;
const DEFAULT_MOUNT = 11512;

struct native PlayOfTheGameInfo
{
    var TgRepInfo_Player PRI;
    var float Rating;

    structdefaultproperties
    {
        PRI=none
        Rating=0.0000000
    }
};

struct native PlayOfTheGameEventConfig
{
    var TgObject.EPlayOfTheGameEventType EventType;
    var float BaseRating;
    var float MultMod;
    var float MaxTimeDiff;
    var bool ScaleByTimeDiff;
    var int MaxMultInstances;
    var float Threshold;
    var float ThresholdTimeOut;

    structdefaultproperties
    {
        EventType=EPlayOfTheGameEventType.POTG_ScoreKill
        BaseRating=0.0000000
        MultMod=0.0000000
        MaxTimeDiff=0.0000000
        ScaleByTimeDiff=true
        MaxMultInstances=999
        Threshold=0.0000000
        ThresholdTimeOut=10000.0000000
    }
};

struct native TgAIBotPlayersToSpawn
{
    var init string fsName;
    var int nBotId;
    var int nTaskForceId;
    var int nSpawnTableDetailId;

    structdefaultproperties
    {
        fsName=""
        nBotId=0
        nTaskForceId=0
        nSpawnTableDetailId=0
    }
};

var Class m_ContentPackageReference;
var TgObject.GAME_WIN_STATE m_GameWinState;
var TgObject.TG_GAME_TYPE m_GameType;
var float m_fSpawnProtectionTime;
var float m_fMaxRepawnTime;
var float m_fUnpauseCountdownRemaining;
var int s_nBotPlayerCount;
var bool s_bGameInitialized;
var bool s_bGameEndMissionProcessed;
var bool s_bMissionSealed;
var const bool m_bForceUsePRISpawnPoint;
var bool m_bRewardCalculated;
var bool m_bStatsCanTie;
var bool m_bStatsIsSymmetric;
var protected bool m_bIsTutorialGametype;
var protected bool m_bIsPracticeGametype;
var globalconfig bool m_bEnableHeadShots;
var bool m_bPlayOfTheGameLocked;
var protected int s_nNextActorInstanceId;
var protected int s_nNextProjectileInstanceId;
var init array<init TgAIVolume> s_AIVolumes;
var init array<init int> s_Taskforce1AIVolumesIndices;
var init array<init int> s_Taskforce2AIVolumesIndices;
var init array<init TgFortressVolume> s_FortressVolumes;
var init native map{VOID,VOID} s_AIAnnotations;
var init array<init TgDeviceVolume> s_DeviceVolumes;
var array<TgActorFactory> s_ActorFactories;
var float s_fXPModifier;
var const config float m_fGlobalCooldownTime;
var init array<init int> m_ClientLogins;
var config float m_fOcclusionCalcPeriod;
var config float m_fOcclusionMaxDeviation;
var PlayOfTheGameInfo m_PlayOfTheGame;
var float m_fPlayOfTheGameLength;
var float m_fPlayOfTheGameIntroBufferLength;
var float m_fPlayOfTheGameOuttroBufferLength;
var array<PlayOfTheGameEventConfig> m_PlayOfTheGameEventConfigs;
var array<TgSpawnTeleporterExit> m_PlayerSpawnExits;

// Export UTgGame::execLoadGameConfig(FFrame&, void* const)
native function LoadGameConfig();

// Export UTgGame::execInitGameRepInfo(FFrame&, void* const)
native function InitGameRepInfo();

// Export UTgGame::execSpawnPlayerCharacter(FFrame&, void* const)
native function TgPawn SpawnPlayerCharacter(Controller C, Vector vLocation);

// Export UTgGame::execGetWinningTaskforce(FFrame&, void* const)
native function int GetWinningTaskforce();

// Export UTgGame::execBeginEndMission(FFrame&, void* const)
native function bool BeginEndMission(optional bool bClearNextMapGame = false, optional Actor EndMissionFocus, optional float fDelayOverride = 0.0000000);

// Export UTgGame::execFinishEndMission(FFrame&, void* const)
native function bool FinishEndMission();

// Export UTgGame::execSpawnBotById(FFrame&, void* const)
native function TgPawn SpawnBotById(int nBotId, int nSkinId, int nHeadId, int nWeaponSkinId, Vector vLocation, Rotator rRotation, TgBotFactory pFactory, optional bool bIgnoreCollision = false, optional TgPawn pOwnerPawn, optional TgDeviceFire deviceFire, optional float fDeployAnimLength = 0.0000000, optional name ControllerClassName, optional name BehaviorTreeName);

// Export UTgGame::execSpawnBotPawn(FFrame&, void* const)
native function TgPawn SpawnBotPawn(TgAIController pTgAI, Vector vLocation, Rotator rRotation, optional bool bIgnoreCollision = false, optional TgPawn pOwnerPawn, optional float fDeploySecs);

// Export UTgGame::execSpawnTemplatePlayer(FFrame&, void* const)
native function TgPawn SpawnTemplatePlayer(TgPlayerController pTgPC, int nProfileId, optional int nSkinId = 0, optional int nWeaponSkinId = 0, optional int nHeadSkinId = 0);

// Export UTgGame::execEnsureBotPrecache(FFrame&, void* const)
native function EnsureBotPrecache(int nBotId, int nSkinId, int nHeadId, int nDeviceSkinId);

// Export UTgGame::execEnsureDevicePrecache(FFrame&, void* const)
native function EnsureDevicePrecache(int nDeviceId, int nDeviceSkinId);

// Export UTgGame::execEnsureHeadPrecache(FFrame&, void* const)
native function EnsureHeadPrecache(int nHeadId);

// Export UTgGame::execSwapToNewAIController(FFrame&, void* const)
native function bool SwapToNewAIController(Controller C, TgPawn_Character TgPawn);

// Export UTgGame::execSpawnDefaultBotPlayers(FFrame&, void* const)
native function bool SpawnDefaultBotPlayers(out array<TgAIBotPlayersToSpawn> BotPlayersToSpawn, optional bool bStartPaused = true);

// Export UTgGame::execPlayerDied(FFrame&, void* const)
native function PlayerDied(TgPlayerController PC);

// Export UTgGame::execBotDied(FFrame&, void* const)
native function BotDied(TgAIController aic);

// Export UTgGame::execGetActualRespawnTime(FFrame&, void* const)
native final function float GetActualRespawnTime(int TaskForceNum);

// Export UTgGame::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame::execGetGameVersion(FFrame&, void* const)
native static function string GetGameVersion();

// Export UTgGame::execNotifyPostCommitMapChange(FFrame&, void* const)
native function NotifyPostCommitMapChange();

// Export UTgGame::execResetStats(FFrame&, void* const)
native function ResetStats();

// Export UTgGame::execAllowPausing(FFrame&, void* const)
native function bool AllowPausing(optional PlayerController PC);

// Export UTgGame::execBeginUnpauseCountdown(FFrame&, void* const)
native function BeginUnpauseCountdown(float fSeconds);

// Export UTgGame::execEndUnpauseCountdown(FFrame&, void* const)
native function EndUnpauseCountdown();

// Export UTgGame::execSendPauseNotification(FFrame&, void* const)
native function SendPauseNotification(optional PlayerController PC);

// Export UTgGame::execCanSpoolCredits(FFrame&, void* const)
native function bool CanSpoolCredits();

// Export UTgGame::execConsiderForBestPlayOfTheGame(FFrame&, void* const)
native function bool ConsiderForBestPlayOfTheGame(TgRepInfo_Player PRI);

// Export UTgGame::execGetWeightedPlayOfTheGameEventRating(FFrame&, void* const)
native function float GetWeightedPlayOfTheGameEventRating(TgRepInfo_Player PRI, int nIndex);

// Export UTgGame::execCachePlayOfTheGame(FFrame&, void* const)
native function CachePlayOfTheGame();

// Export UTgGame::execResetPlayOfTheGame(FFrame&, void* const)
native function ResetPlayOfTheGame();

// Export UTgGame::execLockPlayOfTheGame(FFrame&, void* const)
native function LockPlayOfTheGame(bool bLocked);

// Export UTgGame::execInitPlayOfTheGameConfig(FFrame&, void* const)
native function InitPlayOfTheGameConfig();

event PreBeginPlay()
{
    super(GameInfo).PreBeginPlay();
    ResetStats();
    //return;    
}

event PostBeginPlay()
{
    local TgSpawnTeleporterExit SpawnTeleExit;

    super(GameInfo).PostBeginPlay();
    s_bGameInitialized = true;
    m_ContentPackageReference = Class<Object>(DynamicLoadObject("TgGameContent.TgKeepContentPackageLoaded", Class'Core.Class'));
    // End:0xBB
    foreach WorldInfo.AllActors(Class'TgGame.TgSpawnTeleporterExit', SpawnTeleExit)
    {
        // End:0xBA
        if(SpawnTeleExit != none)
        {
            m_PlayerSpawnExits.AddItem(SpawnTeleExit);
        }        
    }    
    //return;    
}

function InitGameReplicationInfo()
{
    local TgRepInfo_Game TgGRI;

    InitGameRepInfo();
    super(GameInfo).InitGameReplicationInfo();
    TgGRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x68
    if(TgGRI != none)
    {
        TgGRI.SetEnableHeadshots(m_bEnableHeadShots);
    }
    //return;    
}

event int GetNextActorInstanceId()
{
    return ++s_nNextActorInstanceId;
    //return ReturnValue;    
}

event int GetNextProjectileInstanceId()
{
    // End:0x20
    if(++s_nNextProjectileInstanceId >= (1 << 24))
    {
        s_nNextProjectileInstanceId = 1;
    }
    return s_nNextProjectileInstanceId;
    //return ReturnValue;    
}

function Reset()
{
    local Controller C;

    super(GameInfo).Reset();
    // End:0xB1
    foreach WorldInfo.AllControllers(Class'Engine.Controller', C)
    {
        // End:0xB0
        if((C.PlayerReplicationInfo != none) && !C.PlayerReplicationInfo.bOnlySpectator)
        {
            RestartPlayer(C);
        }        
    }    
    //return;    
}

event InitGame(string Options, out string ErrorMessage)
{
    LoadGameConfig();
    InitPlayOfTheGameConfig();
    super(GameInfo).InitGame(Options, ErrorMessage);
    //return;    
}

function StartBots()
{
    //return;    
}

function Pawn SpawnDefaultPawnFor(Controller NewPlayer, NavigationPoint StartSpot)
{
    local Pawn ResultPawn;
    local TgAIController AI;
    local TgPlayerController PC;

    AI = TgAIController(NewPlayer);
    // End:0x8A
    if(AI != none)
    {
        ResultPawn = SpawnBotPawn(AI, StartSpot.Location, StartSpot.Rotation);        
    }
    else
    {
        PC = TgPlayerController(NewPlayer);
        // End:0xB5
        if(PC == none)
        {
        }
        // End:0xD9
        if(PC.Player == none)
        {
        }
        // End:0x138
        if((PC.PlayerReplicationInfo != none) && PC.PlayerReplicationInfo.bOnlySpectator)
        {
            return none;
        }
        // End:0x165
        if(NetConnection(PC.Player) == none)
        {
        }
        ResultPawn = SpawnPlayerCharacter(PC, StartSpot.Location);
    }
    return ResultPawn;
    //return ReturnValue;    
}

event AllPlayersEndGame(Actor EndGameFocus)
{
    local Controller C;
    local TgPawn P;
    local bool IsWinner;

    IsWinner = false;
    // End:0xFE
    foreach WorldInfo.AllControllers(Class'Engine.Controller', C)
    {
        P = TgPawn(C.Pawn);
        // End:0xCB
        if(P != none)
        {
            // End:0xBF
            if(int(P.GetTaskForceNumber()) == (GetWinningTaskforce()))
            {
                IsWinner = true;                
            }
            else
            {
                IsWinner = false;
            }
        }
        C.GameHasEnded(EndGameFocus, IsWinner);        
    }    
    //return;    
}

function RestartPlayer(Controller aPlayer)
{
    local TgPlayerController PC;
    local bool bHadPawn;
    local NavigationPoint np;

    PC = TgPlayerController(aPlayer);
    // End:0x168
    if(((PC != none) && PC.Player != none) && !PC.PlayerReplicationInfo.bOnlySpectator)
    {
        aPlayer.PlayerReplicationInfo.bReadyToPlay = false;
        PC.ClientSetReadyState(false);
        aPlayer.GotoState('PlayerWaiting');
        // End:0x165
        if(!PC.IsReadyForStart())
        {
            PlayerController(aPlayer).ClientGotoState('Dead', 'Begin');
            return;
        }        
    }
    else
    {
        // End:0x1D0
        if(PC != none)
        {
            PC.ClientSetReadyState(false);
            // End:0x1D0
            if(PC.PlayerReplicationInfo.bOnlySpectator)
            {
                return;
            }
        }
    }
    bHadPawn = aPlayer.Pawn != none;
    super(GameInfo).RestartPlayer(aPlayer);
    // End:0x2E0
    if(bHadPawn)
    {
        np = FindPlayerStart(PC);
        // End:0x2E0
        if(np != none)
        {
            PC.Pawn.SetLocation(np.Location);
            PC.Pawn.SetRotation(np.Rotation);
        }
    }
    TgPawn(PC.Pawn).PostPawnSetupServer();
    // End:0x3E3
    if(PC.s_fWaitForSpawnSecs > 0.0000000)
    {
        // End:0x3A6
        if(PC.Pawn.GetStateName() == 'Dying')
        {
            PC.GotoState('Dead');            
        }
        else
        {
            TgPawn(PC.Pawn).DespawnOnReconnect();
        }
    }
    //return;    
}

function AddDefaultInventory(Pawn PlayerPawn)
{
    //return;    
}

function SetPlayerDefaults(Pawn PlayerPawn)
{
    //return;    
}

event NavigationPoint FindPlayerStartPoint(Controller Player, optional string SpawnTagName)
{
    return FindPlayerStart(Player, 0, SpawnTagName);
    //return ReturnValue;    
}

event NavigationPoint GetReviveLocation(Controller Player, out Vector OutLocation, out Rotator OutRotation)
{
    local NavigationPoint RestartNavPoint;
    local Vector Forward;

    RestartNavPoint = FindPlayerStart(Player);
    // End:0x81
    if(RestartNavPoint != none)
    {
        OutLocation = RestartNavPoint.Location;
        OutRotation = RestartNavPoint.Rotation;        
    }
    else
    {
        // End:0x122
        if(Player.Pawn != none)
        {
            OutLocation = Player.Pawn.Location;
            OutRotation = Player.Pawn.Rotation;            
        }
        else
        {
            // End:0x181
            if(Player != none)
            {
                OutLocation = Player.Location;
                OutRotation = Player.Rotation;
            }
        }
    }
    Forward = Vector(OutRotation);
    // End:0x1D6
    if(Forward.Z < 1.0000000)
    {
        OutRotation = Rotator(Normal2D(Forward));        
    }
    else
    {
        OutRotation = MakeRotator(0, 0, 0);
    }
    return RestartNavPoint;
    //return ReturnValue;    
}

function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName)
{
    local NavigationPoint Start;
    local TgStartPoint PS;

    // End:0x85
    if(m_bForceUsePRISpawnPoint)
    {
        Start = ((TgRepInfo_Player(Player.PlayerReplicationInfo) != none) ? TgRepInfo_Player(Player.PlayerReplicationInfo).r_SpawnPoint : none);
    }
    // End:0xC3
    if(Start == none)
    {
        Start = super(GameInfo).FindPlayerStart(Player, InTeam, IncomingName);
    }
    // End:0xFA
    if(Start == none)
    {
        Start = Player.StartSpot;
    }
    PS = TgStartPoint(Start);
    // End:0x144
    if(PS != none)
    {
        PS.AdjustRating();
    }
    return Start;
    //return ReturnValue;    
}

function NavigationPoint FindPlayerGroupStart(Controller Player, int groupNumber, optional byte InTeam, optional string IncomingName)
{
    local NavigationPoint Start;
    local TgStartPoint PS;
    local float NewRating, BestRating;

    // End:0xD3
    foreach WorldInfo.AllNavigationPoints(Class'TgGame.TgStartPoint', PS)
    {
        // End:0xD2
        if(PS.GetStartGroupNumber() == groupNumber)
        {
            NewRating = PS.GetRating(Player);
            // End:0xD2
            if(NewRating > BestRating)
            {
                BestRating = NewRating;
                Start = PS;
            }
        }        
    }    
    PS = TgStartPoint(Start);
    // End:0x11E
    if(PS != none)
    {
        PS.AdjustRating();
    }
    // End:0x12D
    if(Start != none)
    {
    }
    return Start;
    //return ReturnValue;    
}

event float RatePlayerStartPoint(PlayerStart P, Controller Player)
{
    return RatePlayerStart(P, 0, Player);
    //return ReturnValue;    
}

function float RatePlayerStart(PlayerStart P, byte Team, Controller Player)
{
    local TgStartPoint PS;

    PS = TgStartPoint(P);
    // End:0x54
    if(PS != none)
    {
        return PS.GetRating(Player);
    }
    return super(GameInfo).RatePlayerStart(P, Team, Player);
    //return ReturnValue;    
}

function bool ChangeTeam(Controller Other, int Num, bool bNewTeam)
{
    return false;
    //return ReturnValue;    
}

function bool ShouldSpawnAtStartSpot(Controller Player)
{
    local TgRepInfo_Player PRI;

    PRI = ((Player != none) ? TgRepInfo_Player(Player.PlayerReplicationInfo) : none);
    return super(GameInfo).ShouldSpawnAtStartSpot(Player) && (((PRI == none) || WorldInfo == none) || int(PRI.GetTaskForceNumber()) == int(0)) || int(PRI.GetTaskForceNumber()) == int(255);
    //return ReturnValue;    
}

function GotoGameRunningState()
{
    GotoState('GameRunning');
    //return;    
}

function StartMatch()
{
    local TgPlayerController P;

    GotoGameRunningState();
    super(GameInfo).StartMatch();
    // End:0x8D
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', P)
    {
        // End:0x8C
        if(P.IsInState('PlayerWaiting'))
        {
            P.EnterStartState();
        }        
    }    
    //return;    
}

function AddInactivePRI(PlayerReplicationInfo PRI, PlayerController PC)
{
    local int I;
    local TgRepInfo_Player NewPRI, CurrentPRI;

    // End:0x207
    if(!PRI.bFromPreviousLevel && !PRI.bOnlySpectator)
    {
        NewPRI = TgRepInfo_Player(PRI.Duplicate());
        WorldInfo.GRI.RemovePRI(NewPRI);
        I = 0;
        J0xC4:

        // End:0x1E9 [Loop If]
        if(I < InactivePRIArray.Length)
        {
            CurrentPRI = TgRepInfo_Player(InactivePRIArray[I]);
            // End:0x1DB
            if((((CurrentPRI == none) || CurrentPRI.bDeleteMe) || CurrentPRI.r_nPlayerId == NewPRI.r_nPlayerId) || CurrentPRI.r_nPawnId == NewPRI.r_nPawnId)
            {
                InactivePRIArray.Remove(I, 1);
                I--;
            }
            I++;
            // [Loop Continue]
            goto J0xC4;
        }
        InactivePRIArray[InactivePRIArray.Length] = NewPRI;
    }
    PRI.Destroy();
    //return;    
}

function bool FindInactivePRI(PlayerController PC)
{
    local int I;
    local PlayerReplicationInfo OldPRI, CurrentPRI;
    local TgPlayerController TgPC;

    TgPC = TgPlayerController(PC);
    // End:0x66
    if((TgPC == none) || TgPC.PlayerReplicationInfo.bOnlySpectator)
    {
        return false;
    }
    I = 0;
    J0x71:

    // End:0x3B0 [Loop If]
    if(I < InactivePRIArray.Length)
    {
        CurrentPRI = InactivePRIArray[I];
        // End:0xFC
        if((CurrentPRI == none) || CurrentPRI.bDeleteMe)
        {
            InactivePRIArray.Remove(I, 1);
            I--;            
        }
        else
        {
            // End:0x3A2
            if(TgRepInfo_Player(CurrentPRI).r_nPlayerId == TgRepInfo_Player(TgPC.PlayerReplicationInfo).r_nPlayerId)
            {
                OldPRI = PC.PlayerReplicationInfo;
                PC.PlayerReplicationInfo = CurrentPRI;
                PC.PlayerReplicationInfo.SetOwner(PC);
                PC.PlayerReplicationInfo.RemoteRole = ROLE_SimulatedProxy;
                PC.PlayerReplicationInfo.LifeSpan = 0.0000000;
                OverridePRI(PC, OldPRI);
                WorldInfo.GRI.AddPRI(PC.PlayerReplicationInfo);
                InactivePRIArray.Remove(I, 1);
                OldPRI.bIsInactive = true;
                OldPRI.Destroy();
                TgRepInfo_Player(CurrentPRI).SetTaskForceNumber(TgRepInfo_Player(CurrentPRI).GetTaskForceNumber(), true);
                TgPlayerController(PC).CachedPRI = TgRepInfo_Player(CurrentPRI);
                return true;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x71;
    }
    return false;
    //return ReturnValue;    
}

event PostLogin(PlayerController NewPlayer)
{
    super(GameInfo).PostLogin(NewPlayer);
    // End:0x53
    if(TgSpectatorController(NewPlayer) != none)
    {
        TgSpectatorController(NewPlayer).ForwardToSpectatingMatch();
    }
    //return;    
}

event PostCommitMapChange()
{
    NotifyPostCommitMapChange();
    //return;    
}

simulated function bool CanSpectate(PlayerController Viewer, PlayerReplicationInfo ViewTarget)
{
    local bool bViewTargetIsSpectator, bIsFriendlyWithTarget;
    local TgRepInfo_Player viewerPRI, targetPRI;

    // End:0x11
    if(ViewTarget == none)
    {
        return false;
    }
    bViewTargetIsSpectator = ViewTarget.bOnlySpectator || ViewTarget.bIsSpectator;
    bIsFriendlyWithTarget = true;
    viewerPRI = TgRepInfo_Player(Viewer.PlayerReplicationInfo);
    targetPRI = TgRepInfo_Player(ViewTarget);
    // End:0x11A
    if((targetPRI.r_PawnOwner != none) && targetPRI.r_PawnOwner.IsInState('Dying'))
    {
        return false;
    }
    // End:0x1A9
    if((viewerPRI != none) && targetPRI != none)
    {
        bIsFriendlyWithTarget = (viewerPRI.r_TaskForce == targetPRI.r_TaskForce) && viewerPRI.r_TaskForce != none;
    }
    return !bViewTargetIsSpectator && bIsFriendlyWithTarget;
    //return ReturnValue;    
}

function bool PreventDeath(Pawn KilledPawn, Controller Killer, Class<DamageType> DamageType, Vector HitLocation)
{
    // End:0x63
    if((KilledPawn.Controller != none) && KilledPawn.Controller.IsA('TgPlayerController'))
    {
        return true;        
    }
    else
    {
        // End:0xC6
        if((KilledPawn.Controller != none) && KilledPawn.Controller.IsA('TgAIController_BehaviorGod'))
        {
            return true;            
        }
        else
        {
            // End:0x129
            if((KilledPawn.Controller != none) && KilledPawn.Controller.IsA('TgAIController_Manitcore'))
            {
                return true;                
            }
            else
            {
                return false;
            }
        }
    }
    //return ReturnValue;    
}

function bool SetPause(PlayerController PC, optional delegate<CanUnpause> CanUnpauseDelegate = CanUnpause)
{
    local bool bWasPaused;

    bWasPaused = (WorldInfo.Pauser != none) && m_fUnpauseCountdownRemaining <= float(0);
    // End:0xA6
    if(super(GameInfo).SetPause(PC, CanUnpauseDelegate))
    {
        // End:0x95
        if(!bWasPaused)
        {
            SendPauseNotification(PC);
        }
        m_fUnpauseCountdownRemaining = 0.0000000;
        return true;
    }
    return false;
    //return ReturnValue;    
}

event ClearPause()
{
    local int Index;
    local delegate<CanUnpause> CanUnpauseCriteriaMet;

    // End:0x2E
    if(!AllowPausing() && Pausers.Length > 0)
    {
        Pausers.Length = 0;
    }
    Index = 0;
    J0x39:

    // End:0xBA [Loop If]
    if(Index < Pausers.Length)
    {
        CanUnpauseCriteriaMet = Pausers[Index];
        // End:0xAC
        if(CanUnpauseCriteriaMet == none || CanUnpause())
        {
            Pausers.Remove(Index--, 1);
        }
        Index++;
        // [Loop Continue]
        goto J0x39;
    }
    // End:0x108
    if(Pausers.Length == 0)
    {
        // End:0xF9
        if(WorldInfo.IsPlayInEditor())
        {
            ClearPauseAfterCountdown();            
        }
        else
        {
            BeginUnpauseCountdown(3.0000000);
        }
    }
    //return;    
}

event ClearPauseAfterCountdown()
{
    WorldInfo.Pauser = none;
    //return;    
}

event KickIdler(PlayerController PC)
{
    local TgPlayerController aPC;

    aPC = TgPlayerController(PC);
    // End:0x4B
    if(aPC != none)
    {
        aPC.Logoff(true);
    }
    //return;    
}

function SetEnableHeadshots(bool bEnable)
{
    local TgRepInfo_Game TgGRI;

    m_bEnableHeadShots = bEnable;
    TgGRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x69
    if(TgGRI != none)
    {
        TgGRI.SetEnableHeadshots(bEnable);
    }
    //return;    
}

function int GetGameSpawnPhase(TgPawn TgP)
{
    return -1;
    //return ReturnValue;    
}

function int GetCurrentLane()
{
    return -1;
    //return ReturnValue;    
}

function bool FindValidSpawnPoints(TgPawn TgP, out array<TgSpawnTeleporterExit> ValidExits)
{
    local TgSpawnTeleporterExit Exit;
    local bool bFoundAny;
    local int nGamePhase, nCurrentLane;

    // End:0x11
    if(TgP == none)
    {
        return false;
    }
    nCurrentLane = GetCurrentLane();
    nGamePhase = GetGameSpawnPhase(TgP);
    J0x42:

    // End:0x143 [Loop If]
    if(!bFoundAny && nGamePhase >= 0)
    {
        // End:0x134
        foreach m_PlayerSpawnExits(Exit)
        {
            // End:0x133
            if((Exit.PawnCanUse(TgP) && Exit.nGamePhase == nGamePhase) && (nCurrentLane < 0) || Exit.nLane == nCurrentLane)
            {
                ValidExits.AddItem(Exit);
                bFoundAny = true;
            }            
        }        
        nGamePhase--;
        // [Loop Continue]
        goto J0x42;
    }
    // End:0x1B8
    if(!bFoundAny)
    {
        // End:0x1B7
        foreach m_PlayerSpawnExits(Exit)
        {
            // End:0x1B6
            if(Exit.PawnCanUse(TgP))
            {
                ValidExits.AddItem(Exit);
                bFoundAny = true;
            }            
        }        
    }
    return bFoundAny;
    //return ReturnValue;    
}

function PlayerStart FindPlayerStartForCapturePoint(TgChaosCapturePoint CapPoint, Controller Player, optional bool bUseAttackingForwardSpawn = true)
{
    local TgRepInfo_Game GRI;
    local PlayerStart BestStart;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x14A
    if((GRI != none) && CapPoint != none)
    {
        // End:0x118
        if((bUseAttackingForwardSpawn && GRI.r_AttackingTaskForce != none) && int(GRI.r_AttackingTaskForce.GetTeamNum()) == (GetTaskForceForPlayer(Player)))
        {
            BestStart = FindBestPlayerStart(CapPoint.m_PlayerRespawnPoints, Player);
            // End:0x118
            if(BestStart != none)
            {
                return BestStart;
            }
        }
        return FindBestPlayerStart(CapPoint.m_PlayerBaseSpawnPoints, Player);
    }
    return none;
    //return ReturnValue;    
}

function PlayerStart FindBestPlayerStart(out array<PlayerStart> PlayerStartPoints, Controller Player)
{
    local PlayerStart BestStart;
    local int I, nTaskForce;
    local float BestRating, NewRating;

    nTaskForce = GetTaskForceForPlayer(Player);
    I = 0;
    J0x28:

    // End:0x122 [Loop If]
    if(I < PlayerStartPoints.Length)
    {
        // End:0x5C
        if(PlayerStartPoints[I] == none)
        {            
        }
        else
        {
            // End:0x114
            if(nTaskForce == PlayerStartPoints[I].TeamIndex)
            {
                NewRating = RatePlayerStart(PlayerStartPoints[I], byte(nTaskForce), Player);
                // End:0x114
                if(NewRating > BestRating)
                {
                    BestRating = NewRating;
                    BestStart = PlayerStartPoints[I];
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x28;
    }
    return BestStart;
    //return ReturnValue;    
}

static function int GetTaskForceForPlayer(Controller Player)
{
    // End:0x44
    if(TgPlayerController(Player) != none)
    {
        return TgPlayerController(Player).GetTaskForceNumber();        
    }
    else
    {
        // End:0x85
        if(TgAIController(Player) != none)
        {
            return TgAIController(Player).GetTaskForceNumber();
        }
    }
    return -1;
    //return ReturnValue;    
}

event AddPotGEventToAllPlayers(TgObject.EPlayOfTheGameEventType potgEvent)
{
    local TgRepInfo_Game TgGRI;

    TgGRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x53
    if(TgGRI != none)
    {
        TgGRI.AddPotGEventToAllPlayers(potgEvent);
    }
    //return;    
}

auto state PrepGameStart
{
    function Timer()
    {
        global.Timer();
        //return;        
    }
Begin:

    StartMatch();
    stop;        
}

state GameRunning
{
    function BeginState(name PreviousStateName)
    {
        local PlayerReplicationInfo PRI;

        // End:0x5E
        if(PreviousStateName != 'RoundOver')
        {
            // End:0x51
            foreach DynamicActors(Class'Engine.PlayerReplicationInfo', PRI)
            {
                PRI.StartTime = 0;                
            }            
            bWaitingToStartMatch = false;
        }
        //return;        
    }

    function Timer()
    {
        global.Timer();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fSpawnProtectionTime=3.0000000
    m_fMaxRepawnTime=60.0000000
    m_bEnableHeadShots=true
    s_nNextActorInstanceId=1
    s_nNextProjectileInstanceId=1
    s_fXPModifier=1.0000000
    m_fGlobalCooldownTime=1.0000000
    m_fOcclusionCalcPeriod=0.1000000
    m_fPlayOfTheGameLength=13.0000000
    m_fPlayOfTheGameIntroBufferLength=2.0000000
    m_fPlayOfTheGameOuttroBufferLength=2.0000000
    bRestartLevel=false
    bDelayedStart=false
    DefaultPawnClass=Class'TgGame.TgPawn_Character'
    HUDType=Class'TgGame.TgHUD'
    PlayerControllerClass=Class'TgGame.TgPlayerController'
    PlayerReplicationInfoClass=Class'TgGame.TgRepInfo_Player'
    GameReplicationInfoClass=Class'TgGame.TgRepInfo_Game'
    OnlineGameSettingsClass=Class'TgGame.TgOnlineGameSettings'
}