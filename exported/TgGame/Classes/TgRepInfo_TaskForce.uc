class TgRepInfo_TaskForce extends TeamInfo
    native(Game)
    nativereplication
    hidecategories(Navigation,Movement,Collision);

const TG_MAX_PREMADE_DEPLOYS = 20;
const TG_MAX_PRIMARY_OBJECTIVES = 5;
const TG_MAX_TASK_TEAM_NUMBER = 10;

struct native TGTEAM_ENTRY
{
    var string fsName;
    var string fsMapName;
    var int nHealth;
    var int nMaxHealth;
    var bool bLeader;
    var TgRepInfo_Player pPrep;

    structdefaultproperties
    {
        fsName=""
        fsMapName=""
        nHealth=0
        nMaxHealth=0
        bLeader=false
        pPrep=none
    }
};

struct native sPredefinedLevelDeployInfo
{
    var int m_Id;
    var Vector m_Location;

    structdefaultproperties
    {
        m_Id=0
        m_Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

struct native TEAMTIMEMANAGER_ENTRY
{
    var TgTimerManager m_TimerManager;
    var int m_nDeviceId;

    structdefaultproperties
    {
        m_TimerManager=none
        m_nDeviceId=0
    }
};

struct native GLOBALEFFECT_ENTRY
{
    var TgEffectGroup eg;
    var TgPawn pawnInstigator;

    structdefaultproperties
    {
        eg=none
        pawnInstigator=none
    }
};

var string c_fsName;
var int r_nTeamId;
var repnotify int r_nLeaderPlayerId;
var repnotify byte r_nTaskForce;
var TgObject.TgMapTeam r_MapTeam;
var int s_nTaskForceChatId;
var int s_nStrikeForceId;
var int s_nTaskTeamNum;
var Color m_Color;
var repnotify bool r_bIsSurrendering;
var bool r_bSpectator;
var bool m_bDestroyOnEmpty;
var bool r_bIsAttacking;
var int s_nPlayerStartCount;
var private array<TGTEAM_ENTRY> m_TeamPlayers;
var private array<TGTEAM_ENTRY> m_TeamBots;
var array<TgRepInfo_Factory> m_Factories;
var private array<TgBotFactory_Minions> m_MinionFactories;
var private array<TEAMTIMEMANAGER_ENTRY> s_TeamTimerManagers;
var TgMinimapManager s_MinimapManager;
var repnotify int r_nScore;
var float r_fTickets;
var repnotify float r_fSecondaryScore;
var repnotify int r_nScorePercent;
var int r_nGoldBuffCount;
var int s_nGodVisionMask;
var private array<GLOBALEFFECT_ENTRY> m_GlobalEffectGroups;
var int m_nTowersKilled;
var int m_nPhoenixCount;
var int r_nGodKillCount;
var int m_nLastGodIndex;
var int m_nLastGodList;
var TgRespawnBeaconExit r_RespawnBeaconExit;
var int c_nScoreOverride;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_RespawnBeaconExit, r_bIsSurrendering, 
        r_nGoldBuffCount, r_nLeaderPlayerId;

    // Pos:0x011
    if((int(Role) == int(ROLE_Authority)) && (bNetDirty || bNetTimelapseInit) || bNetTimelapsePost)
        r_bIsAttacking, r_fSecondaryScore, 
        r_fTickets, r_nScore, 
        r_nScorePercent;

    // Pos:0x04F
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_MapTeam, r_bSpectator, 
        r_nTaskForce, r_nTeamId;
}

// Export UTgRepInfo_TaskForce::execCycleFrom(FFrame&, void* const)
native function TgRepInfo_Player CycleFrom(TgRepInfo_Player pFrom, bool bForward);

// Export UTgRepInfo_TaskForce::execRepEvent(FFrame&, void* const)
native simulated function bool RepEvent(name VarName);

// Export UTgRepInfo_TaskForce::execGetPlayerCount(FFrame&, void* const)
native function int GetPlayerCount();

// Export UTgRepInfo_TaskForce::execGetActivePlayerCount(FFrame&, void* const)
native function int GetActivePlayerCount();

// Export UTgRepInfo_TaskForce::execGetBotCount(FFrame&, void* const)
native function int GetBotCount();

// Export UTgRepInfo_TaskForce::execGetMinionFactoryCount(FFrame&, void* const)
native function int GetMinionFactoryCount();

// Export UTgRepInfo_TaskForce::execGetPlayer(FFrame&, void* const)
native function TgRepInfo_Player GetPlayer(int nIndex);

// Export UTgRepInfo_TaskForce::execGetPlayerById(FFrame&, void* const)
native function TgRepInfo_Player GetPlayerById(int nPawnId);

// Export UTgRepInfo_TaskForce::execGetPlayerByPower(FFrame&, void* const)
native function TgRepInfo_Player GetPlayerByPower(int nIndex);

// Export UTgRepInfo_TaskForce::execGetBot(FFrame&, void* const)
native function TgRepInfo_Player GetBot(int nIndex);

// Export UTgRepInfo_TaskForce::execGetMinionFactory(FFrame&, void* const)
native function TgBotFactory_Minions GetMinionFactory(int nIndex);

// Export UTgRepInfo_TaskForce::execIsLeader(FFrame&, void* const)
native function bool IsLeader(TgRepInfo_Player pTgPri);

// Export UTgRepInfo_TaskForce::execTeamRemoveFrom(FFrame&, void* const)
native function TeamRemoveFrom(Controller Other);

// Export UTgRepInfo_TaskForce::execUpdateSurrenderTimer(FFrame&, void* const)
native function UpdateSurrenderTimer();

// Export UTgRepInfo_TaskForce::execAddGlobalEffectGroup(FFrame&, void* const)
native function AddGlobalEffectGroup(TgEffectGroup eg, TgPawn InstigatorPawn);

// Export UTgRepInfo_TaskForce::execRemoveGlobalEffectGroup(FFrame&, void* const)
native function RemoveGlobalEffectGroup(int nEffectGroupID);

// Export UTgRepInfo_TaskForce::execApplyGlobalEffectGroups(FFrame&, void* const)
native function ApplyGlobalEffectGroups(TgPawn_Character aPawn);

// Export UTgRepInfo_TaskForce::execRemoveGlobalEffectGroups(FFrame&, void* const)
native function RemoveGlobalEffectGroups(TgPawn_Character aPawn);

// Export UTgRepInfo_TaskForce::execReapplyGlobalEffectGroups(FFrame&, void* const)
native function ReapplyGlobalEffectGroups();

// Export UTgRepInfo_TaskForce::execRemoveAllGlobalEffectGroups(FFrame&, void* const)
native function RemoveAllGlobalEffectGroups();

// Export UTgRepInfo_TaskForce::execGetGodCount(FFrame&, void* const)
native function int GetGodCount();

// Export UTgRepInfo_TaskForce::execGetGod(FFrame&, void* const)
native function TgRepInfo_Player GetGod(int nIndex);

// Export UTgRepInfo_TaskForce::execResetGodIterator(FFrame&, void* const)
native function ResetGodIterator();

// Export UTgRepInfo_TaskForce::execGetNextGod(FFrame&, void* const)
native function TgRepInfo_Player GetNextGod(optional bool bIncrement = true, optional bool bReset = false);

// Export UTgRepInfo_TaskForce::execLaneOfSiegeWeapon(FFrame&, void* const)
native function int LaneOfSiegeWeapon();

// Export UTgRepInfo_TaskForce::execGetASiegeWeapon(FFrame&, void* const)
native function TgPawn GetASiegeWeapon();

// Export UTgRepInfo_TaskForce::execHasBot(FFrame&, void* const)
native function bool HasBot(Class<TgPawn> PawnClass);

// Export UTgRepInfo_TaskForce::execGetNumAlivePlayers(FFrame&, void* const)
native function int GetNumAlivePlayers();

// Export UTgRepInfo_TaskForce::execGetPlayers(FFrame&, void* const)
native function GetPlayers(out array<TgRepInfo_Player> List);

// Export UTgRepInfo_TaskForce::execGetPlayersByDistance(FFrame&, void* const)
native function GetPlayersByDistance(Vector fromVector, float dwDist, out array<TgRepInfo_Player> List);

event PostInit()
{
    local TgBotFactory_Minions MinionFactoryIterator;

    // End:0x75
    foreach WorldInfo.AllActors(Class'TgGame.TgBotFactory_Minions', MinionFactoryIterator)
    {
        // End:0x74
        if(int(MinionFactoryIterator.s_nTaskForce) == int(r_nTaskForce))
        {
            m_MinionFactories.AddItem(MinionFactoryIterator);
        }        
    }    
    // End:0x13F
    if(r_nScore != WorldInfo.Game.GoalScore)
    {
        r_nScore = WorldInfo.Game.GoalScore;
        r_nScorePercent = 100;
        bNetDirty = true;
        // End:0x13F
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            ReceivedScoringChanges();
        }
    }
    //return;    
}

simulated event PostDemoRewind()
{
    super(Actor).PostDemoRewind();
    // End:0x38
    if(s_MinimapManager != none)
    {
        s_MinimapManager.RemoveAllEntities();
    }
    //return;    
}

function CreateMinimap(TgObject.TgMapTeam Team, Class<TgMinimapManager> managerClass)
{
    s_MinimapManager = new (self) managerClass;
    r_MapTeam = Team;
    s_MinimapManager.InitForTaskforce(self);
    //return;    
}

function RemoveFromTeam(Controller Other)
{
    TeamRemoveFrom(Other);
    //return;    
}

simulated function bool HasActivePlayers()
{
    local int Index, Count;

    Count = GetPlayerCount();
    Index = 0;
    J0x1F:

    // End:0x8B [Loop If]
    if(Index < Count)
    {
        // End:0x7D
        if(GetPlayer(Index).Owner.GetStateName() != 'PlayerMatchOver')
        {
            return true;
        }
        Index++;
        // [Loop Continue]
        goto J0x1F;
    }
    return false;
    //return ReturnValue;    
}

simulated event ReceivedScoringChanges()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x5F
    if(GRI != none)
    {
        GRI.UpdateGameScoreUI();
    }
    NotifyScoreChange();
    UpdateKismetOnScore();
    //return;    
}

simulated event ReceivedTaskForceNumber()
{
    local TgPlayerController TgPC;
    local TgRepInfo_Player TgPRI;

    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x8B
    if(TgPC != none)
    {
        TgPRI = TgRepInfo_Player(TgPC.PlayerReplicationInfo);
        // End:0x8B
        if(TgPRI != none)
        {
            TgPRI.RecalculateTeamColor();
        }
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x24
    if(VarName == 'r_bIsSurrendering')
    {
        UpdateSurrenderTimer();        
    }
    else
    {
        // End:0x61
        if((VarName == 'r_nScore') || VarName == 'r_nScorePercent')
        {
            ReceivedScoringChanges();            
        }
        else
        {
            // End:0x85
            if(VarName == 'r_nTaskForce')
            {
                ReceivedTaskForceNumber();                
            }
            else
            {
                // End:0xB0
                if(!RepEvent(VarName))
                {
                    super.ReplicatedEvent(VarName);
                }
            }
        }
    }
    //return;    
}

simulated function UpdateKismetOnScore()
{
    local Sequence GameSeq;
    local array<SequenceObject> AllScoreEvents;
    local int I;
    local array<int> ActivateIndices;
    local TgSeqEvent_TaskForceScoreUpdated Event;

    GameSeq = WorldInfo.GetGameSequence();
    // End:0x6A
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_TaskForceScoreUpdated', true, AllScoreEvents);
    }
    ActivateIndices[0] = 0;
    I = 0;
    J0x82:

    // End:0x161 [Loop If]
    if(I < AllScoreEvents.Length)
    {
        Event = TgSeqEvent_TaskForceScoreUpdated(AllScoreEvents[I]);
        // End:0x153
        if((Event != none) && Event.DefenderTaskForce == int(r_nTaskForce))
        {
            Event.currentScore = r_nScore;
            Event.CheckActivate(self, none,, ActivateIndices);
        }
        I++;
        // [Loop Continue]
        goto J0x82;
    }
    //return;    
}

simulated function TgPlayerController FindLocalPlayerController()
{
    local PlayerController PC;

    // End:0x38
    foreach WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
    {
        // End:0x38
        break;        
    }    
    // End:0x5B
    if(PC != none)
    {
        return TgPlayerController(PC);
    }
    return none;
    //return ReturnValue;    
}

simulated function NotifyScoreChange()
{
    local TgPlayerController TgPC;

    TgPC = FindLocalPlayerController();
    // End:0x4D
    if(TgPC != none)
    {
        TgPC.OnScoreChange(int(r_nTaskForce));
    }
    //return;    
}

function array<TGTEAM_ENTRY> getTeamPlayers()
{
    return m_TeamPlayers;
    //return ReturnValue;    
}

simulated event PostTimeLapse(bool bPlayOfTheGame)
{
    // End:0x22
    if(c_nScoreOverride >= 0)
    {
        r_nScore = c_nScoreOverride;
    }
    //return;    
}

defaultproperties
{
    r_MapTeam=TgMapTeam.MAPTEAM_NEUTRAL
    m_nPhoenixCount=3
    c_nScoreOverride=-1
    m_bHasThreadedWork=true
}