class TgAIController_BehaviorGod extends TgAIController_Behavior
    native(AI)
    config(Game)
    hidecategories(Navigation)
    implements(TgPaladinsController);

const GAMEEVENT_PALADINS_PLAYER_KILL = 1001;
const GAMEEVENT_PALADINS_PLAYER_DEATH = 1002;
const GAMEEVENT_PALADINS_PLAYER_KILL_SUICIDE = 2001;
const GAMEEVENT_PALADINS_PLAYER_KILL_NORMAL = 2002;
const GAMEEVENT_PALADINS_PLAYER_KILL_ASSIST = 2003;
const GAMEEVENT_MATCH_STARTED = 0;
const GAMEEVENT_MATCH_ENDED = 1;
const GAMEEVENT_ROUND_STARTED = 2;
const GAMEEVENT_ROUND_ENDED = 3;
const GAMEEVENT_GAME_CLASS = 6;
const GAMEEVENT_GAME_OPTION_URL = 7;
const GAMEEVENT_GAME_MAPNAME = 8;
const GAMEEVENT_MEMORYUSAGE_POLL = 35;
const GAMEEVENT_FRAMERATE_POLL = 36;
const GAMEEVENT_NETWORKUSAGEIN_POLL = 37;
const GAMEEVENT_NETWORKUSAGEOUT_POLL = 38;
const GAMEEVENT_PING_POLL = 39;
const GAMEEVENT_RENDERTHREAD_POLL = 40;
const GAMEEVENT_GAMETHREAD_POLL = 41;
const GAMEEVENT_GPUFRAMETIME_POLL = 42;
const GAMEEVENT_FRAMETIME_POLL = 43;
const GAMEEVENT_TEAM_CREATED = 50;
const GAMEEVENT_TEAM_GAME_SCORE = 51;
const GAMEEVENT_TEAM_MATCH_WON = 4;
const GAMEEVENT_TEAM_ROUND_WON = 5;
const GAMEEVENT_TEAM_ROUND_STALEMATE = 52;
const GAMEEVENT_PLAYER_LOGIN = 100;
const GAMEEVENT_PLAYER_LOGOUT = 101;
const GAMEEVENT_PLAYER_SPAWN = 102;
const GAMEEVENT_PLAYER_MATCH_WON = 103;
const GAMEEVENT_PLAYER_KILL = 104;
const GAMEEVENT_PLAYER_LOCATION_POLL = 105;
const GAMEEVENT_PLAYER_TEAMCHANGE = 106;
const GAMEEVENT_PLAYER_KILL_STREAK = 107;
const GAMEEVENT_PLAYER_DEATH = 108;
const GAMEEVENT_PLAYER_ROUND_WON = 109;
const GAMEEVENT_PLAYER_ROUND_STALEMATE = 110;
const GAMEEVENT_WEAPON_DAMAGE = 150;
const GAMEEVENT_WEAPON_DAMAGE_MELEE = 151;
const GAMEEVENT_WEAPON_FIRED = 152;
const GAMEEVENT_PLAYER_KILL_NORMAL = 200;
const GAMEEVENT_GENERIC_PARAM_LIST_START = 300;
const GAMEEVENT_GENERIC_PARAM_LIST_END = 400;
const GAMEEVENT_GAME_SPECIFIC = 1000;
const GAMEEVENT_MAX_EVENTID = 0x0000FFFF;

var private native const noexport Pointer VfTable_ITgPaladinsController;
var float WaitForSpawnSecs;
var transient int PlayerID;
var transient bool bCanPurchaseItems;
var transient bool bCanPurchaseSkills;
var bool bRespawnAtOriginalLocation;
var transient float CurrentGoldRemainder;
var transient int CurrentGold;
var transient float CurrentXPRemainder;
var transient int CurrentXP;
var transient Vector GeometricMean;

// Export UTgAIController_BehaviorGod::execPurchaseItems(FFrame&, void* const)
native function PurchaseItems();

// Export UTgAIController_BehaviorGod::execCanAllocateSkillPoint(FFrame&, void* const)
native function bool CanAllocateSkillPoint(int DeviceID, TgDevice aDevice);

// Export UTgAIController_BehaviorGod::execHaveBasicSkillsBeenActivated(FFrame&, void* const)
native function bool HaveBasicSkillsBeenActivated();

// Export UTgAIController_BehaviorGod::execGetSkillPointsAvailable(FFrame&, void* const)
native function int GetSkillPointsAvailable();

// Export UTgAIController_BehaviorGod::execPurchaseSkills(FFrame&, void* const)
native function PurchaseSkills();

// Export UTgAIController_BehaviorGod::execPurchaseBurnCards(FFrame&, void* const)
native function PurchaseBurnCards();

// Export UTgAIController_BehaviorGod::execStartReviveTimer(FFrame&, void* const)
native function float StartReviveTimer();

// Export UTgAIController_BehaviorGod::execOnRespawnRuleChanged(FFrame&, void* const)
native function bool OnRespawnRuleChanged();

// Export UTgAIController_BehaviorGod::execSetBotPlayerId(FFrame&, void* const)
native function SetBotPlayerId();

// Export UTgAIController_BehaviorGod::execSetStartingProperties(FFrame&, void* const)
native function SetStartingProperties();

// Export UTgAIController_BehaviorGod::execSetRewardValues(FFrame&, void* const)
native final function SetRewardValues(int XP, int nCredits, Actor Source, optional TgObject.ERewardValueType RewardType = 0, optional bool bFlankKill = false);

// Export UTgAIController_BehaviorGod::execGetTaskForceNumber(FFrame&, void* const)
native function int GetTaskForceNumber();

function InitPlayerReplicationInfo()
{
    local TgRepInfo_Player PRI;

    super(TgAIController).InitPlayerReplicationInfo();
    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x56
    if(PRI != none)
    {
        PRI.r_bForceNotBot = true;
    }
    //return;    
}

event Revive()
{
    //return;    
}

function LiveRespawn(bool bResetHealth, bool bResetDevices)
{
    local Vector NewLocation;
    local Rotator NewRotation;
    local TgPawn myPawn;

    // End:0x36
    if(bRespawnAtOriginalLocation)
    {
        NewLocation = m_vSpawnLocation;
        NewRotation = m_rSpawnDirection;        
    }
    else
    {
        TgGame(WorldInfo.Game).GetReviveLocation(self, NewLocation, NewRotation);
    }
    Pawn.SetLocation(NewLocation);
    Pawn.SetRotation(NewRotation);
    SetRotation(NewRotation);
    Pawn.SetDesiredRotation(NewRotation);
    myPawn = TgPawn(Pawn);
    // End:0x15E
    if(myPawn != none)
    {
        myPawn.LiveRespawn(bResetHealth, bResetDevices);
    }
    //return;    
}

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    // End:0x1A
    if(!IsA('TgAIController_BehaviorGodDisconnected'))
    {
        SetBotPlayerId();
    }
    super.Possess(inPawn, bVehicleTransition);
    NavMeshPath_SearchExtent_Modifier.X = PawnCollisionRadius * 0.2500000;
    NavMeshPath_SearchExtent_Modifier.Y = NavMeshPath_SearchExtent_Modifier.X;
    SetStartingProperties();
    //return;    
}

function PawnDied(Pawn P)
{
    local TgGame_Paladins TgG;

    super.PawnDied(P);
    TgG = TgGame_Paladins(WorldInfo.Game);
    // End:0x85
    if((TgG != none) && TgG.m_bRespawnBots)
    {
        GotoState('Dead');
    }
    //return;    
}

event CopyPropertiesTo(Controller C)
{
    local TgPlayerController PC;
    local TgAIController_BehaviorGod aic;
    local TgRepInfo_Player FromPri, ToPri;

    PC = TgPlayerController(C);
    aic = TgAIController_BehaviorGod(C);
    // End:0x255
    if(PC != none)
    {
        PC.s_nPlayerId = PlayerID;
        PC.r_nXp = CurrentXP;
        PC.s_fXpRemainder = CurrentXPRemainder;
        PC.r_nCurrency = CurrentGold;
        PC.s_fCurrencyRemainder = CurrentGoldRemainder;
        FromPri = TgRepInfo_Player(PlayerReplicationInfo);
        ToPri = TgRepInfo_Player(PC.PlayerReplicationInfo);
        // End:0x252
        if((FromPri != none) && ToPri != none)
        {
            FromPri.CopyProperties(ToPri);
            FromPri.TransferMinionOwnershipTo(ToPri);
            PlayerReplicationInfo = none;
            FromPri.Destroy();
            ToPri.UniqueId.Uid.A = PC.s_nPlayerId;
        }        
    }
    else
    {
        // End:0x4D4
        if(aic != none)
        {
            aic.PlayerID = PlayerID;
            aic.CurrentXP = CurrentXP;
            aic.CurrentXPRemainder = CurrentXPRemainder;
            aic.CurrentGold = CurrentGold;
            aic.CurrentGoldRemainder = CurrentGoldRemainder;
            FromPri = TgRepInfo_Player(PlayerReplicationInfo);
            ToPri = TgRepInfo_Player(aic.PlayerReplicationInfo);
            // End:0x4D4
            if((FromPri != none) && ToPri != none)
            {
                FromPri.CopyProperties(ToPri);
                FromPri.TransferMinionOwnershipTo(ToPri);
                // End:0x4B1
                if(ToPri.r_SpawnPoint != none)
                {
                    aic.m_vSpawnLocation = ToPri.r_SpawnPoint.Location;
                    aic.m_rSpawnDirection = ToPri.r_SpawnPoint.Rotation;
                }
                PlayerReplicationInfo = none;
                FromPri.Destroy();
            }
        }
    }
    //return;    
}

function Rotator GetAdjustedAimFor(Weapon Weap, Vector StartFireLoc)
{
    local Rotator AdjustedAim;

    AdjustedAim = ((Pawn != none) ? Pawn.GetBaseAimRotation(Weap) : Rotation);
    return AdjustedAim;
    //return ReturnValue;    
}

simulated event PostBeginPlay()
{
    local TgGame_Paladins ChaosGame;

    super.PostBeginPlay();
    // End:0x87
    if(int(Role) == int(ROLE_Authority))
    {
        ChaosGame = TgGame_Paladins(WorldInfo.Game);
        // End:0x87
        if(ChaosGame != none)
        {
            ChaosGame.InitializeCreditsFor(TgPaladinsController(self));
        }
    }
    //return;    
}

function int GetCredits()
{
    local TgRepInfo_Player PRI;

    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x4A
    if(PRI != none)
    {
        return PRI.r_nCredits;
    }
    return 0;
    //return ReturnValue;    
}

function SetCredits(int nCreditsAmount)
{
    local TgRepInfo_Player PRI;

    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x108
    if(PRI != none)
    {
        // End:0xBF
        if(nCreditsAmount > PRI.r_nCredits)
        {
            PRI.r_nEarnedCredits += (nCreditsAmount - PRI.r_nCredits);
            PRI.UpdateScoreboard();
        }
        PRI.r_nCredits = nCreditsAmount;
        PRI.bNetDirty = true;
    }
    //return;    
}

function ResetUlt()
{
    local TgPawn TgP;

    TgP = TgPawn(Pawn);
    // End:0x4A
    if(TgP != none)
    {
        TgP.ResetUlt();
    }
    //return;    
}

function TgPawn GetTgPawn()
{
    return TgPawn(Pawn);
    //return ReturnValue;    
}

state Dead
{
    function BeginState(name PreviousStateName)
    {
        local float reviveTime;
        local TgRepInfo_Player RepInfo;

        // End:0x24
        if(Pawn == none)
        {
            super(Object).BeginState(PreviousStateName);
            return;
        }
        Enemy = none;
        Pawn.ShouldCrouch(false);
        reviveTime = StartReviveTimer();
        RepInfo = TgRepInfo_Player(PlayerReplicationInfo);
        // End:0xD5
        if(RepInfo != none)
        {
            RepInfo.OnDeath();
            RepInfo.r_fReviveSecs = reviveTime;
        }
        ResetBlackboard();
        bCanPurchaseItems = true;
        //return;        
    }

    function EndState(name NextStateName)
    {
        local Vector NewLocation;
        local Rotator NewRotation;

        // End:0x9F
        if(((NextStateName != 'None') && NextStateName != 'RoundEnded') && NextStateName != 'PlayerMatchOver')
        {
            // End:0x9F
            if(IsTimerActive('Revive') || (Pawn != none) && Pawn.bPlayedDeath)
            {
                Revive();
            }
        }
        bCanPurchaseItems = false;
        // End:0x19D
        if(Pawn != none)
        {
            // End:0xF0
            if(bRespawnAtOriginalLocation)
            {
                NewLocation = m_vSpawnLocation;
                NewRotation = m_rSpawnDirection;                
            }
            else
            {
                TgGame(WorldInfo.Game).GetReviveLocation(self, NewLocation, NewRotation);
            }
            Pawn.SetCollision(true, true);
            Pawn.SetLocation(NewLocation);
            Pawn.SetRotation(NewRotation);
        }
        ResetBlackboard();
        bIsAlive = true;
        //return;        
    }

    event Revive()
    {
        local TgProperty prop;
        local int Idx;
        local SeqEvent_PlayerSpawned SpawnedEvent;
        local array<SequenceObject> Events;
        local TgRepInfo_Player prep;
        local TgGame_Paladins tgc;

        ClearTimer('Revive');
        ClearTimer('ReviveTimer');
        ClearTimer('ViewObjectiveCamerasTimer');
        prep = TgRepInfo_Player(PlayerReplicationInfo);
        // End:0x8B
        if(prep != none)
        {
            prep.r_fReviveSecs = 0.0000000;
        }
        Pawn.bReplicateMovement = true;
        TgPawn(Pawn).r_DeathInfo.bDead = false;
        TgPawn(Pawn).r_DeathInfo.dmgType = none;
        Pawn.SetRotation(m_rSpawnDirection);
        Pawn.SetDesiredRotation(m_rSpawnDirection);
        TgPawn(Pawn).OnRespawn();
        TgPawn(Pawn).r_nResetCharacter++;
        GotoState('Idle');
        // End:0x30C
        if(WorldInfo.GetGameSequence() != none)
        {
            WorldInfo.GetGameSequence().FindSeqObjectsByClass(Class'Engine.SeqEvent_PlayerSpawned', true, Events);
            Idx = 0;
            J0x249:

            // End:0x30C [Loop If]
            if(Idx < Events.Length)
            {
                SpawnedEvent = SeqEvent_PlayerSpawned(Events[Idx]);
                // End:0x2FE
                if((SpawnedEvent != none) && SpawnedEvent.CheckActivate(self, self))
                {
                    SpawnedEvent.SpawnPoint = none;
                    SpawnedEvent.PopulateLinkedVariableValues();
                }
                Idx++;
                // [Loop Continue]
                goto J0x249;
            }
        }
        prop = TgPawn(Pawn).GetProperty(19);
        TgPawn(Pawn).SetProperty(19, prop.m_fMaximum);
        prop = TgPawn(Pawn).GetProperty(22);
        TgPawn(Pawn).SetProperty(22, prop.m_fMaximum);
        TgPawn(Pawn).bReplicateMovement = true;
        TgPawn(Pawn).m_LastDamager = none;
        TgPawn(Pawn).s_Damagers.Remove(0, TgPawn(Pawn).s_Damagers.Length);
        TgPawn(Pawn).s_nSpawnTime = WorldInfo.TimeSeconds;
        // End:0x55F
        if(prep != none)
        {
            prep.bForceNetUpdate = true;
            Pawn.bForceNetUpdate = true;
            prep.UpdatePlayerLocation();
        }
        tgc = TgGame_Paladins(WorldInfo.Game);
        // End:0x65D
        if(((tgc != none) && tgc.GameplayEventsWriter != none) && tgc.GameplayEventsWriter.IsSessionInProgress())
        {
            tgc.GameplayEventsWriter.LogPlayerSpawnEvent(102, self, Pawn.Class, GetTaskForceNumber());
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    BlackboardType=1
    LocalRepulsorSolverClass=Class'TgGame.TgAILocalPositionSolver_God'
    NavigationSearchModifier_Max=10.0000000
    UtilityHandleClass=Class'TgGame.TgAIUtilityHandle'
    bIsPaused=true
}