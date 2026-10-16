class TgGame_Paladins extends TgGame_Battle
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

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

struct native TeamDifficultyData
{
    var TgAIController_Behavior.EBotDifficultyLevel CurrentBotDifficultyLevel;
    var float TeamSkillLevel;

    structdefaultproperties
    {
        CurrentBotDifficultyLevel=EBotDifficultyLevel.AIDifficulty_Practice
        TeamSkillLevel=0.0000000
    }
};

var config int m_nGoalScore;
var config bool m_bCanPurchaseItemsAnywhere;
var config bool m_bAutoMountOnRespawn;
var config bool m_bDropHealthNuggetOnDeath;
var bool m_bRespawnBots;
var config bool m_bDisableKillcam;
var config bool m_bCanApplyCardEquipStats;
var config bool m_bTalentsEnabled;
var config bool m_bDeckSwappingAlwaysEnabled;
var bool m_bDiminishingReturnsOnCCEnabled;
var const float m_fPlayerWaitTime;
var int m_nHealthNuggetDeployableId;
var int m_nHealthNuggetTeamOnlyDeployableId;
var int m_fHealthNuggetPersistTime;
var config float m_fPlayerViewDistance;
var config float m_fVisibilityVolumeViewDistance;
var float m_fCardCooldownIncrease;
var config float m_fCardCooldownMultiplier;
var config float m_fGameTypeReminderTime;
var config float m_fRespawnBeaconLifeSpan;
var config float m_fBaseRespawnTime;
var const float m_fMapLaneChangeDelay;
var config int m_nStartingCredits;
var config int m_nMaxCredits;
var config string m_GameplayEventsWriterClassName;
var GameplayEventsWriter GameplayEventsWriter;
var TeamDifficultyData DifficultyData[2];
var TgAIDirector AIDirector;

// Export UTgGame_Paladins::execGetRespawnTime(FFrame&, void* const)
native function float GetRespawnTime(int TaskForceNum);

// Export UTgGame_Paladins::execScoreKillGameType(FFrame&, void* const)
native function ScoreKillGameType(out ScoreKillData Data);

// Export UTgGame_Paladins::execGetScoreKillData(FFrame&, void* const)
native function bool GetScoreKillData(Controller Killer, Controller Other, out ScoreKillData Data);

// Export UTgGame_Paladins::execScoreKillCommon(FFrame&, void* const)
native function ScoreKillCommon(out ScoreKillData Data);

// Export UTgGame_Paladins::execOnBeaconReset(FFrame&, void* const)
native function OnBeaconReset(int nTaskForce, Controller Killer);

// Export UTgGame_Paladins::execBeginEndMission(FFrame&, void* const)
native function bool BeginEndMission(optional bool bClearNextMapGame = false, optional Actor EndMissionFocus, optional float fDelayOverride = 0.0000000);

// Export UTgGame_Paladins::execTriggerMapLaneChange(FFrame&, void* const)
native function TriggerMapLaneChange();

// Export UTgGame_Paladins::execBeginGameStatsLogging(FFrame&, void* const)
native function BeginGameStatsLogging();

// Export UTgGame_Paladins::execEndGameStatsLogging(FFrame&, void* const)
native function EndGameStatsLogging();

event FadeAllClients()
{
    local TgPlayerController TgPC;

    // End:0x80
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        TgPC.ClientSetCameraFade(true, MakeColor(0, 0, 0), vect2d(0.0000000, 1.0000000), 0.0100000);        
    }    
    //return;    
}

event PostBeginPlay()
{
    local TgRepInfo_Game GRI;

    super(TgGame_Mission).PostBeginPlay();
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xF6
    if(GRI != none)
    {
        GRI.r_fPlayerViewDistance = m_fPlayerViewDistance;
        GRI.r_fVisibilityVolumeViewDistance = m_fVisibilityVolumeViewDistance;
        GRI.r_eTalentsEnabled = ((m_bTalentsEnabled) ? 2 : 1);
        GRI.r_bBlockKillCam = m_bDisableKillcam;
    }
    // End:0x120
    if(m_fGameTypeReminderTime > 0.0000000)
    {
        SetTimer(m_fGameTypeReminderTime, true, 'ShowGameTypeHelpTip');
    }
    AIDirector = Spawn(Class'TgGame.TgAIDirector');
    BeginGameStatsLogging();
    //return;    
}

function RestartPlayer(Controller aPlayer)
{
    local TgPawn TgP;

    super(TgGame).RestartPlayer(aPlayer);
    // End:0x165
    if((GameplayEventsWriter != none) && GameplayEventsWriter.IsSessionInProgress())
    {
        TgP = TgPawn(aPlayer.Pawn);
        // End:0x107
        if(TgP != none)
        {
            GameplayEventsWriter.LogPlayerSpawnEvent(102, aPlayer, aPlayer.Pawn.Class, int(TgP.GetTaskForceNumber()));            
        }
        else
        {
            GameplayEventsWriter.LogPlayerSpawnEvent(102, aPlayer, aPlayer.Pawn.Class, 1);
        }
    }
    //return;    
}

function InitializeCreditsFor(TgPaladinsController TgPC)
{
    SetCredits(TgPC, m_nStartingCredits);
    //return;    
}

event SetCredits(TgPaladinsController TgPC, int nCreditsAmount)
{
    nCreditsAmount = Min(nCreditsAmount, m_nMaxCredits);
    TgPC.SetCredits(nCreditsAmount);
    //return;    
}

event GiveCredits(TgPaladinsController TgPC, int nCreditsAmount)
{
    local int nCurrentCredits;

    nCurrentCredits = TgPC.GetCredits();
    nCurrentCredits = Min(nCurrentCredits + nCreditsAmount, m_nMaxCredits);
    nCurrentCredits = Max(nCurrentCredits, 0);
    TgPC.SetCredits(nCurrentCredits);
    //return;    
}

event TakeCredits(TgPaladinsController TgPC, int nCreditsAmount)
{
    local int nCurrentCredits;

    nCurrentCredits = TgPC.GetCredits();
    nCurrentCredits = Max(nCurrentCredits - nCreditsAmount, 0);
    nCurrentCredits = Min(nCurrentCredits, m_nMaxCredits);
    TgPC.SetCredits(nCurrentCredits);
    //return;    
}

function ResetCreditsForAllPlayers()
{
    local Controller TheController;
    local TgPaladinsController TgPC;

    // End:0x84
    foreach WorldInfo.AllControllers(Class'Engine.Controller', TheController)
    {
        TgPC = TgPaladinsController(TheController);
        // End:0x83
        if(NotEqual_InterfaceInterface(TgPC, TgPaladinsController(none)))
        {
            InitializeCreditsFor(TgPC);
        }        
    }    
    //return;    
}

function ResetKillstreaksForAllPlayers()
{
    local Controller TheController;
    local TgPaladinsController TgPC;
    local TgPawn TgP;
    local TgRepInfo_Player PRI;

    // End:0x12B
    foreach WorldInfo.AllControllers(Class'Engine.Controller', TheController)
    {
        TgPC = TgPaladinsController(TheController);
        // End:0x12A
        if(NotEqual_InterfaceInterface(TgPC, TgPaladinsController(none)))
        {
            TgP = TgPC.GetTgPawn();
            // End:0x12A
            if(TgP != none)
            {
                PRI = TgRepInfo_Player(TgP.PlayerReplicationInfo);
                // End:0x12A
                if(PRI != none)
                {
                    PRI.r_nKillstreak = 0;
                    PRI.bNetDirty = true;
                }
            }
        }        
    }    
    //return;    
}

function ResetUltForAllPlayers()
{
    local Controller TheController;
    local TgPaladinsController TgPC;

    // End:0x91
    foreach WorldInfo.AllControllers(Class'Engine.Controller', TheController)
    {
        TgPC = TgPaladinsController(TheController);
        // End:0x90
        if(NotEqual_InterfaceInterface(TgPC, TgPaladinsController(none)))
        {
            TgPC.ResetUlt();
        }        
    }    
    //return;    
}

function int GetGameTypeHelpTipIndex(TgPlayerController TgPC)
{
    return -1;
    //return ReturnValue;    
}

function ShowGameTypeHelpTip()
{
    local TgPlayerController TgPC;
    local int HelpTipIndex;

    // End:0x8D
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
    {
        HelpTipIndex = GetGameTypeHelpTipIndex(TgPC);
        // End:0x8C
        if(HelpTipIndex != -1)
        {
            TgPC.ClientRequestHelpText(HelpTipIndex);
        }        
    }    
    //return;    
}

function SendClientsRequestHelpText(int GameTipId)
{
    local TgPlayerController TgPC;
    local int HelpTipIndex;

    HelpTipIndex = GameTipId;
    // End:0x95
    if((GameTipId > 0) && GameTipId != -1)
    {
        // End:0x94
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TgPC)
        {
            TgPC.ClientRequestHelpText(HelpTipIndex);            
        }        
    }
    //return;    
}

function Killed(Controller Killer, Controller KilledPlayer, Pawn KilledPawn, Class<DamageType> DamageType)
{
    local TgRepInfo_Player KillerPRI, KilledPRI;

    super(GameInfo).Killed(Killer, KilledPlayer, KilledPawn, DamageType);
    // End:0x6E
    if(Killer != none)
    {
        KillerPRI = TgRepInfo_Player(Killer.PlayerReplicationInfo);
    }
    // End:0xAE
    if(KilledPawn != none)
    {
        KilledPRI = TgRepInfo_Player(KilledPawn.PlayerReplicationInfo);
    }
    // End:0xE5
    if(KilledPRI != none)
    {
        KilledPRI.s_LastKillerPRI = KillerPRI;
    }
    //return;    
}

function OnPawnDied(TgPawn Victim)
{
    //return;    
}

function OnKillConfirmed(TgRepInfo_Player PRI, TgRepInfo_TaskForce Taskforce, optional int bonusScore = 0)
{
    //return;    
}

function UpdateTgPawnMetaGameState(TgPawn CurPawn, optional TgPawn.EMetaGameState NewState = 0)
{
    //return;    
}

function UpdateAllPawnsMetaGameState(optional TgPawn.EMetaGameState NewState = 0)
{
    //return;    
}

function float GetPlayerWaitTime()
{
    return m_fPlayerWaitTime;
    //return ReturnValue;    
}

event CheckGameState()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce TF1, TF2;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x43
    if((GRI == none) || int(m_GameWinState) != int(0))
    {
        return;
    }
    TF1 = GRI.GetTaskForce(1);
    TF2 = GRI.GetTaskForce(2);
    // End:0x137
    if(TF1.r_nScore >= m_nGoalScore)
    {
        m_GameWinState = 1;
        GRI.r_Winner = GRI.GetTaskForce(2);
        GRI.bNetDirty = true;        
    }
    else
    {
        // End:0x1D0
        if(TF2.r_nScore >= m_nGoalScore)
        {
            m_GameWinState = 2;
            GRI.r_Winner = GRI.GetTaskForce(1);
            GRI.bNetDirty = true;
        }
    }
    // End:0x1EE
    if(int(m_GameWinState) != int(0))
    {
        EndTheGame();
    }
    //return;    
}

function EndTheGame()
{
    local TgPlayerController PC;

    // End:0x5D
    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', PC)
    {
        PC.SendClientSetGameWinState(m_GameWinState);        
    }    
    BeginEndMission();
    UpdateAllPawnsMetaGameState(0);
    //return;    
}

defaultproperties
{
    m_nGoalScore=100
    m_bRespawnBots=true
    m_bTalentsEnabled=true
    m_bDiminishingReturnsOnCCEnabled=true
    m_fPlayerWaitTime=20.0000000
    m_nHealthNuggetDeployableId=643
    m_nHealthNuggetTeamOnlyDeployableId=754
    m_fHealthNuggetPersistTime=30
    m_fPlayerViewDistance=7200.0000000
    m_fVisibilityVolumeViewDistance=256.0000000
    m_fCardCooldownMultiplier=1.0000000
    m_fRespawnBeaconLifeSpan=120.0000000
    m_fBaseRespawnTime=12.0000000
    m_fMapLaneChangeDelay=8.0000000
    m_nStartingCredits=400
    m_nMaxCredits=7500
    m_GameplayEventsWriterClassName="TgGame.TgGameplayEventsWriter"
    DifficultyData[0]=(CurrentBotDifficultyLevel=EBotDifficultyLevel.AIDifficulty_Easy1,TeamSkillLevel=0.0000000)
    DifficultyData[1]=(CurrentBotDifficultyLevel=EBotDifficultyLevel.AIDifficulty_Easy1,TeamSkillLevel=0.0000000)
    m_fSetupTime=0.1000000
}