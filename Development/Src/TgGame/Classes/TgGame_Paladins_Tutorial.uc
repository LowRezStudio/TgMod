class TgGame_Paladins_Tutorial extends TgGame_Paladins_Siege
    native(Game)
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(TgGame_PaladinsExtended, TgObject, TgPlayerController);

const PALADINS_ACTIVITY_WELL_TRAINED = 1975;

enum ETutorialState {
    ETutState_Invalid,  // 0
    ETutState_TutorialIntro,  // 1
    ETutState_MoveForwardBackward,  // 2
    ETutState_MoveRightLeft,  // 3
    ETutState_PlayerApproachBot,  // 4
    ETutState_PlayerMoveToShootingRange,  // 5
    ETutState_HealthBar,  // 6
    ETutState_AutoAbility,  // 7
    ETutState_AutoAbilityMultipleEnemies,  // 8
    ETutState_BattleAbility,  // 9
    ETutState_CooldownExplain,  // 10
    ETutState_MovementAbility,  // 11
    ETutState_PlayerMoveToUltimateShootingRange,  // 12
    ETutState_AltAbility,  // 13
    ETutState_UltimateAbilityCharge,  // 14
    ETutState_UltimateAbility,  // 15
    ETutState_Mount,  // 16
    ETutState_PlayerMovingToJumpArea,  // 17
    ETutState_Jump,  // 18
    ETutState_PlayerMovingToObjective,  // 19
    ETutState_CapturingObjective,  // 20
    ETutState_ContestingObjective,  // 21
    ETutState_PayloadSpawn,  // 22
    ETutState_PayloadContest,  // 23
    ETutState_PayloadPush,  // 24
    ETutState_TutorialComplete,  // 25
};

enum ETutorialAnnouncerLine {
    Announcer_Line_Tutorial_A_PortalRoom_010,  // 0
    Announcer_Line_Tutorial_A_PortalRoom_020,  // 1
    Announcer_Line_Tutorial_A_PortalRoom_030,  // 2
    Announcer_Line_Tutorial_A_PortalRoom_040,  // 3
    Announcer_Line_Tutorial_A_PortalRoom_050,  // 4
    Announcer_Line_Tutorial_A_PortalRoom_060,  // 5
    Announcer_Line_Tutorial_A_PortalRoom_070,  // 6
    Announcer_Line_Tutorial_A_PortalRoom_080,  // 7
    Announcer_Line_Tutorial_A_PortalRoom_090,  // 8
    Announcer_Line_Tutorial_A_PortalRoom_100,  // 9
    Announcer_Line_Tutorial_A_PortalRoom_110,  // 10
    Announcer_Line_Tutorial_B_BasicTraining_020,  // 11
    Announcer_Line_Tutorial_B_BasicTraining_030,  // 12
    Announcer_Line_Tutorial_B_BasicTraining_050,  // 13
    Announcer_Line_Tutorial_B_BasicTraining_060,  // 14
    Announcer_Line_Tutorial_B_BasicTraining_070,  // 15
    Announcer_Line_Tutorial_B_BasicTraining_080,  // 16
    Announcer_Line_Tutorial_B_BasicTraining_090,  // 17
    Announcer_Line_Tutorial_B_BasicTraining_110,  // 18
    Announcer_Line_Tutorial_B_BasicTraining_120,  // 19
    Announcer_Line_Tutorial_B_BasicTraining_130,  // 20
    Announcer_Line_Tutorial_B_BasicTraining_140,  // 21
    Announcer_Line_Tutorial_B_BasicTraining_150,  // 22
    Announcer_Line_Tutorial_B_BasicTraining_160,  // 23
    Announcer_Line_Tutorial_B_BasicTraining_170,  // 24
    Announcer_Line_Tutorial_B_BasicTraining_180,  // 25
    Announcer_Line_Tutorial_B_BasicTraining_190,  // 26
    Announcer_Line_Tutorial_B_BasicTraining_200,  // 27
    Announcer_Line_Tutorial_B_BasicTraining_210,  // 28
    Announcer_Line_Tutorial_B_BasicTraining_220,  // 29
    Announcer_Line_Tutorial_B_BasicTraining_230,  // 30
    Announcer_Line_Tutorial_B_BasicTraining_240,  // 31
    Announcer_Line_Tutorial_B_BasicTraining_250,  // 32
    Announcer_Line_Tutorial_B_BasicTraining_260,  // 33
    Announcer_Line_Tutorial_B_BasicTraining_270,  // 34
    Announcer_Line_Tutorial_B_BasicTraining_280,  // 35
    Announcer_Line_Tutorial_B_BasicTraining_290,  // 36
    Announcer_Line_Tutorial_B_BasicTraining_300,  // 37
    Announcer_Line_Tutorial_B_BasicTraining_310,  // 38
    Announcer_Line_Tutorial_B_BasicTraining_320,  // 39
    Announcer_Line_Tutorial_B_BasicTraining_330,  // 40
    Announcer_Line_Tutorial_B_BasicTraining_340,  // 41
    Announcer_Line_Tutorial_B_BasicTraining_350,  // 42
    Announcer_Line_Tutorial_B_BasicTraining_360,  // 43
    Announcer_Line_Tutorial_B_BasicTraining_370,  // 44
    Announcer_Line_Tutorial_B_BasicTraining_380,  // 45
    Announcer_Line_Tutorial_B_BasicTraining_390,  // 46
    Announcer_Line_Tutorial_B_BasicTraining_400,  // 47
    Announcer_Line_Tutorial_B_BasicTraining_410,  // 48
    Announcer_Line_Tutorial_B_BasicTraining_420,  // 49
    Announcer_Line_Tutorial_B_BasicTraining_430,  // 50
    Announcer_Line_Tutorial_B_BasicTraining_440,  // 51
    Announcer_Line_Tutorial_B_BasicTraining_450,  // 52
    Announcer_Line_Tutorial_B_BasicTraining_460,  // 53
    Announcer_Line_Tutorial_B_BasicTraining_470,  // 54
    Announcer_Line_Tutorial_C_PortalRoom2_010,  // 55
    Announcer_Line_Tutorial_C_PortalRoom2_020,  // 56
    Announcer_Line_Tutorial_C_PortalRoom2_030,  // 57
    Announcer_Line_Tutorial_C_PortalRoom2_040,  // 58
    Announcer_Line_Tutorial_C_PortalRoom2_050,  // 59
    Announcer_Line_Tutorial_C_PortalRoom2_060,  // 60
    Announcer_Line_Tutorial_C_PortalRoom2_070,  // 61
    Announcer_Line_Tutorial_C_PortalRoom2_080,  // 62
    Announcer_Line_Tutorial_C_PortalRoom2_085,  // 63
    Announcer_Line_Tutorial_C_PortalRoom2_090,  // 64
    Announcer_Line_Tutorial_C_PortalRoom2_100,  // 65
    Announcer_Line_Tutorial_C_PortalRoom2_110,  // 66
    Announcer_Line_Tutorial_D_Objective_012,  // 67
    Announcer_Line_Tutorial_D_Objective_015,  // 68
    Announcer_Line_Tutorial_D_Objective_018,  // 69
    Announcer_Line_Tutorial_D_Objective_020,  // 70
    Announcer_Line_Tutorial_D_Objective_022,  // 71
    Announcer_Line_Tutorial_D_Objective_025,  // 72
    Announcer_Line_Tutorial_D_Objective_028,  // 73
    Announcer_Line_Tutorial_D_Objective_030,  // 74
    Announcer_Line_Tutorial_D_Objective_040,  // 75
    Announcer_Line_Tutorial_D_Objective_050,  // 76
    Announcer_Line_Tutorial_D_Objective_060,  // 77
    Announcer_Line_Tutorial_D_Objective_065,  // 78
    Announcer_Line_Tutorial_D_Objective_070,  // 79
    Announcer_Line_Tutorial_D_Objective_080,  // 80
    Announcer_Line_Tutorial_D_Objective_090,  // 81
    Announcer_Line_Tutorial_D_Objective_100,  // 82
    Announcer_Line_Tutorial_D_Objective_110,  // 83
    Announcer_Line_Tutorial_D_Objective_120,  // 84
    Announcer_Line_Tutorial_D_Objective_130,  // 85
    Announcer_Line_Tutorial_D_Objective_140,  // 86
    Announcer_Line_Tutorial_D_Objective_150,  // 87
    Announcer_Line_Tutorial_D_Objective_160,  // 88
    Announcer_Line_Tutorial_D_Objective_170,  // 89
};

enum ETutorialUI {
    ETUI_Health,  // 0
    ETUI_Auto,  // 1
    ETUI_BattleAbility,  // 2
    ETUI_MovementAbility,  // 3
    ETUI_Alt,  // 4
    ETUI_Ultimate,  // 5
    ETUI_CapturePoint,  // 6
    ETUI_Payload,  // 7
    ETUI_ScoreSection,  // 8
    ETUI_PushTime,  // 9
    ETUI_Cards,  // 10
    ETUI_Prompt,  // 11
    ETUI_Killfeed,  // 12
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

native exec function EnableTutorialUI(TgGame_Paladins_Tutorial.ETutorialUI TutUIElement, bool bEnable, optional float fFadeTime=0.5000000);  // Export UTgGame_Paladins_Tutorial::execEnableTutorialUI(FFrame&, void* const)

native function AwardAchievement();  // Export UTgGame_Paladins_Tutorial::execAwardAchievement(FFrame&, void* const)

native function int GetWinningTaskforce();  // Export UTgGame_Paladins_Tutorial::execGetWinningTaskforce(FFrame&, void* const)

native function HideWorldOverlays();  // Export UTgGame_Paladins_Tutorial::execHideWorldOverlays(FFrame&, void* const)

native function bool IsUIReady();  // Export UTgGame_Paladins_Tutorial::execIsUIReady(FFrame&, void* const)

native function int GetObjectiveMsg();  // Export UTgGame_Paladins_Tutorial::execGetObjectiveMsg(FFrame&, void* const)

native function int GetGamepadObjectiveMsg();  // Export UTgGame_Paladins_Tutorial::execGetGamepadObjectiveMsg(FFrame&, void* const)

native function int GetAnnouncerSTM(TgGame_Paladins_Tutorial.ETutorialAnnouncerLine eLine);  // Export UTgGame_Paladins_Tutorial::execGetAnnouncerSTM(FFrame&, void* const)

function StartMatch() { }

function StartGameMode() { }

function LocalPlayerInputReceived(TgPlayerController.EPlayerInputType InputType) { }

event LocalPlayerDeviceOnDamaged(out OnDamagedParams Params) { }

function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture) { }

function bool IsAllAudioFinished() { }

function HaltAllAudio() { }

function float GetRepeatInstructionTime() { }

function StartRepeatInstructions() { }

function StopRepeatInstructions() { }

function RepeatInstructions() { }

function DisableUI() { }

function SpawnCurrentBots() { }

event bool CurrentBotsDead() { }

function TgBotFactory GetCurrentBotFactory() { }

function KillHelper() { }

function TgGame_Paladins_Tutorial.ETutorialState GetTutorialState() { }

event Tick(float DeltaSeconds) { }

function float GetPointCaptureScoreMultiplier(int nTaskForce) { }

function PauseSetupTimerAt(float TimeRemaining) { }

function PauseSetupTimer() { }

function UnpauseSetupTimer() { }

function TrySetTimer(float fLength, optional bool bLoop=false, optional name FunctionToCall='Timer') { }

function TryClearTimer(name TimerName) { }

function TgPlayerController GetLocalTgPlayerController() { }

function TgPawn GetLocalPlayerPawn() { }

function TgDevice GetLocalPlayerDevice(TgObject.TG_EQUIP_POINT eqp) { }

function TgTutorialInfo GetTutorialInfo() { }

function PlayAK(AkBaseSoundObject AKObj, optional float fLength, optional name NextFunction='None') { }

function PlayAnnouncer(TgGame_Paladins_Tutorial.ETutorialAnnouncerLine eAnnouncerLine, optional float fLength, optional name NextFunction='None') { }

function GainPoints(int nTaskForce, int numPoints, TgGame_PaladinsExtended.EVictoryType VictoryType) { }

event CheckGameState() { }

state TutorialIntro {}

state MoveForwardBackward {}

state MoveRightLeft {}

state PlayerApproachBot {}

state PlayerMoveToShootingRange {}

state HealthBar {}

state AutoAbility {}

state AutoAbilityMultipleEnemies {}

state BattleAbility {}

state CooldownExplain {}

state MovementAbility {}

state PlayerMoveToUltimateShootingRange {}

state AltAbility {}

state UltimateAbilityCharge {}

state UltimateAbility {}

state Mount {}

state PlayerMovingToJumpArea {}

state Jump {}

state PlayerMovingToObjective {}

state CapturingObjective {}

state ContestingObjective {}

state PayloadSpawn {}

state PayloadContest {}

state PayloadPush {}

state TutorialComplete {}

defaultproperties
{
    m_fSetupPauseTime=-1.0000000
    m_EndAnnouncerAudioEvent=AkEvent'Tutorial_Announcer_KillVox_Stop'
    m_nWinningScore=2
    m_bCaptureSpawnAlerts=false
    m_bRespawnBots=false
    m_bRestrictStoreInteractions=true
    m_bFirstBloodAwarded=true
    m_bUsePlayerCharacterIntros=false
    m_bUseKillEmotes=false
    m_bNotifyKillCombos=false
    m_GameType=TGT_CHAOS_TUTORIAL
    m_fSpawnProtectionTime=0.0000000
}
