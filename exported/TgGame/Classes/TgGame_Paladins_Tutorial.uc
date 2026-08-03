class TgGame_Paladins_Tutorial extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision);

const PALADINS_ACTIVITY_WELL_TRAINED = 1975;

enum ETutorialState
{
    ETutState_Invalid,              // 0
    ETutState_TutorialIntro,        // 1
    ETutState_MoveForwardBackward,  // 2
    ETutState_MoveRightLeft,        // 3
    ETutState_PlayerApproachBot,    // 4
    ETutState_PlayerMoveToShootingRange,// 5
    ETutState_HealthBar,            // 6
    ETutState_AutoAbility,          // 7
    ETutState_AutoAbilityMultipleEnemies,// 8
    ETutState_BattleAbility,        // 9
    ETutState_CooldownExplain,      // 10
    ETutState_MovementAbility,      // 11
    ETutState_PlayerMoveToUltimateShootingRange,// 12
    ETutState_AltAbility,           // 13
    ETutState_UltimateAbilityCharge,// 14
    ETutState_UltimateAbility,      // 15
    ETutState_Mount,                // 16
    ETutState_PlayerMovingToJumpArea,// 17
    ETutState_Jump,                 // 18
    ETutState_PlayerMovingToObjective,// 19
    ETutState_CapturingObjective,   // 20
    ETutState_ContestingObjective,  // 21
    ETutState_PayloadSpawn,         // 22
    ETutState_PayloadContest,       // 23
    ETutState_PayloadPush,          // 24
    ETutState_TutorialComplete,     // 25
    ETutState_MAX                   // 26
};

enum ETutorialAnnouncerLine
{
    Announcer_Line_Tutorial_A_PortalRoom_010,// 0
    Announcer_Line_Tutorial_A_PortalRoom_020,// 1
    Announcer_Line_Tutorial_A_PortalRoom_030,// 2
    Announcer_Line_Tutorial_A_PortalRoom_040,// 3
    Announcer_Line_Tutorial_A_PortalRoom_050,// 4
    Announcer_Line_Tutorial_A_PortalRoom_060,// 5
    Announcer_Line_Tutorial_A_PortalRoom_070,// 6
    Announcer_Line_Tutorial_A_PortalRoom_080,// 7
    Announcer_Line_Tutorial_A_PortalRoom_090,// 8
    Announcer_Line_Tutorial_A_PortalRoom_100,// 9
    Announcer_Line_Tutorial_A_PortalRoom_110,// 10
    Announcer_Line_Tutorial_B_BasicTraining_020,// 11
    Announcer_Line_Tutorial_B_BasicTraining_030,// 12
    Announcer_Line_Tutorial_B_BasicTraining_050,// 13
    Announcer_Line_Tutorial_B_BasicTraining_060,// 14
    Announcer_Line_Tutorial_B_BasicTraining_070,// 15
    Announcer_Line_Tutorial_B_BasicTraining_080,// 16
    Announcer_Line_Tutorial_B_BasicTraining_090,// 17
    Announcer_Line_Tutorial_B_BasicTraining_110,// 18
    Announcer_Line_Tutorial_B_BasicTraining_120,// 19
    Announcer_Line_Tutorial_B_BasicTraining_130,// 20
    Announcer_Line_Tutorial_B_BasicTraining_140,// 21
    Announcer_Line_Tutorial_B_BasicTraining_150,// 22
    Announcer_Line_Tutorial_B_BasicTraining_160,// 23
    Announcer_Line_Tutorial_B_BasicTraining_170,// 24
    Announcer_Line_Tutorial_B_BasicTraining_180,// 25
    Announcer_Line_Tutorial_B_BasicTraining_190,// 26
    Announcer_Line_Tutorial_B_BasicTraining_200,// 27
    Announcer_Line_Tutorial_B_BasicTraining_210,// 28
    Announcer_Line_Tutorial_B_BasicTraining_220,// 29
    Announcer_Line_Tutorial_B_BasicTraining_230,// 30
    Announcer_Line_Tutorial_B_BasicTraining_240,// 31
    Announcer_Line_Tutorial_B_BasicTraining_250,// 32
    Announcer_Line_Tutorial_B_BasicTraining_260,// 33
    Announcer_Line_Tutorial_B_BasicTraining_270,// 34
    Announcer_Line_Tutorial_B_BasicTraining_280,// 35
    Announcer_Line_Tutorial_B_BasicTraining_290,// 36
    Announcer_Line_Tutorial_B_BasicTraining_300,// 37
    Announcer_Line_Tutorial_B_BasicTraining_310,// 38
    Announcer_Line_Tutorial_B_BasicTraining_320,// 39
    Announcer_Line_Tutorial_B_BasicTraining_330,// 40
    Announcer_Line_Tutorial_B_BasicTraining_340,// 41
    Announcer_Line_Tutorial_B_BasicTraining_350,// 42
    Announcer_Line_Tutorial_B_BasicTraining_360,// 43
    Announcer_Line_Tutorial_B_BasicTraining_370,// 44
    Announcer_Line_Tutorial_B_BasicTraining_380,// 45
    Announcer_Line_Tutorial_B_BasicTraining_390,// 46
    Announcer_Line_Tutorial_B_BasicTraining_400,// 47
    Announcer_Line_Tutorial_B_BasicTraining_410,// 48
    Announcer_Line_Tutorial_B_BasicTraining_420,// 49
    Announcer_Line_Tutorial_B_BasicTraining_430,// 50
    Announcer_Line_Tutorial_B_BasicTraining_440,// 51
    Announcer_Line_Tutorial_B_BasicTraining_450,// 52
    Announcer_Line_Tutorial_B_BasicTraining_460,// 53
    Announcer_Line_Tutorial_B_BasicTraining_470,// 54
    Announcer_Line_Tutorial_C_PortalRoom2_010,// 55
    Announcer_Line_Tutorial_C_PortalRoom2_020,// 56
    Announcer_Line_Tutorial_C_PortalRoom2_030,// 57
    Announcer_Line_Tutorial_C_PortalRoom2_040,// 58
    Announcer_Line_Tutorial_C_PortalRoom2_050,// 59
    Announcer_Line_Tutorial_C_PortalRoom2_060,// 60
    Announcer_Line_Tutorial_C_PortalRoom2_070,// 61
    Announcer_Line_Tutorial_C_PortalRoom2_080,// 62
    Announcer_Line_Tutorial_C_PortalRoom2_085,// 63
    Announcer_Line_Tutorial_C_PortalRoom2_090,// 64
    Announcer_Line_Tutorial_C_PortalRoom2_100,// 65
    Announcer_Line_Tutorial_C_PortalRoom2_110,// 66
    Announcer_Line_Tutorial_D_Objective_012,// 67
    Announcer_Line_Tutorial_D_Objective_015,// 68
    Announcer_Line_Tutorial_D_Objective_018,// 69
    Announcer_Line_Tutorial_D_Objective_020,// 70
    Announcer_Line_Tutorial_D_Objective_022,// 71
    Announcer_Line_Tutorial_D_Objective_025,// 72
    Announcer_Line_Tutorial_D_Objective_028,// 73
    Announcer_Line_Tutorial_D_Objective_030,// 74
    Announcer_Line_Tutorial_D_Objective_040,// 75
    Announcer_Line_Tutorial_D_Objective_050,// 76
    Announcer_Line_Tutorial_D_Objective_060,// 77
    Announcer_Line_Tutorial_D_Objective_065,// 78
    Announcer_Line_Tutorial_D_Objective_070,// 79
    Announcer_Line_Tutorial_D_Objective_080,// 80
    Announcer_Line_Tutorial_D_Objective_090,// 81
    Announcer_Line_Tutorial_D_Objective_100,// 82
    Announcer_Line_Tutorial_D_Objective_110,// 83
    Announcer_Line_Tutorial_D_Objective_120,// 84
    Announcer_Line_Tutorial_D_Objective_130,// 85
    Announcer_Line_Tutorial_D_Objective_140,// 86
    Announcer_Line_Tutorial_D_Objective_150,// 87
    Announcer_Line_Tutorial_D_Objective_160,// 88
    Announcer_Line_Tutorial_D_Objective_170,// 89
    Announcer_Line_Tutorial_MAX     // 90
};

enum ETutorialUI
{
    ETUI_Health,                    // 0
    ETUI_Auto,                      // 1
    ETUI_BattleAbility,             // 2
    ETUI_MovementAbility,           // 3
    ETUI_Alt,                       // 4
    ETUI_Ultimate,                  // 5
    ETUI_CapturePoint,              // 6
    ETUI_Payload,                   // 7
    ETUI_ScoreSection,              // 8
    ETUI_PushTime,                  // 9
    ETUI_Cards,                     // 10
    ETUI_Prompt,                    // 11
    ETUI_Killfeed,                  // 12
    ETUI_MAX                        // 13
};

var transient TgGame_Paladins_Tutorial.ETutorialState m_eCurrentState;
var private transient TgTutorialInfo TutorialInfo;
var float m_fSetupPauseTime;
var bool m_bSetupTimerPaused;
var transient bool m_bReceivedMovementAbility;
var transient bool m_bReachedJumpLowerArea;
var transient bool m_bReachedJumpUpperArea;
var transient bool m_bDamagedWithAlt;
var transient bool m_bDamagedWithBattle;
var transient bool m_bDamagedWithUlt;
var transient bool m_bPointCaptured;
var transient bool m_bWaitingForUIReady;
var transient float m_fReceivedMoveForwardSeconds;
var transient float m_fReceivedMoveBackwardSeconds;
var transient float m_fReceivedMoveLeftSeconds;
var transient float m_fReceivedMoveRightSeconds;
var transient float m_fVolumeStandTime;
var transient float m_fLastFrameDeltaTime;
var AkEvent m_EndAnnouncerAudioEvent;

// Export UTgGame_Paladins_Tutorial::execEnableTutorialUI(FFrame&, void* const)
native exec function EnableTutorialUI(TgGame_Paladins_Tutorial.ETutorialUI TutUIElement, bool bEnable, optional float fFadeTime = 0.5000000);

// Export UTgGame_Paladins_Tutorial::execAwardAchievement(FFrame&, void* const)
native function AwardAchievement();

// Export UTgGame_Paladins_Tutorial::execGetWinningTaskforce(FFrame&, void* const)
native function int GetWinningTaskforce();

// Export UTgGame_Paladins_Tutorial::execHideWorldOverlays(FFrame&, void* const)
native function HideWorldOverlays();

// Export UTgGame_Paladins_Tutorial::execIsUIReady(FFrame&, void* const)
native function bool IsUIReady();

// Export UTgGame_Paladins_Tutorial::execGetObjectiveMsg(FFrame&, void* const)
native function int GetObjectiveMsg();

// Export UTgGame_Paladins_Tutorial::execGetGamepadObjectiveMsg(FFrame&, void* const)
native function int GetGamepadObjectiveMsg();

// Export UTgGame_Paladins_Tutorial::execGetAnnouncerSTM(FFrame&, void* const)
native function int GetAnnouncerSTM(TgGame_Paladins_Tutorial.ETutorialAnnouncerLine eLine);

function StartMatch()
{
    local TgPawn TgP;
    local TgPlayerController TgPC;
    local TgRepInfo_Game GRI;

    TgPC = GetLocalTgPlayerController();
    // End:0x1AE
    if(TgPC != none)
    {        
        TgPC.ConsoleCommand("switchclass Viktor", true);
        TgPC.SetAllInputAllowed(false);
        TgPC.bGodMode = true;
        TgP = TgPawn(TgPC.Pawn);
        // End:0x141
        if(TgP != none)
        {
            TgP.PrepareIntro();
            TgP.SetTaskForceNumber(1);
            TgP.s_bHasInteractedWithStore = true;
        }
        TgPC.SetCanPurchaseFlag(false);
        TgPC.m_bShowChampionOverviewTip = false;
        TgPC.ClearTimer('ShowChampionOverviewTip');        
    }
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x233
    if(GRI != none)
    {
        GRI.r_bBlockCreditGain = true;
        GRI.r_bBlockEnergyGain = true;        
    }
    super(TgGame_Mission).StartMatch();
    //return;    
}

function StartGameMode()
{
    // End:0x13
    if((GetTutorialInfo()) == none)
    {        
    }
    else
    {
        GotoState('TutorialIntro');
    }
    //return;    
}

function LocalPlayerInputReceived(TgPlayerController.EPlayerInputType InputType)
{
    //return;    
}

event LocalPlayerDeviceOnDamaged(out OnDamagedParams Params)
{
    //return;    
}

function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce Taskforce1;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x61
    if(GRI != none)
    {
        GRI.r_CapturingTaskForce = none;
    }
    // End:0x106
    if(nTaskForce == 1)
    {
        m_bPointCaptured = true;
        Taskforce1 = GRI.GetTaskForce(1);
        // End:0x103
        if(Taskforce1 != none)
        {
            Taskforce1.r_bIsAttacking = nTaskForce == 1;
            Taskforce1.bNetDirty = true;
        }        
    }
    //return;    
}

function bool IsAllAudioFinished()
{
    return (((!IsTimerActive('Audio1') && !IsTimerActive('Audio2')) && !IsTimerActive('Audio3')) && !IsTimerActive('Audio4')) && !IsTimerActive('Audio5');
    //return ReturnValue;    
}

function HaltAllAudio()
{
    PlayAK(m_EndAnnouncerAudioEvent);
    TryClearTimer('Audio1');
    TryClearTimer('Audio2');
    TryClearTimer('Audio3');
    TryClearTimer('Audio4');
    TryClearTimer('Audio5');
    //return;    
}

function float GetRepeatInstructionTime()
{
    return GetTutorialInfo().fRepeatInstructionTime;
    //return ReturnValue;    
}

function StartRepeatInstructions()
{
    SetTimer(GetRepeatInstructionTime(), false, 'RepeatInstructions');
    //return;    
}

function StopRepeatInstructions()
{
    // End:0x2B
    if(IsTimerActive('RepeatInstructions'))
    {
        ClearTimer('RepeatInstructions');
    }
    //return;    
}

function RepeatInstructions()
{
    StartRepeatInstructions();
    //return;    
}

function DisableUI()
{
    local int X;

    X = 0;
    J0x0B:

    // End:0x44 [Loop If]
    if(X < 13)
    {
        EnableTutorialUI(byte(X), false, 0.0500000);
        X++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

function SpawnCurrentBots()
{
    local TgBotFactory Factory;

    Factory = GetCurrentBotFactory();
    // End:0x61
    if(Factory != none)
    {
        Factory.ResetQueue();
        Factory.SpawnNextBot();
    }
    //return;    
}

event bool CurrentBotsDead()
{
    local TgBotFactory Factory;

    Factory = GetCurrentBotFactory();
    return (Factory == none) || (Factory.nCurrentCount == 0) && Factory.m_SpawnQueue.Length == 0;
    //return ReturnValue;    
}

function TgBotFactory GetCurrentBotFactory()
{
    return none;
    //return ReturnValue;    
}

function KillHelper()
{
    GetTutorialInfo().DestroyHelperBot();
    //return;    
}

function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
{
    return 0;
    //return ReturnValue;    
}

event Tick(float DeltaSeconds)
{
    super(Actor).Tick(DeltaSeconds);
    m_fLastFrameDeltaTime = DeltaSeconds;
    m_eCurrentState = GetTutorialState();
    //return;    
}

function float GetPointCaptureScoreMultiplier(int nTaskForce)
{
    // End:0x65
    if((nTaskForce == 1) && (IsInState('CapturingObjective') || IsInState('BotMovingToContestObjective')) || IsInState('ContestingObjective'))
    {
        return GetTutorialInfo().fPlayerTeamCaptureMultiplier;
    }
    return 0.0000000;
    //return ReturnValue;    
}

function PauseSetupTimerAt(float TimeRemaining)
{
    // End:0xCB
    if(((TimeRemaining > 0.0000000) && !m_bSetupTimerPaused) && IsTimerActive('OpenSpawnGates'))
    {
        // End:0xCB
        if((GetTimerRate('OpenSpawnGates') - GetTimerCount('OpenSpawnGates')) > TimeRemaining)
        {
            m_fSetupPauseTime = TimeRemaining;
            SetTimer((GetTimerRate('OpenSpawnGates') - GetTimerCount('OpenSpawnGates')) - m_fSetupPauseTime, false, 'PauseSetupTimer');
        }
    }
    //return;    
}

function PauseSetupTimer()
{
    ClearTimer('PauseSetupTimer');
    m_bSetupTimerPaused = true;
    // End:0x4B
    if(IsTimerActive('StartBroadcastTimer'))
    {
        ClearTimer('StartBroadcastTimer');
    }
    // End:0x76
    if(IsTimerActive('BroadcastTimer'))
    {
        ClearTimer('BroadcastTimer');
    }
    // End:0xA2
    if(IsTimerActive('PickNextObjective'))
    {
        PauseTimer(true, 'PickNextObjective');
    }
    // End:0xCE
    if(IsTimerActive('OpenSpawnGates'))
    {
        PauseTimer(true, 'OpenSpawnGates');
    }
    // End:0xFA
    if(IsTimerActive('AutoMountAllPlayers'))
    {
        PauseTimer(true, 'AutoMountAllPlayers');
    }
    // End:0x126
    if(IsTimerActive('AutoMountAttackers'))
    {
        PauseTimer(true, 'AutoMountAttackers');
    }
    // End:0x152
    if(IsTimerActive('AutoMountDefenders'))
    {
        PauseTimer(true, 'AutoMountDefenders');
    }
    //return;    
}

function UnpauseSetupTimer()
{
    // End:0x1E0
    if(m_bSetupTimerPaused)
    {
        // End:0x39
        if(IsTimerActive('StartBroadcastTimer'))
        {
            PauseTimer(false, 'StartBroadcastTimer');
        }
        // End:0x65
        if(IsTimerActive('BroadcastTimer'))
        {
            PauseTimer(false, 'BroadcastTimer');
        }
        // End:0x91
        if(IsTimerActive('PickNextObjective'))
        {
            PauseTimer(false, 'PickNextObjective');
        }
        // End:0xBD
        if(IsTimerActive('OpenSpawnGates'))
        {
            PauseTimer(false, 'OpenSpawnGates');
        }
        // End:0xE9
        if(IsTimerActive('AutoMountAllPlayers'))
        {
            PauseTimer(false, 'AutoMountAllPlayers');
        }
        // End:0x115
        if(IsTimerActive('AutoMountAttackers'))
        {
            PauseTimer(false, 'AutoMountAttackers');
        }
        // End:0x141
        if(IsTimerActive('AutoMountDefenders'))
        {
            PauseTimer(false, 'AutoMountDefenders');
        }
        // End:0x16D
        if(IsTimerActive('ResetAllPlayersNotInSpawnRoom'))
        {
            PauseTimer(false, 'ResetAllPlayersNotInSpawnRoom');
        }
        // End:0x199
        if(IsTimerActive('ResetAttackersNotInSpawnRoom'))
        {
            PauseTimer(false, 'ResetAttackersNotInSpawnRoom');
        }
        // End:0x1C5
        if(IsTimerActive('ResetDefendersNotInSpawnRoom'))
        {
            PauseTimer(false, 'ResetDefendersNotInSpawnRoom');
        }
        m_fSetupPauseTime = -1.0000000;
        m_bSetupTimerPaused = false;
    }
    //return;    
}

function TrySetTimer(float fLength, optional bool bLoop = false, optional name FunctionToCall = 'Timer')
{
    // End:0x4B
    if(!IsTimerActive(FunctionToCall))
    {
        SetTimer(fLength, bLoop, FunctionToCall);
    }
    //return;    
}

function TryClearTimer(name TimerName)
{
    // End:0x2B
    if(IsTimerActive(TimerName))
    {
        ClearTimer(TimerName);
    }
    //return;    
}

function TgPlayerController GetLocalTgPlayerController()
{
    return TgPlayerController(GetALocalPlayerController());
    //return ReturnValue;    
}

function TgPawn GetLocalPlayerPawn()
{
    local TgPlayerController TgPC;

    TgPC = GetLocalTgPlayerController();
    // End:0x4B
    if(TgPC != none)
    {
        return TgPawn(TgPC.Pawn);
    }
    //return ReturnValue;    
}

function TgDevice GetLocalPlayerDevice(TgObject.TG_EQUIP_POINT eqp)
{
    local TgPawn TgP;

    TgP = GetLocalPlayerPawn();
    // End:0x4E
    if(TgP != none)
    {
        return TgP.GetDeviceByEqPoint(int(eqp));
    }
    return none;
    //return ReturnValue;    
}

function TgTutorialInfo GetTutorialInfo()
{
    local TgTutorialInfo FoundInfo;

    // End:0x73
    if(TutorialInfo == none)
    {
        // End:0x72
        foreach WorldInfo.AllActors(Class'TgGame.TgTutorialInfo', FoundInfo)
        {
            // End:0x71
            if(FoundInfo != none)
            {
                // End:0x71
                if(TutorialInfo == none)
                {
                    TutorialInfo = FoundInfo;
                    // End:0x71
                    continue;
                }
            }            
        }        
    }
    return TutorialInfo;
    //return ReturnValue;    
}

function PlayAK(AkBaseSoundObject AKObj, optional float fLength, optional name NextFunction = 'None')
{
    local TgPlayerController TgPC;

    TgPC = GetLocalTgPlayerController();
    // End:0x59
    if(TgPC != none)
    {
        TgPC.ClientPlaySoundBase(AKObj);
    }
    // End:0x9C
    if((fLength > 0.0000000) && NextFunction != 'None')
    {
        SetTimer(fLength, false, NextFunction);
    }
    //return;    
}

function PlayAnnouncer(TgGame_Paladins_Tutorial.ETutorialAnnouncerLine eAnnouncerLine, optional float fLength, optional name NextFunction = 'None')
{
    local TgPlayerController TgPC;
    local int nAnnouncerSTM;

    nAnnouncerSTM = GetAnnouncerSTM(eAnnouncerLine);
    // End:0x10E
    if(nAnnouncerSTM > 0)
    {
        TgPC = GetLocalTgPlayerController();
        // End:0xCB
        if((TgPC != none) && TgPC.c_SubtitledMessages != none)
        {
            TgPC.c_SubtitledMessages.PlaySubtitledMessage(nAnnouncerSTM, true, true, m_EndAnnouncerAudioEvent);
        }
        // End:0x10E
        if((fLength > 0.0000000) && NextFunction != 'None')
        {
            SetTimer(fLength, false, NextFunction);
        }
    }
    //return;    
}

function GainPoints(int nTaskForce, int numPoints, TgGame_PaladinsExtended.EVictoryType VictoryType)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce Taskforce;

    switch(nTaskForce)
    {
        // End:0x2E
        case 1:
            m_nTF1Score -= numPoints;
            // End:0x4D
            break;
        // End:0x4A
        case 2:
            m_nTF2Score -= numPoints;
            // End:0x4D
            break;
        // End:0xFFFF
        default:
            break;
    }
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x122
    if(GRI != none)
    {
        Taskforce = GRI.GetTaskForce(nTaskForce);
        // End:0x122
        if(Taskforce != none)
        {
            Taskforce.r_nScore = GetScore(nTaskForce);
            Taskforce.bNetDirty = true;
        }
    }
    //return;    
}

event CheckGameState()
{
    local TgRepInfo_Game GRI;
    local TgPlayerController PC;

    GRI = TgRepInfo_Game(GameReplicationInfo);
    // End:0x43
    if((GRI == none) || int(m_GameWinState) != int(0))
    {
        return;
    }
    m_GameWinState = 2;
    GRI.r_Winner = GRI.GetTaskForce(1);
    GRI.bNetDirty = true;
    // End:0x12F
    if(int(m_GameWinState) != int(0))
    {
        // End:0x121
        foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', PC)
        {
            PC.SendClientSetGameWinState(m_GameWinState);            
        }        
        BeginEndMission();
    }
    //return;    
}

state TutorialIntro
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 1;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgPawn_Character TgP;
        local TgPlayerController TgPC;

        TgPC = GetLocalTgPlayerController();
        // End:0x101
        if(TgPC != none)
        {
            TgPC.SetAllInputAllowed(false);
            TgPC.HideMeshes(true, false);
            TgP = TgPawn_Character(TgPC.Pawn);
            // End:0x101
            if(TgP != none)
            {
                TgP.PlayIntroAnims();
                TgP.m_fEnergyChargeMultiplier = GetTutorialInfo().fEnergyChargeMultiplier;
            }
        }
        CloseSpawnGates();
        m_bWaitingForUIReady = true;
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x94
        if(m_bWaitingForUIReady && IsUIReady())
        {
            m_bWaitingForUIReady = false;
            Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 0);
            DisableUI();
            SetTimer(0.5000000, false, 'DisableUI');
            PlayAnnouncer(0, 4.0000000, 'Audio1');
        }
        //return;        
    }

    function Audio1()
    {
        SetTimer(GetTutorialInfo().fIntroExtensionTime, false, 'IntroDelay');
        //return;        
    }

    function IntroDelay()
    {
        GotoState('MoveForwardBackward');
        //return;        
    }
    stop;    
}

state MoveForwardBackward
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 2;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgPlayerController TgPC;

        TgPC = GetLocalTgPlayerController();
        // End:0x155
        if(TgPC != none)
        {
            TgPC.SetInputAllowed(6, true);
            TgPC.SetInputAllowed(7, true);
            TgPC.SetInputAllowed(4, true);
            TgPC.SetInputAllowed(5, true);
            TgPC.SetInputAllowed(0, true);
            TgPC.SetInputAllowed(1, true);
            TgPC.SetInputAllowed(3, true);
            TgPC.SetInputAllowed(2, true);
            TgPC.SetInputAllowed(14, true);
        }
        PlayAnnouncer(5, 2.0000000, 'Audio1');
        //return;        
    }

    function LocalPlayerInputReceived(TgPlayerController.EPlayerInputType InputType)
    {
        switch(InputType)
        {
            // End:0x2F
            case 0:
                m_fReceivedMoveForwardSeconds += m_fLastFrameDeltaTime;
                // End:0x4E
                break;
            // End:0x4B
            case 1:
                m_fReceivedMoveBackwardSeconds += m_fLastFrameDeltaTime;
                // End:0x4E
                break;
            // End:0xFFFF
            default:
                break;
        }
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x91
        if((m_fReceivedMoveForwardSeconds >= GetTutorialInfo().fButtonHoldTime) && m_fReceivedMoveBackwardSeconds >= GetTutorialInfo().fButtonHoldTime)
        {
            HaltAllAudio();
            StopRepeatInstructions();
            GotoState('MoveRightLeft');
        }
        //return;        
    }

    function Audio1()
    {
        PlayAnnouncer(6, 4.0000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        StartRepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(6, 4.0000000, 'Audio2');
        //return;        
    }
    stop;    
}

state MoveRightLeft
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 3;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        PlayAnnouncer(7, 3.0000000, 'Audio1');
        //return;        
    }

    function LocalPlayerInputReceived(TgPlayerController.EPlayerInputType InputType)
    {
        switch(InputType)
        {
            // End:0x2F
            case 3:
                m_fReceivedMoveLeftSeconds += m_fLastFrameDeltaTime;
                // End:0x4E
                break;
            // End:0x4B
            case 2:
                m_fReceivedMoveRightSeconds += m_fLastFrameDeltaTime;
                // End:0x4E
                break;
            // End:0xFFFF
            default:
                break;
        }
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x91
        if((m_fReceivedMoveLeftSeconds >= GetTutorialInfo().fButtonHoldTime) && m_fReceivedMoveRightSeconds >= GetTutorialInfo().fButtonHoldTime)
        {
            HaltAllAudio();
            StopRepeatInstructions();
            GotoState('PlayerApproachBot');
        }
        //return;        
    }

    function Audio1()
    {
        StartRepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(7, 3.0000000, 'Audio1');
        //return;        
    }
    stop;    
}

state PlayerApproachBot
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 4;
        //return ReturnValue;        
    }

    function TgBotFactory GetCurrentBotFactory()
    {
        return GetTutorialInfo().HelperBotFactory;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        GetTutorialInfo().SpawnHelperBot();
        Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 1);
        PlayAK(AkEvent'WW_VGS_Ying.Ying_VGS_Other_G_H_Play', 1.5000000, 'Audio1');
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(13, 2.5000000, 'Audio2');
        //return;        
    }

    function Audio1()
    {
        RepeatInstructions();
        //return;        
    }

    function Audio2()
    {
        StartRepeatInstructions();
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x94
        if((GetTutorialInfo().ApproachHelperArea != none) && GetTutorialInfo().ApproachHelperArea.m_bHasLocalPawn)
        {
            HaltAllAudio();
            StopRepeatInstructions();
            GotoState('PlayerMoveToShootingRange');
        }
        //return;        
    }
    stop;    
}

state PlayerMoveToShootingRange
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 5;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        OpenSpawnGates();
        Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 2);
        m_fVolumeStandTime = 0.0000000;
        SetTimer(0.2500000, false, 'MoveBotToNextArea');
        //return;        
    }

    function MoveBotToNextArea()
    {
        GetTutorialInfo().MoveHelperToActor(GetTutorialInfo().HelperMoveTargetAutoRange);
        PlayAK(AkEvent'WW_VGS_Ying.Ying_VGS_Other_V_F_Play', 1.5000000, 'Audio1');
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0xF7
        if((GetTutorialInfo().AutoShootingRangeStandingTargetArea != none) && GetTutorialInfo().AutoShootingRangeStandingTargetArea.m_bHasLocalPawn)
        {
            m_fVolumeStandTime += m_fLastFrameDeltaTime;
            // End:0xF7
            if(m_fVolumeStandTime > GetTutorialInfo().fVolumeStandTime)
            {
                HaltAllAudio();
                StopRepeatInstructions();
                Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 3);
                GotoState('HealthBar');
            }
        }
        // End:0x193
        if(!IsTimerActive('MoveBotToNextArea'))
        {
            // End:0x193
            if(!GetTutorialInfo().HelperIsNavigatingToOrAtDestination(GetTutorialInfo().HelperMoveTargetAutoRange))
            {
                GetTutorialInfo().MoveHelperToActor(GetTutorialInfo().HelperMoveTargetAutoRange);
            }
        }
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(13, 2.5000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        StartRepeatInstructions();
        //return;        
    }
    stop;    
}

state HealthBar
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 6;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        EnableTutorialUI(0, true);
        PlayAnnouncer(15, 6.0000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        PlayAnnouncer(16, 6.0000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        PlayAnnouncer(17, 5.0000000, 'Audio3');
        //return;        
    }

    function Audio3()
    {
        GotoState('AutoAbility');
        //return;        
    }
    stop;    
}

state AutoAbility
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 7;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgPawn TgP;
        local TgPlayerController TgPC;

        TgPC = GetLocalTgPlayerController();
        // End:0x105
        if(TgPC != none)
        {
            TgPC.SetInputAllowed(8, true);
            TgPC.SetInputAllowed(13, true);
            TgPC.HideMeshes(false, false);
            TgP = GetLocalPlayerPawn();
            // End:0x105
            if((TgP != none) && TgP.m_WeaponMesh != none)
            {
                TgP.m_WeaponMesh.PlayWeaponQuickRetrieve();
            }
        }
        EnableTutorialUI(1, true);
        PlayAnnouncer(18, 2.5000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        PlayAnnouncer(19, 3.5000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        PlayAK(AkEvent'WW_VGS_Ying.Ying_VGS_Other_G_R_Play', 1.5000000, 'Audio3');
        //return;        
    }

    function Audio3()
    {
        SpawnCurrentBots();
        StartRepeatInstructions();
        //return;        
    }

    function Audio4()
    {
        StartRepeatInstructions();
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x82
        if(!IsTimerActive('GoToNext') && CurrentBotsDead())
        {
            HaltAllAudio();
            StopRepeatInstructions();
            TrySetTimer(GetTutorialInfo().fBotTargetsKilledWaitTime, false, 'GoToNext');
        }
        //return;        
    }

    function GoToNext()
    {
        GotoState('AutoAbilityMultipleEnemies');
        //return;        
    }

    function TgBotFactory GetCurrentBotFactory()
    {
        return GetTutorialInfo().AutoBotFactory;
        //return ReturnValue;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(20, 3.0000000, 'Audio4');
        //return;        
    }
    stop;    
}

state AutoAbilityMultipleEnemies
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 8;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        PlayAnnouncer(21, 1.5000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        PlayAnnouncer(22, 3.5000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        PlayAK(AkEvent'WW_VGS_Ying.Ying_VGS_OK_Play', 1.5000000, 'Audio3');
        //return;        
    }

    function Audio3()
    {
        SpawnCurrentBots();
        PlayAnnouncer(23, 4.0000000, 'Audio4');
        //return;        
    }

    function Audio4()
    {
        StartRepeatInstructions();
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x82
        if(!IsTimerActive('GoToNext') && CurrentBotsDead())
        {
            HaltAllAudio();
            StopRepeatInstructions();
            TrySetTimer(GetTutorialInfo().fBotTargetsKilledWaitTime, false, 'GoToNext');
        }
        //return;        
    }

    function TgBotFactory GetCurrentBotFactory()
    {
        return GetTutorialInfo().MultipleAutoBotFactory;
        //return ReturnValue;        
    }

    simulated function GoToNext()
    {
        GotoState('BattleAbility');
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(20, 4.0000000, 'Audio4');
        //return;        
    }
    stop;    
}

state BattleAbility
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 9;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        PlayAnnouncer(27, 3.5000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        local TgPlayerController TgPC;

        TgPC = GetLocalTgPlayerController();
        // End:0x45
        if(TgPC != none)
        {
            TgPC.SetInputAllowed(10, true);
        }
        EnableTutorialUI(2, true);
        PlayAnnouncer(28, 4.5000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        SpawnCurrentBots();
        PlayAnnouncer(29, 4.5000000, 'Audio3');
        //return;        
    }

    function Audio3()
    {
        StartRepeatInstructions();
        //return;        
    }

    function Audio4()
    {
        StartRepeatInstructions();
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        local TgDevice BattleDevice;

        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x9C
        if(!IsTimerActive('GoToNext') && CurrentBotsDead())
        {
            // End:0x92
            if(m_bDamagedWithBattle)
            {
                HaltAllAudio();
                StopRepeatInstructions();
                TrySetTimer(GetTutorialInfo().fBotTargetsKilledWaitTime, false, 'GoToNext');                
            }
            else
            {
                SpawnCurrentBots();
            }
        }
        // End:0x122
        if(!IsTimerActive('GoToNext'))
        {
            BattleDevice = GetLocalPlayerDevice(3);
            // End:0x122
            if((BattleDevice != none) && BattleDevice.GetCooldownRemaining() > float(0))
            {
                BattleDevice.EndCooldown();
            }
        }
        //return;        
    }

    function TgBotFactory GetCurrentBotFactory()
    {
        return GetTutorialInfo().BattleAbilityBotFactory;
        //return ReturnValue;        
    }

    event LocalPlayerDeviceOnDamaged(out OnDamagedParams Params)
    {
        // End:0x39
        if(Params.Dev == (GetLocalPlayerDevice(3)))
        {
            m_bDamagedWithBattle = true;
        }
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(29, 3.0000000, 'Audio4');
        //return;        
    }

    simulated function GoToNext()
    {
        GotoState('CooldownExplain');
        //return;        
    }
    stop;    
}

state CooldownExplain
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 10;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgDevice BattleDevice;

        BattleDevice = GetLocalPlayerDevice(3);
        // End:0x6C
        if((BattleDevice != none) && !BattleDevice.IsDeviceCoolingDown())
        {
            BattleDevice.StartCooldown();
        }
        PlayAnnouncer(31, 2.0000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        PlayAnnouncer(32, 5.0000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        GotoState('MovementAbility');
        //return;        
    }
    stop;    
}

state MovementAbility
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 11;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgPlayerController TgPC;

        TgPC = GetLocalTgPlayerController();
        // End:0x45
        if(TgPC != none)
        {
            TgPC.SetInputAllowed(11, true);
        }
        EnableTutorialUI(3, true);
        Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 4);
        m_fVolumeStandTime = 0.0000000;
        PlayAnnouncer(34, 2.5000000, 'Audio1');
        SetTimer(GetTutorialInfo().fBotDelayTravelToMovementTime, false, 'MoveBotToNextArea');
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        local TgDevice MovementDevice;

        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x77
        if(!m_bReceivedMovementAbility)
        {
            MovementDevice = GetLocalPlayerDevice(4);
            // End:0x77
            if((MovementDevice != none) && MovementDevice.NativeIsFiring())
            {
                m_bReceivedMovementAbility = true;
            }
        }
        // End:0xA6
        if(m_bReceivedMovementAbility)
        {
            HaltAllAudio();
            StopRepeatInstructions();
            GotoState('PlayerMoveToUltimateShootingRange');
        }
        // End:0x142
        if(!IsTimerActive('MoveBotToNextArea'))
        {
            // End:0x142
            if(!GetTutorialInfo().HelperIsNavigatingToOrAtDestination(GetTutorialInfo().HelperMoveTargetMovementAbility))
            {
                GetTutorialInfo().MoveHelperToActor(GetTutorialInfo().HelperMoveTargetMovementAbility);
            }
        }
        //return;        
    }

    function MoveBotToNextArea()
    {
        GetTutorialInfo().MoveHelperToActor(GetTutorialInfo().HelperMoveTargetMovementAbility);
        //return;        
    }

    function Audio1()
    {
        RepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        // End:0x29
        if(!m_bReceivedMovementAbility)
        {
            PlayAnnouncer(35, 5.0000000, 'Audio2');
        }
        //return;        
    }

    function Audio2()
    {
        StartRepeatInstructions();
        //return;        
    }
    stop;    
}

state PlayerMoveToUltimateShootingRange
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 12;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        m_fVolumeStandTime = 0.0000000;
        Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 5);
        SetTimer(GetTutorialInfo().fBotDelayTravelToUltRangeTime, false, 'MoveBotToNextArea');
        PlayAnnouncer(13, 2.5000000, 'Audio1');
        //return;        
    }

    function MoveBotToNextArea()
    {
        GetTutorialInfo().MoveHelperToActor(GetTutorialInfo().HelperMoveTargetUltRange);
        //return;        
    }

    function float GetRepeatInstructionTime()
    {
        return GetTutorialInfo().fExtendedRepeatInstructionTime;
        //return ReturnValue;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(13, 2.5000000, 'Audio2');
        //return;        
    }

    function Audio1()
    {
        PlayAK(AkEvent'WW_VGS_Ying.Ying_VGS_Other_V_F_Play', 1.5000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        StartRepeatInstructions();
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x136
        if((GetTutorialInfo().UltimateShootingRangeStandingTargetArea != none) && GetTutorialInfo().UltimateShootingRangeStandingTargetArea.m_bHasLocalPawn)
        {
            m_fVolumeStandTime += m_fLastFrameDeltaTime;
            // End:0x136
            if(m_fVolumeStandTime > GetTutorialInfo().fVolumeStandTime)
            {
                Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 6);
                HaltAllAudio();
                StopRepeatInstructions();
                GotoState('AltAbility');
                GetTutorialInfo().TeleportHelperToActor(GetTutorialInfo().HelperMoveTargetUltRange);
            }
        }
        // End:0x1D2
        if(!IsTimerActive('MoveBotToNextArea'))
        {
            // End:0x1D2
            if(!GetTutorialInfo().HelperIsNavigatingToOrAtDestination(GetTutorialInfo().HelperMoveTargetUltRange))
            {
                GetTutorialInfo().MoveHelperToActor(GetTutorialInfo().HelperMoveTargetUltRange);
            }
        }
        //return;        
    }
    stop;    
}

state AltAbility
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 13;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgPlayerController TgPC;

        TgPC = GetLocalTgPlayerController();
        // End:0x45
        if(TgPC != none)
        {
            TgPC.SetInputAllowed(9, true);
        }
        EnableTutorialUI(4, true);
        PlayAnnouncer(36, 4.5000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        PlayAnnouncer(37, 4.0000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        PlayAnnouncer(38, 5.0000000, 'Audio3');
        SpawnCurrentBots();
        //return;        
    }

    function Audio3()
    {
        StartRepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(37, 4.0000000, 'Audio3');
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x9C
        if(!IsTimerActive('GoToNext') && CurrentBotsDead())
        {
            // End:0x92
            if(m_bDamagedWithAlt)
            {
                HaltAllAudio();
                StopRepeatInstructions();
                TrySetTimer(GetTutorialInfo().fBotTargetsKilledWaitTime, false, 'GoToNext');                
            }
            else
            {
                SpawnCurrentBots();
            }
        }
        //return;        
    }

    function TgBotFactory GetCurrentBotFactory()
    {
        return GetTutorialInfo().AltAbilityBotFactory;
        //return ReturnValue;        
    }

    event LocalPlayerDeviceOnDamaged(out OnDamagedParams Params)
    {
        local TgDevice_ViktorInhand Device;

        Device = TgDevice_ViktorInhand(Params.Dev);
        // End:0x8A
        if(((Device != none) && Device == (GetLocalPlayerDevice(1))) && Device.m_bIsADS)
        {
            m_bDamagedWithAlt = true;
        }
        //return;        
    }

    function GoToNext()
    {
        GotoState('UltimateAbilityCharge');
        //return;        
    }
    stop;    
}

state UltimateAbilityCharge
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 14;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgRepInfo_Game GRI;

        EnableTutorialUI(5, true);
        PlayAnnouncer(39, 1.5000000, 'Audio1');
        GRI = TgRepInfo_Game(WorldInfo.GRI);
        // End:0x89
        if(GRI != none)
        {
            GRI.r_bBlockEnergyGain = false;
        }
        //return;        
    }

    function Audio1()
    {
        PlayAnnouncer(40, 5.5000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        PlayAnnouncer(41, 6.5000000, 'Audio3');
        //return;        
    }

    function Audio3()
    {
        PlayAnnouncer(42, 4.5000000, 'Audio4');
        //return;        
    }

    function Audio4()
    {
        SpawnCurrentBots();
        RepeatInstructions();
        //return;        
    }

    function Audio5()
    {
        StartRepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(44, 4.0000000, 'Audio5');
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x42
        if(CurrentBotsDead())
        {
            HaltAllAudio();
            StopRepeatInstructions();
            GotoState('UltimateAbility');
        }
        //return;        
    }

    function TgBotFactory GetCurrentBotFactory()
    {
        return GetTutorialInfo().UltimateChargeBotFactory;
        //return ReturnValue;        
    }
    stop;    
}

state UltimateAbility
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 15;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgPlayerController TgPC;

        TgPC = GetLocalTgPlayerController();
        // End:0x45
        if(TgPC != none)
        {
            TgPC.SetInputAllowed(12, true);
        }
        SetUltState(true);
        SpawnCurrentBots();
        PlayAnnouncer(49, 5.5000000, 'Audio1');
        //return;        
    }

    function EndState(name NextStateName)
    {
        SetUltState(false);
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        local TgPawn TgP;

        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x11D
        if(!IsTimerActive('GoToNext'))
        {
            // End:0xBC
            if(CurrentBotsDead())
            {
                // End:0xB2
                if(m_bDamagedWithUlt)
                {
                    Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 7);
                    HaltAllAudio();
                    StopRepeatInstructions();
                    TrySetTimer(GetTutorialInfo().fBotTargetsKilledWaitTime, false, 'GoToNext');                    
                }
                else
                {
                    SpawnCurrentBots();
                }
            }
            TgP = GetLocalPlayerPawn();
            // End:0x11D
            if(TgP != none)
            {
                TgP.GiveEnergy(TgP.GetMaxEnergy());
            }
        }
        //return;        
    }

    function TgBotFactory GetCurrentBotFactory()
    {
        return GetTutorialInfo().UltimateAbilityBotFactory;
        //return ReturnValue;        
    }

    event LocalPlayerDeviceOnDamaged(out OnDamagedParams Params)
    {
        // End:0x5D
        if((Params.Dev != none) && Params.Dev == (GetLocalPlayerDevice(18)))
        {
            m_bDamagedWithUlt = true;
        }
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(49, 5.5000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        StartRepeatInstructions();
        //return;        
    }

    function GoToNext()
    {
        GotoState('Mount');
        //return;        
    }

    function SetUltState(bool bForceStayOpen)
    {
        local TgDevice TgD;

        TgD = GetLocalPlayerDevice(2);
        // End:0xCB
        if(TgD != none)
        {
            TgD.m_bPreventInterrupt = bForceStayOpen;
            TgD.m_bPreventCancel = bForceStayOpen;
            // End:0xCB
            if(!bForceStayOpen && TgD.NativeIsFiring())
            {
                TgD.InterruptFiring();
            }
        }
        //return;        
    }
    stop;    
}

state Mount
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 16;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        PlayAnnouncer(12, 5.0000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        local TgPlayerController TgPC;

        TgPC = GetLocalTgPlayerController();
        // End:0x45
        if(TgPC != none)
        {
            TgPC.SetInputAllowed(15, true);
        }
        PickNextObjective();
        AutoMountLocalPlayer();
        GotoState('PlayerMovingToJumpArea');
        PlayAK(AkEvent'WW_VGS_Ying.Ying_VGS_Other_G_B_Play', 1.5000000, 'KillHelper');
        //return;        
    }

    function AutoMountLocalPlayer()
    {
        local TgDevice_Mount MountDevice;

        MountDevice = TgDevice_Mount(GetLocalPlayerDevice(23));
        // End:0x6C
        if(MountDevice != none)
        {
            MountDevice.SetAllowMountServerTimer();
            MountDevice.ClientStartMount();
        }
        //return;        
    }
    stop;    
}

state PlayerMovingToJumpArea
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 17;
        //return ReturnValue;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0xA2
        if((GetTutorialInfo().JumpLowerArea != none) && GetTutorialInfo().JumpLowerArea.m_bHasSeenLocalPawnBefore)
        {
            Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 8);
            GotoState('Jump');
        }
        //return;        
    }
    stop;    
}

state Jump
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 18;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        PlayAnnouncer(11, 4.0000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        StartRepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(11, 4.0000000, 'Audio1');
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0xB6
        if((GetTutorialInfo().JumpUpperArea != none) && GetTutorialInfo().JumpUpperArea.m_bHasSeenLocalPawnBefore)
        {
            Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 9);
            HaltAllAudio();
            StopRepeatInstructions();
            GotoState('PlayerMovingToObjective');
        }
        //return;        
    }
    stop;    
}

state PlayerMovingToObjective
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 19;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        PlayAnnouncer(70, 1.5000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        StartRepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(70, 1.5000000, 'Audio1');
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        local TgPlayerController TgPC;
        local TgPawn_Character TgP;

        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        TgPC = GetLocalTgPlayerController();
        // End:0xDE
        if(TgPC != none)
        {
            TgP = TgPawn_Character(TgPC.Pawn);
            // End:0xDE
            if((TgP != none) && TgP.r_bNearCapturePoint)
            {
                Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 10);
                HaltAllAudio();
                StopRepeatInstructions();
                GotoState('CapturingObjective');
            }
        }
        //return;        
    }
    stop;    
}

state CapturingObjective
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 20;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgPawn TgP;

        TgP = GetLocalPlayerPawn();
        // End:0x9C
        if(TgP != none)
        {
            TgP.AutoMount(false);
            // End:0x9C
            if(TgP.m_WeaponMesh != none)
            {
                TgP.m_WeaponMesh.PlayWeaponQuickRetrieve();
            }
        }
        EnableTutorialUI(6, true);
        PlayAnnouncer(74, 3.5000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        PlayAnnouncer(76, 6.0000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        PlayAnnouncer(77, 3.5000000, 'Audio3');
        //return;        
    }

    function Audio3()
    {
        GotoState('ContestingObjective');
        //return;        
    }
    stop;    
}

state ContestingObjective
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 21;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        SpawnCurrentBots();
        Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 11);
        PlayAnnouncer(80, 9.0000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        RepeatInstructions();
        //return;        
    }

    function Audio2()
    {
        StartRepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        // End:0x29
        if(!CurrentBotsDead())
        {
            PlayAnnouncer(81, 7.5000000, 'Audio2');
        }
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x51
        if(m_bPointCaptured && CurrentBotsDead())
        {
            HaltAllAudio();
            StopRepeatInstructions();
            GotoState('PayloadSpawn');
        }
        //return;        
    }

    function TgBotFactory GetCurrentBotFactory()
    {
        return GetTutorialInfo().ContestCapturePointBotFactory;
        //return ReturnValue;        
    }
    stop;    
}

state PayloadSpawn
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 22;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgObjective Objective;

        GainPoints(1, m_nPointsForCapturing, 1);
        SpawnLanePusher();
        // End:0x70
        foreach WorldInfo.DynamicActors(Class'TgGame.TgObjective', Objective)
        {
            Objective.SetStatus(0);            
        }        
        EnableTutorialUI(7, true);
        SetTimer(1.0000000, false, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        PlayAnnouncer(82, 7.5000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        RepeatInstructions();
        //return;        
    }

    function Audio3()
    {
        StartRepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(83, 7.0000000, 'Audio3');
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        local TgRepInfo_Game GRI;

        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        GRI = TgRepInfo_Game(WorldInfo.GRI);
        // End:0xB9
        if((GRI != none) && GRI.r_fPayloadProgressPercent >= GetTutorialInfo().fPayloadContestPercent)
        {
            HaltAllAudio();
            StopRepeatInstructions();
            GotoState('PayloadContest');
        }
        //return;        
    }

    function SpawnLanePusher()
    {
        local TgRepInfo_Game GRI;

        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x69
        if(((GRI == none) || GRI.r_AttackingTaskForce == none) || int(m_GameWinState) != int(0))
        {
            return;
        }
        // End:0x393
        if(m_CapturedPoint != none)
        {
            // End:0x393
            if(m_CapturedPoint.m_Taskforce1Factories[0] != none)
            {
                // End:0xEB
                if(m_bOverrideSpawnTableID)
                {
                    m_CapturedPoint.m_Taskforce1Factories[0].nSpawnTableId = GetNextSpawnTableId();
                }
                m_CapturedPoint.m_Taskforce1Factories[0].ResetQueue();
                GRI.r_LanePusher = TgPawn_LanePusher(m_CapturedPoint.m_Taskforce1Factories[0].UseSpawnTable());
                // End:0x314
                if(GRI.r_LanePusher != none)
                {
                    GRI.r_LanePusher.m_bFadeOutOnLifeAfterDeathTimerExpired = false;
                    GRI.r_LanePusher.m_fLifeAfterDeathSecs = 0.1000000;
                    GRI.r_LanePusher.m_bAllowBackpeddling = false;
                    // End:0x2BF
                    if(m_CapturedPoint.m_Taskforce1PathStart != none)
                    {
                        GRI.r_LanePusher.SetSpline(m_CapturedPoint.m_Taskforce1PathStart, true);
                    }
                    GRI.r_LanePusher.SetProperty(8, GetTutorialInfo().fLanePusherGroundSpeed);
                }
                SendLanePusherSpawnAlert(int(GRI.r_AttackingTaskForce.r_nTaskForce));
                SendLanePusherUpdateAlert(true, int(GRI.r_AttackingTaskForce.r_nTaskForce));
            }
        }
        //return;        
    }
    stop;    
}

state PayloadContest
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 23;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        SpawnCurrentBots();
        Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 11);
        PlayAnnouncer(84, 5.5000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        PlayAnnouncer(86, 5.0000000, 'Audio2');
        //return;        
    }

    function Audio2()
    {
        RepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(87, 3.5000000, 'Audio3');
        //return;        
    }

    function Audio3()
    {
        StartRepeatInstructions();
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        // End:0x42
        if(CurrentBotsDead())
        {
            HaltAllAudio();
            StopRepeatInstructions();
            GotoState('PayloadPush');
        }
        //return;        
    }

    function TgBotFactory GetCurrentBotFactory()
    {
        return GetTutorialInfo().ContestPayloadBotsFactory;
        //return ReturnValue;        
    }
    stop;    
}

state PayloadPush
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 24;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        PlayAnnouncer(88, 3.5000000, 'Audio1');
        //return;        
    }

    function Audio1()
    {
        StartRepeatInstructions();
        //return;        
    }

    function RepeatInstructions()
    {
        PlayAnnouncer(88, 3.5000000, 'Audio1');
        //return;        
    }

    event Tick(float DeltaSeconds)
    {
        local TgRepInfo_Game GRI;

        super(TgGame_Paladins_Tutorial).Tick(DeltaSeconds);
        GRI = TgRepInfo_Game(GameReplicationInfo);
        // End:0x8A
        if((GRI != none) && GRI.r_fPayloadProgressPercent >= 1.0000000)
        {
            HaltAllAudio();
            StopRepeatInstructions();
            GotoState('TutorialComplete');
        }
        //return;        
    }
    stop;    
}

state TutorialComplete
{
    function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState()
    {
        return 25;
        //return ReturnValue;        
    }

    function BeginState(name PreviousStateName)
    {
        local TgRepInfo_Game GRI;

        GRI = TgRepInfo_Game(WorldInfo.GRI);
        // End:0x9A
        if((GRI != none) && GRI.r_LanePusher != none)
        {
            GRI.r_LanePusher.Suicide();
        }
        GainPoints(1, m_nPointsForPayload, 3);
        PlayAnnouncer(89, 5.0000000, 'Audio1');
        Class'TgGame.TgSeqEvent_Tutorial'.static.TriggerGlobal(self, 13);
        AwardAchievement();
        HideWorldOverlays();
        //return;        
    }

    function Audio1()
    {
        CheckGameState();
        AllPlayersEndGame(GetTutorialInfo().EndGameFocus);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fSetupPauseTime=-1.0000000
    m_EndAnnouncerAudioEvent=AkEvent'WW_VOX_Announcer_Tutorial.Tutorial_Announcer_KillVox_Stop'
    m_nWinningScore=2
    m_bCaptureSpawnAlerts=false
    m_bRespawnBots=false
    m_bRestrictStoreInteractions=true
    m_bFirstBloodAwarded=true
    m_bUsePlayerCharacterIntros=false
    m_bUseKillEmotes=false
    m_bNotifyKillCombos=false
    m_GameType=TG_GAME_TYPE.TGT_CHAOS_TUTORIAL
    m_fSpawnProtectionTime=0.0000000
}