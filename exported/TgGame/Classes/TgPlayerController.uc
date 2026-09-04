class TgPlayerController extends PComPlayerController
    native(Pawns)
    nativereplication
    config(Game)
    hidecategories(Navigation)
    implements(TgPaladinsController,TgCallbackInterface);

const MAX_FLASH_SIM_PROJECTILES = 32;
const PING_LENGTH = 4;
const VGS_SPAM_LENGTH = 0.5;
const MAX_LAST_PURCHASED = 26;
const CUE_ATTACKFROMBEHIND_PERIOD = 30.0;
const CUE_ATTACKFROMSNIPER_PERIOD = 30.0;
const CUE_ATTACKFROMABOVE_PERIOD = 30.0;
const CUE_ATTACKANY_PERIOD = 5.0;
const CUE_ATTACKFROMSNIPER_RANGESQR = 1000000;
const RIGHT_CLICK_CANCELING_ENABLED = false;
const ABILITY_ANDROXUS_DEFIANCE = 13324;
const ABILITY_ANDROXUS_REVERSAL = 13251;
const ABILITY_BOMBKING_STICKY = 14308;
const ABILITY_BOMBKING_GRUMPY = 13412;
const ABILITY_BUCK_NETSHOT = 12981;
const ABILITY_DROGOZ_SALVO = 14140;
const ABILITY_DROGOX_FIRESPIT = 13327;
const ABILITY_GROHK_CHAINLIGHTNING = 11510;
const ABILITY_GROVER_AXETHROW = 11490;
const ABILITY_RUCKUS_DUALFIRE = 11460;
const ABILITY_SKYE_POISONBOLTS = 11491;
const ABILITY_VIKTOR_FRAGGRENADE = 14149;
const ABILITY_YING_SHATTER = 13284;
const ABILITY_YING_ILLUSION_AUTO = 13332;
const ABILITY_MAKOA_ANCHOR = 14181;
const DEVICE_DEATH_FOG = 13033;
const PIT_MAX_SIZE = 20;
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

enum EGiveGoldResult
{
    GGR_PlayerNotFound,             // 0
    GGR_PlayerNotFriendly,          // 1
    GGR_NotEnoughGold,              // 2
    GGR_Success,                    // 3
    GGR_MAX                         // 4
};

enum EAnnouncerSeries
{
    ANS_TimeRemaining,              // 0
    ANS_TotalTimeRemaining,         // 1
    ANS_Countdown,                  // 2
    ANS_Overtime,                   // 3
    ANS_MAX                         // 4
};

enum EPlayerInputType
{
    PIT_MoveForward,                // 0
    PIT_MoveBackward,               // 1
    PIT_MoveRight,                  // 2
    PIT_MoveLeft,                   // 3
    PIT_LookLeft,                   // 4
    PIT_LookRight,                  // 5
    PIT_LookUp,                     // 6
    PIT_LookDown,                   // 7
    PIT_Auto,                       // 8
    PIT_Alt,                        // 9
    PIT_BattleAbility,              // 10
    PIT_MovementAbility,            // 11
    PIT_Ultimate,                   // 12
    PIT_Reload,                     // 13
    PIT_Jump,                       // 14
    PIT_Mount,                      // 15
    PIT_LoadoutMenu,                // 16
    PIT_BurnCardMenu,               // 17
    PIT_Emote,                      // 18
    PIT_Spray,                      // 19
    PIT_MAX                         // 20
};

enum TG_CAMERAPOSTURE
{
    TG_CAMERAPOSTURE_None,          // 0
    TG_CAMERAPOSTURE_Emote3P,       // 1
    TG_CAMERAPOSTURE_Ability3P,     // 2
    TG_CAMERAPOSTURE_Force3P,       // 3
    TG_CAMERAPOSTURE_Force1P,       // 4
    TG_CAMERAPOSTURE_MAX            // 5
};

enum EWatchOtherPlayersMode
{
    WOPM_NONE,                      // 0
    WOPM_PLAYER,                    // 1
    WOPM_MAX                        // 2
};

enum EHUDOverlay
{
    HO_None,                        // 0
    HO_Sniper,                      // 1
    HO_Binoculars,                  // 2
    HO_OwlScope,                    // 3
    HO_MAX                          // 4
};

struct native TG_LAST_PURCHASE
{
    var int nItemId;
    var int nCount;

    structdefaultproperties
    {
        nItemId=0
        nCount=0
    }
};

struct native FLOOD
{
    var int m_nCount;
    var float m_fLastUpdate;

    structdefaultproperties
    {
        m_nCount=0
        m_fLastUpdate=0.0000000
    }
};

struct native CameraStackInfo
{
    var TgPlayerController.TG_CAMERAPOSTURE ePosture;
    var int nStackId;

    structdefaultproperties
    {
        ePosture=TG_CAMERAPOSTURE.TG_CAMERAPOSTURE_None
        nStackId=0
    }
};

struct native InventoryChangeFlags
{
    var bool bDevice;
    var bool bComponent;
    var bool bEquipped;
    var bool bDeviceFailed;

    structdefaultproperties
    {
        bDevice=false
        bComponent=false
        bEquipped=false
        bDeviceFailed=false
    }
};

struct native sSimProjectileFireInfo
{
    var int nOwnerFireModeId;
    var Vector vLocation;
    var Vector vVelocity;
    var Vector vDirectionMunged;
    var int nActorID;
    var int nClientFireRequestId;
    var PComStructures.CMTargetType ActorType;
    var float fGeneric1;
    var float fGeneric2;

    structdefaultproperties
    {
        nOwnerFireModeId=0
        vLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        vVelocity=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        vDirectionMunged=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        nActorID=0
        nClientFireRequestId=0
        ActorType=CMTargetType.CMTT_Pawn
        fGeneric1=0.0000000
        fGeneric2=0.0000000
    }
};

struct native BinocularSettings
{
    var int nTargets;
    var Rotator rHeading;
    var float fRange;
    var float fTimer1;
    var float fTimer2;
    var float fTimer3;
    var float fTimerDuration;
    var float fRefireTimerPercent;
    var float fDurationPercent;

    structdefaultproperties
    {
        nTargets=0
        rHeading=(Pitch=0,Yaw=0,Roll=0)
        fRange=0.0000000
        fTimer1=0.0000000
        fTimer2=0.0000000
        fTimer3=0.0000000
        fTimerDuration=0.0000000
        fRefireTimerPercent=0.0000000
        fDurationPercent=0.0000000
    }
};

var private native const noexport Pointer VfTable_ITgPaladinsController;
var private native const noexport Pointer VfTable_ITgCallbackInterface;
var int m_nAnnouncerSeriesStep[EAnnouncerSeries];
var int s_nPlayerId;
var QWord s_qwNetAccessFlags;
var repnotify int r_nXp;
var repnotify int r_nCurrency;
var float s_fCurrencyRemainder;
var float s_fXpRemainder;
var repnotify bool r_bCanPurchaseItems;
var repnotify bool r_bCanChangeLoadout;
var repnotify bool r_bAutoPurchase;
var repnotify bool r_bAutoSkillUp;
var repnotify bool r_bToggleZoom;
var bool m_bBlockVGS;
var bool s_bSentAutoKickAlert;
var transient bool s_bAddDeadTimeStatsTracker;
var bool r_bLockYawRotation;
var bool bPressingLeftMouseButton;
var bool bPressingRightMouseButton;
var bool bPressingMovementButton;
var bool m_bPendingReload;
var bool r_bRove;
var bool m_bNoSmoothedMovementCorrection;
var bool c_bProcessedNoSmoothNotification;
var bool s_bNoSmoothedMovementCorrectionRequested;
var bool s_bIsNoSmoothMovementCorrectionManaged;
var bool s_bClearAchievementIgnoreListsOnNextTick;
var bool bDebugProjectileLagCompensation;
var bool c_bAssistModeSublevelLoaded;
var globalconfig bool c_bAllowSpecialMaterialEffects;
var transient bool m_bIgnoreSilhouettes;
var transient bool m_bForceSilhouettesOnVisibleGods;
var transient bool m_bDetailedViewEnabled;
var config bool m_bContextNotifiesEnabled;
var bool m_bShowPlayerCircles;
var bool m_bAllowUndrawnPurchase;
var const bool m_bCanHearStealthPawns;
var bool c_bShowFootstepInfoDebug;
var bool m_bDetailedDeviceLogging;
var bool m_bBehindView;
var() bool m_bOutlineEnemies;
var() bool m_bOutlineFriendlies;
var config bool c_bEnablePathfinderGuide;
var bool m_fPathfinderEnabled;
var bool c_bIsPlayingFallWindSound;
var bool m_bJustDidJumpDoubleTap;
var bool m_bThreatSystemEnabled;
var bool m_bOcclusionSystemEnabled;
var bool m_bDebugThreatSystem;
var bool c_bMatchAlmostWonSwitchPrimed;
var bool m_IsTimeDilationInterpolating;
var bool m_IsDesaturationInterpolating;
var transient bool m_bIsTrackingAimTowardTargetLocation;
var bool bForcedTimelapseRequested;
var bool bForcedPlayOfGameRequested;
var bool m_bRewindMoversForReplaySavedMoves;
var bool m_bShowDebugRewindMovers;
var bool c_bCaptureProgressAkEventPlaying;
var bool m_bShowChampionOverviewTip;
var config bool m_bEnableUltimateAkEventUnocclusion;
var bool c_bIsPlayOfTheGame;
var float c_fLastGoldNagTime;
var int m_nReviveBuybackCost;
var repnotify int r_nStatPoints;
var FLOOD s_VGSFlood;
var FLOOD s_PingFlood;
var Actor c_aLastViewTarget;
var TgPlayerInput m_CachedPlayerInput;
var TgSpectatorInput m_CachedSpectatorInput;
var Actor m_aHoverActor;
var Vector m_vHoverLocation;
var float m_fHoverActorActiveTime;
var Vector m_vWorldMapLocation;
var init transient array<init ReplicationInfo> m_WorldMapTargetRepInfos;
var transient Vector m_vWorldMouseLocation;
var transient Vector m_vWorldMouseDirection;
var float c_fTimeTillAFK;
var float s_bAutoKickStartTime;
var TG_LAST_PURCHASE r_LastPurchasedItems[26];
var Pawn s_LastPossessedPawn;
var float m_fRecentLostHealth;
var float m_fLastLostHealthTime;
var array<Actor> m_TargetedPlayers;
var float s_fWaitForSpawnSecs;
var float c_fRespawnTime;
var float m_fDeathTime;
var int r_bInputEnabled[20];
var() editinline TgControlModule ControlModule;
var Class<TgControlModule> DefaultControlModuleClass;
var int c_nCameraYawOffset;
var int m_nDevicesLockingInput;
var int m_nDevicesLockingCamera;
var int m_nDevicesLockingRotation;
var float m_fPendingReloadTime;
var float m_fPendingReloadMaxTime;
var transient Actor m_EndGameFocus;
var float m_fLastVGS;
var Vector m_vLastServerCorrectOrigPos;
var float s_fLastConfirmedSentSmoothedMovementTimestamp;
var float c_fLastRecievedNoSmoothTimestamp;
var byte m_byDesiredMoveSpeedReduction;
var TgPlayerController.TG_CAMERAPOSTURE c_eCameraPosture;
var TgPlayerController.EWatchOtherPlayersMode r_WatchOtherPlayer;
var TgObject.GAME_WIN_STATE c_GameWinState;
var byte m_bOldbRun;
var TgPlayerController.EHUDOverlay c_eCurrentOverlay;
var TgObject.TG_EQUIP_POINT m_eDetailedDeviceEqp;
var TgObject.TG_EQUIP_POINT m_LastEquipPoint;
var transient byte c_LastSentClientRoll;
var input byte m_UltHeld;
var input byte m_JumpHeld;
var input byte m_JumpHeldAlt;
var input byte m_PerCharacterAlt;
var array<CameraStackInfo> c_CameraStack;
var int c_nNextCameraStackId;
var const float m_fTimeToViewOthersCamAfterDeath;
var() const float m_fWatchOthersFadeToBlackCamTime;
var() const float m_fWatchOthersFadeFromBlackCamTime;
var array<TgAchievement> s_Achievements;
var TgAkAudioManagement c_TgAkAudio;
var int r_nFlashProjectile[32];
var sSimProjectileFireInfo r_FlashProjectileEx[32];
var repnotify int r_nFirstValidProjIdx;
var repnotify int r_nFlashSimProjIdx;
var int c_nLastFlashSimProjIdx;
var int r_nPerkPointsAvail;
var transient TgGameTipManager c_GameTipManager;
var native Pointer s_pCombatMessages;
var float s_fLastCombatMessageProcess;
var int c_nCurrentLevel;
var TgTutorialAnnouncer c_TutorialAnnouncer;
var repnotify int r_TutorialBlockedClientActions;
var TgSubtitledMessages c_SubtitledMessages;
var transient TgRepInfo_Player CachedPRI;
var MaterialInstanceConstant m_OverlayPathMaterial;
var int m_nContextNotifyGroundTargeterId;
var array<TgPawn> m_HiddenPawns;
var export editinline AudioComponent c_AlertAudioComponent;
var AkEvent c_AlertAkEvent;
var array<TgObjectReferencer> c_KismetLoadedDevices;
var TgContextNotifyActor m_ObjectiveNotify;
var() editinline TgCameraShake m_PreviewCameraShake;
var array<TgChaosCapturePoint> m_CapturePoints;
var() float m_fPathfinderStreamTime;
var() float m_fPathfinderPulseTime;
var() float m_fPathfinderLifetime;
var() float m_fPathfinderSpeed;
var() float m_fPathfinderStartDist;
var transient float c_LastSentMoveTimeStamp;
var transient Vector c_LastSentMoveAcceleration;
var transient int c_LastSentMoveCompressedFlags;
var transient Vector c_LastSentClientLoc;
var transient int c_LastSentView;
var AkEvent c_FallWindSoundPlay;
var AkEvent c_FallWindSoundStop;
var transient int m_nKillCamTargetId;
var transient int m_nKillCamTargetBackupId;
var float r_fServerTimeStamp;
var float m_fLastJumpTapTime;
var float m_fMaxJumpDoubleTapTime;
var int m_nVoicePackId;
var array<TgPawn> m_PawnsWithThreatLevels;
var TgPathfinder m_Pathfinder;
var config float m_fThreatCoefficientProximity;
var config float m_fThreatCoefficientOcclusion;
var config float m_fThreatCoefficientBinnedOcclusion;
var config float m_fThreatCoefficientUlt;
var config float m_fThreatCoefficientShotAt;
var config float m_fThreatCoefficientSeenBy;
var config float m_fThreatCoefficientDamaged;
var config float m_fThreatCoefficientFocused;
var config float m_fThreatCoefficientFocusTarget;
var config float m_fThreatCoefficientBehind;
var config float m_fThreatCoefficientInEffectiveRange;
var config float m_fThreatDecayCoefficientShotAt;
var config float m_fThreatDecayCoefficientSeenBy;
var config float m_fThreatDecayCoefficientUlt;
var string m_DebugThreatSystemChannel;
var string m_CurrentMusicEventName;
var name m_nameBuyBurnCardsTimer;
var Vector2D m_TimeDilationFromTo;
var float m_TimeDilationInterpolateSeconds;
var float m_TimeDilationUsedSeconds;
var Vector2D m_DesaturationFromTo;
var float m_DesaturationInterpolateSeconds;
var float m_DesaturationUsedSeconds;
var int m_EnergyLastFrame;
var transient Vector m_TrackingTargetLocation;
var transient float m_fTrackingTargetMaxAimDistDiff;
var AkBaseSoundObject m_RoundEndAlert;
var SeqAct_Interp m_CurrentDirectorMatinee;
var AkEvent m_CaptureProgressPlayAkEvent;
var AkEvent m_CaptureProgressStopAkEvent;
var float m_fCachedCaptureProgress;
var AkEvent m_PointGettingCapturedPlayAkEvent;
var int m_nPointGettingCapturedPlayCount;
var float m_fShowChampionOverviewTipDelay;
var float c_fLastAttackAudioCueTimestamp;
var float c_fLastAttackFromBehindAudioCueTimestamp;
var float c_fLastAttackFromAboveAudioCueTimestamp;
var float c_fLastAttackFromSniperAudioCueTimestamp;
var int s_nRoundsIdle;
var float s_fIdleTimeReduction;
var int c_nLeadingTeam;
var int c_nLeadingTeamTicketAmount;
var TgCallbackContainer m_CallbackContainer;

replication
{
    // Pos:0x000
    if(((int(Role) == int(ROLE_Authority)) && !bDemoRecording) && (bNetInitial || bNetTimelapseInit) || bNetTimelapsePost)
        r_nFirstValidProjIdx;

    // Pos:0x04F
    if((int(Role) == int(ROLE_Authority)) && bDemoRecording || !(bNetInitial || bNetTimelapseInit) || bNetTimelapsePost)
        r_FlashProjectileEx, r_nFlashProjectile, 
        r_nFlashSimProjIdx;

    // Pos:0x09E
    if((int(Role) == int(ROLE_Authority)) && bNetOwner)
        r_LastPurchasedItems, r_TutorialBlockedClientActions, 
        r_WatchOtherPlayer, r_bAutoPurchase, 
        r_bAutoSkillUp, r_bCanChangeLoadout, 
        r_bCanPurchaseItems, r_bInputEnabled, 
        r_bLockYawRotation, r_bRove, 
        r_bToggleZoom, r_fServerTimeStamp, 
        r_nCurrency, r_nPerkPointsAvail, 
        r_nStatPoints, r_nXp;
}

// Export UTgPlayerController::execSetViewTarget(FFrame&, void* const)
native function SetViewTarget(Actor NewViewTarget, optional ViewTargetTransitionParams TransitionParams);

// Export UTgPlayerController::execCanDoFullSellback(FFrame&, void* const)
native function CanDoFullSellback();

// Export UTgPlayerController::execIsReadyForStart(FFrame&, void* const)
native function bool IsReadyForStart();

// Export UTgPlayerController::execQueueReviveTimeChanged(FFrame&, void* const)
native function QueueReviveTimeChanged();

// Export UTgPlayerController::execCueAttackedFromBehind(FFrame&, void* const)
native function CueAttackedFromBehind();

// Export UTgPlayerController::execCueAttackedFromAbove(FFrame&, void* const)
native function CueAttackedFromAbove();

// Export UTgPlayerController::execCueAttackedFromSniper(FFrame&, void* const)
native function CueAttackedFromSniper();

// Export UTgPlayerController::execAnnouncerGetStep(FFrame&, void* const)
native function int AnnouncerGetStep(TgPlayerController.EAnnouncerSeries series);

// Export UTgPlayerController::execAnnouncerReset(FFrame&, void* const)
native function AnnouncerReset();

// Export UTgPlayerController::execAnnouncerPlaySeries(FFrame&, void* const)
native function bool AnnouncerPlaySeries(TgPlayerController.EAnnouncerSeries series, optional int Step = 0);

// Export UTgPlayerController::execPlayPointAlienFX(FFrame&, void* const)
native function PlayPointAlienFX(bool bPointWonLocal);

// Export UTgPlayerController::execNativeAnnounceEOM(FFrame&, void* const)
native function NativeAnnounceEOM(bool bVictory);

// Export UTgPlayerController::execLogPerfLeakData(FFrame&, void* const)
native exec function LogPerfLeakData();

// Export UTgPlayerController::execTestVGSPOTG(FFrame&, void* const)
native exec function TestVGSPOTG(int nPackId, int nBotId, int nSkinId);

// Export UTgPlayerController::execGetHudClass(FFrame&, void* const)
native function Class<HUD> GetHudClass(Class<HUD> pNewHudType);

// Export UTgPlayerController::execCanCameraSeePawnCenter(FFrame&, void* const)
native function bool CanCameraSeePawnCenter(TgPawn Other);

// Export UTgPlayerController::execCanCameraSeeActorCenter(FFrame&, void* const)
native function bool CanCameraSeeActorCenter(Actor Other, optional float ZOffset);

// Export UTgPlayerController::execServerSetTaskforceLead(FFrame&, void* const)
reliable server native function ServerSetTaskforceLead(string fsName);

// Export UTgPlayerController::execFriend(FFrame&, void* const)
native exec function Friend(string sCmd, string sName);

// Export UTgPlayerController::execConfirmMatchLeave(FFrame&, void* const)
native function ConfirmMatchLeave(bool bLeave);

// Export UTgPlayerController::execMatchLeave(FFrame&, void* const)
native exec function MatchLeave(bool bAsTeam);

// Export UTgPlayerController::execMatchAccept(FFrame&, void* const)
native event MatchAccept(bool bAccepted);

// Export UTgPlayerController::execGetClientSettings(FFrame&, void* const)
native static function TgClientSettings GetClientSettings();

// Export UTgPlayerController::execBug(FFrame&, void* const)
native exec function Bug();

// Export UTgPlayerController::exec_Crash(FFrame&, void* const)
native exec function _Crash();

// Export UTgPlayerController::execLogTo(FFrame&, void* const)
native exec function LogTo(string fsHost, optional int nPort = 4040);

// Export UTgPlayerController::execStopLogTo(FFrame&, void* const)
native exec function StopLogTo();

// Export UTgPlayerController::execToggleInHandTargeting(FFrame&, void* const)
native exec function ToggleInHandTargeting(bool bHide);

// Export UTgPlayerController::execDisableProfanityFilter(FFrame&, void* const)
native exec function DisableProfanityFilter(bool bDisable);

// Export UTgPlayerController::execSpectateDamage(FFrame&, void* const)
native exec function SpectateDamage(bool bShow);

// Export UTgPlayerController::execSpectateHeals(FFrame&, void* const)
native exec function SpectateHeals(bool bShow);

// Export UTgPlayerController::execSpectateCrits(FFrame&, void* const)
native exec function SpectateCrits(bool bShow);

// Export UTgPlayerController::execSpectateGold(FFrame&, void* const)
native exec function SpectateGold(bool bShow);

// Export UTgPlayerController::execSpectateXP(FFrame&, void* const)
native exec function SpectateXP(bool bShow);

// Export UTgPlayerController::execSpectateOutlines(FFrame&, void* const)
native exec function SpectateOutlines(bool bShow);

// Export UTgPlayerController::execToggleCombatInfo(FFrame&, void* const)
native exec function ToggleCombatInfo();

// Export UTgPlayerController::execFinalSave(FFrame&, void* const)
native function FinalSave();

// Export UTgPlayerController::execForceRelevant(FFrame&, void* const)
native function ForceRelevant(Actor pActor, optional float fDuration = -1.0000000);

// Export UTgPlayerController::execbIsEditor(FFrame&, void* const)
native function bool bIsEditor();

// Export UTgPlayerController::execGetValue(FFrame&, void* const)
native function GetValue(string fsObject, string fsValue);

// Export UTgPlayerController::execSetValue(FFrame&, void* const)
native function SetValue(string fsObject, string fsVariable, string fsValue);

// Export UTgPlayerController::execGetDeviceIdByName(FFrame&, void* const)
native function int GetDeviceIdByName(string sDeviceName);

// Export UTgPlayerController::execClientLoadDevices(FFrame&, void* const)
native function ClientLoadDevices(TgSeqAct_ClientLoadDevices Action);

// Export UTgPlayerController::execDumpClassInfoToFile(FFrame&, void* const)
native function DumpClassInfoToFile(string sClassName);

// Export UTgPlayerController::execSendGameOverEvent(FFrame&, void* const)
native function SendGameOverEvent(TgObject.GAME_WIN_STATE gameWinState, bool bPlayerIsAttacker);

// Export UTgPlayerController::execGetPlayerControlPawn(FFrame&, void* const)
native function TgPawn GetPlayerControlPawn();

// Export UTgPlayerController::execConvertTimeDisplay(FFrame&, void* const)
native function ConvertTimeDisplay(int nMinutes, out string sDisplay);

// Export UTgPlayerController::execCheckMaxEffectDistance(FFrame&, void* const)
native simulated function bool CheckMaxEffectDistance(PlayerController P, Vector SpawnLocation, optional float CullDistance);

// Export UTgPlayerController::execBlockVGS(FFrame&, void* const)
native simulated function BlockVGS(bool bBlock);

// Export UTgPlayerController::execOutputRelevantActors(FFrame&, void* const)
native exec function OutputRelevantActors();

// Export UTgPlayerController::execDoClientSidePerfTracking(FFrame&, void* const)
native function DoClientSidePerfTracking(int nLength);

// Export UTgPlayerController::execToggleTick(FFrame&, void* const)
native exec function ToggleTick(string ClassName, bool bDisable);

// Export UTgPlayerController::execSetPawnTickState(FFrame&, void* const)
native exec function SetPawnTickState(int nState);

// Export UTgPlayerController::execTgPerfTrack(FFrame&, void* const)
native exec function TgPerfTrack(bool bStart);

// Export UTgPlayerController::execDumpPerfTrackData(FFrame&, void* const)
native function DumpPerfTrackData();

// Export UTgPlayerController::execSetSoundMode(FFrame&, void* const)
native simulated function SetSoundMode(name NewSoundMode);

// Export UTgPlayerController::execDebugGetLangMsg(FFrame&, void* const)
native exec function DebugGetLangMsg(int nMsgId);

// Export UTgPlayerController::execHandleSimulatedProjectile(FFrame&, void* const)
native simulated function HandleSimulatedProjectile();

// Export UTgPlayerController::execSendUIXpChange(FFrame&, void* const)
native simulated function SendUIXpChange();

// Export UTgPlayerController::execSendUICurrencyChange(FFrame&, void* const)
native simulated function SendUICurrencyChange();

// Export UTgPlayerController::execGetDamageAngle(FFrame&, void* const)
native function GetDamageAngle(Rotator HitDir, out float PitchDegrees, out float YawDegrees);

// Export UTgPlayerController::execAutoPurchase(FFrame&, void* const)
native function AutoPurchase();

// Export UTgPlayerController::execAutoSkillUp(FFrame&, void* const)
native function AutoSkillUp();

// Export UTgPlayerController::execToggleZoom(FFrame&, void* const)
native function ToggleZoom();

// Export UTgPlayerController::execSetAutoPurchaseFlag(FFrame&, void* const)
native function SetAutoPurchaseFlag(bool bOn, optional bool bForce = false);

// Export UTgPlayerController::execSetAutoSkillUpFlag(FFrame&, void* const)
native function SetAutoSkillUpFlag(bool bOn, optional bool bForce = false);

// Export UTgPlayerController::execSetToggleZoomFlag(FFrame&, void* const)
native function SetToggleZoomFlag(bool bOn, optional bool bForce = false);

exec function TgPlayerController.EGiveGoldResult GiveGoldToFriendlyPlayer(int PlayerID, int GoldCount)
{
    return ServerTransferGoldBetweenFriendlyPlayers(PlayerID, GoldCount);
    //return ReturnValue;    
}

// Export UTgPlayerController::execServerTransferGoldBetweenFriendlyPlayers(FFrame&, void* const)
reliable server native function TgPlayerController.EGiveGoldResult ServerTransferGoldBetweenFriendlyPlayers(int ReceivingPlayerID, int GoldCount);

// Export UTgPlayerController::execGetPerkPointsAvailable(FFrame&, void* const)
native function int GetPerkPointsAvailable();

// Export UTgPlayerController::execGetPerkPointsSpent(FFrame&, void* const)
native function int GetPerkPointsSpent();

// Export UTgPlayerController::execCanAllocateDevicePoint(FFrame&, void* const)
native function bool CanAllocateDevicePoint(int nDeviceId, TgDevice aDevice, optional bool ignorePause = false);

// Export UTgPlayerController::execGetDevicePointsAvailable(FFrame&, void* const)
native function int GetDevicePointsAvailable();

// Export UTgPlayerController::execGetDevicePointsSpent(FFrame&, void* const)
native function int GetDevicePointsSpent();

// Export UTgPlayerController::execHaveBasicAbilitiesBeenActivated(FFrame&, void* const)
native function bool HaveBasicAbilitiesBeenActivated();

// Export UTgPlayerController::execServerAllocateDevicePoint(FFrame&, void* const)
reliable server native function ServerAllocateDevicePoint(int nDeviceId);

// Export UTgPlayerController::execClientUpdateUIDeviceState(FFrame&, void* const)
native function bool ClientUpdateUIDeviceState();

// Export UTgPlayerController::execClientUpdateTutorialBlockingActions(FFrame&, void* const)
native function ClientUpdateTutorialBlockingActions();

// Export UTgPlayerController::execGetTaskForceNumber(FFrame&, void* const)
native function int GetTaskForceNumber();

// Export UTgPlayerController::execIsFiringUlt(FFrame&, void* const)
native function bool IsFiringUlt();

// Export UTgPlayerController::execServerPurchaseItem(FFrame&, void* const)
reliable server native function ServerPurchaseItem(int nLootTableId, int nLootTableItemId, int nItemCount);

// Export UTgPlayerController::execServerUpgradeItem(FFrame&, void* const)
reliable server native function ServerUpgradeItem(int nLootTableId, int nLootTableItemId, int nUpgradeInvId);

// Export UTgPlayerController::execServerSellItem(FFrame&, void* const)
reliable server native function ServerSellItem(int nInventoryId);

// Export UTgPlayerController::execServerPlayVGS(FFrame&, void* const)
reliable server native function ServerPlayVGS(int nVgsId, optional int usedVPSetting = 0);

// Export UTgPlayerController::execServerPlayPing(FFrame&, void* const)
reliable server native function ServerPlayPing(float X, float Y, float Z, TgObject.PING_TYPE pingType);

// Export UTgPlayerController::execFadeHud(FFrame&, void* const)
reliable client native simulated function FadeHud();

// Export UTgPlayerController::execClientLogoff(FFrame&, void* const)
reliable client native simulated function ClientLogoff(bool bForced);

// Export UTgPlayerController::execLogTutorialAction(FFrame&, void* const)
native function LogTutorialAction(int nPlayerAction, int nEventData);

// Export UTgPlayerController::execTriggerTutorialEvent(FFrame&, void* const)
native function TriggerTutorialEvent(int nTutEvent, int nInfoData);

// Export UTgPlayerController::execHandleForcedClientTutorialAction(FFrame&, void* const)
native function HandleForcedClientTutorialAction(int nAction, int nActionElement);

// Export UTgPlayerController::execHandleTutorialHighlighter(FFrame&, void* const)
native function HandleTutorialHighlighter(bool bShow, int highlightedElement);

// Export UTgPlayerController::execHandleTutorialActionOnServer(FFrame&, void* const)
native function bool HandleTutorialActionOnServer(TgSeqAct_ForceClientTutorialAction inAction);

// Export UTgPlayerController::execIsTutorialBlockingAction(FFrame&, void* const)
native function bool IsTutorialBlockingAction(TgObject.eTutorialForceableElements Action);

// Export UTgPlayerController::execOnSceneLoadChange(FFrame&, void* const)
native function OnSceneLoadChange(string SceneName, bool bLoaded);

// Export UTgPlayerController::execUpdateTargetingList(FFrame&, void* const)
native function UpdateTargetingList(array<ImpactInfo> ImpactList, optional bool bLightUp = true);

// Export UTgPlayerController::execClearTargetingList(FFrame&, void* const)
native function ClearTargetingList();

// Export UTgPlayerController::execToggleMiniMapPing(FFrame&, void* const)
native function ToggleMiniMapPing(bool bStart);

// Export UTgPlayerController::execUpdatePlayerVitalsUI(FFrame&, void* const)
native function UpdatePlayerVitalsUI();

// Export UTgPlayerController::execUpdateTransitionUI(FFrame&, void* const)
native function UpdateTransitionUI();

// Export UTgPlayerController::execSetHUDOverlay(FFrame&, void* const)
native function SetHUDOverlay(TgPlayerController.EHUDOverlay eOverlay);

// Export UTgPlayerController::execSetSniperChargedMeter(FFrame&, void* const)
native function SetSniperChargedMeter(float fPercent);

// Export UTgPlayerController::execSetBinocularSettings(FFrame&, void* const)
native function SetBinocularSettings(BinocularSettings BinocSettings);

// Export UTgPlayerController::execShowRespawnBuyback(FFrame&, void* const)
native function ShowRespawnBuyback(int nCost);

// Export UTgPlayerController::execSendCombatMessage(FFrame&, void* const)
native function SendCombatMessage(CombatMessageInfo msgInfo);

// Export UTgPlayerController::execKickWarning(FFrame&, void* const)
native event KickWarning();

// Export UTgPlayerController::execSpectateGM(FFrame&, void* const)
native exec function SpectateGM(string sPlayerName, optional string sSpectatePassword);

// Export UTgPlayerController::execSpectate(FFrame&, void* const)
native exec function Spectate(string sPlayerName, optional string sSpectatePassword);

// Export UTgPlayerController::execSpectateStop(FFrame&, void* const)
native exec function SpectateStop();

// Export UTgPlayerController::execIsLocalPlayerController(FFrame&, void* const)
native function bool IsLocalPlayerController();

// Export UTgPlayerController::execResetKeysToDefault(FFrame&, void* const)
native exec function ResetKeysToDefault(bool bSpectator);

// Export UTgPlayerController::execUpdateRuntimeInput(FFrame&, void* const)
native function UpdateRuntimeInput(bool bSpectator);

// Export UTgPlayerController::execUpdateKeybindsUI(FFrame&, void* const)
native function UpdateKeybindsUI();

// Export UTgPlayerController::execStartFX(FFrame&, void* const)
native function StartFX();

// Export UTgPlayerController::execPlayEventFX(FFrame&, void* const)
native function PlayEventFX();

// Export UTgPlayerController::execCheckHealthFX(FFrame&, void* const)
native function CheckHealthFX(float fCurrent, float fMaximum);

// Export UTgPlayerController::execClientAddCheats(FFrame&, void* const)
native function ClientAddCheats();

// Export UTgPlayerController::execSendContextNotifyVGS(FFrame&, void* const)
native function SendContextNotifyVGS(int ContextId);

// Export UTgPlayerController::execServerPlayContextNotify(FFrame&, void* const)
unreliable server native function ServerPlayContextNotify(int ContextId, Vector NotifyLocation);

// Export UTgPlayerController::execServerGiveCard(FFrame&, void* const)
reliable server native function ServerGiveCard(int nDeviceId);

// Export UTgPlayerController::execServerRequestGraphData(FFrame&, void* const)
reliable server native function ServerRequestGraphData();

// Export UTgPlayerController::execAchievementPossess(FFrame&, void* const)
native function AchievementPossess(Pawn aPawn);

// Export UTgPlayerController::execAchievementUnPossess(FFrame&, void* const)
native function AchievementUnPossess();

// Export UTgPlayerController::execAchievementAchievedById(FFrame&, void* const)
native function AchievementAchievedById(int nActivityId);

// Export UTgPlayerController::execAchievementModifiedHealthProp(FFrame&, void* const)
native function AchievementModifiedHealthProp(int nHealth, int nMaxHealth);

// Export UTgPlayerController::execSetSelectedTalent(FFrame&, void* const)
native function SetSelectedTalent(int nBotId, int nDeviceIndex);

// Export UTgPlayerController::execSetSelectedDeck(FFrame&, void* const)
native function SetSelectedDeck(int nBotId, int nIndex);

// Export UTgPlayerController::execSetRewardValues(FFrame&, void* const)
native function SetRewardValues(int XP, int nCredits, Actor Source, optional TgObject.ERewardValueType RewardType = 0, optional bool bFlankKill = false);

// Export UTgPlayerController::execOnRequestCard(FFrame&, void* const)
native function bool OnRequestCard(int nDeviceId, int nRank);

// Export UTgPlayerController::execOnRequestTalent(FFrame&, void* const)
native function OnRequestTalent(int nDeviceId);

// Export UTgPlayerController::execOnRequestDeck(FFrame&, void* const)
native function OnRequestDeck(int nDeviceId);

// Export UTgPlayerController::execUIFade(FFrame&, void* const)
native function UIFade(bool bFade, optional float fTime = 0.2500000, optional float fDelay = 0.0000000, optional float FailSafeTime = 5.0000000);

// Export UTgPlayerController::execUIFadeEndOfRound(FFrame&, void* const)
native function UIFadeEndOfRound(bool bFade, optional float fTime = 0.2500000, optional float fDelay = 0.0000000, optional float FailSafeTime = 5.0000000);

// Export UTgPlayerController::execOnScoredPoints(FFrame&, void* const)
private native final function OnScoredPoints(int nValue, TgObject.ERewardValueType eType, int nPlayerId);

// Export UTgPlayerController::execGetBestKillCamTarget(FFrame&, void* const)
native final function Actor GetBestKillCamTarget();

// Export UTgPlayerController::execIsConfused(FFrame&, void* const)
native final function bool IsConfused();

// Export UTgPlayerController::execShouldHideUIWorldOverlay(FFrame&, void* const)
native final function bool ShouldHideUIWorldOverlay();

// Export UTgPlayerController::execWants3P(FFrame&, void* const)
native function bool Wants3P();

// Export UTgPlayerController::execRefreshLastActiveTime(FFrame&, void* const)
native final function RefreshLastActiveTime();

// Export UTgPlayerController::execShowAutoPurchaseTip(FFrame&, void* const)
native function ShowAutoPurchaseTip();

// Export UTgPlayerController::execIsTopMenu(FFrame&, void* const)
native function bool IsTopMenu(string sName);

// Export UTgPlayerController::execCloseHUDMenus(FFrame&, void* const)
native function CloseHUDMenus();

// Export UTgPlayerController::execSetAkWorldTimeDilation(FFrame&, void* const)
native function SetAkWorldTimeDilation();

// Export UTgPlayerController::execUpdateMinimap(FFrame&, void* const)
native function UpdateMinimap(TgMapBoundsVolume pMapBoundsVolume);

// Export UTgPlayerController::execCanPlayKillCam(FFrame&, void* const)
native function bool CanPlayKillCam(bool bPlayOfGame);

// Export UTgPlayerController::execNextScoreboardDisplayType(FFrame&, void* const)
native exec function NextScoreboardDisplayType();

// Export UTgPlayerController::execSetReticleVisibility(FFrame&, void* const)
native function SetReticleVisibility(bool bShowReticle, bool bShowReticleAccessories);

// Export UTgPlayerController::execNotifyUpdatedInhandAmmoCount(FFrame&, void* const)
native function NotifyUpdatedInhandAmmoCount(int nAmmo, TgDevice pDevice, int nDeviceId);

// Export UTgPlayerController::execGetMICResource(FFrame&, void* const)
native function MaterialInstanceConstant GetMICResource(int nResourceId);

// Export UTgPlayerController::execTestCrashReport(FFrame&, void* const)
native function TestCrashReport();

// Export UTgPlayerController::execSetNWCondition(FFrame&, void* const)
native function SetNWCondition(int nPktLoss, int nPktLag);

// Export UTgPlayerController::execStartReviveTimer(FFrame&, void* const)
native function float StartReviveTimer(optional bool bDoNotUpdateStatsTracker);

// Export UTgPlayerController::execOnRespawnRuleChanged(FFrame&, void* const)
native function bool OnRespawnRuleChanged();

// Export UTgPlayerController::execSetLevel(FFrame&, void* const)
native function SetLevel(int nLevel);

// Export UTgPlayerController::execSetPlayerProfile(FFrame&, void* const)
native function SetPlayerProfile(int nProfileId, int nSkinId, int nWeaponSkinId, int nHeadSkinId, optional int nVoicePackId = 0);

// Export UTgPlayerController::execSetPlayerWard(FFrame&, void* const)
native function SetPlayerWard(int nWardSkinId);

// Export UTgPlayerController::execReloadKeybindsForPawn(FFrame&, void* const)
native function ReloadKeybindsForPawn();

// Export UTgPlayerController::execSetAudioFriendlyAndLocal(FFrame&, void* const)
native simulated function SetAudioFriendlyAndLocal();

// Export UTgPlayerController::execServerMove(FFrame&, void* const)
unreliable server native function ServerMove(float TimeStamp, Vector InAccel, Vector ClientLoc, byte MoveFlags, byte ClientRoll, int View);

function CallServerMove(SavedMove NewMove, Vector ClientLoc, byte ClientRoll, int View, SavedMove OldMove)
{
    super(PlayerController).CallServerMove(NewMove, ClientLoc, ClientRoll, View, OldMove);
    c_LastSentMoveTimeStamp = NewMove.TimeStamp;
    c_LastSentMoveAcceleration = NewMove.Acceleration;
    c_LastSentMoveCompressedFlags = int(NewMove.CompressedFlags());
    c_LastSentClientLoc = ClientLoc;
    c_LastSentClientRoll = ClientRoll;
    c_LastSentView = View;
    //return;    
}

exec event AllocateDevicePoint(int nDeviceId)
{
    // End:0x2B
    if(CanAllocateDevicePoint(nDeviceId, none))
    {
        ServerAllocateDevicePoint(nDeviceId);
    }
    //return;    
}

function Logoff(bool bForced)
{
    ClientLogoff(bForced);
    //return;    
}

unreliable client simulated function ClientPlaySound(SoundCue ASound)
{
    PlaySound(ASound);
    //return;    
}

unreliable client simulated function ClientPlaySoundBase(AkBaseSoundObject ASound)
{
    PlaySoundBase(ASound);
    //return;    
}

reliable client simulated event ClientShowRespawnBuyback(int nCost)
{
    ShowRespawnBuyback(nCost);
    //return;    
}

event RequestShowRespawnBuyback()
{
    // End:0x2C
    if(!IsTimerActive('ShowRespawnTimerExpired'))
    {
        ClientShowRespawnBuyback(m_nReviveBuybackCost);
    }
    //return;    
}

function ShowRespawnTimerExpired()
{
    // End:0x23
    if(IsInState('Dead'))
    {
        ClientShowRespawnBuyback(m_nReviveBuybackCost);
    }
    //return;    
}

exec function SetTaskforceLead(string fsName)
{
    ServerSetTaskforceLead(fsName);
    //return;    
}

exec function ShowBinoculars(bool bShow)
{
    SetHUDOverlay(((bShow) ? 2 : 0));
    //return;    
}

function SetCanChangeLoadout(bool bCanChangeLoadout)
{
    r_bCanChangeLoadout = bCanChangeLoadout;
    //return;    
}

function SetCanPurchaseFlag(bool bCanPurchase)
{
    local TgGame_Battle ActualGame;
    local TgPawn aPawn;

    ActualGame = TgGame_Battle(WorldInfo.Game);
    aPawn = TgPawn(Pawn);
    // End:0x115
    if(ActualGame != none)
    {
        // End:0xC1
        if(bCanPurchase)
        {
            // End:0xBE
            if(ActualGame.m_bRestrictStoreInteractions)
            {
                // End:0xBE
                if(aPawn != none)
                {
                    // End:0xBE
                    if(aPawn.s_bHasInteractedWithStore)
                    {
                        return;
                    }
                }
            }            
        }
        else
        {
            // End:0x115
            if(ActualGame.m_bRestrictStoreInteractions && aPawn != none)
            {
                aPawn.s_bHasInteractedWithStore = true;
            }
        }
    }
    r_bCanPurchaseItems = bCanPurchase;
    // End:0x141
    if(bCanPurchase)
    {
        AutoPurchase();
    }
    // End:0x19E
    if(WorldInfo.IsRecordingDemo() && aPawn != none)
    {
        aPawn.r_bDemoCanPurchaseItems = bCanPurchase;
    }
    // End:0x1E0
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && IsLocalPlayerController())
    {
        OnCanPurchaseItemChange();
    }
    //return;    
}

exec event SetAutoPurchase(bool bAutoPurchase)
{
    ServerSetAutoPurchase(bAutoPurchase);
    //return;    
}

reliable server function ServerSetAutoPurchase(bool bAutoPurchase)
{
    SetAutoPurchaseFlag(bAutoPurchase);
    AutoPurchase();
    //return;    
}

exec event SetAutoSkillUp(bool bAutoSkill)
{
    ServerSetAutoSkillUp(bAutoSkill);
    //return;    
}

reliable server function ServerSetAutoSkillUp(bool bAutoSkill)
{
    SetAutoSkillUpFlag(bAutoSkill);
    AutoSkillUp();
    //return;    
}

exec event SetToggleZoom(bool bToggleZoom)
{
    ServerSetToggleZoom(bToggleZoom);
    //return;    
}

reliable server function ServerSetToggleZoom(bool bToggleZoom)
{
    SetToggleZoomFlag(bToggleZoom);
    ToggleZoom();
    //return;    
}

// Export UTgPlayerController::execAddKillAlert(FFrame&, void* const)
native function AddKillAlert(string KilledName, string KillerName, bool KillerWasPlayer);

// Export UTgPlayerController::execAddAssistAlert(FFrame&, void* const)
native function AddAssistAlert(string KilledName, string KillerName);

// Export UTgPlayerController::execAddAutoKickAlert(FFrame&, void* const)
native function AddAutoKickAlert();

exec function WhereAmI()
{
    LocalPlayer(Player).ViewportClient.ViewportConsole.OutputText("Location = " @ string(GetPlayerControlPawn().Location));
    //return;    
}

exec function TestScreenCapturePostProcess()
{
    local LocalPlayer LocalPlayer;
    local TgScreenCapturePostEffect TgScreenCapturePostEffect;
    local MaterialInstanceTimeVarying NewMaterial;

    LocalPlayer = LocalPlayer(Player);
    ClearTimer('RemoveScreenCapturePostProcess');
    RemoveScreenCapturePostProcess();
    // End:0x1EF
    if((LocalPlayer != none) && LocalPlayer.PlayerPostProcess != none)
    {
        TgScreenCapturePostEffect = new Class'TgGame.TgScreenCapturePostEffect';
        TgScreenCapturePostEffect.InitializeRenderTarget(self);
        NewMaterial = new Class'Engine.MaterialInstanceTimeVarying';
        NewMaterial.SetParent(MaterialInstanceTimeVarying'TgPostProcess.MIC_FadeOldFrame');
        NewMaterial.SetTextureParameterValue('OldFrame', TgScreenCapturePostEffect.ScreenCapture);
        NewMaterial.SetScalarStartTime('FadeAmount', 0.0000000);
        SetTimer(NewMaterial.GetMaxDurationFromAllParameters(), false, 'RemoveScreenCapturePostProcess');
        TgScreenCapturePostEffect.Material = NewMaterial;
        LocalPlayer.PlayerPostProcess.Effects.AddItem(TgScreenCapturePostEffect);
    }
    //return;    
}

function RemoveScreenCapturePostProcess()
{
    local LocalPlayer LocalPlayer;
    local TgScreenCapturePostEffect TgScreenCapturePostEffect;
    local PostProcessEffect CurrentEffect;

    LocalPlayer = LocalPlayer(Player);
    // End:0xFF
    if((LocalPlayer != none) && LocalPlayer.PlayerPostProcess != none)
    {
        // End:0xFE
        foreach LocalPlayer.PlayerPostProcess.Effects(CurrentEffect)
        {
            TgScreenCapturePostEffect = TgScreenCapturePostEffect(CurrentEffect);
            // End:0xFD
            if(TgScreenCapturePostEffect != none)
            {
                TgScreenCapturePostEffect.Cleanup(LocalPlayer.PlayerPostProcess);                
            }
            else
            {                
            }
        }        
    }
    //return;    
}

simulated exec event CauseClientEvent(optional name EventName)
{
    local array<SequenceObject> AllConsoleEvents;
    local SeqEvent_Console ConsoleEvt;
    local Sequence GameSeq;
    local int Idx;
    local bool bFoundEvt;

    GameSeq = WorldInfo.GetGameSequence();
    // End:0x150
    if((GameSeq != none) && EventName != 'None')
    {
        GameSeq.FindSeqObjectsByClass(Class'Engine.SeqEvent_Console', true, AllConsoleEvents);
        Idx = 0;
        J0x8F:

        // End:0x150 [Loop If]
        if(Idx < AllConsoleEvents.Length)
        {
            ConsoleEvt = SeqEvent_Console(AllConsoleEvents[Idx]);
            // End:0x142
            if((ConsoleEvt != none) && EventName == ConsoleEvt.ConsoleEventName)
            {
                bFoundEvt = true;
                ConsoleEvt.CheckActivate(self, Pawn);
            }
            Idx++;
            // [Loop Continue]
            goto J0x8F;
        }
    }
    // End:0x15F
    if(!bFoundEvt)
    {
    }
    //return;    
}

exec function CCE(optional name EventName)
{
    CauseClientEvent(EventName);
    //return;    
}

exec function OnLeftMousePressed()
{
    local TgPawn P;
    local TgObject.EDeviceFailType failType;
    local int I;
    local TgDevice Dev;

    InputReceived(8);
    // End:0x1F
    if(!IsInputAllowed(8))
    {
        return;
    }
    bPressingLeftMouseButton = true;
    // End:0x4F
    if(WorldInfo.IsPlayingTimelapse())
    {
        return;
    }
    P = TgPawn(Pawn);
    // End:0xD7
    if((m_nContextNotifyGroundTargeterId != 0) && P != none)
    {
        ServerPlayContextNotify(m_nContextNotifyGroundTargeterId, vect(0.0000000, 0.0000000, 0.0000000));
        SendContextNotifyVGS(m_nContextNotifyGroundTargeterId);
        EnableContextNotify(0);
        bPressingLeftMouseButton = false;
        return;
    }
    // End:0x29F
    if(P != none)
    {
        I = 0;
        J0xF1:

        // End:0x175 [Loop If]
        if(I < 33)
        {
            Dev = P.m_EquippedDevices[I];
            // End:0x167
            if(Dev != none)
            {
                // End:0x167
                if(Dev.InterceptLeftMousePressed(self))
                {
                    return;
                }
            }
            ++I;
            // [Loop Continue]
            goto J0xF1;
        }
        // End:0x29F
        if(P.c_CurrentTargetingDevice != none)
        {
            // End:0x1DB
            if(P.OnMountCancelOffhandSlotPressed(P.c_CurrentTargetingDevice))
            {
                return;
            }
            // End:0x290
            if(!P.StartAction(P.c_CurrentTargetingDevice, failType))
            {
                TgHUD(myHUD).PlayDeviceFailResponse(failType, P.c_CurrentTargetingDevice.IsAbility());                
            }
            else
            {
                m_bPendingReload = false;
            }            
        }
    }
    //return;    
}

exec function OnLeftMouseReleased()
{
    local int I;
    local TgPawn P;
    local TgDevice Dev;

    P = TgPawn(Pawn);
    // End:0x2D
    if(!bPressingLeftMouseButton)
    {
        return;
    }
    bPressingLeftMouseButton = false;
    // End:0x1EE
    if(P != none)
    {
        I = 0;
        J0x53:

        // End:0xD7 [Loop If]
        if(I < 33)
        {
            Dev = P.m_EquippedDevices[I];
            // End:0xC9
            if(Dev != none)
            {
                // End:0xC9
                if(Dev.InterceptLeftMouseReleased(self))
                {
                    return;
                }
            }
            ++I;
            // [Loop Continue]
            goto J0x53;
        }
        // End:0x1EE
        if(P.c_CurrentTargetingDevice != none)
        {
            // End:0x175
            if(P.c_CurrentTargetingDevice.m_bIsFireHoldDevice)
            {
                P.c_CurrentTargetingDevice.ReleaseFireHold();
                m_bPendingReload = false;                
            }
            else
            {
                // End:0x1EB
                if(!P.c_CurrentTargetingDevice.IsFunctionallyToggleDevice())
                {
                    P.StopAction(P.c_CurrentTargetingDevice);
                }
            }            
        }
    }
    //return;    
}

exec function OnRightMousePressed()
{
    local TgPawn P;
    local int I;
    local TgDevice Dev;
    local WeaponMeshSwapStrategy SwapStrategy;

    InputReceived(9);
    // End:0x1F
    if(!IsInputAllowed(9))
    {
        return;
    }
    bPressingRightMouseButton = true;
    // End:0x71
    if(m_nContextNotifyGroundTargeterId != 0)
    {
        EnableContextNotify(0);        
        ConsoleCommand("UnloadScene UIHudVGS");
        return;
    }
    P = TgPawn(Pawn);
    // End:0x2DE
    if(P != none)
    {
        I = 0;
        J0xA7:

        // End:0x12B [Loop If]
        if(I < 33)
        {
            Dev = P.m_EquippedDevices[I];
            // End:0x11D
            if(Dev != none)
            {
                // End:0x11D
                if(Dev.InterceptRightMousePressed(self))
                {
                    return;
                }
            }
            ++I;
            // [Loop Continue]
            goto J0xA7;
        }
        Dev = none;
        // End:0x2D2
        if((P.c_CurrentTargetingDevice == none) || ((P.c_CurrentTargetingDevice != none) && int(P.c_CurrentTargetingDevice.r_eEquippedAt) != int(1)) && P.c_CurrentTargetingDevice.ShouldSwitchBackToBasicAttackTargeting(GetClientSettings().GetCastMode(P.r_nProfileId, P.c_CurrentTargetingDevice.r_eEquippedAt)))
        {
            P.SetTargetingDevice(P.GetDeviceByEqPoint(1), SwapStrategy);
            P.c_CurrentStartActionDevice = none;
        }
        OnOffhandSlotPressed(16);
    }
    //return;    
}

exec function OnRightMouseReleased()
{
    local TgPawn P;
    local TgDevice Dev;
    local int I;

    // End:0x11
    if(!bPressingRightMouseButton)
    {
        return;
    }
    P = TgPawn(Pawn);
    bPressingRightMouseButton = false;
    // End:0x23C
    if(P != none)
    {
        I = 0;
        J0x53:

        // End:0xD7 [Loop If]
        if(I < 33)
        {
            Dev = P.m_EquippedDevices[I];
            // End:0xC9
            if(Dev != none)
            {
                // End:0xC9
                if(Dev.InterceptRightMouseReleased(self))
                {
                    return;
                }
            }
            ++I;
            // [Loop Continue]
            goto J0x53;
        }
        Dev = none;
        // End:0x230
        if(P.c_CurrentTargetingDevice != none)
        {
            // End:0x1B7
            if(P.c_CurrentTargetingDevice.m_bIsFireHoldDevice)
            {
                // End:0x1B4
                if(P.c_CurrentTargetingDevice.ReleaseHoldOnRightMouseReleased())
                {
                    P.c_CurrentTargetingDevice.ReleaseFireHold();
                    m_bPendingReload = false;
                }                
            }
            else
            {
                // End:0x22D
                if(!P.c_CurrentTargetingDevice.IsFunctionallyToggleDevice())
                {
                    P.StopAction(P.c_CurrentTargetingDevice);
                }
            }            
        }
        OnOffhandSlotReleased(16);
    }
    //return;    
}

simulated function bool PingMap(Vector WorldLocation, const out array<ReplicationInfo> worldActorRepInfos, TgObject.PING_TYPE Type)
{
    local TgDevice targetingDevice;

    // End:0x49
    if(TgPawn(Pawn) != none)
    {
        targetingDevice = TgPawn(Pawn).c_CurrentTargetingDevice;
    }
    // End:0xEB
    if((targetingDevice != none) && int(targetingDevice.GetTargetingMode()) == int(9))
    {
        m_vWorldMapLocation = WorldLocation;
        m_WorldMapTargetRepInfos = worldActorRepInfos;
        // End:0xD5
        if(int(Type) != int(0))
        {
            OnRightMousePressed();
            OnRightMouseReleased();            
        }
        else
        {
            OnLeftMousePressed();
            OnLeftMouseReleased();
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

reliable server function ServerSetViewTarget(Actor me)
{
    ResetCameraMode();
    SetViewTarget(me);
    ClientSetViewTarget(me);
    //return;    
}

function SetCorrectViewTarget()
{
    local Vector Loc;
    local Rotator Rot;

    // End:0x52
    if(r_bRove == true)
    {
        GetPlayerViewPoint(Loc, Rot);
        SetRotation(Rot);
        SetLocation(Loc);
        ServerViewSelf();        
    }
    else
    {
        ServerSetViewTarget(Pawn);
    }
    //return;    
}

exec function StartWatchOthers(optional TgPlayerController.EWatchOtherPlayersMode Mode = 1)
{
    ServerWatchOtherPlayer(Mode);
    ServerViewNextPlayer();
    //return;    
}

exec function StopWatchOthers()
{
    ServerWatchOtherPlayer(0);
    // End:0x2E
    if(Pawn != none)
    {
        ServerSetViewTarget(Pawn);
    }
    //return;    
}

reliable server function ServerWatchOtherPlayer(TgPlayerController.EWatchOtherPlayersMode Mode)
{
    r_WatchOtherPlayer = Mode;
    //return;    
}

unreliable server function ServerViewSelf(optional ViewTargetTransitionParams TransitionParams)
{
    ServerWatchOtherPlayer(0);
    super(PlayerController).ServerViewSelf();
    //return;    
}

exec function ToggleRove()
{
    r_bRove = !r_bRove;
    ServerRove(r_bRove);
    SetCorrectViewTarget();
    //return;    
}

reliable server function ServerRove(bool bOn)
{
    r_bRove = bOn;
    //return;    
}

reliable client simulated event ClientSetRotationAndDesired(Rotator NewRotation, optional bool bResetCamera)
{
    NewRotation.Pitch = NormalizeRotAxis(NewRotation.Pitch);
    SetRotation(NewRotation);
    // End:0xBC
    if(Pawn != none)
    {
        NewRotation.Pitch = 0;
        NewRotation.Roll = 0;
        Pawn.SetRotation(NewRotation);
    }
    //return;    
}

unreliable client simulated function ClientPingMap(Vector WorldLoc, TgObject.PING_TYPE pingType)
{
    // End:0x52
    if(TgHUD(myHUD) != none)
    {
        TgHUD(myHUD).PingWorldLocation(WorldLoc, pingType);
    }
    //return;    
}

// Export UTgPlayerController::execAddAlertScript(FFrame&, void* const)
native function AddAlertScript(TgObject.AlertPriority Priority, TgObject.AlertType Type, float fDuration, int nMsgId, optional bool bBlockDuplicates = false);

// Export UTgPlayerController::execRemoveAlertScript(FFrame&, void* const)
native function RemoveAlertScript(int nMsgId);

exec function SelfAlert(int nPriority, float fDuration, int nMsgId)
{
    local TgObject.AlertPriority Priority;

    Priority = byte(nPriority);
    AddAlertScript(Priority, 0, fDuration, nMsgId);
    //return;    
}

exec function ServerProfileScript(string Command)
{
    ServerProfiling(Command);
    //return;    
}

reliable server function ServerProfiling(string Command)
{
    TgGame(WorldInfo.Game).ConsoleCommand("PROFILESCRIPT" @ Command);
    //return;    
}

exec event PressJump(bool bOn)
{
    local TgPawn P;

    P = TgPawn(Pawn);
    // End:0x2D
    if(P == none)
    {
        return;
    }
    // End:0x6A
    if(bOn && IsInputAllowed(14))
    {
        PlayerInput.Jump();
    }
    //return;    
}

exec event ClientPurchaseItem(int nLootTableId, int nLootTableItemId, int nItemCount)
{
    ServerPurchaseItem(nLootTableId, nLootTableItemId, nItemCount);
    //return;    
}

exec event ClientSellItem(int nInventoryId)
{
    ServerSellItem(nInventoryId);
    //return;    
}

simulated event Destroyed()
{
    local Pawn ControlledPawn;
    local TgGame_Mission TheGame;
    local bool bDestroyPawn;
    local TgAchievement Achievement;

    // End:0x167
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        bDestroyPawn = true;
        TheGame = TgGame_Mission(WorldInfo.Game);
        ControlledPawn = Pawn;
        // End:0x9B
        if(ControlledPawn == none)
        {
            ControlledPawn = s_LastPossessedPawn;
        }
        // End:0x167
        if((ControlledPawn != none) && ControlledPawn.Controller == self)
        {
            FinalSave();
            // End:0x167
            if((TheGame != none) && TgPawn_Character(ControlledPawn) != none)
            {
                bDestroyPawn = !TheGame.SwapToNewAIController(self, TgPawn_Character(ControlledPawn));
                // End:0x167
                if(bDestroyPawn)
                {
                    ControlledPawn.Destroy();
                }
            }
        }
    }
    // End:0x1A0
    if(c_TutorialAnnouncer != none)
    {
        c_TutorialAnnouncer.Destroyed();
        c_TutorialAnnouncer = none;
    }
    // End:0x1D9
    if(c_SubtitledMessages != none)
    {
        c_SubtitledMessages.Destroyed();
        c_SubtitledMessages = none;
    }
    // End:0x20B
    if(myHUD != none)
    {
        myHUD.Destroy();
        myHUD = none;
    }
    // End:0x242
    foreach s_Achievements(Achievement)
    {
        Achievement.StopTracking();        
    }    
    s_Achievements.Length = 0;
    super(PlayerController).Destroyed();
    //return;    
}

function InitPlayerReplicationInfo()
{
    super(Controller).InitPlayerReplicationInfo();
    CachedPRI = TgRepInfo_Player(PlayerReplicationInfo);
    //return;    
}

function CleanupPRI()
{
    // End:0x27
    if(!IsInState('RoundEnded'))
    {
        CachedPRI = none;
        super(PlayerController).CleanupPRI();
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
    // End:0x1F2
    if(PC != none)
    {
        PC.s_nPlayerId = s_nPlayerId;
        PC.r_nXp = r_nXp;
        PC.s_fXpRemainder = s_fXpRemainder;
        PC.r_nCurrency = r_nCurrency;
        PC.s_fCurrencyRemainder = s_fCurrencyRemainder;
        FromPri = TgRepInfo_Player(PlayerReplicationInfo);
        ToPri = TgRepInfo_Player(PC.PlayerReplicationInfo);
        // End:0x1EF
        if((FromPri != none) && ToPri != none)
        {
            FromPri.CopyProperties(ToPri);
            FromPri.TransferMinionOwnershipTo(ToPri);
            PlayerReplicationInfo = none;
            FromPri.Destroy();
        }        
    }
    else
    {
        // End:0x4D2
        if(aic != none)
        {
            aic.PlayerID = s_nPlayerId;
            aic.CurrentXP = r_nXp;
            aic.CurrentXPRemainder = s_fXpRemainder;
            aic.CurrentGold = r_nCurrency;
            aic.CurrentGoldRemainder = s_fCurrencyRemainder;
            FromPri = TgRepInfo_Player(PlayerReplicationInfo);
            ToPri = TgRepInfo_Player(aic.PlayerReplicationInfo);
            // End:0x4D2
            if((FromPri != none) && ToPri != none)
            {
                FromPri.CopyProperties(ToPri);
                FromPri.TransferMinionOwnershipTo(ToPri);
                // End:0x4AF
                if(ToPri.r_SpawnPoint != none)
                {
                    aic.m_vSpawnLocation = ToPri.r_SpawnPoint.Location;
                    aic.m_rSpawnDirection = ToPri.r_SpawnPoint.Rotation;
                    // End:0x4AF
                    if(Pawn != none)
                    {
                        aic.m_vSpawnLocation.Z += Pawn.GetCollisionHeight();
                    }
                }
                PlayerReplicationInfo = none;
                FromPri.Destroy();
            }
        }
    }
    //return;    
}

event PreRender(Canvas Canvas)
{
    // End:0x49
    if(TgPawn(Pawn) != none)
    {
        TgPawn(Pawn).PreRender(Canvas);
    }
    //return;    
}

function SetControlModuleOnPossess()
{
    local TgPawn TgP;

    TgP = TgPawn(Pawn);
    // End:0xC9
    if(((((TgP != none) && TgP.DefaultControlModuleClass != none) && DefaultControlModuleClass != TgP.DefaultControlModuleClass) && ControlModule != none) && DefaultControlModuleClass == ControlModule.Class)
    {
        SwitchControl(none);
    }
    //return;    
}

function AcknowledgePossession(Pawn P)
{
    super.AcknowledgePossession(P);
    // End:0x5D
    if(Pawn != none)
    {
        c_nCameraYawOffset = Pawn.Rotation.Yaw;
    }
    // End:0xB7
    if((P == none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        WorldInfo.ForceGarbageCollection();
    }
    SetControlModuleOnPossess();
    // End:0xF4
    if(PlayerCamera != none)
    {
        PlayerCamera.UpdateCamera(0.0000000);
    }
    // End:0x163
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && m_bShowChampionOverviewTip)
    {
        // End:0x159
        if(m_fShowChampionOverviewTipDelay > 0.0000000)
        {
            SetTimer(m_fShowChampionOverviewTipDelay, false, 'ShowChampionOverviewTip');            
        }
        else
        {
            ShowChampionOverviewTip();
        }
    }
    //return;    
}

reliable server function ServerAcknowledgePossession(Pawn P)
{
    local TgRepInfo_Player PRI;

    super(PlayerController).ServerAcknowledgePossession(P);
    // End:0x97
    if((P != none) && TgGame_Mission(WorldInfo.Game) != none)
    {
        TgGame_Mission(WorldInfo.Game).MarkAsReady(Player);
    }
    PRI = CachedPRI;
    // End:0x165
    if(PRI != none)
    {
        PRI.r_bMapHasLoaded = true;
        // End:0x122
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            PRI.UpdatePlayerReady();
        }
        // End:0x165
        if(PRI.LoadCardDeck())
        {
            PRI.DrawNewCards();
        }
    }
    //return;    
}

event Possess(Pawn aPawn, bool bVehicleTransition)
{
    super(PlayerController).Possess(aPawn, bVehicleTransition);
    s_LastPossessedPawn = aPawn;
    AchievementPossess(aPawn);
    ReloadKeybindsForPawn();
    SetControlModuleOnPossess();
    // End:0xDB
    if((CachedPRI != none) && TgInventoryManager(aPawn.InvManager) != none)
    {
        CachedPRI.UpdateBroadcastedItems(TgInventoryManager(aPawn.InvManager));
    }
    //return;    
}

event UnPossess()
{
    local bool bSwitchControl;
    local TgPawn TgP;

    TgP = TgPawn(Pawn);
    bSwitchControl = ((((TgP != none) && TgP.DefaultControlModuleClass != none) && DefaultControlModuleClass != TgP.DefaultControlModuleClass) && ControlModule != none) && ControlModule.Class == TgP.DefaultControlModuleClass;
    AchievementUnPossess();
    super(PlayerController).UnPossess();
    // End:0x140
    if(TgP != none)
    {
        TgP.r_bIsMounted = false;
        TgP.bNetDirty = true;
    }
    // End:0x158
    if(bSwitchControl)
    {
        SwitchControl(none);
    }
    //return;    
}

function NotifyChangedWeapon(Weapon PreviousWeapon, Weapon NewWeapon)
{
    // End:0x50
    if(int(Role) < int(ROLE_Authority))
    {
        TgHUD(myHUD).DeviceChangeEvent(TgDevice(NewWeapon), 3);
    }
    //return;    
}

function NotifyTakeHit(Controller InstigatedBy, Vector HitLocation, int Damage, Class<DamageType> DamageType, Vector Momentum)
{
    super(PlayerController).NotifyTakeHit(InstigatedBy, HitLocation, Damage, DamageType, Momentum);
    //return;    
}

unreliable client simulated function ClientPlayTakeHit(Rotator HitDir, int Damage, Class<DamageType> DamageType)
{
    //return;    
}

function NotifyBodyUnderAttack(byte Damage)
{
    //return;    
}

reliable client simulated function ClientNotifyBodyUnderAttack(byte Damage)
{
    //return;    
}

simulated function NotifyInBombRange()
{
    //return;    
}

simulated function CancelInBombRange()
{
    //return;    
}

event RestartPlayerOnTransfer()
{
    // End:0x83
    if(CanRestartPlayer())
    {
        WorldInfo.Game.RestartPlayer(self);
        // End:0x83
        if(TgPawn(Pawn) != none)
        {
            TgPawn(Pawn).ReapplyLoadoutEffects();
        }
    }
    //return;    
}

reliable server function ServerLadderLetGo()
{
    LadderLetGo();
    //return;    
}

function LadderLetGo()
{
    local TgPawn TgPawn;

    TgPawn = TgPawn(Pawn);
    // End:0x98
    if(TgPawn != none)
    {
        // End:0x4B
        if(!IsInState('Dead'))
        {
            GotoState('PlayerWalking');
        }
        TgPawn.Velocity = Normal(Vector(Rotation)) * -100.0000000;
        TgPawn.SetPhysics(2);
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

    TgGame(WorldInfo.Game).GetReviveLocation(self, NewLocation, NewRotation);
    SetNoSmoothedMovementCorrection(true, false);
    Pawn.SetLocation(NewLocation);
    Pawn.SetRotation(NewRotation);
    SetRotation(NewRotation);
    Pawn.SetDesiredRotation(NewRotation);
    ClientSetRotationAndDesired(NewRotation);
    myPawn = TgPawn(Pawn);
    // End:0x148
    if(myPawn != none)
    {
        myPawn.LiveRespawn(bResetHealth, bResetDevices);
    }
    //return;    
}

function ReviveTimer()
{
    //return;    
}

function ViewPlayersTimer()
{
    //return;    
}

simulated function FadeForViewPlayersTimer()
{
    //return;    
}

event DisplayKillingBlowGameTip(CombatMessageInfo Info)
{
    local int GameTipId;
    local TgPawn KillerPawn;

    // End:0x79
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn', KillerPawn)
    {
        // End:0x78
        if(KillerPawn.r_nPawnId == Info.nSourceId)
        {
            // End:0x79
            break;
        }        
    }    
    // End:0x9C
    if(KillerPawn == TgPawn(Pawn))
    {
        return;
    }
    GameTipId = -1;
    // End:0x10C
    if(KillerPawn.r_EquipDeviceInfo[2].nDeviceId == Info.nSourceItemId)
    {
        GameTipId = 156;
    }
    // End:0x2C7
    if(GameTipId == -1)
    {
        switch(Info.nSourceItemId)
        {
            // End:0x15C
            case 13324:
                GameTipId = 142;
                // End:0x2C7
                break;
            // End:0x173
            case 13251:
                GameTipId = 143;
                // End:0x2C7
                break;
            // End:0x18A
            case 14308:
                GameTipId = 144;
                // End:0x2C7
                break;
            // End:0x1A1
            case 13412:
                GameTipId = 145;
                // End:0x2C7
                break;
            // End:0x1B8
            case 12981:
                GameTipId = 146;
                // End:0x2C7
                break;
            // End:0x1CF
            case 14140:
                GameTipId = 147;
                // End:0x2C7
                break;
            // End:0x1E6
            case 13327:
                GameTipId = 148;
                // End:0x2C7
                break;
            // End:0x1FD
            case 11510:
                GameTipId = 149;
                // End:0x2C7
                break;
            // End:0x214
            case 11490:
                GameTipId = 150;
                // End:0x2C7
                break;
            // End:0x22B
            case 14181:
                GameTipId = 187;
                // End:0x2C7
                break;
            // End:0x242
            case 11460:
                GameTipId = 151;
                // End:0x2C7
                break;
            // End:0x259
            case 11491:
                GameTipId = 152;
                // End:0x2C7
                break;
            // End:0x270
            case 13284:
                GameTipId = 153;
                // End:0x2C7
                break;
            // End:0x287
            case 13332:
                GameTipId = 154;
                // End:0x2C7
                break;
            // End:0x29E
            case 14149:
                GameTipId = 155;
                // End:0x2C7
                break;
            // End:0x2B5
            case 13033:
                GameTipId = 159;
                // End:0x2C7
                break;
            // End:0xFFFF
            default:
                GameTipId = -1;
                break;
        }
    }
    // End:0x4C5
    if(GameTipId == -1)
    {
        switch(KillerPawn.GetBotId())
        {
            // End:0x31A
            case 2151:
                GameTipId = 139;
                // End:0x4C5
                break;
            // End:0x331
            case 2273:
                GameTipId = 154;
                // End:0x4C5
                break;
            // End:0x348
            case 2092:
                GameTipId = 133;
                // End:0x4C5
                break;
            // End:0x35F
            case 2094:
                GameTipId = 134;
                // End:0x4C5
                break;
            // End:0x376
            case 2071:
                GameTipId = 135;
                // End:0x4C5
                break;
            // End:0x38D
            case 2254:
                GameTipId = 136;
                // End:0x4C5
                break;
            // End:0x3A4
            case 2249:
                GameTipId = 137;
                // End:0x4C5
                break;
            // End:0x3BB
            case 2288:
                GameTipId = 188;
                // End:0x4C5
                break;
            // End:0x3D2
            case 2303:
                GameTipId = 189;
                // End:0x4C5
                break;
            // End:0x3E9
            case 2056:
                GameTipId = 138;
                // End:0x4C5
                break;
            // End:0x400
            case 2149:
                GameTipId = 140;
                // End:0x4C5
                break;
            // End:0x417
            case 2057:
                GameTipId = 141;
                // End:0x4C5
                break;
            // End:0x431
            case 2073:
                GameTipId = -1;
                // End:0x4C5
                break;
            // End:0x44B
            case 2277:
                GameTipId = -1;
                // End:0x4C5
                break;
            // End:0x465
            case 2093:
                GameTipId = -1;
                // End:0x4C5
                break;
            // End:0x47F
            case 2147:
                GameTipId = -1;
                // End:0x4C5
                break;
            // End:0x499
            case 2205:
                GameTipId = -1;
                // End:0x4C5
                break;
            // End:0x4B3
            case 2267:
                GameTipId = -1;
                // End:0x4C5
                break;
            // End:0xFFFF
            default:
                GameTipId = -1;
                break;
        }
    }
    // End:0x4EB
    if(GameTipId != -1)
    {
        ClientRequestHelpText(GameTipId);
    }
    //return;    
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
    local Canvas Canvas;
    local Vector CamLoc;
    local Rotator CamRot;

    Canvas = HUD.Canvas;
    Canvas.SetDrawColor(255, 255, 255, 255);
    Canvas.DrawText((("CONTROLLER " $ (GetItemName(string(self)))) $ " Pawn ") $ (GetItemName(string(Pawn))));
    out_YPos += out_YL;
    Canvas.SetPos(4.0000000, out_YPos);
    // End:0x1F4
    if(Pawn == none)
    {
        // End:0x151
        if(PlayerReplicationInfo == none)
        {
            Canvas.DrawText("NO PLAYERREPLICATIONINFO", false);            
        }
        else
        {
            PlayerReplicationInfo.DisplayDebug(HUD, out_YL, out_YPos);
        }
        out_YPos += out_YL;
        Canvas.SetPos(4.0000000, out_YPos);
        super(PlayerController).DisplayDebug(HUD, out_YL, out_YPos);
        return;
    }
    // End:0x26A
    if((PlayerCamera != none) && HUD.ShouldDisplayDebug('Camera'))
    {
        PlayerCamera.DisplayDebug(HUD, out_YL, out_YPos);
    }
    // End:0x3FD
    if(HUD.ShouldDisplayDebug('HUD'))
    {
        myHUD.DisplayDebug(HUD, out_YL, out_YPos);
        CamLoc = ViewTarget.Location;
        CamRot = ViewTarget.Rotation;
        HUD.Canvas.DrawText((((("View Target Location: " $ string(CamLoc)) $ ", Rotation: ") $ string(CamRot)) $ " Controller Rot:") $ string(Rotation));
        out_YPos += out_YL;
        Canvas.SetPos(4.0000000, out_YPos);
    }
    // End:0x458
    if(TgPlayerInput(PlayerInput) != none)
    {
        TgPlayerInput(PlayerInput).DisplayDebug(HUD, out_YL, out_YPos);
    }
    //return;    
}

function OnToggleCinematicMode(SeqAct_ToggleCinematicMode Action)
{
    local bool bNewCinematicMode;

    // End:0x46
    if(Action.InputLinks[0].bHasImpulse)
    {
        bNewCinematicMode = true;        
    }
    else
    {
        // End:0x8C
        if(Action.InputLinks[1].bHasImpulse)
        {
            bNewCinematicMode = false;            
        }
        else
        {
            // End:0xDB
            if(Action.InputLinks[2].bHasImpulse)
            {
                bNewCinematicMode = !bCinematicMode;
            }
        }
    }
    SetCinematicMode(bNewCinematicMode, Action.bHidePlayer, Action.bHideHUD, Action.bDisableMovement, Action.bDisableTurning, Action.bDisableInput);
    //return;    
}

function SetCinematicMode(bool bInCinematicMode, bool bHidePlayer, bool bAffectsHUD, bool bAffectsMovement, bool bAffectsTurning, bool bAffectsButtons)
{
    local bool bAdjustMoveInput, bAdjustLookInput;

    bCinematicMode = bInCinematicMode;
    // End:0x63
    if(bCinematicMode)
    {
        // End:0x60
        if((Pawn != none) && bHidePlayer)
        {
            Pawn.SetHidden(true);
        }        
    }
    else
    {
        // End:0x92
        if(Pawn != none)
        {
            Pawn.SetHidden(false);
        }
    }
    bAdjustMoveInput = bAffectsMovement && bCinematicMode != bCinemaDisableInputMove;
    bAdjustLookInput = bAffectsTurning && bCinematicMode != bCinemaDisableInputLook;
    // End:0x128
    if(bAdjustMoveInput)
    {
        IgnoreMoveInput(bCinematicMode);
        bCinemaDisableInputMove = bCinematicMode;
    }
    // End:0x15E
    if(bAdjustLookInput)
    {
        IgnoreLookInput(bCinematicMode);
        bCinemaDisableInputLook = bCinematicMode;
    }
    ClientSetCinematicMode(bCinematicMode, bAdjustMoveInput, bAdjustLookInput, bAffectsHUD);
    //return;    
}

reliable client simulated function ClientSetCinematicMode(bool bInCinematicMode, bool bAffectsMovement, bool bAffectsTurning, bool bAffectsHUD)
{
    bCinematicMode = bInCinematicMode;
    // End:0xAD
    if((myHUD != none) && bAffectsHUD)
    {
        // End:0xAD
        if((bInCinematicMode && TgHUD(myHUD).bShowHUD) || !bInCinematicMode && !TgHUD(myHUD).bShowHUD)
        {
        }
    }
    // End:0xCE
    if(bAffectsMovement)
    {
        IgnoreMoveInput(bCinematicMode);
    }
    // End:0xEF
    if(bAffectsTurning)
    {
        IgnoreLookInput(bCinematicMode);
    }
    //return;    
}

function Reset()
{
    super(PlayerController).Reset();
    // End:0x19
    if(PlayerCamera != none)
    {
    }
    //return;    
}

reliable client simulated event ClientReset()
{
    super(PlayerController).ClientReset();
    // End:0x19
    if(PlayerCamera != none)
    {
    }
    //return;    
}

exec function SetRadius(float NewRadius)
{
    Pawn.SetCollisionSize(NewRadius, Pawn.GetCollisionHeight());
    //return;    
}

function bool UsingFirstPersonCamera()
{
    return false;
    //return ReturnValue;    
}

simulated event GetAimingViewPoint(out Vector POVLocation, out Rotator POVRotation)
{
    GetPlayerViewPoint(POVLocation, POVRotation);
    // End:0x5C
    if(ControlModule != none)
    {
        ControlModule.AdjustAimingView(POVLocation, POVRotation);
    }
    //return;    
}

simulated event GetPlayerViewPoint(out Vector POVLocation, out Rotator POVRotation)
{
    super(PlayerController).GetPlayerViewPoint(POVLocation, POVRotation);
    //return;    
}

reliable client simulated function ClientSetHUD(Class<HUD> newHUDType)
{
    local TgHUD TgHUD;

    newHUDType = GetHudClass(newHUDType);
    // End:0x3F
    if(myHUD == none)
    {
        super(PlayerController).ClientSetHUD(newHUDType);
    }
    TgHUD = TgHUD(myHUD);
    // End:0xF2
    if(TgHUD != none)
    {
        TgHUD.m_TgPlayerController = self;
        TgHUD.m_TgPlayerController.SendUICurrencyChange();
        TgHUD.m_TgPlayerController.SendUIXpChange();
    }
    AddPostRenderActors();
    //return;    
}

function AddPostRenderActors()
{
    local TgObjective TgO;

    // End:0x42
    foreach AllActors(Class'TgGame.TgObjective', TgO)
    {
        myHUD.AddPostRenderedActor(TgO);        
    }    
    //return;    
}

function bool AllowVoiceMessage(name MessageType)
{
    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_Standalone))
    {
        return true;
    }
    return true;
    //return ReturnValue;    
}

singular function EnterStartState()
{
    // End:0x64
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x61
        if(!WorldInfo.Game.bWaitingToStartMatch)
        {
            super(PlayerController).EnterStartState();
            ClientEnterStartState();
        }        
    }
    else
    {
        // End:0x80
        if(!IsInState('Dead'))
        {
            super(PlayerController).EnterStartState();
        }
    }
    //return;    
}

reliable client simulated function ClientEnterStartState()
{
    EnterStartState();
    //return;    
}

function int BlendRot(float DeltaTime, int BlendC, int NewC)
{
    // End:0x5E
    if(Abs(float(BlendC - NewC)) > float(32767))
    {
        // End:0x4E
        if(BlendC > NewC)
        {
            NewC += 65536;            
        }
        else
        {
            BlendC += 65536;
        }
    }
    // End:0x98
    if(Abs(float(BlendC - NewC)) > float(4096))
    {
        BlendC = NewC;        
    }
    else
    {
        BlendC = int(float(BlendC) + (float(NewC - BlendC) * FMin(1.0000000, 24.0000000 * DeltaTime)));
    }
    return BlendC & 65535;
    //return ReturnValue;    
}

event float GetFOVAngle()
{
    local CameraActor ca;
    local TPOV CamActorPOV;

    ca = CameraActor(ViewTarget);
    // End:0x78
    if(ca != none)
    {
        ca.GetCameraView(0.0000000, CamActorPOV);
        return CamActorPOV.FOV;        
    }
    else
    {
        // End:0xA7
        if(PlayerCamera != none)
        {
            return PlayerCamera.GetFOVAngle();
        }
    }
    return FOVAngle;
    //return ReturnValue;    
}

unreliable server function ServerViewNextPlayer(optional bool bFriendlyOnly)
{
    ServerViewAPlayer(1, bFriendlyOnly);
    //return;    
}

unreliable server function ServerViewPrevPlayer(optional bool bFriendlyOnly)
{
    ServerViewAPlayer(-1, bFriendlyOnly);
    //return;    
}

function HandleViewTargetOnAdjustPosition()
{
    // End:0x19
    if(int(r_WatchOtherPlayer) == int(1))
    {
        return;        
    }
    else
    {
        super(PlayerController).HandleViewTargetOnAdjustPosition();
    }
    //return;    
}

function ServerViewAPlayer(int Dir, optional bool bFriendlyOnly)
{
    local array<TgPawn> PawnList;
    local TgPawn P;
    local int Index;
    local TgRepInfo_Game GRI;

    // End:0x3A2
    if(int(r_WatchOtherPlayer) == int(1))
    {
        // End:0xE6
        foreach WorldInfo.AllPawns(Class'TgGame.TgPawn', P)
        {
            // End:0xE5
            if(P.IsA('TgPawn_Character') && WorldInfo.Game.CanSpectate(self, P.GetPRI()))
            {
                PawnList[PawnList.Length] = P;
            }            
        }        
        // End:0x2D5
        if(PawnList.Length == 0)
        {
            GRI = TgRepInfo_Game(WorldInfo.GRI);
            // End:0x2D5
            if(GRI != none)
            {
                // End:0x1C2
                if((GRI.r_LanePusher != none) && GRI.r_LanePusher.IsAliveAndWell())
                {
                    PawnList.AddItem(GRI.r_LanePusher);                    
                }
                else
                {
                    // End:0x24D
                    if((GRI.r_LanePusher1 != none) && GRI.r_LanePusher1.IsAliveAndWell())
                    {
                        PawnList.AddItem(GRI.r_LanePusher1);                        
                    }
                    else
                    {
                        // End:0x2D5
                        if((GRI.r_LanePusher2 != none) && GRI.r_LanePusher2.IsAliveAndWell())
                        {
                            PawnList.AddItem(GRI.r_LanePusher2);
                        }
                    }
                }
            }
        }
        // End:0x3A2
        if(PawnList.Length > 0)
        {
            Index = PawnList.Find(GetViewTarget());
            // End:0x324
            if(Index == -1)
            {
                Index = 0;
            }
            Index += Dir;
            // End:0x35E
            if(Index >= PawnList.Length)
            {
                Index = 0;                
            }
            else
            {
                // End:0x384
                if(Index < 0)
                {
                    Index = PawnList.Length - 1;
                }
            }
            SetViewTarget(PawnList[Index]);
        }
    }
    //return;    
}

exec function ViewPlayerByName(string PlayerName)
{
    ServerViewPlayerByName(PlayerName);
    //return;    
}

exec event DoSetViewTarget(Actor NewTarget)
{
    // End:0x22
    if(NewTarget != none)
    {
        ServerSetViewTarget(NewTarget);
    }
    //return;    
}

reliable server function ServerViewPlayerByName(string PlayerName)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x105 [Loop If]
    if(I < WorldInfo.GRI.PRIArray.Length)
    {
        // End:0xF7
        if(WorldInfo.GRI.PRIArray[I].PlayerName ~= PlayerName)
        {
            SetViewTarget(WorldInfo.GRI.PRIArray[I]);
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

function TgCameraModule GetCurrentCameraModule()
{
    local TgPlayerCamera Cam;

    Cam = TgPlayerCamera(PlayerCamera);
    // End:0x4A
    if(Cam != none)
    {
        return Cam.CurrentCameraMod;
    }
    return none;
    //return ReturnValue;    
}

exec function zoomIn()
{
    local TgPlayerCamera Cam;
    local TgCameraModule_ThirdPerson camModule;

    Cam = TgPlayerCamera(PlayerCamera);
    // End:0xB2
    if(Cam != none)
    {
        Cam.zoomIn();
        camModule = TgCameraModule_ThirdPerson(Cam.CurrentCameraMod);
        // End:0xB2
        if(camModule != none)
        {
            ServerSetZoomFactor(camModule.fZoomFactor);
        }
    }
    //return;    
}

exec function ZoomOut()
{
    local TgPlayerCamera Cam;
    local TgCameraModule_ThirdPerson camModule;

    Cam = TgPlayerCamera(PlayerCamera);
    // End:0xB2
    if(Cam != none)
    {
        Cam.ZoomOut();
        camModule = TgCameraModule_ThirdPerson(Cam.CurrentCameraMod);
        // End:0xB2
        if(camModule != none)
        {
            ServerSetZoomFactor(camModule.fZoomFactor);
        }
    }
    //return;    
}

unreliable server function ServerSetZoomFactor(float fZoom)
{
    local TgPlayerCamera Cam;
    local TgCameraModule_ThirdPerson camModule;

    Cam = TgPlayerCamera(PlayerCamera);
    // End:0x93
    if(Cam != none)
    {
        camModule = TgCameraModule_ThirdPerson(Cam.CurrentCameraMod);
        // End:0x93
        if(camModule != none)
        {
            camModule.fZoomFactor = fZoom;
        }
    }
    //return;    
}

exec function ShowPathToNearestPOI()
{
    local TgPointOfInterest POI, nearest;
    local float Dist, nearestDist;

    nearestDist = -1.0000000;
    nearest = none;
    // End:0xF6
    foreach WorldInfo.AllNavigationPoints(Class'TgGame.TgPointOfInterest', POI)
    {
        // End:0xF5
        if(POI != none)
        {
            Dist = VSize(POI.Location - Pawn.Location);
            // End:0xF5
            if((nearestDist > Dist) || nearest == none)
            {
                nearest = POI;
                nearestDist = Dist;
            }
        }        
    }    
    // End:0x11C
    if(nearest != none)
    {
        ShowPathTo(nearest);        
    }
    else
    {
        AddNavFailedAlert();
    }
    //return;    
}

simulated function OnNavIndicator(TgSeqAct_NavIndicator Action)
{
    // End:0x11
    if(Action == none)
    {
        return;
    }
    // End:0x5D
    if(Action.m_NavTarget != none)
    {
        ShowPathTo(Action.m_NavTarget);
    }
    //return;    
}

simulated function OnPingMinimap(TgSeqAct_PingMinimap Action)
{
    // End:0x4E
    if(Action != none)
    {
        ClientPingMap(Action.m_PingTarget.Location, 0);
    }
    //return;    
}

simulated event TutorialMessage(int msgId, bool bTip)
{
    local TgHUD TgH;

    // End:0x6C
    if(myHUD != none)
    {
        TgH = TgHUD(myHUD);
        // End:0x6C
        if(TgH != none)
        {
            TgH.TutorialMessage(msgId, bTip);
        }
    }
    //return;    
}

reliable client simulated function ClientShowPathTo(Actor destActor)
{
    ShowPathTo(destActor);
    //return;    
}

simulated event ShowPathTo(Actor destActor)
{
    local TgNavRouteIndicator navIndicator;
    local int setRouteResult;

    // End:0x11
    if(destActor == none)
    {
        return;
    }
    // End:0x4F
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        ClientShowPathTo(destActor);
        return;
    }
    navIndicator = Spawn(Class'TgGame.TgNavRouteIndicator', self,, Pawn.Location, Pawn.Rotation,, true);
    setRouteResult = int(navIndicator.SetRouteTo(destActor));
    // End:0x111
    if(setRouteResult == 1)
    {
        navIndicator.StartSeeking();        
    }
    else
    {
        AddNavFailedAlert(setRouteResult == 2);
    }
    //return;    
}

// Export UTgPlayerController::execAddNavFailedAlert(FFrame&, void* const)
native function AddNavFailedAlert(optional bool bAlreadyThere = false);

exec function GoSpectate()
{
    GotoState('Spectating');
    //return;    
}

function FindGoodView()
{
    //return;    
}

event SendClientSetGameWinState(TgObject.GAME_WIN_STATE gameWinState)
{
    ClientSetGameWinState(gameWinState);
    //return;    
}

reliable client simulated function ClientSetGameWinState(TgObject.GAME_WIN_STATE gameWinState)
{
    c_GameWinState = gameWinState;
    //return;    
}

simulated function PrepareIntro()
{
    local TgPawn P;

    P = TgPawn(Pawn);
    // End:0x4A
    if(P != none)
    {
        P.PrepareIntro();
    }
    //return;    
}

simulated function PlayIntro()
{
    local TgPawn P;

    P = TgPawn(Pawn);
    // End:0x4A
    if(P != none)
    {
        P.PlaySpawnFx();
    }
    //return;    
}

reliable client simulated function ClientPlayIntro()
{
    PrepareIntro();
    SetTimer(1.0000000, false, 'PlayIntro');
    UpdateTransitionUI();
    //return;    
}

reliable client simulated event ClientFinishIntro()
{
    SetTimer(1.0000000, true, 'FinishIntro');
    //return;    
}

function FinishIntro()
{
    local TgHUD HUD;

    HUD = TgHUD(myHUD);
    // End:0x63
    if((HUD != none) && HUD.FinishIntro())
    {
        ClearTimer('FinishIntro');
    }
    //return;    
}

event ResetPlayer()
{
    local Vector NewLocation;
    local Rotator NewRotation;

    // End:0x27
    if((int(Role) < int(ROLE_Authority)) || Pawn == none)
    {
        return;
    }
    TgGame(WorldInfo.Game).GetReviveLocation(self, NewLocation, NewRotation);
    Pawn.SetLocation(NewLocation);
    Pawn.SetRotation(NewRotation);
    SetRotation(NewRotation);
    Pawn.SetDesiredRotation(NewRotation);
    ClientSetRotationAndDesired(NewRotation);
    //return;    
}

function SetupIntro()
{
    ClientPlayIntro();
    //return;    
}

function EndIntro()
{
    //return;    
}

function GameHasEnded(optional Actor EndGameFocus, optional bool bIsWinner)
{
    m_EndGameFocus = EndGameFocus;
    GotoState('RoundEnded');
    ClientGameEnded(EndGameFocus, bIsWinner);
    //return;    
}

reliable client simulated function ClientGameEnded(Actor EndGameFocus, bool bIsWinner)
{
    // End:0x4A
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        m_EndGameFocus = EndGameFocus;
        GotoState('RoundEnded');
    }
    //return;    
}

function float GetOutroTime()
{
    return 7.0000000;
    //return ReturnValue;    
}

exec function Talk()
{
    //return;    
}

exec function TeamTalk()
{
    //return;    
}

function SetPlayerTeam(TeamInfo NewTeam)
{
    //return;    
}

// Export UTgPlayerController::execIsForceFeedbackEnabled(FFrame&, void* const)
native function bool IsForceFeedbackEnabled();

event InitInputSystem()
{
    PlayerInput = new (self) InputClass;
    TgPlayerInput(PlayerInput).c_TgPC = self;
    super(PlayerController).InitInputSystem();
    ReloadKeybindsForPawn();
    // End:0x8E
    if(ForceFeedbackManager != none)
    {
        ForceFeedbackManager.bAllowsForceFeedback = IsForceFeedbackEnabled();
    }
    //return;    
}

event PlayerTick(float DeltaTime)
{
    local TgPawn ActualPawn;
    local float NewTimeDilation, DesaturationT;

    super(PlayerController).PlayerTick(DeltaTime);
    ActualPawn = TgPawn(Pawn);
    // End:0xA5
    if((WorldInfo.TimeSeconds - LastActiveTime) >= 15.0000000)
    {
        // End:0xA2
        if((ActualPawn != none) && !ActualPawn.r_bIsAFK)
        {
            ServerToggleAFK(true);
        }        
    }
    else
    {
        // End:0xE3
        if((ActualPawn != none) && ActualPawn.r_bIsAFK)
        {
            ServerToggleAFK(false);
        }
    }
    // End:0x29B
    if(m_IsTimeDilationInterpolating)
    {
        m_TimeDilationUsedSeconds += (DeltaTime / WorldInfo.TimeDilation);
        // End:0x1D3
        if(!m_TimeDilationFromTo.Y ~= WorldInfo.TimeDilation && m_TimeDilationInterpolateSeconds > float(0))
        {
            NewTimeDilation = Lerp(m_TimeDilationFromTo.X, m_TimeDilationFromTo.Y, m_TimeDilationUsedSeconds / m_TimeDilationInterpolateSeconds);            
        }
        else
        {
            NewTimeDilation = m_TimeDilationFromTo.Y;
            m_IsTimeDilationInterpolating = false;
        }
        // End:0x269
        if(WorldInfo.Game != none)
        {
            WorldInfo.Game.SetGameSpeed(NewTimeDilation);            
        }
        else
        {
            WorldInfo.TimeDilation = NewTimeDilation;
        }
        SetAkWorldTimeDilation();
    }
    // End:0x433
    if(m_IsDesaturationInterpolating)
    {
        m_DesaturationUsedSeconds += (DeltaTime / WorldInfo.TimeDilation);
        // End:0x3D9
        if(!m_DesaturationFromTo.Y ~= WorldInfo.DefaultPostProcessSettings.Scene_Desaturation && m_DesaturationInterpolateSeconds > float(0))
        {
            DesaturationT = m_DesaturationUsedSeconds / m_DesaturationInterpolateSeconds;
            WorldInfo.DefaultPostProcessSettings.Scene_Desaturation = Lerp(m_DesaturationFromTo.X, m_DesaturationFromTo.Y, DesaturationT);            
        }
        else
        {
            WorldInfo.DefaultPostProcessSettings.Scene_Desaturation = m_DesaturationFromTo.Y;
            m_IsDesaturationInterpolating = false;
        }
    }
    // End:0x482
    if(m_bIsTrackingAimTowardTargetLocation && IsTargetInPawnAim(m_TrackingTargetLocation, m_fTrackingTargetMaxAimDistDiff))
    {
        m_bIsTrackingAimTowardTargetLocation = false;
        TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_LookAtReceived', self);
    }
    //return;    
}

function GoAFKTimer()
{
    // End:0x42
    if(WorldInfo != none)
    {
        LastActiveTime = WorldInfo.TimeSeconds - c_fTimeTillAFK;
    }
    //return;    
}

unreliable server function ServerToggleAFK(bool bEnabled)
{
    local TgPawn ThePawn;

    ThePawn = TgPawn(Pawn);
    // End:0x6D
    if((ThePawn != none) && CanAFK(ThePawn))
    {
        ThePawn.r_bIsAFK = bEnabled;
    }
    //return;    
}

function bool CanAFK(TgPawn ThePawn)
{
    return !IsSpectating();
    //return ReturnValue;    
}

exec function DisplayHiddenActors(optional float Time)
{
    // End:0x21
    if(Time == 0.0000000)
    {
        DisplayHiddenActorsTimer();        
    }
    else
    {
        SetTimer(Time, false, 'DisplayHiddenActorsTimer');
    }
    //return;    
}

function DisplayHiddenActorsTimer()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x31 [Loop If]
    if(I < HiddenActors.Length)
    {
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

reliable client simulated function ClientSetOnlineStatus()
{
    local LocalPlayer LP;
    local TgObject.TG_GAME_TYPE GameType;
    local string PresenceId;
    local int GameModeId;

    LP = LocalPlayer(Player);
    GameType = 22;
    GameModeId = 0;
    // End:0x76
    if(WorldInfo.bIsMenuLevel)
    {
        PresenceId = "in_lobby";
        SendSessionEnd();        
    }
    else
    {
        // End:0xB2
        if(WorldInfo.GRI == none)
        {
            SetTimer(2.0000000, false, 'ClientSetOnlineStatus');
            return;            
        }
        else
        {
            GameType = TgRepInfo_Game(WorldInfo.GRI).r_GameType;
            GameModeId = 0;
            switch(GameType)
            {
                // End:0x146
                case 29:
                    PresenceId = "in_siege_training";
                    GameModeId = 1;
                    // End:0x24A
                    break;
                // End:0x179
                case 27:
                    PresenceId = "in_payload_training";
                    GameModeId = 2;
                    // End:0x24A
                    break;
                // End:0x1A4
                case 35:
                    PresenceId = "in_training";
                    GameModeId = 3;
                    // End:0x24A
                    break;
                // End:0x1D4
                case 34:
                    PresenceId = "in_shootingrange";
                    GameModeId = 4;
                    // End:0x24A
                    break;
                // End:0x1FC
                case 28:
                    PresenceId = "in_siege";
                    GameModeId = 5;
                    // End:0x24A
                    break;
                // End:0x226
                case 26:
                    PresenceId = "in_payload";
                    GameModeId = 6;
                    // End:0x24A
                    break;
                // End:0xFFFF
                default:
                    PresenceId = "in_game";
                    GameModeId = 0;
                    // End:0x24A
                    break;
                    break;
            }
            SendSessionStart(GameModeId);
        }
    }
    // End:0x314
    if(((OnlineSub != none) && NotEqual_InterfaceInterface(OnlineSub.PlayerInterface, OnlinePlayerInterface(none))) && PresenceId != "")
    {
        OnlineSub.PlayerInterface.SetOnlineStatus(byte(LP.ControllerId), PresenceId, true);
    }
    //return;    
}

simulated event Rotator ApplyAimVectorModification(TgDevice Device, Rotator InRotation)
{
    local TgPlayerInput TgPlayerInput;

    TgPlayerInput = TgPlayerInput(PlayerInput);
    // End:0x60
    if(TgPlayerInput != none)
    {
        return TgPlayerInput.ApplyAimVectorModification(Device, InRotation);        
    }
    else
    {
        return InRotation;
    }
    //return ReturnValue;    
}

simulated function Rotator GetAdjustedAimFor(Weapon W, Vector StartFireLoc)
{
    local Rotator AdjustedAim;

    AdjustedAim = ((Pawn != none) ? Pawn.GetBaseAimRotation(W) : Rotation);
    return AdjustedAim;
    //return ReturnValue;    
}

function bool IsTargetInFrontOfPawn(Vector TargetLocation)
{
    local Vector FacingDir, LookingDir;
    local float Orientation;

    FacingDir = Normal(Vector(Pawn.Rotation));
    LookingDir = Normal(TargetLocation - Pawn.Location);
    Orientation = FacingDir Dot LookingDir;
    return Orientation >= float(0);
    //return ReturnValue;    
}

function bool IsTargetInPawnAim(Vector TargetLocation, float MaxAimFeetOffset)
{
    local Vector PawnAimLocation, PawnAim, TowardTarget;
    local float FacingOrientation, AimDistToPoint;

    PawnAimLocation = Pawn.GetPawnViewLocation();
    PawnAim = Vector(Pawn.GetViewRotation());
    TowardTarget = Normal(TargetLocation - PawnAimLocation);
    FacingOrientation = PawnAim Dot TowardTarget;
    // End:0xA7
    if(FacingOrientation <= 0.0000000)
    {
        return false;
    }
    AimDistToPoint = PointDistToLine(TargetLocation, PawnAim, PawnAimLocation) / float(16);
    return AimDistToPoint < MaxAimFeetOffset;
    //return ReturnValue;    
}

function bool IsTargetDied(Actor TargetActor)
{
    // End:0x38
    if((TargetActor == none) || !TargetActor.IsA('TgPawn'))
    {
        return true;
    }
    return TgPawn(TargetActor).Health < 2;
    //return ReturnValue;    
}

function bool IsValidTarget(Actor HoverActor)
{
    return ((HoverActor != none) && HoverActor.IsA('Pawn')) && HoverActor != Pawn;
    //return ReturnValue;    
}

function TgDeviceFire GetEqPointDevFire()
{
    local TgDevice Dev;

    // End:0x37
    if((Pawn == none) || Pawn.Weapon == none)
    {
        return none;
    }
    Dev = TgDevice(Pawn.Weapon);
    return Dev.m_FireMode[int(Dev.CurrentFireMode)];
    //return ReturnValue;    
}

function TgDevice GetEqPointDevice(TgObject.TG_EQUIP_POINT eEqPoint)
{
    // End:0x2B
    if((Pawn == none) || TgPawn(Pawn) == none)
    {
        return none;
    }
    // End:0x57
    if((int(eEqPoint) <= int(0)) || int(eEqPoint) >= int(33))
    {
        return none;
    }
    return TgPawn(Pawn).GetDeviceByEqPoint(int(eEqPoint));
    //return ReturnValue;    
}

simulated function TgObject.TG_EQUIP_POINT GetCurrentEqPoint()
{
    // End:0x72
    if((Pawn != none) && Pawn.Weapon != none)
    {
        return TgDevice(Pawn.Weapon).r_eEquippedAt;
    }
    return 0;
    //return ReturnValue;    
}

simulated function int GetCurrentDeviceType()
{
    // End:0x72
    if((Pawn != none) && Pawn.Weapon != none)
    {
        return TgDevice(Pawn.Weapon).m_nDeviceType;
    }
    return 0;
    //return ReturnValue;    
}

reliable server function ServerToggleSceneCaptureState()
{
    // End:0x23
    if(!IsInState('PlayerUpdateMiniMap'))
    {
        GotoState('PlayerUpdateMiniMap');        
    }
    else
    {
        GotoState('PlayerWalking');
    }
    //return;    
}

simulated function ShowChampionOverviewTip()
{
    // End:0x0F
    if(c_GameTipManager != none)
    {
    }
    //return;    
}

simulated event PostBeginPlay()
{
    local TgMapInfo TgMapInfo;
    local StaticMeshActor PathOverlayActor;
    local TgGame_Paladins ChaosGame;
    local float fNormalize;

    // End:0x71
    if((c_TgAkAudio == none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        c_TgAkAudio = new (self) Class'TgGame.TgAkAudioManagement';
        c_TgAkAudio.Initialize();
    }
    fNormalize = 0.0000000;
    fNormalize += m_fThreatCoefficientProximity;
    fNormalize += m_fThreatCoefficientOcclusion;
    fNormalize += m_fThreatCoefficientBinnedOcclusion;
    fNormalize += m_fThreatCoefficientUlt;
    fNormalize += m_fThreatCoefficientShotAt;
    fNormalize += m_fThreatCoefficientSeenBy;
    fNormalize += m_fThreatCoefficientDamaged;
    fNormalize += m_fThreatCoefficientFocused;
    fNormalize += m_fThreatCoefficientFocusTarget;
    fNormalize += m_fThreatCoefficientInEffectiveRange;
    fNormalize += m_fThreatCoefficientBehind;
    // End:0x189
    if(fNormalize != 0.0000000)
    {
        fNormalize = 1.0000000 / fNormalize;
    }
    m_fThreatCoefficientProximity *= fNormalize;
    m_fThreatCoefficientOcclusion *= fNormalize;
    m_fThreatCoefficientBinnedOcclusion *= fNormalize;
    m_fThreatCoefficientUlt *= fNormalize;
    m_fThreatCoefficientShotAt *= fNormalize;
    m_fThreatCoefficientSeenBy *= fNormalize;
    m_fThreatCoefficientDamaged *= fNormalize;
    m_fThreatCoefficientFocused *= fNormalize;
    m_fThreatCoefficientFocusTarget *= fNormalize;
    m_fThreatCoefficientBehind *= fNormalize;
    m_fThreatCoefficientInEffectiveRange *= fNormalize;
    SetAllInputAllowed(true);
    super(PlayerController).PostBeginPlay();
    m_TimeDilationFromTo = vect2d(1.0000000, 1.0000000);
    m_TimeDilationInterpolateSeconds = 0.0000000;
    m_TimeDilationUsedSeconds = 0.0000000;
    SwitchControl(DefaultControlModuleClass);
    // End:0x326
    if((c_GameTipManager == none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        c_GameTipManager = Spawn(Class'TgGame.TgGameTipManager', self);
    }
    // End:0x397
    if((c_SubtitledMessages == none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        c_SubtitledMessages = new (self) Class'TgGame.TgSubtitledMessages';
        c_SubtitledMessages.Init();
    }
    s_bAddDeadTimeStatsTracker = true;
    StartFX();
    AnnouncerReset();
    // End:0x50D
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        TgMapInfo = TgMapInfo(WorldInfo.GetMapInfo());
        // End:0x503
        if((TgMapInfo != none) && TgMapInfo.m_OverlayPathMesh != none)
        {
            PathOverlayActor = TgMapInfo.m_OverlayPathMesh;
            // End:0x503
            if((PathOverlayActor != none) && PathOverlayActor.StaticMeshComponent != none)
            {
                m_OverlayPathMaterial = PathOverlayActor.StaticMeshComponent.CreateAndSetMaterialInstanceConstant(0);
                PathOverlayActor.SetHidden(true);
            }
        }
        UpdateAssistModeSubLevel();
    }
    SetRTPCValue('IsPosition3D', 0.0000000);
    // End:0x5A2
    if(int(Role) == int(ROLE_Authority))
    {
        ChaosGame = TgGame_Paladins(WorldInfo.Game);
        // End:0x5A2
        if(ChaosGame != none)
        {
            ChaosGame.InitializeCreditsFor(TgPaladinsController(self));
        }
    }
    //return;    
}

simulated function SwitchControl(Class<TgControlModule> ControlModuleClass)
{
    local TgControlModule NewControlModule;

    // End:0x9D
    if(ControlModuleClass == none)
    {
        // End:0x8A
        if((TgPawn(Pawn) != none) && TgPawn(Pawn).DefaultControlModuleClass != none)
        {
            ControlModuleClass = TgPawn(Pawn).DefaultControlModuleClass;            
        }
        else
        {
            ControlModuleClass = DefaultControlModuleClass;
        }
    }
    NewControlModule = new (Outer) ControlModuleClass;
    NewControlModule.Controller = self;
    NewControlModule.Init();
    // End:0x15E
    if(ControlModule != none)
    {
        ControlModule.OnBecomeInActive(NewControlModule);
        NewControlModule.OnBecomeActive(ControlModule);        
    }
    else
    {
        NewControlModule.OnBecomeActive(none);
    }
    ControlModule = NewControlModule;
    //return;    
}

exec function SwitchCamera(string sCamera)
{
    local TgPlayerCamera TgCamera;
    local TgCameraModule newCameraMod;

    // End:0x19
    if(PlayerCamera == none)
    {
        SpawnPlayerCamera();
    }
    TgCamera = TgPlayerCamera(PlayerCamera);
    switch(sCamera)
    {
        // End:0xAA
        case "third":
            newCameraMod = TgCamera.SwitchCameras(Class'TgGame.TgCameraModule_ThirdPerson');
            // End:0xA7
            if(newCameraMod != none)
            {
                SwitchControl(Class'TgGame.TgControlModule_ThirdPerson');
            }
            // End:0x2F8
            break;
        // End:0x10B
        case "erez":
            newCameraMod = TgCamera.SwitchCameras(Class'TgGame.TgCameraModule_ThirdPersonVariableHeight');
            // End:0x108
            if(newCameraMod != none)
            {
                SwitchControl(Class'TgGame.TgControlModule_ThirdPerson');
            }
            // End:0x2F8
            break;
        // End:0x16C
        case "dead":
            newCameraMod = TgCamera.SwitchCameras(Class'TgGame.TgCameraModule_Dead');
            // End:0x169
            if(newCameraMod != none)
            {
                SwitchControl(Class'TgGame.TgControlModule_Dead');
            }
            // End:0x2F8
            break;
        // End:0x1D7
        case "falloutofworld":
            newCameraMod = TgCamera.SwitchCameras(Class'TgGame.TgCameraModule_FallOutOfWorld');
            // End:0x1D4
            if(newCameraMod != none)
            {
                SwitchControl(Class'TgGame.TgControlModule_Dead');
            }
            // End:0x2F8
            break;
        // End:0x232
        case "engine":
            newCameraMod = TgCamera.SwitchCameras(none);
            // End:0x22F
            if(newCameraMod != none)
            {
                SwitchControl(Class'TgGame.TgControlModule_BaseEngine');
            }
            // End:0x2F8
            break;
        // End:0x292
        case "iso":
            newCameraMod = TgCamera.SwitchCameras(Class'TgGame.TgCameraModule_SpectatorOverview');
            // End:0x28F
            if(newCameraMod != none)
            {
                SwitchControl(Class'TgGame.TgControlModule_SpectatorOverview');
            }
            // End:0x2F8
            break;
        // End:0x29E
        case "default":
        // End:0x2A8
        case "reset":
        // End:0x2F5
        case "":
            newCameraMod = TgCamera.SwitchCameras(none);
            // End:0x2F2
            if(newCameraMod != none)
            {
                SwitchControl(none);
            }
            // End:0x2F8
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

function int PushCameraPosture(TgPlayerController.TG_CAMERAPOSTURE eCamPosture)
{
    local int I, NewPostureGUID;
    local bool WasInserted;

    WasInserted = false;
    NewPostureGUID = c_nNextCameraStackId++;
    I = 0;
    J0x2C:

    // End:0x10E [Loop If]
    if(I < c_CameraStack.Length)
    {
        // End:0x100
        if(int(c_CameraStack[I].ePosture) > int(eCamPosture))
        {
            c_CameraStack.Insert(I, 1);
            c_CameraStack[I].ePosture = eCamPosture;
            c_CameraStack[I].nStackId = NewPostureGUID;
            WasInserted = true;
            // [Explicit Break]
            goto J0x10E;
        }
        ++I;
        // [Loop Continue]
        goto J0x2C;
    }
    J0x10E:

    // End:0x1AE
    if(!WasInserted)
    {
        c_CameraStack.Add(1);
        c_CameraStack[c_CameraStack.Length - 1].ePosture = eCamPosture;
        c_CameraStack[c_CameraStack.Length - 1].nStackId = NewPostureGUID;
        c_eCameraPosture = eCamPosture;
        OnCameraPostureChange();
    }
    return NewPostureGUID;
    //return ReturnValue;    
}

function bool PopCameraPosture(int nStackId)
{
    local int Index;

    Index = c_CameraStack.Find('nStackId', nStackId);
    // End:0x124
    if(Index != -1)
    {
        c_CameraStack.Remove(Index, 1);
        // End:0x122
        if(c_CameraStack.Length <= Index)
        {
            // End:0xF8
            if((c_CameraStack.Length > 0) && int(c_CameraStack[c_CameraStack.Length - 1].ePosture) != int(c_eCameraPosture))
            {
                c_eCameraPosture = c_CameraStack[c_CameraStack.Length - 1].ePosture;
                OnCameraPostureChange();                
            }
            else
            {
                // End:0x122
                if(int(c_eCameraPosture) != int(0))
                {
                    c_eCameraPosture = 0;
                    OnCameraPostureChange();
                }
            }
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

function OnCameraPostureChange()
{
    //return;    
}

simulated event ReceivedPlayer()
{
    local TgClientSettings Settings;
    local TgLocalPlayer LP;
    local bool bEnableColorBlindEffect;

    super(PlayerController).ReceivedPlayer();
    // End:0x154
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        LP = TgLocalPlayer(Player);
        // End:0x7D
        if(LP != none)
        {
            LP.InitPostProcessingChain();
        }
        Settings = GetClientSettings();
        // End:0x154
        if(Settings != none)
        {
            bEnableColorBlindEffect = ((int(Settings.SelectedColorBlindOption) != int(0)) ? true : false);
            EnableColorBlindEffect(bEnableColorBlindEffect, int(Settings.SelectedColorBlindOption), Settings.ColorBlindModeShaderSimulateMode);
            ServerSetAutoPurchase(Settings.AutoPurchase);
        }
    }
    //return;    
}

simulated event OnSettingsChanged(TgClientSettings Settings, optional int settingsType)
{
    local bool bEnableColorBlindEffect;

    // End:0xF8
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && Settings != none)
    {
        bEnableColorBlindEffect = ((int(Settings.SelectedColorBlindOption) != int(0)) ? true : false);
        EnableColorBlindEffect(bEnableColorBlindEffect, int(Settings.SelectedColorBlindOption), Settings.ColorBlindModeShaderSimulateMode);
        ControlModule.OnSettingsChanged(Settings);
        UpdateAssistModeSubLevel();
    }
    //return;    
}

exec function EnableColorBlindEffect(optional bool bEnable = true, optional int Type = 1, optional bool bSimulate = false)
{
    local TgLocalPlayer LP;

    LP = TgLocalPlayer(Player);
    // End:0x76
    if(LP != none)
    {
        LP.EnableColorBlindEffect(bEnable, Type, bSimulate);
    }
    //return;    
}

simulated function UpdateAssistModeSubLevel()
{
    local TgClientSettings Settings;

    Settings = GetClientSettings();
    // End:0x107
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && Settings != none)
    {
        // End:0x97
        if(!c_bAssistModeSublevelLoaded && Settings.LoadAssistModeSubLevel)
        {
            CauseClientEvent('AssistModeOn');            
        }
        else
        {
            // End:0xDD
            if(c_bAssistModeSublevelLoaded && !Settings.LoadAssistModeSubLevel)
            {
                CauseClientEvent('AssistModeOff');
            }
        }
        c_bAssistModeSublevelLoaded = Settings.LoadAssistModeSubLevel;
    }
    //return;    
}

event NotifyJumpApex()
{
    //return;    
}

function CheckJumpOrDuck()
{
    local TgPawn TgP;

    TgP = TgPawn(Pawn);
    // End:0x78
    if(bPressedJump && TgP != none)
    {
        TgP.DoJump(true, TgP.JumpZ);
    }
    //return;    
}

exec function SetReadyToPlay()
{
    ServerSetReadyToPlay();
    ClientSetReadyState(true);
    //return;    
}

reliable server function ServerSetReadyToPlay()
{
    PlayerReplicationInfo.bReadyToPlay = true;
    EnterStartState();
    //return;    
}

reliable client simulated function ClientSetReadyState(bool bReadyToPlay)
{
    GotoState('PlayerWaiting');
    //return;    
}

function PawnDied(Pawn P)
{
    // End:0x1F
    if(GetStateName() != 'RoundEnded')
    {
        GotoState('Dead');
    }
    //return;    
}

simulated function OnCanPurchaseItemChange()
{
    UpdatePlayerVitalsUI();
    //return;    
}

simulated event UpdateFirstValidProjIdx()
{
    c_nLastFlashSimProjIdx = r_nFirstValidProjIdx - 1;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x23
    if(VarName == 'r_nFirstValidProjIdx')
    {
        UpdateFirstValidProjIdx();
        return;
    }
    // End:0x46
    if(VarName == 'r_nFlashSimProjIdx')
    {
        HandleSimulatedProjectile();
        return;
    }
    // End:0x69
    if(VarName == 'r_nXp')
    {
        SendUIXpChange();
        return;
    }
    // End:0xA5
    if((VarName == 'r_bCanPurchaseItems') || VarName == 'r_nStatPoints')
    {
        OnCanPurchaseItemChange();
        return;
    }
    // End:0xC8
    if(VarName == 'r_nCurrency')
    {
        SendUICurrencyChange();
        return;
    }
    // End:0xF6
    if(VarName == 'r_bAutoPurchase')
    {
        SetAutoPurchaseFlag(r_bAutoPurchase);
        return;
    }
    // End:0x124
    if(VarName == 'r_bAutoSkillUp')
    {
        SetAutoSkillUpFlag(r_bAutoSkillUp);
        return;
    }
    // End:0x152
    if(VarName == 'r_bToggleZoom')
    {
        SetToggleZoomFlag(r_bToggleZoom);
        return;
    }
    // End:0x175
    if(VarName == 'r_TutorialBlockedClientActions')
    {
        ClientUpdateTutorialBlockingActions();
        return;
    }
    // End:0x1A8
    if(VarName == 'PlayerReplicationInfo')
    {
        CachedPRI = TgRepInfo_Player(PlayerReplicationInfo);
    }
    super(Controller).ReplicatedEvent(VarName);
    //return;    
}

event name GetStateNameEx()
{
    return GetStateName();
    //return ReturnValue;    
}

function ViewObjectiveCamerasTimer()
{
    //return;    
}

reliable client simulated event UpdateReviveTimeRemaining(float fTimeRemaining)
{
    c_fRespawnTime = fTimeRemaining;
    QueueReviveTimeChanged();
    //return;    
}

simulated function bool CanUseNow()
{
    local TgPawn P;

    P = TgPawn(Pawn);
    // End:0x2D
    if(P == none)
    {
        return false;
    }
    return !P.IsInFireLock();
    //return ReturnValue;    
}

reliable server function ServerUse()
{
    // End:0x11
    if(!CanUseNow())
    {
        return;
    }
    // End:0x2A
    if(!ServerPerformedUseAction())
    {
        ClientUse();
    }
    //return;    
}

reliable client simulated function ClientUse()
{
    // End:0x11
    if(!CanUseNow())
    {
        return;
    }
    ClientPerformedUseAction();
    //return;    
}

function bool ServerPerformedUseAction()
{
    local TgPawn P;

    P = TgPawn(Pawn);
    // End:0x2B
    if(PerformedUseAction())
    {
        return true;
    }
    // End:0x3C
    if(P == none)
    {
        return false;
    }
    // End:0x184
    if(P.m_CurrentUseActor != none)
    {
        // End:0x104
        if(P.m_CurrentUseActor.IsA('TgTrigger_Use'))
        {
            TgTrigger_Use(P.m_CurrentUseActor).UsedByPawn(P);
            P.m_bUseInterrupted = false;
            return true;            
        }
        else
        {
            // End:0x184
            if(P.m_CurrentUseActor.IsA('TgModifyPawnPropertiesVolume'))
            {
                TgModifyPawnPropertiesVolume(P.m_CurrentUseActor).Used(P);
                return true;
            }
        }
    }
    return false;
    //return ReturnValue;    
}

function bool ClientPerformedUseAction()
{
    local TgPawn P;

    P = TgPawn(Pawn);
    // End:0x2D
    if(P == none)
    {
        return false;
    }
    return false;
    //return ReturnValue;    
}

function OnRestartPlayers(TgSeqAct_RestartPlayers inAction)
{
    // End:0x6A
    if(TgGame(WorldInfo.Game) != none)
    {
        TgGame(WorldInfo.Game).Reset();
    }
    //return;    
}

function bool ShouldStunChangePhysics()
{
    local TgPawn TgP;

    TgP = TgPawn(Pawn);
    return (TgP != none) && int(TgP.Physics) == int(15);
    //return ReturnValue;    
}

reliable client simulated function ClientResetStunnedBehavior(bool bStunController, optional Controller.EStunType eType)
{
    Stun(bStunController, eType);
    //return;    
}

simulated function Stun(bool bStunController, optional Controller.EStunType eType = 0)
{
    local Controller.EStunType OldStunType;

    OldStunType = m_eCurrentStunType;
    m_eCurrentStunType = eType;
    // End:0x3F
    if(GetStateName() == 'Dead')
    {
        return;
    }
    // End:0x94
    if(bStunController)
    {
        // End:0x6C
        if(!IsInState('Unconscious'))
        {
            GotoState('Unconscious');
        }
        // End:0x91
        if(int(m_eCurrentStunType) != int(OldStunType))
        {
            StunTypeChanged();
        }        
    }
    else
    {
        // End:0xB3
        if(GetStateName() == 'Unconscious')
        {
            GotoState('PlayerWalking');
        }
    }
    //return;    
}

function StunTypeChanged()
{
    switch(m_eCurrentStunType)
    {
        // End:0x2E
        case 9:
            SwitchControl(Class'TgGame.TgControlModule_Feared');
            // End:0x81
            break;
        // End:0x49
        case 7:
            SwitchControl(Class'TgGame.TgControlModule_StunTaunted');
            // End:0x81
            break;
        // End:0x51
        case 5:
            // End:0x81
            break;
        // End:0x59
        case 0:
            // End:0x81
            break;
        // End:0x5E
        case 6:
        // End:0x63
        case 1:
        // End:0x68
        case 4:
        // End:0xFFFF
        default:
            SwitchControl(Class'TgGame.TgControlModule_Stunned');
            // End:0x81
            break;
            break;
    }
    //return;    
}

exec function GotoFly()
{
    ServerGotoFly();
    //return;    
}

reliable server function ServerGotoFly()
{
    GotoState('PlayerFlying');
    //return;    
}

exec function KillPets()
{
    ServerKillPets();
    //return;    
}

reliable server function ServerKillPets()
{
    TgPawn(Pawn).KillPets();
    //return;    
}

reliable client simulated function ClientSetValue(string strObject, string strVariable, string StrValue)
{
    SetValue(strObject, strVariable, StrValue);
    //return;    
}

reliable server function ServerSetValue(string strObject, string strVariable, string StrValue)
{
    SetValue(strObject, strVariable, StrValue);
    //return;    
}

reliable client simulated function ClientGetValue(string strObject, string strVariable)
{
    GetValue(strObject, strVariable);
    //return;    
}

reliable server function ServerGetValue(string strObject, string strVariable)
{
    GetValue(strObject, strVariable);
    //return;    
}

exec function SetClientValue(string strObject, string strVariable, string StrValue)
{
    ClientSetValue(strObject, strVariable, StrValue);
    //return;    
}

exec function SetServerValue(string strObject, string strVariable, string StrValue)
{
    ServerSetValue(strObject, strVariable, StrValue);
    //return;    
}

exec function GetClientValue(string strObject, string strVariable)
{
    ClientGetValue(strObject, strVariable);
    //return;    
}

exec function GetServerValue(string strObject, string strVariable)
{
    ServerGetValue(strObject, strVariable);
    //return;    
}

exec function StorePlayOfGame(optional float Begin = -5.0000000, optional float End = 2.0000000)
{
    ServerStorePlayOfGame(Begin, End);
    //return;    
}

reliable server function ServerStorePlayOfGame(float Begin, float End)
{
    SavePlayOfGame(Begin, End);
    //return;    
}

// Export UTgPlayerController::execSavePlayOfGame(FFrame&, void* const)
native function SavePlayOfGame(float Begin, float End);

exec function StartTimelapse(optional float Begin = -5.0000000, optional float End = 2.0000000, optional bool bPlayOfGame = false, optional bool bForced = true)
{
    ScriptTrace();
    // End:0x5F
    if(bForced)
    {
        bForcedTimelapseRequested = !bPlayOfGame;
        bForcedPlayOfGameRequested = bPlayOfGame;
    }
    ServerStartTimelapse(Begin, End, bPlayOfGame, bForced);
    //return;    
}

reliable server function ServerStartTimelapse(float Begin, float End, bool bPlayOfGame, optional bool bForced = false)
{
    // End:0x3E
    if(bForced)
    {
        bForcedTimelapseRequested = !bPlayOfGame;
        bForcedPlayOfGameRequested = bPlayOfGame;
    }
    StartTimelapsePlayback(Begin, End, bPlayOfGame);
    //return;    
}

// Export UTgPlayerController::execStartTimelapsePlayback(FFrame&, void* const)
native function StartTimelapsePlayback(float BeginTimeOffset, float EndTimeOffset, optional bool bPlayOfGame);

function StartPlayOfTheGamePlaybackDelayed()
{
    StartTimelapse(0.0000000, 0.0000000, true, true);
    //return;    
}

event StartPlayOfGamePlayback()
{
    SetTimer(2.0000000, false, 'StartPlayOfTheGamePlaybackDelayed');
    //return;    
}

// Export UTgPlayerController::execClientDebugPlayPotg(FFrame&, void* const)
reliable client native simulated function ClientDebugPlayPotg();

event ControllerPreTimeLapse()
{
    local Actor KillCamViewTarget;
    local array<SequenceObject> AllTimeLapseEvents;
    local TgSeqEvent_TimeLapse TimeLapseEvt;
    local Sequence GameSeq;
    local int Idx;
    local array<int> ActivateIndices;

    DestroySimulatedProjectiles();
    KillCamViewTarget = GetBestKillCamTarget();
    // End:0x41
    if(!CanPlayKillCam(bIsTimelapsePlayOfTheGame))
    {
        SkipKillCam();
    }
    // End:0x64
    if(KillCamViewTarget != none)
    {
        SetViewTarget(KillCamViewTarget);
    }
    TgPlayerCamera(PlayerCamera).SwitchCameras(Class'TgGame.TgCameraModule_SpectatorFirstPerson');
    UIFade(false, m_fWatchOthersFadeFromBlackCamTime);
    GameSeq = WorldInfo.GetGameSequence();
    // End:0x1B6
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_TimeLapse', true, AllTimeLapseEvents);
        ActivateIndices.AddItem(0);
        Idx = 0;
        J0x12F:

        // End:0x1B6 [Loop If]
        if(Idx < AllTimeLapseEvents.Length)
        {
            TimeLapseEvt = TgSeqEvent_TimeLapse(AllTimeLapseEvents[Idx]);
            // End:0x1A8
            if(TimeLapseEvt != none)
            {
                TimeLapseEvt.CheckActivate(self, self, false, ActivateIndices);
            }
            Idx++;
            // [Loop Continue]
            goto J0x12F;
        }
    }
    super(PlayerController).ControllerPreTimeLapse();
    OnPreTimeLapse();
    //return;    
}

event ControllerPostTimeLapse()
{
    local TgPlayerCamera Cam;
    local array<SequenceObject> AllTimeLapseEvents;
    local TgSeqEvent_TimeLapse TimeLapseEvt;
    local Sequence GameSeq;
    local int Idx;
    local array<int> ActivateIndices;

    DestroySimulatedProjectiles();
    SetViewTarget(Pawn);
    SetHUDOverlay(0);
    ClearKillCamTarget();
    Cam = TgPlayerCamera(PlayerCamera);
    // End:0xA7
    if(Cam != none)
    {
        Cam.SwitchCameras(Class'TgGame.TgCameraModule_ThirdPerson');
        Cam.ResetFOV();
    }
    GameSeq = WorldInfo.GetGameSequence();
    // End:0x1B1
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_TimeLapse', true, AllTimeLapseEvents);
        ActivateIndices.AddItem(1);
        Idx = 0;
        J0x12A:

        // End:0x1B1 [Loop If]
        if(Idx < AllTimeLapseEvents.Length)
        {
            TimeLapseEvt = TgSeqEvent_TimeLapse(AllTimeLapseEvents[Idx]);
            // End:0x1A3
            if(TimeLapseEvt != none)
            {
                TimeLapseEvt.CheckActivate(self, self, false, ActivateIndices);
            }
            Idx++;
            // [Loop Continue]
            goto J0x12A;
        }
    }
    super(PlayerController).ControllerPostTimeLapse();
    OnPostTimeLapse();
    //return;    
}

// Export UTgPlayerController::execOnPreTimeLapse(FFrame&, void* const)
native function OnPreTimeLapse();

// Export UTgPlayerController::execOnPostTimeLapse(FFrame&, void* const)
native function OnPostTimeLapse();

simulated function DestroySimulatedProjectiles()
{
    local TgRepInfo_Game GRI;
    local int I;

    // End:0x2B
    if(int(WorldInfo.NetMode) != int(NM_Client))
    {
        return;
    }
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x152
    if(GRI != none)
    {
        // End:0x152
        if(GRI.m_Projectiles.Length > 0)
        {
            I = GRI.m_Projectiles.Length - 1;
            J0xBC:

            // End:0x152 [Loop If]
            if(I >= 0)
            {
                // End:0x144
                if(GRI.m_Projectiles[I].IsA('TgProj_Simulated'))
                {
                    GRI.m_Projectiles[I].Destroy();
                }
                I--;
                // [Loop Continue]
                goto J0xBC;
            }
        }
    }
    //return;    
}

event NotifyDirectorControl(bool bNowControlling, SeqAct_Interp CurrentMatinee, float fFadeTime)
{
    // End:0x4A
    if(bNowControlling)
    {
        // End:0x34
        if(fFadeTime > 0.0000000)
        {
            DoFade(true, fFadeTime);
        }
        m_CurrentDirectorMatinee = CurrentMatinee;        
    }
    else
    {
        // End:0x71
        if(fFadeTime > 0.0000000)
        {
            DoFade(false, fFadeTime);
        }
        m_CurrentDirectorMatinee = none;
    }
    super(PlayerController).NotifyDirectorControl(bNowControlling, CurrentMatinee, fFadeTime);
    //return;    
}

simulated event ClientKillCurrentDirectorMatinee()
{
    KillCurrentDirectorMatinee();
    ServerKillCurrentDirectorMatinee();
    //return;    
}

reliable server function ServerKillCurrentDirectorMatinee()
{
    KillCurrentDirectorMatinee();
    //return;    
}

// Export UTgPlayerController::execKillCurrentDirectorMatinee(FFrame&, void* const)
native simulated function KillCurrentDirectorMatinee();

function SetKillCamTarget(TgPawn KillCamTarget)
{
    // End:0x16F
    if(int(Role) == int(ROLE_Authority))
    {
        m_nKillCamTargetId = ((KillCamTarget != none) ? KillCamTarget.r_nPawnId : default.m_nKillCamTargetId);
        // End:0x13F
        if((m_nKillCamTargetId != default.m_nKillCamTargetId) && KillCamTarget.IsPet())
        {
            J0x91:

            // End:0xE0 [Loop If]
            if(KillCamTarget.r_Owner != none)
            {
                KillCamTarget = KillCamTarget.r_Owner;
                // [Loop Continue]
                goto J0x91;
            }
            m_nKillCamTargetBackupId = ((KillCamTarget.r_nPawnId != m_nKillCamTargetId) ? KillCamTarget.r_nPawnId : default.m_nKillCamTargetBackupId);
        }
        // End:0x16F
        if(int(RemoteRole) == int(ROLE_AutonomousProxy))
        {
            ClientSetKillCamTarget(m_nKillCamTargetId, m_nKillCamTargetBackupId);
        }
    }
    //return;    
}

reliable client simulated function ClientSetKillCamTarget(int KillCamTargetId, int BackupKillCamTargetId)
{
    m_nKillCamTargetId = KillCamTargetId;
    m_nKillCamTargetBackupId = BackupKillCamTargetId;
    //return;    
}

function ClearKillCamTarget()
{
    m_nKillCamTargetId = default.m_nKillCamTargetId;
    m_nKillCamTargetBackupId = default.m_nKillCamTargetBackupId;
    //return;    
}

function ForceKillCamViewTargetChange(optional Actor ForceTarget)
{
    local Actor BestTarget;

    // End:0x26
    if(ForceTarget != none)
    {
        SetViewTarget(ForceTarget);
        return;
    }
    BestTarget = GetBestKillCamTarget();
    // End:0x69
    if(BestTarget != (GetViewTarget()))
    {
        SetViewTarget(BestTarget);        
    }
    else
    {
        SetViewTarget(Pawn);
    }
    //return;    
}

reliable server function ServerSkipKillCam()
{
    EndTimelapsePlayback();
    //return;    
}

// Export UTgPlayerController::execEndTimelapsePlayback(FFrame&, void* const)
native function EndTimelapsePlayback();

exec event SkipKillCam()
{
    // End:0x52
    if(WorldInfo.IsPlayingTimelapse() && !WorldInfo.IsTimelapsePlayOfTheGame())
    {
        ServerSkipKillCam();
    }
    //return;    
}

exec function ViewNextTeammate()
{
    ServerCycleTeammateView(true);
    //return;    
}

exec function ViewPreviousTeammate()
{
    ServerCycleTeammateView(false);
    //return;    
}

reliable server function ServerCycleTeammateView(bool bForward)
{
    local TgPawn OldViewTarget;
    local TgRepInfo_Player NewViewTargetPRI, PRI;
    local TgRepInfo_TaskForce TRI;
    local TgPlayerController NewViewTargetPC;
    local TgPawn NewViewTargetPawn;

    PRI = CachedPRI;
    // End:0x24
    if(PRI == none)
    {
        return;
    }
    TRI = PRI.r_TaskForce;
    // End:0x5D
    if(TRI == none)
    {
        return;
    }
    OldViewTarget = TgPawn(GetViewTarget());
    // End:0xA5
    if(OldViewTarget == none)
    {
        OldViewTarget = TgPawn(Pawn);
    }
    NewViewTargetPRI = TRI.CycleFrom(OldViewTarget.GetPRI(), bForward);
    // End:0x18A
    if(NewViewTargetPRI != none)
    {
        NewViewTargetPC = TgPlayerController(NewViewTargetPRI.Owner);
        // End:0x18A
        if(NewViewTargetPC != none)
        {
            NewViewTargetPawn = TgPawn(NewViewTargetPC.Pawn);
            ServerSetViewTarget(NewViewTargetPawn);
        }
    }
    //return;    
}

function TgRepInfo_TaskForce GetTFRI()
{
    local TgRepInfo_Player PRI;

    PRI = CachedPRI;
    // End:0x41
    if(CachedPRI != none)
    {
        return PRI.r_TaskForce;
    }
    return none;
    //return ReturnValue;    
}

simulated function bool CanPlayerMove(Pawn P)
{
    return ((P != none) && TgPawn(P) != none) && TgPawn(P).CanMove();
    //return ReturnValue;    
}

exec function TestCrash()
{
    TestCrashReport();
    //return;    
}

exec function DumpClassInfo(string sClassName)
{
    DumpClassInfoToFile(sClassName);
    //return;    
}

simulated function SpeakTTS(coerce string S, optional PlayerReplicationInfo PRI)
{
    //return;    
}

private final simulated function bool CanCommunicate()
{
    return true;
    //return ReturnValue;    
}

reliable server event ServerUpdateStats()
{
    local TgPawn myPawn;

    myPawn = TgPawn(Pawn);
    // End:0x4A
    if(myPawn != none)
    {
        myPawn.UpdateHUDScores();
    }
    //return;    
}

event CheatFly(bool bOn)
{
    // End:0x7D
    if(!bCheatFlying && bOn)
    {
        // End:0x6E
        if((Pawn != none) && Pawn.CheatGhost())
        {
            bCheatFlying = true;
            GotoState('PlayerFlying');            
        }
        else
        {
            bCollideWorld = false;
        }        
    }
    else
    {
        // End:0xE5
        if(bCheatFlying && !bOn)
        {
            bCheatFlying = false;
            // End:0xE5
            if((Pawn != none) && Pawn.CheatWalk())
            {
                Restart(false);
            }
        }
    }
    ClientCheatFly(bCheatFlying);
    //return;    
}

reliable client simulated function ClientCheatFly(bool bOn)
{
    // End:0x7D
    if(!bCheatFlying && bOn)
    {
        // End:0x6E
        if((Pawn != none) && Pawn.CheatGhost())
        {
            bCheatFlying = true;
            GotoState('PlayerFlying');            
        }
        else
        {
            bCollideWorld = false;
        }        
    }
    else
    {
        // End:0xE5
        if(bCheatFlying && !bOn)
        {
            bCheatFlying = false;
            // End:0xE5
            if((Pawn != none) && Pawn.CheatWalk())
            {
                Restart(false);
            }
        }
    }
    //return;    
}

exec function Camera(name NewMode)
{
    ServerCamera(NewMode);
    //return;    
}

reliable server function ServerCamera(name NewMode)
{
    SetCameraMode(NewMode);
    ClientSetCameraMode(NewMode);
    //return;    
}

reliable client simulated function ClientSetCameraMode(name NewCamMode)
{
    // End:0x37
    if(PlayerCamera != none)
    {
        PlayerCamera.CameraStyle = NewCamMode;
    }
    switch(NewCamMode)
    {
        // End:0xB6
        case 'Rove':
            // End:0xB3
            if((CheatManager != none) && CheatManager.IsA('GameCheatManager'))
            {
                GameCheatManager(CheatManager).EnableDebugCamera(false);
            }
            // End:0xC8
            break;
        // End:0xC5
        case 'Attach':
            // End:0xC8
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated function OnClientLoadDevices(TgSeqAct_ClientLoadDevices Action)
{
    // End:0x22
    if(Action != none)
    {
        ClientLoadDevices(Action);
    }
    //return;    
}

exec function DoFade(bool bInToGameplay, float Time)
{
    ClientSetCameraFade(true, MakeColor(0, 0, 0), ((bInToGameplay) ? vect2d(1.0000000, 0.0000000) : vect2d(0.0000000, 1.0000000)), Time);
    //return;    
}

exec function Cloth(bool bEnabled)
{
    local TgKAsset_ClientSideSim ClothActor;

    // End:0x5E
    foreach AllActors(Class'TgGame.TgKAsset_ClientSideSim', ClothActor)
    {
        // End:0x43
        if(bEnabled)
        {
            ClothActor.SetPhysics(10);
            // End:0x5D
            continue;
        }
        ClothActor.SetPhysics(0);        
    }    
    //return;    
}

function OnTgCameraShake(TgSeqAct_TgCameraShake inAction)
{
    // End:0x354
    if(inAction.InputLinks[0].bHasImpulse)
    {
        // End:0x229
        if(inAction.m_CameraShake.m_bRadialShake)
        {
            // End:0x224
            if(inAction.m_LocationActor != none)
            {
                Class'Engine.Camera'.static.PlayWorldCameraShake(inAction.m_CameraShake, inAction.m_LocationActor, inAction.m_LocationActor.Location, inAction.m_CameraShake.m_fRadialShake_InnerRadius, inAction.m_CameraShake.m_fRadialShake_OuterRadius, inAction.m_CameraShake.m_fRadialShake_Falloff, inAction.m_CameraShake.m_bDoControllerVibration, inAction.m_CameraShake.m_bOrientTowardRadialEpicenter);                
            }
            else
            {
                return;
            }            
        }
        else
        {
            ClientPlayCameraShake(inAction.m_CameraShake, inAction.m_CameraShake.m_fShakeScale, inAction.m_CameraShake.m_bDoControllerVibration, inAction.m_CameraShake.m_PlaySpace, ((inAction.m_LocationActor == none) ? rot(0, 0, 0) : inAction.m_LocationActor.Rotation));
        }        
    }
    else
    {
        ClientStopCameraShake(inAction.m_CameraShake);
    }
    //return;    
}

exec function TestTgCameraShake(TgCameraShake CameraShake)
{
    PlayTgCameraShake(CameraShake, vect(0.0000000, 0.0000000, 0.0000000), none);
    //return;    
}

event PlayTgCameraShake(TgCameraShake CameraShake, Vector Epicenter, Actor ShakeInstigator)
{
    // End:0xF7
    if(CameraShake.m_bRadialShake)
    {
        Class'Engine.Camera'.static.PlayWorldCameraShake(CameraShake, ShakeInstigator, Epicenter, CameraShake.m_fRadialShake_InnerRadius, CameraShake.m_fRadialShake_OuterRadius, CameraShake.m_fRadialShake_Falloff, CameraShake.m_bDoControllerVibration, CameraShake.m_bOrientTowardRadialEpicenter);        
    }
    else
    {
        ClientPlayCameraShake(CameraShake, CameraShake.m_fShakeScale, CameraShake.m_bDoControllerVibration, CameraShake.m_PlaySpace);
    }
    //return;    
}

event StopTgCameraShake(TgCameraShake CameraShake)
{
    ClientStopCameraShake(CameraShake);
    //return;    
}

exec function TestShake(int Index)
{
    // End:0x27
    if(m_PreviewCameraShake == none)
    {
        m_PreviewCameraShake = new Class'TgGame.TgCameraShake';
    }
    PlayTgCameraShake(m_PreviewCameraShake, Pawn.Location, Pawn);
    //return;    
}

function OnTutorialPlayerAction(TgSeqAct_LogTutorialAction inAction)
{
    LogTutorialAction(inAction.PlayerAction, inAction.EventData);
    //return;    
}

reliable server function ServerNotifyTutorialUIEvent(int Evt, int evtData)
{
    TriggerTutorialEvent(Evt, evtData);
    //return;    
}

exec event ClientNotifyTutorialUIEvent(int Evt, int evtData)
{
    ServerNotifyTutorialUIEvent(Evt, evtData);
    //return;    
}

function OnForceClientTutorialAction(TgSeqAct_ForceClientTutorialAction inAction)
{
    // End:0x62
    if(!HandleTutorialActionOnServer(inAction))
    {
        ClientForceTutorialAction(int(inAction.ForcedAction), int(inAction.GameUIElement));
    }
    //return;    
}

function OnTutorialHighlighter(TgSeqAct_TutorialHighlighter inAction)
{
    local bool bShow;

    // End:0x46
    if(inAction.InputLinks[0].bHasImpulse)
    {
        bShow = true;        
    }
    else
    {
        // End:0x89
        if(inAction.InputLinks[1].bHasImpulse)
        {
            bShow = false;
        }
    }
    ClientTutorialHighlighter(bShow, int(inAction.GameUIElement));
    //return;    
}

reliable client simulated function ClientForceTutorialAction(int Action, int ActionElement)
{
    HandleForcedClientTutorialAction(Action, ActionElement);
    //return;    
}

reliable client simulated function ClientTutorialHighlighter(bool bShow, int highlightedElement)
{
    HandleTutorialHighlighter(bShow, highlightedElement);
    //return;    
}

// Export UTgPlayerController::execGivePlayerFullVitals(FFrame&, void* const)
native function GivePlayerFullVitals();

function OnGiveFullVitals(TgSeqAct_GiveFullVitals inAction)
{
    GivePlayerFullVitals();
    //return;    
}

exec function AllocateAbilitySkillPoint(TgObject.TG_EQUIP_POINT eqp)
{
    local TgDevice aDev;
    local TgPawn aPawn;

    aPawn = TgPawn(Pawn);
    // End:0x96
    if(aPawn != none)
    {
        aDev = aPawn.GetDeviceByEqPoint(int(eqp));
        // End:0x96
        if(aDev != none)
        {
            AllocateDevicePoint(aDev.r_nDeviceId);
        }
    }
    return;
    //return;    
}

event DeviceOnStartBuildup(TgDevice Device)
{
    //return;    
}

event DeviceOnStopBuildup(TgDevice Device, bool WasInterrupted)
{
    local TgPawn TgPawn;
    local WeaponMeshSwapStrategy SwapStrategy;

    TgPawn = TgPawn(Pawn);
    // End:0x161
    if(((TgPawn != none) && WasInterrupted) && IsLocalPlayerController())
    {
        // End:0x161
        if(Device.ShouldSwitchBackToBasicAttackTargeting(GetClientSettings().GetCastMode(TgPawn.r_nProfileId, Device.r_eEquippedAt)))
        {
            // End:0x161
            if(!Device.m_bHandDevice && Device == TgPawn.c_CurrentTargetingDevice)
            {
                TgPawn.SetTargetingDevice(TgPawn.GetDeviceByEqPoint(1), SwapStrategy);
            }
        }
    }
    //return;    
}

event DeviceOnStartFire(TgDevice Device)
{
    //return;    
}

event DeviceOnStopFire(TgDevice Device, bool WasInterrupted)
{
    local TgPawn TgPawn;
    local WeaponMeshSwapStrategy SwapStrategy;

    TgPawn = TgPawn(Pawn);
    // End:0x171
    if((TgPawn != none) && IsLocalPlayerController())
    {
        // End:0x171
        if(Device.ShouldSwitchBackToBasicAttackTargeting(GetClientSettings().GetCastMode(TgPawn.r_nProfileId, Device.r_eEquippedAt)))
        {
            // End:0x171
            if(!Device.m_bHandDevice && Device == TgPawn.c_CurrentTargetingDevice)
            {
                SwapStrategy.RetrieveStrategy = 2;
                TgPawn.SetTargetingDevice(TgPawn.GetDeviceByEqPoint(1), SwapStrategy);
            }
        }
    }
    //return;    
}

exec function OnRespawnBeaconButtonPressed()
{
    //return;    
}

exec function OnRespawnBeaconButtonReleased()
{
    //return;    
}

exec function OnFlourish()
{
    local TgPawn TgP;

    TgP = TgPawn(Pawn);
    // End:0x4A
    if(TgP != none)
    {
        TgP.StartFlourish();
    }
    //return;    
}

exec function OnPerCharacterAltPressed()
{
    local TgPawn TgPawn;
    local TgObject.TG_EQUIP_POINT EquipPoint;

    TgPawn = TgPawn(Pawn);
    // End:0xC2
    if(TgPawn != none)
    {
        EquipPoint = TgPawn.GetPerCharacterAltEquipPoint();
        // End:0xC2
        if(int(EquipPoint) != int(0))
        {
            m_PerCharacterAlt = byte(int(1) - int(m_PerCharacterAlt));
            // End:0xAF
            if(int(m_PerCharacterAlt) == int(1))
            {
                OnOffhandSlotPressed(EquipPoint);                
            }
            else
            {
                OnOffhandSlotReleased(EquipPoint);
            }
        }
    }
    //return;    
}

// Export UTgPlayerController::execOnOffhandSlotPressed(FFrame&, void* const)
native exec function bool OnOffhandSlotPressed(TgObject.TG_EQUIP_POINT eqp);

// Export UTgPlayerController::execOnOffhandSlotReleased(FFrame&, void* const)
native exec function bool OnOffhandSlotReleased(TgObject.TG_EQUIP_POINT eqp);

exec event bool OnDefaultCastOffhandSlotPressed(TgObject.TG_EQUIP_POINT eqp)
{
    local TgDevice newDev;
    local bool Success;
    local byte bySuccess;
    local TgPawn TgPawn;
    local TgObject.EDeviceFailType failType;
    local WeaponMeshSwapStrategy SwapStrategy;

    TgPawn = TgPawn(Pawn);
    // End:0x76
    if((int(eqp) == int(23)) && !TgRepInfo_Game(WorldInfo.GRI).AllowPlayerMounting())
    {
        return false;
    }
    // End:0x87
    if(TgPawn == none)
    {
        return false;
    }
    Success = false;
    eqp = TgPawn.OverrideOffhandSlot(eqp);
    newDev = TgPawn.GetDeviceByEqPoint(int(eqp));
    // End:0x126
    if(TgPawn.OnMountCancelOffhandSlotPressed(newDev))
    {
        return false;
    }
    // End:0x137
    if(newDev == none)
    {
        return false;
    }
    // End:0x15B
    if(newDev.m_bHandDevice)
    {
        return false;
    }
    // End:0x19B
    if(newDev.CheckReactivationToggleLogic(bySuccess))
    {
        return int(bySuccess) != int(0);        
    }
    else
    {
        // End:0x372
        if(newDev.UsesTargetingMode())
        {
            // End:0x275
            if(TgPawn.c_CurrentTargetingDevice == newDev)
            {
                // End:0x272
                if(newDev.CanToggleTargetingOff())
                {
                    SwapStrategy.bPlayPutAway = true;
                    TgPawn.SetTargetingDevice(TgPawn.GetDeviceByEqPoint(1), SwapStrategy);
                }                
            }
            else
            {
                // End:0x31E
                if(newDev.IsTargetingModeReady(failType))
                {
                    failType = 0;
                    SwapStrategy.bPlayPutAway = true;
                    SwapStrategy.RetrieveStrategy = 1;
                    TgPawn.SetTargetingDevice(newDev, SwapStrategy);                    
                }
                else
                {
                    TgHUD(myHUD).PlayDeviceFailResponse(failType, newDev.IsAbility());
                }
            }            
        }
        else
        {
            // End:0x3B6
            if(TgPawn.StartAction(newDev, failType))
            {
                Success = true;                
            }
            else
            {
                TgHUD(myHUD).PlayDeviceFailResponse(failType, newDev.IsAbility());
                Success = false;
            }
        }
    }
    return Success;
    //return ReturnValue;    
}

exec event bool OnDefaultCastOffhandSlotReleased(TgObject.TG_EQUIP_POINT eqp)
{
    local TgDevice newDev;
    local TgPawn TgPawn;

    TgPawn = TgPawn(Pawn);
    // End:0x2D
    if(TgPawn == none)
    {
        return false;
    }
    eqp = TgPawn.OverrideOffhandSlot(eqp);
    newDev = TgPawn.GetDeviceByEqPoint(int(eqp));
    // End:0xA4
    if(newDev == none)
    {
        return false;
    }
    // End:0xEE
    if(newDev.ShouldStopActionOnOffhandSlotReleased())
    {
        TgPawn.StopAction(newDev);
    }
    return true;
    //return ReturnValue;    
}

exec event bool OnQuickCastOffhandSlotPressed(TgObject.TG_EQUIP_POINT eqp)
{
    local TgDevice newDev;
    local bool Success;
    local byte bySuccess;
    local TgPawn TgPawn;
    local TgObject.EDeviceFailType failType;
    local WeaponMeshSwapStrategy SwapStrategy;

    TgPawn = TgPawn(Pawn);
    // End:0x2D
    if(TgPawn == none)
    {
        return false;
    }
    Success = false;
    eqp = TgPawn.OverrideOffhandSlot(eqp);
    newDev = TgPawn.GetDeviceByEqPoint(int(eqp));
    // End:0xCC
    if(TgPawn.OnMountCancelOffhandSlotPressed(newDev))
    {
        return false;
    }
    // End:0xDD
    if(newDev == none)
    {
        return false;
    }
    // End:0x102
    if(newDev.InterceptSlotPressed(self))
    {
        return true;
    }
    // End:0x126
    if(newDev.m_bHandDevice)
    {
        return false;
    }
    // End:0x166
    if(newDev.CheckReactivationToggleLogic(bySuccess))
    {
        return int(bySuccess) != int(0);        
    }
    else
    {
        // End:0x253
        if(newDev.UsesTargetingMode())
        {
            // End:0x1F3
            if(newDev.IsTargetingModeReady(failType))
            {
                failType = 0;
                TgPawn.SetTargetingDevice(newDev, SwapStrategy);                
            }
            else
            {
                TgHUD(myHUD).PlayDeviceFailResponse(failType, newDev.IsAbility());
            }
            Success = true;            
        }
        else
        {
            // End:0x297
            if(TgPawn.StartAction(newDev, failType))
            {
                Success = true;                
            }
            else
            {
                TgHUD(myHUD).PlayDeviceFailResponse(failType, newDev.IsAbility());
                Success = false;
            }
        }
    }
    return Success;
    //return ReturnValue;    
}

exec event bool OnQuickCastOffhandSlotReleased(TgObject.TG_EQUIP_POINT eqp)
{
    local TgDevice newDev;
    local bool Success;
    local TgPawn TgPawn;
    local TgObject.EDeviceFailType failType;
    local WeaponMeshSwapStrategy SwapStrategy;

    TgPawn = TgPawn(Pawn);
    // End:0x2D
    if(TgPawn == none)
    {
        return false;
    }
    Success = false;
    eqp = TgPawn.OverrideOffhandSlot(eqp);
    newDev = TgPawn.GetDeviceByEqPoint(int(eqp));
    // End:0xB0
    if(newDev == none)
    {
        return false;
    }
    // End:0xD5
    if(newDev.InterceptSlotReleased(self))
    {
        return true;
    }
    // End:0x2EF
    if((TgPawn.c_CurrentTargetingDevice == newDev) && newDev.UsesTargetingMode())
    {
        // End:0x276
        if(!TgPawn.StartAction(newDev, failType))
        {
            // End:0x20D
            if(newDev.ShouldSwitchBackToBasicAttackTargeting(GetClientSettings().GetCastMode(TgPawn.r_nProfileId, eqp)))
            {
                TgPawn.SetTargetingDevice(TgPawn.GetDeviceByEqPoint(1), SwapStrategy);
            }
            TgHUD(myHUD).PlayDeviceFailResponse(failType, TgPawn.c_CurrentTargetingDevice.IsAbility());            
        }
        else
        {
            // End:0x2EC
            if(!TgPawn.c_CurrentTargetingDevice.IsFunctionallyToggleDevice())
            {
                TgPawn.StopAction(TgPawn.c_CurrentTargetingDevice);
            }
        }        
    }
    else
    {
        // End:0x339
        if(newDev.ShouldStopActionOnOffhandSlotReleased())
        {
            TgPawn.StopAction(newDev);
        }
    }
    return Success;
    //return ReturnValue;    
}

exec event bool OnInstantCastOffhandSlotPressed(TgObject.TG_EQUIP_POINT eqp)
{
    local TgDevice newDev;
    local bool Success;
    local byte bySuccess;
    local TgPawn TgPawn;
    local TgObject.EDeviceFailType failType;
    local WeaponMeshSwapStrategy SwapStrategy;

    TgPawn = TgPawn(Pawn);
    // End:0x2D
    if(TgPawn == none)
    {
        return false;
    }
    Success = false;
    eqp = TgPawn.OverrideOffhandSlot(eqp);
    newDev = TgPawn.GetDeviceByEqPoint(int(eqp));
    // End:0xCC
    if(TgPawn.OnMountCancelOffhandSlotPressed(newDev))
    {
        return false;
    }
    // End:0xDD
    if(newDev == none)
    {
        return false;
    }
    // End:0x101
    if(newDev.m_bHandDevice)
    {
        return false;
    }
    // End:0x141
    if(newDev.CheckReactivationToggleLogic(bySuccess))
    {
        return int(bySuccess) != int(0);        
    }
    else
    {
        // End:0x1D1
        if(TgPawn.StartAction(newDev, failType))
        {
            Success = true;
            // End:0x1CE
            if(!newDev.IsFunctionallyToggleDevice())
            {
                TgPawn.StopAction(newDev);
            }            
        }
        else
        {
            TgHUD(myHUD).PlayDeviceFailResponse(failType, newDev.IsAbility());
            // End:0x2D3
            if(newDev.ShouldSwitchBackToBasicAttackTargeting(GetClientSettings().GetCastMode(TgPawn.r_nProfileId, eqp)))
            {
                TgPawn.SetTargetingDevice(TgPawn.GetDeviceByEqPoint(1), SwapStrategy);
            }
            Success = false;
        }
    }
    return Success;
    //return ReturnValue;    
}

exec event ClientPlayVGS(int nId, optional int usedVPSetting = 0)
{
    // End:0x4D
    if((m_fLastVGS > float(0)) && (WorldInfo.TimeSeconds - m_fLastVGS) < 0.5000000)
    {
        return;
    }
    ServerPlayVGS(nId, usedVPSetting);
    m_fLastVGS = WorldInfo.TimeSeconds;
    return;
    //return;    
}

exec event ClientPlayPing(float X, float Y, float Z, TgObject.PING_TYPE pingType)
{
    ServerPlayPing(X, Y, Z, pingType);
    //return;    
}

exec event ClientSurrender(optional bool bSurrender = true)
{
    //return;    
}

reliable server function ServerSurrender(bool bSurrender)
{
    //return;    
}

simulated event UpdateLockedTarget(Actor LockedActor)
{
    local TgPawn P;

    P = TgPawn(Pawn);
    // End:0x81
    if((P != none) && P.r_LockedTarget != LockedActor)
    {
        P.ServerUpdateLockedTarget(LockedActor);
    }
    //return;    
}

exec function RequestScoreBoard()
{
    ServerRequestScoreBoard();
    TgHUD(myHUD).UpdateScoreboard();
    //return;    
}

exec function SuppressHelpText()
{
    local int nTipId;

    // End:0xFF
    if(((c_GameTipManager != none) && c_GameTipManager.m_GameTipQueue.Length > 0) && !c_GameTipManager.m_GameTipQueue[0].bDisplayAlways)
    {
        nTipId = c_GameTipManager.m_GameTipQueue[0].nTipId;
        c_GameTipManager.DismissHelpText(nTipId);
        c_GameTipManager.SuppressHelpText(nTipId);
    }
    //return;    
}

exec function ResetGameTips()
{
    // End:0x2E
    if(c_GameTipManager != none)
    {
        c_GameTipManager.UnsuppressAllGameTips();
    }
    //return;    
}

reliable server function ServerRequestScoreBoard()
{
    local TgRepInfo_Player PRI;

    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    PRI.UpdateScoreboard();
    //return;    
}

reliable server function ServerToggleAIDebug(Actor Target)
{
    local TgPawn P;
    local TgAIController_Behavior behavior_ai;

    P = TgPawn(Target);
    // End:0x10A
    if(P != none)
    {
        behavior_ai = TgAIController_Behavior(P.Controller);
        // End:0x10A
        if(behavior_ai != none)
        {
            P.r_bDebugShowAIDebug = !P.r_bDebugShowAIDebug;
            behavior_ai.bBtDebugClientOverlay = P.r_bDebugShowAIDebug;
            behavior_ai.UpdatePawnDebug();
        }
    }
    //return;    
}

// Export UTgPlayerController::execAllowRagdoll(FFrame&, void* const)
native function bool AllowRagdoll();

// Export UTgPlayerController::execAllowRagdollUpdated(FFrame&, void* const)
native function AllowRagdollUpdated();

// Export UTgPlayerController::execSetAllowParticleSystems(FFrame&, void* const)
native exec function SetAllowParticleSystems(bool Value);

// Export UTgPlayerController::execSetAllowAnimationFrameRateLOD(FFrame&, void* const)
native exec function SetAllowAnimationFrameRateLOD(bool Value, optional float lLODDistanceFactor, optional int lLODFrameRate);

reliable client simulated function PlayTutorialAnnouncement(int SoundIndex, SoundCue OptionalCue, optional bool bPlayImmediately = false, optional bool bFlushOthers = false)
{
    local Class<TgTutorialAnnouncer> AnnouncerClass;

    // End:0xDC
    if((c_TutorialAnnouncer == none) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        AnnouncerClass = Class<TgTutorialAnnouncer>(DynamicLoadObject("TgGameContent.TgTutorialAnnouncer_Content", Class'Core.Class'));
        // End:0xDC
        if(AnnouncerClass != none)
        {
            c_TutorialAnnouncer = new (self) AnnouncerClass;
            c_TutorialAnnouncer.Init();
        }
    }
    // End:0x130
    if(c_TutorialAnnouncer != none)
    {
        c_TutorialAnnouncer.PlayAnnouncement(SoundIndex, OptionalCue, bPlayImmediately, bFlushOthers);
    }
    //return;    
}

exec function DropFlag()
{
    ServerDropFlag();
    //return;    
}

reliable server function ServerDropFlag()
{
    local TgPawn_Character TgP;

    TgP = TgPawn_Character(Pawn);
    // End:0x4B
    if(TgP != none)
    {
        TgP.DropFlag();
    }
    //return;    
}

reliable client simulated event ArenaCrowdEvent(byte EventType)
{
    local Sequence GameSeq;
    local array<SequenceObject> AllCrowdEvents;
    local int I;
    local array<int> ActivateIndices;

    GameSeq = WorldInfo.GetGameSequence();
    // End:0x6A
    if(GameSeq != none)
    {
        GameSeq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_CrowdEvent', true, AllCrowdEvents);
    }
    switch(EventType)
    {
        // End:0x92
        case 0:
            ActivateIndices[0] = 0;
            // End:0x119
            break;
        // End:0xA8
        case 1:
            ActivateIndices[0] = 2;
            // End:0x119
            break;
        // End:0xBE
        case 2:
            ActivateIndices[0] = 3;
            // End:0x119
            break;
        // End:0xD4
        case 3:
            ActivateIndices[0] = 4;
            // End:0x119
            break;
        // End:0xEA
        case 4:
            ActivateIndices[0] = 5;
            // End:0x119
            break;
        // End:0x100
        case 5:
            ActivateIndices[0] = 6;
            // End:0x119
            break;
        // End:0x116
        case 6:
            ActivateIndices[0] = 7;
            // End:0x119
            break;
        // End:0xFFFF
        default:
            break;
    }
    I = 0;
    J0x124:

    // End:0x189 [Loop If]
    if(I < AllCrowdEvents.Length)
    {
        SequenceEvent(AllCrowdEvents[I]).CheckActivate(self, none,, ActivateIndices);
        I++;
        // [Loop Continue]
        goto J0x124;
    }
    //return;    
}

simulated function OnScoreChange(int nTeam)
{
    //return;    
}

exec function IgnoreOverlays(bool bIgnore)
{
    m_bIgnoreSilhouettes = bIgnore;
    //return;    
}

reliable client simulated function InsertAdditionalPostProcess(PostProcessChain PP, optional bool bAlterMeshDepth, optional TgPawn OtherDepthTarget)
{
    local LocalPlayer LP;
    local TgPawn TgP;

    LP = LocalPlayer(Player);
    // End:0x5B
    if(LP != none)
    {
        LP.InsertPostProcessingChain(PP, -1, false);
    }
    // End:0xEC
    if(bAlterMeshDepth)
    {
        TgP = TgPawn(Pawn);
        // End:0xBC
        if(TgP != OtherDepthTarget)
        {
            TgP.SetMeshDepthPriority(4);
        }
        // End:0xEC
        if(OtherDepthTarget != none)
        {
            OtherDepthTarget.SetMeshDepthPriority(4);
        }
    }
    //return;    
}

reliable client simulated function RemoveAdditionalPostProcess(PostProcessChain PP, optional TgPawn OtherDepthTarget)
{
    local LocalPlayer LP;
    local int chainIndex;
    local TgPawn TgP;

    LP = LocalPlayer(Player);
    // End:0x12C
    if(LP != none)
    {
        chainIndex = 0;
        J0x37:

        // End:0x12C [Loop If]
        if(chainIndex < LP.PlayerPostProcessChains.Length)
        {
            // End:0x11E
            if((LP.PlayerPostProcessChains[chainIndex] != none) && LP.PlayerPostProcessChains[chainIndex].Name == PP.Name)
            {
                LP.RemovePostProcessingChain(chainIndex);
                return;
            }
            chainIndex++;
            // [Loop Continue]
            goto J0x37;
        }
    }
    TgP = TgPawn(Pawn);
    // End:0x180
    if(TgP != OtherDepthTarget)
    {
        TgP.SetMeshDepthPriority(2);
    }
    // End:0x1B0
    if(OtherDepthTarget != none)
    {
        OtherDepthTarget.SetMeshDepthPriority(2);
    }
    //return;    
}

event TgPlayerInput GetPlayerInputClass()
{
    // End:0x38
    if(m_CachedPlayerInput == none)
    {
        m_CachedPlayerInput = TgPlayerInput(self.PlayerInput);
    }
    // End:0x89
    if(m_CachedPlayerInput == none)
    {
        m_CachedPlayerInput = new (self) Class'TgGame.TgPlayerInput';
        m_CachedPlayerInput.c_TgPC = self;
        ReloadKeybindsForPawn();
    }
    return m_CachedPlayerInput;
    //return ReturnValue;    
}

event TgSpectatorInput GetSpectatorInputClass()
{
    // End:0x38
    if(m_CachedPlayerInput == none)
    {
        m_CachedPlayerInput = TgSpectatorInput(self.PlayerInput);
    }
    // End:0x7F
    if(m_CachedSpectatorInput == none)
    {
        m_CachedSpectatorInput = new (self) Class'TgGame.TgSpectatorInput';
        m_CachedSpectatorInput.c_TgPC = self;
    }
    return m_CachedSpectatorInput;
    //return ReturnValue;    
}

exec function UnbindCommandPC(bool bSpectator, int nAlternate, string Command)
{
    // End:0x42
    if(bSpectator)
    {
        GetSpectatorInputClass().UnbindCommand(Command, nAlternate);        
    }
    else
    {
        GetPlayerInputClass().UnbindCommand(Command, nAlternate);
    }
    UpdateRuntimeInput(bSpectator);
    //return;    
}

exec function UnbindCommandAllPC(bool bSpectator, string Command)
{
    // End:0x39
    if(bSpectator)
    {
        GetSpectatorInputClass().UnbindCommandAll(Command);        
    }
    else
    {
        GetPlayerInputClass().UnbindCommandAll(Command);
    }
    UpdateRuntimeInput(bSpectator);
    //return;    
}

exec function SetBindPC(bool bSpectator, string ExtendedBinding, string Command)
{
    // End:0x42
    if(bSpectator)
    {
        GetSpectatorInputClass().SetBindExtended(ExtendedBinding, Command);        
    }
    else
    {
        GetPlayerInputClass().SetBindExtended(ExtendedBinding, Command);
    }
    UpdateRuntimeInput(bSpectator);
    //return;    
}

exec event SetCommandBindPC(bool bSpectator, int nAlternate, string ExtendedBinding, string Command)
{
    // End:0x4B
    if(bSpectator)
    {
        GetSpectatorInputClass().SetCommandBind(Command, nAlternate, ExtendedBinding);        
    }
    else
    {
        GetPlayerInputClass().SetCommandBind(Command, nAlternate, ExtendedBinding);
    }
    UpdateRuntimeInput(bSpectator);
    //return;    
}

event bool IsPawnWithin(Pawn aPawn, float Distance)
{
    local Vector ViewLoc;
    local Rotator ViewRot;

    // End:0x11
    if(aPawn == none)
    {
        return false;
    }
    GetPlayerViewPoint(ViewLoc, ViewRot);
    return VSizeSq(aPawn.Location - ViewLoc) < Distance;
    //return ReturnValue;    
}

exec function ToggleDetailedView()
{
    local TgMapInfo TgMapInfo;

    m_bDetailedViewEnabled = !m_bDetailedViewEnabled;
    // End:0x10D
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && !WorldInfo.IsPlayingDemo())
    {
        TgMapInfo = TgMapInfo(WorldInfo.GetMapInfo());
        // End:0x10D
        if((TgMapInfo != none) && TgMapInfo.m_OverlayPathMesh != none)
        {
            TgMapInfo.m_OverlayPathMesh.SetHidden(!m_bDetailedViewEnabled);
        }
    }
    //return;    
}

reliable client simulated event PlayEpicFatality(byte TaskForceNumber, int MeshAsmId)
{
    local TgMapInfo MapInfo;
    local TgFatalityFactory FatalityFactory;

    MapInfo = TgMapInfo(WorldInfo.GetMapInfo());
    // End:0xAA
    if(MapInfo != none)
    {
        FatalityFactory = MapInfo.GetEmptyFatalityFactory(TaskForceNumber);
        // End:0xAA
        if(FatalityFactory != none)
        {
            FatalityFactory.PlayEpicFatality(MeshAsmId);
        }
    }
    //return;    
}

event EnableContextNotify(int ContextId)
{
    local TgPawn TgP;

    // End:0x4B
    if(m_bContextNotifiesEnabled)
    {
        TgP = TgPawn(Pawn);
        // End:0x4B
        if(TgP != none)
        {
            m_nContextNotifyGroundTargeterId = ContextId;
        }
    }
    //return;    
}

event ReceivedContextNotify(int ContextId, Vector NotifyLocation, bool bEnemy)
{
    //return;    
}

reliable client simulated event ClientPlayRoadkillNotify()
{
    //return;    
}

exec function DoJump()
{
    // End:0x89
    if(IsInputAllowed(14))
    {
        bPressedJump = true;
        // End:0x61
        if((m_fLastJumpTapTime + m_fMaxJumpDoubleTapTime) >= WorldInfo.TimeSeconds)
        {
            m_bJustDidJumpDoubleTap = true;            
        }
        else
        {
            m_fLastJumpTapTime = WorldInfo.TimeSeconds;
        }
    }
    SkipKillCam();
    //return;    
}

exec function HoldJump()
{
    m_JumpHeld = byte(int(1) - int(m_JumpHeld));
    //return;    
}

exec function OnJumpRelease()
{
    m_bJustDidJumpDoubleTap = false;
    //return;    
}

exec function OnJumpHeldAltPressed()
{
    m_JumpHeldAlt = byte(int(1) - int(m_JumpHeldAlt));
    //return;    
}

exec function ToggleSprint()
{
    // End:0x44
    if(!TgRepInfo_Game(WorldInfo.GRI).AllowPlayerMounting())
    {
        return;
    }
    InputReceived(15);
    // End:0x6B
    if(IsInputAllowed(15))
    {
        OnDefaultCastOffhandSlotPressed(23);
    }
    //return;    
}

simulated event SetBehindView(bool bNewBehindView)
{
    local TgCameraModule_ThirdPerson CamMod;
    local TgPawn TgP;
    local TgDevice TgD;

    CamMod = TgCameraModule_ThirdPerson(GetCurrentCameraModule());
    // End:0xB4
    if((((CamMod != none) && bNewBehindView) && !m_bBehindView) && int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        CamMod.f3pViewPaddingRemainingTime = CamMod.f3pViewPaddingTime;
    }
    TgP = TgPawn(Pawn);
    // End:0x14C
    if(bNewBehindView)
    {
        // End:0x14C
        if(TgP != none)
        {
            TgD = TgDevice(TgP.Weapon);
            // End:0x14C
            if(TgD != none)
            {
                TgD.AltUse(false);
            }
        }
    }
    m_bBehindView = bNewBehindView;
    // End:0x1D4
    if((TgP != none) && TgP.m_WeaponMesh != none)
    {
        TgP.m_WeaponMesh.OnBehindViewUpdated(m_bBehindView);
    }
    //return;    
}

function HandleWalking()
{
    local TgPawn pPawn;
    local TgDevice_Mount MountDevice;

    pPawn = TgPawn(Pawn);
    // End:0x1D8
    if(pPawn != none)
    {
        // End:0x125
        if(!pPawn.IsAliveAndWell())
        {
            // End:0xE4
            if(int(bRun) == int(1))
            {
                MountDevice = TgDevice_Mount(pPawn.GetDeviceByEqPoint(23));
                // End:0xE4
                if(MountDevice != none)
                {
                    MountDevice.InterruptFiring();
                    MountDevice.ClientInterrupt();
                }
            }
            // End:0x125
            if(pPawn.m_bIsLanding)
            {
                pPawn.OnJumpPenaltyEnded();
            }
        }
        // End:0x1C5
        if(int(m_bOldbRun) != int(bRun))
        {
            ((int(bRun) == int(1)) ? pPawn.PawnOnStartSprint() : pPawn.PawnOnEndSprint());
            pPawn.r_bIsMounted = int(bRun) == int(1);
        }
        m_bOldbRun = bRun;
    }
    //return;    
}

simulated exec function ReloadWeapon()
{
    local TgPawn TgP;

    NextScoreboardDisplayType();
    InputReceived(13);
    // End:0x29
    if(!IsInputAllowed(13))
    {
        return;
    }
    TgP = TgPawn(Pawn);
    // End:0x165
    if(((TgP != none) && TgP.c_CurrentTargetingDevice != none) && !TgP.c_CurrentTargetingDevice.IsReloading())
    {
        // End:0x131
        if(TgP.c_CurrentTargetingDevice.CanReload())
        {
            TgP.c_CurrentTargetingDevice.StartReload();
            m_bPendingReload = false;            
        }
        else
        {
            m_bPendingReload = true;
            m_fPendingReloadTime = WorldInfo.TimeSeconds;
        }
    }
    //return;    
}

simulated exec function SSF(optional bool bSprint = true, optional bool bMinimapTeamVisibility = false, optional float DamageMultiplier = 1.0000000, optional bool bForce3P = false, optional bool bForce1P = false, optional bool bOutOfCombatSprint = false)
{
    SetServerFlags(bSprint, bMinimapTeamVisibility, DamageMultiplier, bForce3P, bForce1P, bOutOfCombatSprint);
    //return;    
}

simulated exec function SetServerFlags(optional bool bSprint = true, optional bool bMinimapTeamVisibility = false, optional float DamageMultiplier = 1.0000000, optional bool bForce3P = false, optional bool bForce1P = false, optional bool bOutOfCombatSprint = false)
{
    ServerSetServerFlags(bSprint, bMinimapTeamVisibility, DamageMultiplier, bForce3P, bForce1P, bOutOfCombatSprint);
    //return;    
}

reliable server function ServerSetServerFlags(bool bSprint, bool bMinimapTeamVisibility, float DamageMultiplier, bool bForce3P, bool bForce1P, bool bOutOfCombatSprint)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x13A
    if(GRI != none)
    {
        GRI.r_bServerFlagSprint = bSprint;
        GRI.r_bServerFlagMinimapTeamVisibility = bMinimapTeamVisibility;
        GRI.r_fServerFlagDamageMultiplier = DamageMultiplier;
        GRI.r_bForce3P = bForce3P;
        GRI.r_bForce1P = bForce1P;
        GRI.r_bForceOutOfCombatSprint = bOutOfCombatSprint;
    }
    //return;    
}

exec function AutoMelee(bool bEnabled)
{
    ServerAutoMelee(bEnabled);
    //return;    
}

reliable server function ServerAutoMelee(bool bEnabled)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x6A
    if(GRI != none)
    {
        GRI.r_bAutoMelee = bEnabled;
    }
    //return;    
}

reliable server event ServerRequestCard(int nDeviceId, int nRank)
{
    // End:0x30
    if(int(Role) == int(ROLE_Authority))
    {
        OnRequestCard(nDeviceId, nRank);
    }
    //return;    
}

reliable server event ServerRequestTalent(int nDeviceId)
{
    // End:0x27
    if(int(Role) == int(ROLE_Authority))
    {
        OnRequestTalent(nDeviceId);
    }
    //return;    
}

reliable client simulated event ClientChangedTalent(int nBotId, int nDeviceId)
{
    SetSelectedTalent(nBotId, nDeviceId);
    //return;    
}

reliable server event ServerRequestDeck(int nIndex)
{
    // End:0x27
    if(int(Role) == int(ROLE_Authority))
    {
        OnRequestDeck(nIndex);
    }
    //return;    
}

reliable client simulated event ClientChangedDeck(int nBotId, int nDeckIndex)
{
    SetSelectedDeck(nBotId, nDeckIndex);
    //return;    
}

event OnDeckUpdatedOnServer(int nBotId, int nDeckIndex)
{
    Class'TgGame.TgSeqEvent_LoadoutChanged'.static.TriggerGlobal(Pawn, nDeckIndex);
    //return;    
}

event OnCardSelection(TgDevice pDevice)
{
    local TgPawn TgP;

    TgP = TgPawn(Pawn);
    // End:0x174
    if((pDevice != none) && TgP != none)
    {
        // End:0x89
        if(pDevice.m_nDeviceType == 11049)
        {
            TgP.PlayEmoteSelfOnly(26);            
        }
        else
        {
            // End:0xD6
            if(pDevice.m_nDeviceType == 11051)
            {
                TgP.PlayEmoteSelfOnly(27);                
            }
            else
            {
                // End:0x174
                if(((pDevice.m_nDeviceType == 15000) || pDevice.m_nDeviceType == 15188) || pDevice.m_nDeviceType == 15189)
                {
                    TgP.PlayEmoteSelfOnly(28);
                }
            }
        }
    }
    //return;    
}

exec event FrontFacingCamera(bool bEnabled)
{
    TgPlayerCamera(PlayerCamera).SwitchCameras(((bEnabled) ? Class'TgGame.TgCameraModule_FrontFacingCamera' : Class'TgGame.TgCameraModule_ThirdPerson'), 0.0000000);
    //return;    
}

exec function SetOutlines(bool bFriendly, bool bEnemy)
{
    local TgPawn TgP;

    m_bOutlineEnemies = bEnemy;
    m_bOutlineFriendlies = bFriendly;
    // End:0x9F
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn', TgP)
    {
        TgP.InitializeOverlayMeshComponent(TgP.Mesh);        
    }    
    //return;    
}

exec function SetJumpZ(float NewJumpZ)
{
    local TgPawn TgP;

    // End:0x3C
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        ServerSetJumpZ(NewJumpZ);
    }
    // End:0x9B
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn', TgP)
    {
        TgP.JumpZ = NewJumpZ;        
    }    
    //return;    
}

reliable server function ServerSetJumpZ(float NewJumpZ)
{
    SetJumpZ(NewJumpZ);
    //return;    
}

reliable client simulated function ClientUpdateRoundEndedTimer(float RoundEndTimeRemaining, float RoundEndTotalTime)
{
    TgHUD(myHUD).UpdateRoundEndedTimer(RoundEndTimeRemaining, RoundEndTotalTime);
    //return;    
}

reliable client simulated function ClientUpdateRoundSetupTimer(float SetupTimeRemaining)
{
    TgHUD(myHUD).UpdateRoundSetupTimer(SetupTimeRemaining, WorldInfo.TimeSeconds);
    //return;    
}

reliable client simulated function ClientOnRoundEnded()
{
    SetTimeDilation(1.0000000, 0.0000000);
    SetDesaturation(0.0000000, 0.0000000);
    DoFade(true, 0.5000000);
    AnnouncerReset();
    //return;    
}

reliable client simulated function ClientOnRoundObjectivesCompleted()
{
    local TgRepInfo_Game GRI;
    local bool bRoundWon;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x1A8
    if(GRI != none)
    {
        ClientPlaySoundBase(m_RoundEndAlert);
        // End:0x90
        if(int(WorldInfo.NetMode) != int(NM_Standalone))
        {
            SetTimeDilation(0.2000000, 5.0000000);
        }
        SetDesaturation(1.0000000, 5.0000000);
        // End:0xD8
        if(GRI.r_bFadeOutAtRoundEnd)
        {
            UIFadeEndOfRound(true, 4.0000000);
        }
        ClientRequestHelpText(126);
        // End:0x1A8
        if((GRI.r_Winner != none) && GRI.r_Winner.r_nTeamId > 0)
        {
            bRoundWon = GRI.r_Winner.r_nTeamId == (GetTaskForceNumber());
            // End:0x1A8
            if(!bRoundWon)
            {
                ClientRequestHelpText(131);
            }
        }
    }
    //return;    
}

reliable client simulated function SetTimeDilation(float DesiredDilation, float SecondsToInterpolate)
{
    // End:0x78
    if(!bIsEditor())
    {
        m_IsTimeDilationInterpolating = true;
        m_TimeDilationUsedSeconds = 0.0000000;
        m_TimeDilationInterpolateSeconds = SecondsToInterpolate;
        m_TimeDilationFromTo = vect2d(WorldInfo.TimeDilation, DesiredDilation);
    }
    //return;    
}

reliable client simulated function SetDesaturation(float DesiredDesaturation, float SecondsToInterpolate)
{
    local TgRepInfo_Game GRI;

    m_IsDesaturationInterpolating = true;
    m_DesaturationUsedSeconds = 0.0000000;
    m_DesaturationInterpolateSeconds = SecondsToInterpolate;
    m_DesaturationFromTo = vect2d(WorldInfo.DefaultPostProcessSettings.Scene_Desaturation, DesiredDesaturation);
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x270
    if(GRI != none)
    {
        // End:0x15B
        if(int(GRI.r_GameEnvironmentRule) == int(1))
        {
            WorldInfo.DefaultPostProcessSettings.bOverride_Scene_Colorize = true;
            WorldInfo.DefaultPostProcessSettings.Scene_Colorize = vect(0.9000000, 0.9000000, 1.5000000);            
        }
        else
        {
            // End:0x1FA
            if(int(GRI.r_GameEnvironmentRule) == int(3))
            {
                WorldInfo.DefaultPostProcessSettings.bOverride_Scene_Colorize = true;
                WorldInfo.DefaultPostProcessSettings.Scene_Colorize = vect(1.3000000, 1.0000000, 1.0000000);                
            }
            else
            {
                WorldInfo.DefaultPostProcessSettings.bOverride_Scene_Colorize = true;
                WorldInfo.DefaultPostProcessSettings.Scene_Colorize = vect(1.0000000, 1.0000000, 1.0000000);
            }
        }        
    }
    else
    {
        WorldInfo.DefaultPostProcessSettings.bOverride_Scene_Colorize = true;
        WorldInfo.DefaultPostProcessSettings.Scene_Colorize = vect(1.0000000, 1.0000000, 1.0000000);
    }
    //return;    
}

reliable client simulated function ClientOnRoundSetupStarted(bool bForceOpenCardMenu)
{
    SetTimer(5.0000000, false, 'TorvaldCheck');
    TgHUD(myHUD).OnRoundSetupStarted();
    //return;    
}

simulated function TorvaldCheck()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce ERI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xC8
    if(GRI != none)
    {
        ERI = GRI.GetTaskForce((((GetTaskForceNumber()) == 2) ? 1 : 2));
        // End:0xC8
        if((ERI != none) && ERI.HasBot(Class'TgGame.TgPawn_Gauntlet'))
        {
            ClientRequestHelpText(198);
        }
    }
    //return;    
}

simulated function OpenUpgradeMenuTimer()
{
    ConsoleCommand("ShowUpgradeMenu");
    //return;    
}

reliable client simulated function ClientPlayPointCapturedEffects(TgChaosCapturePoint CapturedPoint, bool bFriendlyCapture)
{
    local TgSpecialFx Fx;
    local TgPawn myPawn;
    local int I;
    local Vector SpawnLocation;

    Fx = Class'TgGame.TgPawn'.static.GetSpecialFx(6148);
    // End:0x1B5
    if(Fx != none)
    {
        I = 0;
        J0x48:

        // End:0x133 [Loop If]
        if(I < Fx.c_PSCList.Length)
        {
            Fx.c_ParticleChannelOverride.bInitialized = true;
            Fx.c_ParticleChannelOverride.Friendly = bFriendlyCapture;
            Fx.c_ParticleChannelOverride.Enemy = !bFriendlyCapture;
            I++;
            // [Loop Continue]
            goto J0x48;
        }
        SpawnLocation = CapturedPoint.Location;
        SpawnLocation.Z -= 175.0000000;
        Fx.SpawnEmitter(SpawnLocation, vect(1.0000000, 0.0000000, 0.0000000));
    }
    // End:0x20F
    if(bFriendlyCapture)
    {
        myPawn = TgPawn(Pawn);
        // End:0x20F
        if(myPawn != none)
        {
            myPawn.PlayEmoteAtWorldLocation(33);
        }
    }
    PlayPointAlienFX(bFriendlyCapture);
    //return;    
}

unreliable client simulated function ClientPlayTakeoverSecondPhaseInstructions(bool bFriendlyCapture)
{
    //return;    
}

function OnControllerChanged(int ControllerId, bool bIsConnected, bool bPauseGame)
{
    local LocalPlayer LP;
    local string CurrentMovieName;

    LP = LocalPlayer(Player);
    // End:0x1C3
    if((((LP != none) && LP.ControllerId == ControllerId) && WorldInfo.IsConsoleBuild()) && (WorldInfo.Game == none) || !WorldInfo.Game.IsAutomatedPerfTesting())
    {
        bIsControllerConnected = bIsConnected;
        // End:0x1B9
        if(!bIsConnected)
        {
            GetCurrentMovie(CurrentMovieName);
            LP.ViewportClient.UIController.SceneClient.TgFlushPlayerInput();
            ShowControllerDisconnectedWarning();
            // End:0x1B6
            if((bPauseGame && IsInGame()) && CurrentMovieName == "")
            {
                ControllerChangedPause();
            }            
        }
        else
        {
            ControllerChangedUnpause();
        }
    }
    //return;    
}

// Export UTgPlayerController::execOnLoginStatusChange(FFrame&, void* const)
native function OnLoginStatusChange(OnlineSubsystem.ELoginStatus NewStatus, UniqueNetId NewId);

// Export UTgPlayerController::execOnConnectionStatusChange(FFrame&, void* const)
native function OnConnectionStatusChange(OnlineSubsystem.EOnlineServerConnectionStatus ConnectionStatus);

// Export UTgPlayerController::execOnCurrentUserChanged(FFrame&, void* const)
native function OnCurrentUserChanged(byte LocalUserNum, string CurrentUser, string LoggedInUser);

// Export UTgPlayerController::execOnRemoteTalkerStatusChange(FFrame&, void* const)
native function OnRemoteTalkerStatusChange(UniqueNetId RemoteNetId, bool bIsTalking);

// Export UTgPlayerController::execShowControllerDisconnectedWarning(FFrame&, void* const)
native function ShowControllerDisconnectedWarning();

// Export UTgPlayerController::execShowCurrentUserChangeWarning(FFrame&, void* const)
native function ShowCurrentUserChangeWarning(string CurrentUser, string LoggedInUser);

// Export UTgPlayerController::execShowNoFriendsForPartyInviteWarning(FFrame&, void* const)
native function ShowNoFriendsForPartyInviteWarning();

// Export UTgPlayerController::execShowUnableToReadFriendsListWarning(FFrame&, void* const)
native function ShowUnableToReadFriendsListWarning();

// Export UTgPlayerController::execShowPartyFullWarning(FFrame&, void* const)
native function ShowPartyFullWarning(bool bPartySession);

// Export UTgPlayerController::execShowPartyNoLongerAvailableWarning(FFrame&, void* const)
native function ShowPartyNoLongerAvailableWarning();

// Export UTgPlayerController::execShowPackageNotInstalledForPartyInviteWarning(FFrame&, void* const)
native function ShowPackageNotInstalledForPartyInviteWarning();

// Export UTgPlayerController::execShowCustomGameDisallowedPopup(FFrame&, void* const)
native function ShowCustomGameDisallowedPopup();

// Export UTgPlayerController::execIsInGame(FFrame&, void* const)
native function bool IsInGame();

// Export UTgPlayerController::execLogoutPlayer(FFrame&, void* const)
native function LogoutPlayer();

// Export UTgPlayerController::execTryAutoLogin(FFrame&, void* const)
native function bool TryAutoLogin();

// Export UTgPlayerController::execBlockPartySceneInput(FFrame&, void* const)
native function BlockPartySceneInput(bool bBlockInput);

// Export UTgPlayerController::execTryOpenPartyUI(FFrame&, void* const)
native function TryOpenPartyUI();

// Export UTgPlayerController::execUpdatePartyUI(FFrame&, void* const)
native function UpdatePartyUI();

// Export UTgPlayerController::execOnAllMarketplaceProductDetailsRead(FFrame&, void* const)
native function OnAllMarketplaceProductDetailsRead();

function ShowPathfinder(bool bEnabled, float interval)
{
    // End:0x31
    if(bEnabled)
    {
        SpawnPathfinder();
        SetTimer(interval, true, 'SpawnPathfinder');        
    }
    else
    {
        ClearTimer('SpawnPathfinder');
    }
    //return;    
}

function SpawnPathfinder()
{
    local TgPathfinder Pathfinder;
    local Actor TargetActor;

    TargetActor = GetPathfinderTarget();
    // End:0x17A
    if(TargetActor != none)
    {
        Pathfinder = Spawn(Class'TgGame.TgPathfinder', Pawn,, GetPathfinderStartLocation((((Pawn != none) && VSizeSq(Pawn.Velocity) > 0.0000000) ? m_fPathfinderStartDist : m_fPathfinderStartDist / 4.0000000)));
        Pathfinder.SetupPathProperties(Pawn.GetCollisionRadius(), m_fPathfinderSpeed);
        Pathfinder.SetPhysics(0);
        Pathfinder.SetRouteTo(TargetActor, true);
        Pathfinder.StartWalkerStream(m_fPathfinderStreamTime, m_fPathfinderPulseTime, m_fPathfinderLifetime, m_fPathfinderSpeed);
    }
    //return;    
}

function Vector GetPathfinderStartLocation(float StartDist)
{
    local Vector Start, End, HitLocation, HitNormal, Extent, Loc;

    local Rotator Rot;
    local float CollisionRadius, CollisionHeight;

    Rot = Pawn.Rotation;
    Rot.Pitch = 0;
    CollisionRadius = Pawn.GetCollisionRadius();
    CollisionHeight = Pawn.GetCollisionHeight();
    Start = Pawn.Location + (vect(0.0000000, 0.0000000, 1.0000000) * CollisionHeight);
    End = Start + (Vector(Rot) * StartDist);
    Loc = End;
    Extent.X = CollisionRadius;
    Extent.Y = CollisionRadius;
    Extent.Z = CollisionHeight;
    // End:0x1D6
    if(Trace(HitLocation, HitNormal, End, Start,, Extent) != none)
    {
        Loc = HitLocation;
    }
    Start = Loc;
    End = Loc + ((vect(0.0000000, 0.0000000, -1.0000000) * CollisionHeight) * 3.0000000);
    Loc = End;
    // End:0x27C
    if(Trace(HitLocation, HitNormal, End, Start,, Extent) != none)
    {
        Loc = HitLocation;
    }
    return Loc;
    //return ReturnValue;    
}

function Actor GetPathfinderTarget()
{
    local TgChaosCapturePoint capturePoint;
    local int I;
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x85
    if((GRI != none) && GRI.r_LanePusher != none)
    {
        return GRI.r_LanePusher;
    }
    // End:0xC6
    if(m_CapturePoints.Length == 0)
    {
        // End:0xC5
        foreach DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
        {
            m_CapturePoints.AddItem(capturePoint);            
        }        
    }
    I = 0;
    J0xD1:

    // End:0x173 [Loop If]
    if(I < m_CapturePoints.Length)
    {
        // End:0x165
        if((int(m_CapturePoints[I].r_eStatus) == int(1)) || int(m_CapturePoints[I].r_eStatus) == int(2))
        {
            return m_CapturePoints[I];
        }
        I++;
        // [Loop Continue]
        goto J0xD1;
    }
    return none;
    //return ReturnValue;    
}

unreliable client simulated event ClientRequestHelpText(int HelpTipId)
{
    // End:0x3B
    if(c_GameTipManager != none)
    {
        c_GameTipManager.RequestHelpText(HelpTipId);
    }
    //return;    
}

exec function TestHelpTip(int HelpTipId)
{
    local Vector SpawnLocation;

    SpawnLocation = Pawn.Location + (Vector(Pawn.Rotation) * 800.0000000);
    c_GameTipManager.RequestHelpText(HelpTipId,,, SpawnLocation);
    //return;    
}

exec function SetBlur(float TargetBlurAmount, float InterpSpeed, float BlurKernelSize)
{
    TgLocalPlayer(Player).SetBlurAmount(TargetBlurAmount, InterpSpeed, BlurKernelSize);
    //return;    
}

function DebugNextPlayerStart()
{
    local TgBattleCheatManager CM;

    CM = TgBattleCheatManager(CheatManager);
    // End:0x57
    if(CM.m_DebugPlayerStarts.Length == 0)
    {
        ClearTimer('DebugNextPlayerStart');
        return;
    }
    Pawn.SetLocation(CM.m_DebugPlayerStarts[0].Location);
    Pawn.SetRotation(CM.m_DebugPlayerStarts[0].Rotation);
    SetRotation(CM.m_DebugPlayerStarts[0].Rotation);
    Pawn.SetDesiredRotation(CM.m_DebugPlayerStarts[0].Rotation);
    ClientSetRotationAndDesired(CM.m_DebugPlayerStarts[0].Rotation);
    CM.m_DebugPlayerStarts.Remove(0, 1);
    //return;    
}

function DebugEnableAllAI()
{
    local TgAIController_BehaviorGod TgAI;
    local TgPawn TgP;

    // End:0xB9
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
    {
        TgP = TgPawn(TgAI.Pawn);
        // End:0xB8
        if((TgP != none) && TgP.IsGod())
        {
            TgAI.SetTickIsDisabled(false);
        }        
    }    
    //return;    
}

function DebugDisableAllAI()
{
    local TgAIController_BehaviorGod TgAI;
    local TgPawn TgP;

    // End:0xB9
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', TgAI)
    {
        TgP = TgPawn(TgAI.Pawn);
        // End:0xB8
        if((TgP != none) && TgP.IsGod())
        {
            TgAI.SetTickIsDisabled(true);
        }        
    }    
    //return;    
}

exec function FireDebugConsoleKismetTestNode()
{
    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_DebugConsoleKismetTest', self);
    //return;    
}

private unreliable client final simulated event ClientOnScoredPoints(int nValue, TgObject.ERewardValueType eType, int nPlayerId)
{
    local int GameTipId;

    OnScoredPoints(nValue, eType, nPlayerId);
    // End:0x13E
    if(((WorldInfo.GRI == none) || WorldInfo.GRI.GameClass == none) || !ClassIsChildOf(WorldInfo.GRI.GameClass, Class'TgGame.TgGame_Paladins_Onslaught'))
    {
        switch(eType)
        {
            // End:0xF1
            case 11:
                GameTipId = 160;
                // End:0x12B
                break;
            // End:0x105
            case 12:
                GameTipId = 161;
                // End:0x12B
                break;
            // End:0x119
            case 15:
                GameTipId = 162;
                // End:0x12B
                break;
            // End:0xFFFF
            default:
                GameTipId = -1;
                break;
        }
        ClientRequestHelpText(GameTipId);
    }
    //return;    
}

final function ShowHit(Actor Target, float DamageAmount, const out ExtraDamageInfo ExtraInfo)
{
    local TgPawn TgPawnTarget, ViewPawn;
    local TgDeployable TargetDeployable;

    TgPawnTarget = TgPawn(Target);
    ViewPawn = GetTgPawn();
    // End:0x9D
    if(((TgPawnTarget != none) && ViewPawn != none) && TgPawnTarget.IsStealthed(TgRepInfo_Player(ViewPawn.PlayerReplicationInfo)))
    {
        return;
    }
    // End:0x1C5
    if(((((IsLocalPlayerController()) && TgHUD(myHUD) != none) && Target != none) && Target != ViewPawn) && ViewPawn.IsEnemy(Target))
    {
        TargetDeployable = TgDeployable(Target);
        TgHUD(myHUD).ShowHit(Target, DamageAmount, ((TargetDeployable != none) ? int(TargetDeployable.m_CollisionSettings.mCollisionMode) == int(1) : false), ExtraInfo);
    }
    // End:0x232
    if(WorldInfo.IsPlayingTimelapse() || WorldInfo.IsPlayingDemo())
    {
        SendProxyDamageMessage(Target, int(DamageAmount), ExtraInfo);
    }
    //return;    
}

// Export UTgPlayerController::execSendProxyDamageMessage(FFrame&, void* const)
native function SendProxyDamageMessage(Actor TargetActor, int DamageAmount, const out ExtraDamageInfo ExtraInfo);

reliable client simulated function ClientSendPayloadMissionEvent(int nEventId, byte nAttackingTaskForce, byte nWinningTaskForce)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x7A
    if(GRI != none)
    {
        GRI.ProcessMissionTimerEvent(nEventId, nAttackingTaskForce, nWinningTaskForce);
    }
    //return;    
}

// Export UTgPlayerController::execGetTgPawn(FFrame&, void* const)
native function TgPawn GetTgPawn();

// Export UTgPlayerController::execGetCurrentPRI(FFrame&, void* const)
native function TgRepInfo_Player GetCurrentPRI();

event UpdateClientFOV()
{
    local TgPlayerCamera pCamera;
    local TgClientSettings pSettings;

    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return;
    }
    pCamera = TgPlayerCamera(PlayerCamera);
    pSettings = GetClientSettings();
    // End:0x7D
    if((pSettings == none) || pCamera == none)
    {
        return;
    }
    pCamera.DefaultFOV = FClamp(pSettings.DesiredFOV, 80.0000000, 120.0000000);
    pCamera.ResetFOV();
    //return;    
}

function ClientUpdatePosition()
{
    local SavedMove CurrentMove;
    local int realbRun, realbDuck, realJumpHeld, realUltHeld;
    local bool bRealJump, bRealPreciseDestination, bRealForceMaxAccel, bRealRootMotionFromInterpCurve;
    local SkeletalMeshComponent.ERootMotionMode RealRootMotionMode;

    bUpdatePosition = false;
    // End:0x48
    if((Pawn != none) && int(Pawn.Physics) == int(10))
    {
        return;
    }
    realbRun = int(bRun);
    realbDuck = int(bDuck);
    bRealJump = bPressedJump;
    realJumpHeld = int(m_JumpHeld);
    realUltHeld = int(m_UltHeld);
    bUpdating = true;
    bRealPreciseDestination = bPreciseDestination;
    // End:0x172
    if(Pawn != none)
    {
        bRealForceMaxAccel = Pawn.bForceMaxAccel;
        bRealRootMotionFromInterpCurve = Pawn.bRootMotionFromInterpCurve;
        RealRootMotionMode = Pawn.Mesh.RootMotionMode;
    }
    ClearAckedMoves();
    CurrentMove = SavedMoves;
    J0x18F:

    // End:0x2DB [Loop If]
    if(CurrentMove != none)
    {
        // End:0x1EE
        if((PendingMove == CurrentMove) && Pawn != none)
        {
            PendingMove.SetInitialPosition(Pawn);
        }
        CurrentMove.PrepMoveFor(Pawn);
        MoveAutonomous(CurrentMove.Delta, CurrentMove.CompressedFlags(), CurrentMove.Acceleration, rot(0, 0, 0));
        CurrentMove.ResetMoveFor(Pawn);
        CurrentMove = CurrentMove.NextMove;
        // [Loop Continue]
        goto J0x18F;
    }
    bUpdating = false;
    bDuck = byte(realbDuck);
    bRun = byte(realbRun);
    bPressedJump = bRealJump;
    m_JumpHeld = byte(realJumpHeld);
    m_UltHeld = byte(realUltHeld);
    bPreciseDestination = bRealPreciseDestination;
    // End:0x405
    if(Pawn != none)
    {
        Pawn.bForceMaxAccel = bRealForceMaxAccel;
        Pawn.bRootMotionFromInterpCurve = bRealRootMotionFromInterpCurve;
        Pawn.Mesh.RootMotionMode = RealRootMotionMode;
    }
    UpdateCameraForServerCorrectionSmoothing();
    //return;    
}

function SavePositionForSmoothServerCorrection()
{
    // End:0x37
    if(Pawn != none)
    {
        m_vLastServerCorrectOrigPos = Pawn.Location;
    }
    //return;    
}

function UpdateCameraForServerCorrectionSmoothing()
{
    local TgPlayerCamera Cam;
    local TgCameraModule_ThirdPerson camModule;

    Cam = TgPlayerCamera(PlayerCamera);
    // End:0x133
    if(Cam != none)
    {
        camModule = TgCameraModule_ThirdPerson(Cam.CurrentCameraMod);
        // End:0x133
        if(camModule != none)
        {
            // End:0xEA
            if(m_bNoSmoothedMovementCorrection)
            {
                camModule.vServerCorrectionDelta = vect(0.0000000, 0.0000000, 0.0000000);
                // End:0xE7
                if(!c_bProcessedNoSmoothNotification)
                {
                    c_bProcessedNoSmoothNotification = true;
                    ServerAckNoSmoothCorrection(WorldInfo.TimeSeconds);
                }                
            }
            else
            {
                camModule.vServerCorrectionDelta += (Pawn.Location - m_vLastServerCorrectOrigPos);
            }
        }
    }
    //return;    
}

function bool ShouldInterpolateMovementCorrections()
{
    return !m_bNoSmoothedMovementCorrection;
    //return ReturnValue;    
}

event SetNoSmoothedMovementCorrection(bool bNoSmoothedCorrections, optional bool bManaged = false)
{
    // End:0x3B
    if((int(Role) != int(ROLE_Authority)) || s_bIsNoSmoothMovementCorrectionManaged && !bManaged)
    {
        return;
    }
    s_bNoSmoothedMovementCorrectionRequested = bNoSmoothedCorrections;
    s_bIsNoSmoothMovementCorrectionManaged = bManaged && s_bNoSmoothedMovementCorrectionRequested;
    m_bNoSmoothedMovementCorrection = m_bNoSmoothedMovementCorrection || s_bNoSmoothedMovementCorrectionRequested;
    //return;    
}

event SendClientAdjustment()
{
    // End:0x8D
    if((s_bNoSmoothedMovementCorrectionRequested && AcknowledgedPawn == Pawn) && PendingAdjustment.TimeStamp != float(0))
    {
        s_fLastConfirmedSentSmoothedMovementTimestamp = PendingAdjustment.TimeStamp;
        // End:0x8D
        if(!s_bIsNoSmoothMovementCorrectionManaged)
        {
            s_bNoSmoothedMovementCorrectionRequested = false;
        }
    }
    super(PlayerController).SendClientAdjustment();
    //return;    
}

unreliable server function ServerAckNoSmoothCorrection(float TimeStamp)
{
    // End:0x2F
    if(s_bNoSmoothedMovementCorrectionRequested || TimeStamp <= (s_fLastConfirmedSentSmoothedMovementTimestamp + 0.3000000))
    {
        return;
    }
    m_bNoSmoothedMovementCorrection = false;
    //return;    
}

simulated function RecievedServerMovement(float TimeStamp, bool bNoInterp)
{
    // End:0x46
    if(bNoInterp)
    {
        c_fLastRecievedNoSmoothTimestamp = FMax(c_fLastRecievedNoSmoothTimestamp, TimeStamp);
        c_bProcessedNoSmoothNotification = false;
        m_bNoSmoothedMovementCorrection = true;        
    }
    else
    {
        // End:0x78
        if(c_bProcessedNoSmoothNotification && TimeStamp > c_fLastRecievedNoSmoothTimestamp)
        {
            m_bNoSmoothedMovementCorrection = false;
        }
    }
    //return;    
}

unreliable client simulated function LongClientAdjustPositionNoInterp(float TimeStamp, name NewState, Actor.EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, float NewVelX, float NewVelY, float NewVelZ, Actor NewBase, float NewFloorX, float NewFloorY, float NewFloorZ)
{
    RecievedServerMovement(TimeStamp, true);
    LongClientAdjustPosition(TimeStamp, NewState, newPhysics, NewLocX, NewLocY, NewLocZ, NewVelX, NewVelY, NewVelZ, NewBase, NewFloorX, NewFloorY, NewFloorZ);
    //return;    
}

unreliable client simulated function LongClientAdjustPosition(float TimeStamp, name NewState, Actor.EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, float NewVelX, float NewVelY, float NewVelZ, Actor NewBase, float NewFloorX, float NewFloorY, float NewFloorZ)
{
    RecievedServerMovement(TimeStamp, false);
    super(PlayerController).LongClientAdjustPosition(TimeStamp, NewState, newPhysics, NewLocX, NewLocY, NewLocZ, NewVelX, NewVelY, NewVelZ, NewBase, NewFloorX, NewFloorY, NewFloorZ);
    //return;    
}

unreliable client simulated function ClientAdjustPositionNoInterp(float TimeStamp, name NewState, Actor.EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, float NewVelX, float NewVelY, float NewVelZ, Actor NewBase)
{
    RecievedServerMovement(TimeStamp, true);
    ClientAdjustPosition(TimeStamp, NewState, newPhysics, NewLocX, NewLocY, NewLocZ, NewVelX, NewVelY, NewVelZ, NewBase);
    //return;    
}

unreliable client simulated function ClientAdjustPosition(float TimeStamp, name NewState, Actor.EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, float NewVelX, float NewVelY, float NewVelZ, Actor NewBase)
{
    RecievedServerMovement(TimeStamp, false);
    super(PlayerController).ClientAdjustPosition(TimeStamp, NewState, newPhysics, NewLocX, NewLocY, NewLocZ, NewVelX, NewVelY, NewVelZ, NewBase);
    //return;    
}

unreliable client simulated function ShortClientAdjustPositionNoInterp(float TimeStamp, name NewState, Actor.EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, Actor NewBase)
{
    RecievedServerMovement(TimeStamp, true);
    ShortClientAdjustPosition(TimeStamp, NewState, newPhysics, NewLocX, NewLocY, NewLocZ, NewBase);
    //return;    
}

unreliable client simulated function ShortClientAdjustPosition(float TimeStamp, name NewState, Actor.EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, Actor NewBase)
{
    RecievedServerMovement(TimeStamp, false);
    super(PlayerController).ShortClientAdjustPosition(TimeStamp, NewState, newPhysics, NewLocX, NewLocY, NewLocZ, NewBase);
    //return;    
}

unreliable client simulated function VeryShortClientAdjustPositionNoInterp(float TimeStamp, float NewLocX, float NewLocY, float NewLocZ, Actor NewBase)
{
    RecievedServerMovement(TimeStamp, true);
    VeryShortClientAdjustPosition(TimeStamp, NewLocX, NewLocY, NewLocZ, NewBase);
    //return;    
}

unreliable client simulated function VeryShortClientAdjustPosition(float TimeStamp, float NewLocX, float NewLocY, float NewLocZ, Actor NewBase)
{
    RecievedServerMovement(TimeStamp, false);
    super(PlayerController).VeryShortClientAdjustPosition(TimeStamp, NewLocX, NewLocY, NewLocZ, NewBase);
    //return;    
}

unreliable client simulated function ClientAckGoodMoveNoInterp(float TimeStamp)
{
    RecievedServerMovement(TimeStamp, true);
    ClientAckGoodMove(TimeStamp);
    //return;    
}

unreliable client simulated function ClientAckGoodMove(float TimeStamp)
{
    RecievedServerMovement(TimeStamp, false);
    super(PlayerController).ClientAckGoodMove(TimeStamp);
    //return;    
}

event MoveAutonomous(float DeltaTime, byte CompressedFlags, Vector newAccel, Rotator DeltaRot)
{
    super(PlayerController).MoveAutonomous(DeltaTime, CompressedFlags, newAccel, DeltaRot);
    // End:0x6E
    if(TgPawn(Pawn) != none)
    {
        TgPawn(Pawn).ForceUpdateUncompressedRemoteYaw();
    }
    //return;    
}

exec function PlayCameraAnim(CameraAnim CamAnim, optional float Rate = 1.0000000, optional float Scale = 1.0000000, optional float BlendInTime, optional float BlendOutTime, optional bool bLoop, optional bool bRandomStartTime, optional float Duration, optional bool bSingleInstance)
{
    PlayerCamera.PlayCameraAnim(CamAnim, Rate, Scale, BlendInTime, BlendOutTime, bLoop, bRandomStartTime, Duration, bSingleInstance);
    //return;    
}

simulated function SetViewportLocationAndScale(Vector2D InOrigin, Vector2D InSize)
{
    local LocalPlayer LocalPlayer;

    LocalPlayer = LocalPlayer(Player);
    // End:0x7B
    if(LocalPlayer != none)
    {
        LocalPlayer.Origin = InOrigin;
        LocalPlayer.Size = InSize;
    }
    //return;    
}

exec function ExecSetViewportLocationAndScale(optional float OriginX = 0.0000000, optional float OriginY = 0.0000000, optional float SizeX = 1.0000000, optional float SizeY = 1.0000000)
{
    SetViewportLocationAndScale(vect2d(OriginX, OriginY), vect2d(SizeX, SizeY));
    //return;    
}

simulated function StartBuyBurnCardsTimer()
{
    SetTimer(30.0000000, false, m_nameBuyBurnCardsTimer);
    // End:0x46
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        ClientStartBuyBurnCardsTimer();
    }
    //return;    
}

reliable client simulated function ClientStartBuyBurnCardsTimer()
{
    StartBuyBurnCardsTimer();
    //return;    
}

function BuyBurnCards()
{
    //return;    
}

event bool IsPlayerDead()
{
    return IsDead();
    //return ReturnValue;    
}

reliable client simulated exec function HideMeshes(bool bHide1PMesh, bool bHide3PMesh)
{
    local TgPawn_Character Character;

    Character = TgPawn_Character(Pawn);
    // End:0x93
    if(Character != none)
    {
        Character.c_bHideMeshFromKismet = bHide3PMesh;
        Character.m_WeaponMesh.SetHidden(bHide1PMesh);
    }
    //return;    
}

event SendEnergyUpdatedEvent()
{
    local TgPawn ActualPawn;
    local float CurrentEnergy;
    local int EnergyIndex;

    ActualPawn = TgPawn(Pawn);
    // End:0xC3
    if(ActualPawn != none)
    {
        CurrentEnergy = ActualPawn.GetPropCurrentValue(2);
        EnergyIndex = Class'TgGame.TgSeqEvent_EnergyUpdated'.static.GetIndex(CurrentEnergy, float(m_EnergyLastFrame));
        // End:0xC3
        if(EnergyIndex != -1)
        {
            TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_EnergyUpdated', self, EnergyIndex);
        }
    }
    //return;    
}

simulated function bool IsDeviceLockingInput()
{
    return m_nDevicesLockingInput > 0;
    //return ReturnValue;    
}

simulated function bool IsDeviceLockingCamera()
{
    return m_nDevicesLockingCamera > 0;
    //return ReturnValue;    
}

simulated function bool IsDeviceLockingRotation()
{
    return m_nDevicesLockingRotation > 0;
    //return ReturnValue;    
}

// Export UTgPlayerController::execGetInputType(FFrame&, void* const)
native static function TgPlayerController.EPlayerInputType GetInputType(TgObject.TG_EQUIP_POINT eqp);

// Export UTgPlayerController::execIsInputAllowed(FFrame&, void* const)
native function bool IsInputAllowed(TgPlayerController.EPlayerInputType InputType);

// Export UTgPlayerController::execSetInputAllowed(FFrame&, void* const)
native exec function SetInputAllowed(TgPlayerController.EPlayerInputType InputType, bool bEnabled);

simulated function SetAllInputAllowed(bool bEnabled)
{
    local int X;

    X = 0;
    J0x0B:

    // End:0x48 [Loop If]
    if(X < 20)
    {
        SetInputAllowed(byte(X), bEnabled);
        X++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

event InputReceived(TgPlayerController.EPlayerInputType InputType)
{
    local TgGame_Paladins_Tutorial Tutorial;

    Tutorial = TgGame_Paladins_Tutorial(WorldInfo.Game);
    // End:0x68
    if(Tutorial != none)
    {
        Tutorial.LocalPlayerInputReceived(InputType);
    }
    Class'TgGame.TgSeqEvent_InputReceived'.static.TriggerGlobal(self, InputType, IsInputAllowed(InputType));
    //return;    
}

event OnBurnCardPurchased(TgDevice BurnCard, int nEquipSlot, int nFilledCardSlots)
{
    local int BurnCardSlots;

    BurnCardSlots = 3;
    // End:0x60
    if(BurnCard != none)
    {
        Class'TgGame.TgSeqEvent_BurnCardPurchased'.static.TriggerGlobal(Pawn, nFilledCardSlots, nFilledCardSlots == BurnCardSlots);
    }
    //return;    
}

reliable client simulated function ClientUpdateTF1Score(int nScore)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce TF1;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xA2
    if(GRI != none)
    {
        TF1 = GRI.GetTaskForce(1);
        // End:0xA2
        if(TF1 != none)
        {
            TF1.c_nScoreOverride = nScore;
        }
    }
    //return;    
}

reliable client simulated function ClientUpdateTF2Score(int nScore)
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce TF2;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xA3
    if(GRI != none)
    {
        TF2 = GRI.GetTaskForce(2);
        // End:0xA3
        if(TF2 != none)
        {
            TF2.c_nScoreOverride = nScore;
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

reliable client simulated function ClientActivateSpawnGates()
{
    local TgSpawnGate SpawnGate;

    // End:0x4E
    foreach WorldInfo.DynamicActors(Class'TgGame.TgSpawnGate', SpawnGate)
    {
        SpawnGate.Activate();        
    }    
    //return;    
}

reliable client simulated function ClientDeactivateSpawnGates()
{
    local TgSpawnGate SpawnGate;

    // End:0x4E
    foreach WorldInfo.DynamicActors(Class'TgGame.TgSpawnGate', SpawnGate)
    {
        SpawnGate.Deactivate();        
    }    
    //return;    
}

reliable client simulated function ClientToggleSpawnGateTeamColors()
{
    local TgSpawnGate SpawnGate;

    // End:0x4E
    foreach WorldInfo.DynamicActors(Class'TgGame.TgSpawnGate', SpawnGate)
    {
        SpawnGate.ToggleTeamColors();        
    }    
    //return;    
}

reliable client simulated function ClientDeactivateAttackersSpawnGates()
{
    local TgSpawnGate SpawnGate;

    // End:0x77
    foreach WorldInfo.DynamicActors(Class'TgGame.TgSpawnGate', SpawnGate)
    {
        // End:0x76
        if(int(SpawnGate.m_eSpawnGateType) == int(1))
        {
            SpawnGate.Deactivate();
        }        
    }    
    //return;    
}

reliable client simulated function ClientDeactivateDefendersSpawnGates()
{
    local TgSpawnGate SpawnGate;

    // End:0x77
    foreach WorldInfo.DynamicActors(Class'TgGame.TgSpawnGate', SpawnGate)
    {
        // End:0x76
        if(int(SpawnGate.m_eSpawnGateType) == int(2))
        {
            SpawnGate.Deactivate();
        }        
    }    
    //return;    
}

event ToggleCaptureProgressAkEvent(bool bEnable)
{
    // End:0x64
    if(bEnable != c_bCaptureProgressAkEventPlaying)
    {
        // End:0x3C
        if(bEnable)
        {
            PostAkEvent(m_CaptureProgressPlayAkEvent);            
        }
        else
        {
            PostAkEvent(m_CaptureProgressStopAkEvent);
        }
        c_bCaptureProgressAkEventPlaying = bEnable;
    }
    //return;    
}

simulated exec function SetServerCorrectionCameraInterpVars(float SnapDist, float MinBaseSpeed, float MaxBaseSpeed, float BaseSpeedMult, float NewInfoWeight, float MinCorrectionMod, float MaxCorrectionMod, float CorrectionModMult)
{
    local TgCameraModule_ThirdPerson CamMod;

    CamMod = TgCameraModule_ThirdPerson(GetCurrentCameraModule());
    // End:0x204
    if(CamMod != none)
    {
        CamMod.CorrectionSmoothing.fServerCorrectSnapDist = SnapDist;
        CamMod.CorrectionSmoothing.fMinBaseSpeed = MinBaseSpeed;
        CamMod.CorrectionSmoothing.fMaxBaseSpeed = MaxBaseSpeed;
        CamMod.CorrectionSmoothing.fBaseSpeedMultiplier = BaseSpeedMult;
        CamMod.CorrectionSmoothing.fNewInfoWeight = NewInfoWeight;
        CamMod.CorrectionSmoothing.fMinCorrectionModifier = MinCorrectionMod;
        CamMod.CorrectionSmoothing.fMaxCorrectionModifier = MaxCorrectionMod;
        CamMod.CorrectionSmoothing.fCorrectionModifierMultiplier = CorrectionModMult;
    }
    //return;    
}

// Export UTgPlayerController::execSwitchChampion(FFrame&, void* const)
native function SwitchChampion(int BotId, int BodySkinId, int HeadSkinId, int WeaponSkinId, int VoicePackId);

simulated exec function LogLocalPropertyValue(int nPropId)
{
    local TgPawn TgP;

    TgP = GetTgPawn();
    // End:0x23
    if(TgP != none)
    {
    }
    //return;    
}

event ResetCaptureProgressRTPC()
{
    m_fCachedCaptureProgress = 0.0000000;
    //return;    
}

exec function FixAll()
{
    local editinline TgSkeletalMeshComponent MeshComp;

    MeshComp = TgPawn(Pawn).m_WeaponMesh.m_WeaponMesh1P;
    MeshComp.SetHasPhysicsAssetInstance(true);
    MeshComp.PhysicsWeight = 1.0000000;
    MeshComp.PhysicsAssetInstance.SetAllBodiesFixed(true);
    //return;    
}

exec function Unfix(name BoneName)
{
    local editinline TgSkeletalMeshComponent MeshComp;
    local RB_BodyInstance Body;

    MeshComp = TgPawn(Pawn).m_WeaponMesh.m_WeaponMesh1P;
    MeshComp.SetHasPhysicsAssetInstance(true);
    MeshComp.PhysicsWeight = 1.0000000;
    Body = MeshComp.FindBodyInstanceNamed(BoneName);
    // End:0xEC
    if(Body != none)
    {
        Body.SetFixed(false);
    }
    //return;    
}

reliable client simulated event ClientDrawDebugLine(float X, float Y, float Z, float X2, float Y2, float z2, byte R, byte G, byte B)
{
    local Vector P1, P2;

    P1.X = X;
    P1.Y = Y;
    P1.Z = Z;
    P2.X = X2;
    P2.Y = Y2;
    P2.Z = z2;
    DrawDebugLine(P1, P2, R, G, B, true);
    //return;    
}

reliable client simulated event ClientDrawDebugBox(float X, float Y, float Z, float extX, float extY, float extZ, byte R, byte G, byte B)
{
    local Vector Center, extents;

    Center.X = X;
    Center.Y = Y;
    Center.Z = Z;
    extents.X = extX;
    extents.Y = extY;
    extents.Z = extZ;
    DrawDebugBox(Center, extents, R, G, B, true);
    //return;    
}

reliable client simulated event ClientDrawDebugSphere(float X, float Y, float Z, float Radius, int Segments, byte R, byte G, byte B)
{
    local Vector Center;

    Center.X = X;
    Center.Y = Y;
    Center.Z = Z;
    DrawDebugSphere(Center, Radius, Segments, R, G, B, true);
    //return;    
}

exec function EnablePhysics(bool bEnabled)
{
    TgPawn(Pawn).m_WeaponMesh.m_WeaponMesh1P.SetHasPhysicsAssetInstance(true);
    TgPawn(Pawn).m_WeaponMesh.m_WeaponMesh1P.PhysicsWeight = ((bEnabled) ? 1.0000000 : 0.0000000);
    //return;    
}

exec function SetPhysicsWeight(float Amount)
{
    TgPawn(Pawn).m_WeaponMesh.m_WeaponMesh1P.PhysicsWeight = Amount;
    //return;    
}

simulated function bool IsForceFeedbackAllowed()
{
    return (ForceFeedbackManager != none) && ForceFeedbackManager.bAllowsForceFeedback || myHUD.IsA('TgLobbyHUD');
    //return ReturnValue;    
}

state PlayerWalking
{
    ignores Bump, HearNoise, SeePlayer;

    event BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        //return;        
    }

    function bool NotifyLanded(Vector HitNormal, Actor FloorActor)
    {
        // End:0x23
        if(int(DoubleClickDir) == int(5))
        {
            DoubleClickDir = 6;            
        }
        else
        {
            DoubleClickDir = 0;
        }
        // End:0x50
        if(global.NotifyLanded(HitNormal, FloorActor))
        {
            return true;
        }
        return false;
        //return ReturnValue;        
    }

    function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
    {
        local Vector PawnX, PawnY, PawnZ;
        local float MovementForward, MovementRight;
        local bool MovingOnForwardAxis, MovingOnRightAxis;
        local float ServerFloatEpsilon;

        ServerFloatEpsilon = 0.0500000;
        // End:0x64
        if(ControlModule != none)
        {
            ControlModule.ProcessMove(DeltaTime, newAccel, DoubleClickMove, DeltaRot);            
        }
        else
        {
            super.ProcessMove(DeltaTime, newAccel, DoubleClickMove, DeltaRot);
        }
        // End:0x2D9
        if((int(WorldInfo.NetMode) != int(NM_Client)) && Pawn != none)
        {
            Pawn.GetAxes(Pawn.Rotation, PawnX, PawnY, PawnZ);
            MovementForward = newAccel Dot PawnX;
            MovementRight = newAccel Dot PawnY;
            MovingOnForwardAxis = Abs(MovementForward) > ServerFloatEpsilon;
            MovingOnRightAxis = Abs(MovementRight) > ServerFloatEpsilon;
            // End:0x23B
            if(MovingOnForwardAxis && !MovingOnRightAxis)
            {
                // End:0x203
                if(MovementForward > 0.0000000)
                {
                    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_PlayerMoved', self, Class'TgGame.TgSeqEvent_PlayerMoved'.static.GetIndex(0));                    
                }
                else
                {
                    TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_PlayerMoved', self, Class'TgGame.TgSeqEvent_PlayerMoved'.static.GetIndex(1));
                }                
            }
            else
            {
                // End:0x2D9
                if(MovingOnRightAxis && !MovingOnForwardAxis)
                {
                    // End:0x2A4
                    if(MovementRight > 0.0000000)
                    {
                        TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_PlayerMoved', self, Class'TgGame.TgSeqEvent_PlayerMoved'.static.GetIndex(3));                        
                    }
                    else
                    {
                        TriggerGlobalEventClass(Class'TgGame.TgSeqEvent_PlayerMoved', self, Class'TgGame.TgSeqEvent_PlayerMoved'.static.GetIndex(2));
                    }
                }
            }
        }
        //return;        
    }

    function PlayerMove(float DeltaTime)
    {
        // End:0x52
        if(TgPlayerCamera(PlayerCamera) != none)
        {
            TgPlayerCamera(PlayerCamera).ProcessInput(PlayerInput, DeltaTime);
        }
        // End:0x72
        if(Pawn == none)
        {
            GotoState('Dead');            
        }
        else
        {
            // End:0xAC
            if(ControlModule != none)
            {
                ControlModule.PlayerMove(DeltaTime);                
            }
            else
            {
                super.PlayerMove(DeltaTime);
            }
        }
        //return;        
    }

    function UpdateRotation(float DeltaTime)
    {
        // End:0x3A
        if(ControlModule != none)
        {
            ControlModule.UpdateRotation(DeltaTime);            
        }
        else
        {
            super(PlayerController).UpdateRotation(DeltaTime);
        }
        ViewShake(DeltaTime);
        //return;        
    }
    stop;    
}

state PlayerClimbing
{
    ignores Bump, HearNoise, SeePlayer;

    exec function OnRightMousePressed()
    {
        // End:0x2B
        if(int(Role) < int(ROLE_Authority))
        {
            LadderLetGo();
            ServerLadderLetGo();            
        }
        else
        {
            LadderLetGo();
        }
        //return;        
    }

    exec function OnLeftMousePressed()
    {
        // End:0x70
        if((Pawn.Weapon != none) && TgDevice(Pawn.Weapon).CanFireWhileHanging())
        {
            global.OnLeftMousePressed();
        }
        //return;        
    }

    function BeginState(name PreviousStateName)
    {
        // End:0xB8
        if((Pawn.Weapon != none) && TgDevice(Pawn.Weapon).CanFireWhileHanging() == false)
        {
            TgPawn(Pawn).StopAction(TgDevice(Pawn.Weapon));
        }
        super.BeginState(PreviousStateName);
        //return;        
    }

    function EndState(name NextStateName)
    {
        Pawn.SetRotation(Rotation);
        super.EndState(NextStateName);
        //return;        
    }

    function PlayerMove(float DeltaTime)
    {
        local Vector X, Y, Z, newAccel;

        // End:0xEF
        if(Pawn.OnLadder != none)
        {
            newAccel = PlayerInput.aForward * Pawn.OnLadder.ClimbDir;
            // End:0xEC
            if(Pawn.OnLadder.bAllowLadderStrafing)
            {
                newAccel += (PlayerInput.aStrafe * Y);
            }            
        }
        else
        {
            newAccel = (PlayerInput.aForward * X) + (PlayerInput.aStrafe * Y);
        }
        newAccel = Pawn.AccelRate * Normal(newAccel);
        GetAxes(Pawn.Rotation, X, Y, Z);
        c_nCameraYawOffset = NormalizeRotAxis(int(float(c_nCameraYawOffset) + PlayerInput.aTurn));
        UpdateRotation(DeltaTime);
        // End:0x24F
        if(int(Role) < int(ROLE_Authority))
        {
            ReplicateMove(DeltaTime, newAccel, 0, Rotation);            
        }
        else
        {
            ProcessMove(DeltaTime, newAccel, 0, Rotation);
        }
        bPressedJump = false;
        //return;        
    }

    function UpdateRotation(float DeltaTime)
    {
        local Rotator DeltaRot, ViewRotation;

        ViewRotation = Rotation;
        Pawn.SetDesiredRotation(ViewRotation);
        DeltaRot.Yaw = int(PlayerInput.aTurn);
        DeltaRot.Pitch = int(PlayerInput.aLookUp);
        ProcessViewRotation(DeltaTime, ViewRotation, DeltaRot);
        SetRotation(ViewRotation);
        // End:0x12A
        if(Pawn != none)
        {
            Pawn.FaceRotation(ViewRotation, DeltaTime);
        }
        //return;        
    }
    stop;    
}

state Dead
{
    ignores ServerRestartPlayer, StartFire, SetControlModuleOnPossess, ClientPlayForceFeedbackWaveform, ClientPlayCameraShake, PrevWeapon, 
	    NextWeapon, KilledBy, HearNoise, SeePlayer;

    event Revive()
    {
        local NavigationPoint RestartNavPoint;
        local TgPawn myPawn;
        local Vector NewLocation;
        local Rotator NewRotation;
        local int Idx;
        local SeqEvent_PlayerSpawned SpawnedEvent;
        local array<SequenceObject> Events;
        local TgRepInfo_Player prep;
        local TgGame_Battle bg;
        local TgGame_Paladins tgc;

        // End:0x16
        if(int(Role) != int(ROLE_Authority))
        {
            return;
        }
        ClearTimer('ReviveTimer');
        ClearTimer('ViewObjectiveCamerasTimer');
        prep = TgRepInfo_Player(PlayerReplicationInfo);
        // End:0x8D
        if(prep != none)
        {
            prep.r_fReviveSecs = 0.0000000;
        }
        Pawn.bReplicateMovement = true;
        TgPawn(Pawn).r_DeathInfo.bDead = false;
        TgPawn(Pawn).r_DeathInfo.dmgType = none;
        // End:0x13E
        if(IsLocalPlayerController())
        {
            UpdatePlayerVitalsUI();
        }
        RestartNavPoint = TgGame(WorldInfo.Game).GetReviveLocation(self, NewLocation, NewRotation);
        SetNoSmoothedMovementCorrection(true, false);
        Pawn.SetLocation(NewLocation);
        Pawn.SetRotation(NewRotation);
        SetRotation(NewRotation);
        Pawn.SetDesiredRotation(NewRotation);
        ClientSetRotationAndDesired(NewRotation);
        GotoState('PlayerWalking');
        TgPawn(Pawn).OnRespawn();
        TgPawn(Pawn).r_nResetCharacter++;
        // End:0x3D4
        if(WorldInfo.GetGameSequence() != none)
        {
            WorldInfo.GetGameSequence().FindSeqObjectsByClass(Class'Engine.SeqEvent_PlayerSpawned', true, Events);
            Idx = 0;
            J0x309:

            // End:0x3D4 [Loop If]
            if(Idx < Events.Length)
            {
                SpawnedEvent = SeqEvent_PlayerSpawned(Events[Idx]);
                // End:0x3C6
                if((SpawnedEvent != none) && SpawnedEvent.CheckActivate(self, self))
                {
                    SpawnedEvent.SpawnPoint = RestartNavPoint;
                    SpawnedEvent.PopulateLinkedVariableValues();
                }
                Idx++;
                // [Loop Continue]
                goto J0x309;
            }
        }
        myPawn = TgPawn(Pawn);
        // End:0x504
        if(myPawn != none)
        {
            myPawn.SetSpawnHealth();
            myPawn.SetSpawnMana();
            myPawn.bReplicateMovement = true;
            myPawn.m_LastDamager = none;
            myPawn.s_Damagers.Remove(0, TgPawn(Pawn).s_Damagers.Length);
            myPawn.s_nSpawnTime = WorldInfo.TimeSeconds;
        }
        bg = TgGame_Battle(WorldInfo.Game);
        // End:0x574
        if((bg != none) && bg.m_bEnableCrowdEvents)
        {
            ArenaCrowdEvent(3);
        }
        // End:0x5E4
        if(prep != none)
        {
            prep.bForceNetUpdate = true;
            Pawn.bForceNetUpdate = true;
            prep.UpdatePlayerLocation();
        }
        m_nReviveBuybackCost = 0;
        ClientShowRespawnBuyback(m_nReviveBuybackCost);
        StartBuyBurnCardsTimer();
        tgc = TgGame_Paladins(WorldInfo.Game);
        // End:0x70A
        if(((tgc != none) && tgc.GameplayEventsWriter != none) && tgc.GameplayEventsWriter.IsSessionInProgress())
        {
            tgc.GameplayEventsWriter.LogPlayerSpawnEvent(102, self, Pawn.Class, GetTaskForceNumber());
        }
        //return;        
    }

    reliable client simulated event ClientSetViewTarget(Actor A, optional ViewTargetTransitionParams TransitionParams)
    {
        // End:0x1C
        if(A == none)
        {
            ServerVerifyViewTarget();
            return;
        }
        SetViewTarget(A, TransitionParams);
        //return;        
    }

    function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
    {
        // End:0x55
        if(ControlModule != none)
        {
            ControlModule.ProcessMove(DeltaTime, newAccel, DoubleClickMove, DeltaRot);            
        }
        else
        {
            super(PlayerController).ProcessMove(DeltaTime, newAccel, DoubleClickMove, DeltaRot);
        }
        //return;        
    }

    function PlayerMove(float DeltaTime)
    {
        // End:0x52
        if(TgPlayerCamera(PlayerCamera) != none)
        {
            TgPlayerCamera(PlayerCamera).ProcessInput(PlayerInput, DeltaTime);
        }
        // End:0x8C
        if(ControlModule != none)
        {
            ControlModule.PlayerMove(DeltaTime);            
        }
        else
        {
            super.PlayerMove(DeltaTime);
        }
        //return;        
    }

    function UpdateRotation(float DeltaTime)
    {
        // End:0x3A
        if(ControlModule != none)
        {
            ControlModule.UpdateRotation(DeltaTime);            
        }
        else
        {
            super(PlayerController).UpdateRotation(DeltaTime);
        }
        //return;        
    }

    exec function OnLeftMousePressed()
    {
        // End:0x1F
        if(int(r_WatchOtherPlayer) > int(0))
        {
            ServerViewNextPlayer(true);
        }
        //return;        
    }

    exec function OnRightMousePressed()
    {
        // End:0x1F
        if(int(r_WatchOtherPlayer) > int(0))
        {
            ServerViewPrevPlayer(true);
        }
        //return;        
    }

    simulated function FadeForViewPlayersTimer()
    {
        // End:0x7E
        if(((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && !Pawn.IsAliveAndWell()) && CanPlayKillCam(bIsTimelapsePlayOfTheGame))
        {
            UIFade(true, m_fWatchOthersFadeToBlackCamTime);
        }
        //return;        
    }

    simulated function ViewPlayersTimer()
    {
        local array<PlayerController> viewerArray;
        local TgPlayerController PC;
        local int I;
        local TgPawn myPawn;

        // End:0x1A5
        if(!CanPlayKillCam(bIsTimelapsePlayOfTheGame))
        {
            StartWatchOthers();
            myPawn = TgPawn(Pawn);
            // End:0x9A
            if((myPawn != none) && myPawn.m_DeathDamageType == Class'TgGame.TgDamageType_FallOutOfWorld')
            {
                SwitchCamera("falloutofworld");                
            }
            else
            {
                SwitchCamera("dead");
            }
            // End:0x1A2
            if(int(Role) == int(ROLE_Authority))
            {
                myPawn = TgPawn(Pawn);
                viewerArray = myPawn.s_Viewers;
                I = 0;
                J0x10D:

                // End:0x1A2 [Loop If]
                if(I < viewerArray.Length)
                {
                    PC = TgPlayerController(viewerArray[I]);
                    // End:0x194
                    if((PC != self) && TgSpectatorController(PC) == none)
                    {
                        PC.ServerViewNextPlayer();
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x10D;
                }
            }            
        }
        else
        {
            // End:0x1CE
            if(int(Role) == int(ROLE_Authority))
            {
                StartTimelapsePlayback(-7.5000000, -3.0000000);
            }
        }
        //return;        
    }

    function BeginState(name PreviousStateName)
    {
        local LocalPlayer LocPlayer;
        local float fReviveTime;
        local TgRepInfo_Player prep;
        local TgPawn aPawn;

        aPawn = TgPawn(Pawn);
        // End:0x51
        if((Player == none) || Pawn == none)
        {
            super.BeginState(PreviousStateName);
            return;
        }
        OnLeftMouseReleased();
        OnRightMouseReleased();
        bPressedJump = false;
        m_bJustDidJumpDoubleTap = false;
        m_JumpHeld = 0;
        m_JumpHeldAlt = 0;
        // End:0xAC
        if(IsLocalPlayerController())
        {
            UpdatePlayerVitalsUI();
        }
        // End:0x106
        if((aPawn != none) && aPawn.m_DeathDamageType == Class'TgGame.TgDamageType_FallOutOfWorld')
        {
            SwitchCamera("falloutofworld");            
        }
        else
        {
            // End:0x160
            if(!WorldInfo.IsPlayingDemo() && !WorldInfo.IsPlayingTimelapse())
            {
                SwitchCamera("dead");
            }
        }
        // End:0x1F0
        if((m_fTimeToViewOthersCamAfterDeath > float(0)) && s_fWaitForSpawnSecs == float(0))
        {
            SetTimer(m_fTimeToViewOthersCamAfterDeath, false, 'ViewPlayersTimer');
            // End:0x1ED
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                SetTimer((m_fTimeToViewOthersCamAfterDeath - m_fWatchOthersFadeToBlackCamTime) - 0.1000000, false, 'FadeForViewPlayersTimer');
            }            
        }
        else
        {
            ViewPlayersTimer();
        }
        // End:0x257
        if(!WorldInfo.IsPlayingDemo() && !WorldInfo.IsPlayingTimelapse())
        {
            SwitchControl(Class'TgGame.TgControlModule_Dead');
        }
        Pawn.ShouldCrouch(false);
        bDuck = 0;
        LocPlayer = LocalPlayer(Player);
        // End:0x3BD
        if((((LocPlayer != none) && LocPlayer.ViewportClient != none) && LocPlayer.ViewportClient.UIController != none) && LocPlayer.ViewportClient.UIController.SceneClient != none)
        {
            LocPlayer.ViewportClient.UIController.SceneClient.TgFlushPlayerInput();
        }
        CleanOutSavedMoves();
        FOVAngle = DesiredFOV;
        Enemy = none;
        bFrozen = true;
        bPressedJump = false;
        m_fDeathTime = WorldInfo.TimeSeconds;
        // End:0x4EA
        if(int(Role) == int(ROLE_Authority))
        {
            fReviveTime = StartReviveTimer(!s_bAddDeadTimeStatsTracker);
            s_bAddDeadTimeStatsTracker = true;
            UpdateReviveTimeRemaining(fReviveTime);
            prep = TgRepInfo_Player(PlayerReplicationInfo);
            // End:0x4EA
            if(prep != none)
            {
                prep.OnDeath();
                prep.r_fReviveSecs = fReviveTime;
            }
        }
        CancelInBombRange();
        // End:0x55F
        if(TgGame(WorldInfo.Game) != none)
        {
            TgGame(WorldInfo.Game).PlayerDied(self);
        }
        // End:0x58F
        if(aPawn != none)
        {
            aPawn.s_bHasInteractedWithStore = false;
        }
        //return;        
    }

    function EndState(name NextStateName)
    {
        local TgPawn TgP;

        TgP = TgPawn(Pawn);
        // End:0x58
        if(TgP != none)
        {
            m_eCurrentStunType = 0;
            TgP.r_eCurrentStunType = 0;
        }
        // End:0x7F
        if(int(Role) != int(ROLE_Authority))
        {
            SetSoundMode('Default');
        }
        UpdateReviveTimeRemaining(0.0000000);
        // End:0x14E
        if((((NextStateName != 'None') && NextStateName != 'RoundEnded') && NextStateName != 'PlayerMatchOver') && int(Role) == int(ROLE_Authority))
        {
            // End:0x14E
            if(IsTimerActive('ReviveTimer') || TgPawn(Pawn).r_DeathInfo.bDead)
            {
                Revive();
            }
        }
        Velocity = vect(0.0000000, 0.0000000, 0.0000000);
        Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
        bPressedJump = false;
        // End:0x1BC
        if(NextStateName != 'RoundEnded')
        {
            StopWatchOthers();
            SwitchCamera("default");
        }
        CleanOutSavedMoves();
        // End:0x224
        if(int(Role) < int(ROLE_Authority))
        {
            // End:0x224
            if(Pawn != none)
            {
                c_nCameraYawOffset = Pawn.Rotation.Yaw;
            }
        }
        // End:0x2BF
        if(((!bDeleteMe && !bPendingDelete) && NextStateName != 'PlayerMatchOver') && Pawn != none)
        {
            Pawn.SetCollision(true, true, false);
            Pawn.SetLocation(Pawn.Location);
        }
        UIFade(false, m_fWatchOthersFadeFromBlackCamTime);
        EndTimelapsePlayback();
        //return;        
    }

    event ControllerPostTimeLapse()
    {
        local TgPlayerCamera Cam;
        local TgPawn TgP;
        local array<SequenceObject> AllTimeLapseEvents;
        local TgSeqEvent_TimeLapse TimeLapseEvt;
        local Sequence GameSeq;
        local int Idx;
        local array<int> ActivateIndices;

        TgP = TgPawn(Pawn);
        // End:0xE9
        if((TgP != none) && !IsZero(TgP.m_vMeshTranslationOffset) || TgP.m_bDoSmoothCorrectionThisTick)
        {
            TgP.m_vMeshTranslationOffset = vect(0.0000000, 0.0000000, 0.0000000);
            TgP.m_bDoSmoothCorrectionThisTick = false;
            TgP.SmoothCorrectionTranslationTick(0.0000000, true);
        }
        SetHUDOverlay(0);
        StartWatchOthers();
        ClearKillCamTarget();
        Cam = TgPlayerCamera(PlayerCamera);
        // End:0x17D
        if(Cam != none)
        {
            Cam.ResetFOV();
            Cam.SwitchCameras(Class'TgGame.TgCameraModule_SpectatorFirstPerson');
        }
        ServerViewNextPlayer(true);
        GameSeq = WorldInfo.GetGameSequence();
        // End:0x292
        if(GameSeq != none)
        {
            GameSeq.FindSeqObjectsByClass(Class'TgGame.TgSeqEvent_TimeLapse', true, AllTimeLapseEvents);
            ActivateIndices.AddItem(1);
            Idx = 0;
            J0x20B:

            // End:0x292 [Loop If]
            if(Idx < AllTimeLapseEvents.Length)
            {
                TimeLapseEvt = TgSeqEvent_TimeLapse(AllTimeLapseEvents[Idx]);
                // End:0x284
                if(TimeLapseEvt != none)
                {
                    TimeLapseEvt.CheckActivate(self, self, false, ActivateIndices);
                }
                Idx++;
                // [Loop Continue]
                goto J0x20B;
            }
        }
        OnPostTimeLapse();
        //return;        
    }
    stop;    
}

auto state PlayerWaiting
{
    ignores ServerSuicide, PlayerMove, Suicide, Jump, StopAltFire, StartAltFire, 
	    StartFire, SwitchToBestWeapon, PrevWeapon, NextWeapon, PhysicsVolumeChange, 
	    TakeDamage, NotifyBump, HearNoise, SeePlayer;

    reliable server function ServerRestartPlayer()
    {
        super.ServerRestartPlayer();
        // End:0x62
        if(WorldInfo.Game.bWaitingToStartMatch)
        {
            PlayerReplicationInfo.bReadyToPlay = false;
        }
        //return;        
    }

    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        c_nCameraYawOffset = 32767;
        // End:0x55
        if(PlayerReplicationInfo != none)
        {
            PlayerReplicationInfo.bReadyToPlay = false;            
        }
        //return;        
    }

    function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

state Spectating
{
    ignores EndState;

    exec function ViewPlayerByName(string PlayerName)
    {
        ServerViewPlayerByName(PlayerName);
        //return;        
    }

    exec function PrevWeapon()
    {
        ServerViewPrevPlayer();
        //return;        
    }

    exec function NextWeapon()
    {
        ServerViewNextPlayer();
        //return;        
    }

    exec function OnRightMousePressed()
    {
        ServerViewSelf();
        //return;        
    }
    stop;    
}

state RoundEnded
{
    ignores EndState, Timer;

    event BeginState(name PreviousStateName)
    {
        ClearTimer();
        SendSessionEnd();
        FOVAngle = DesiredFOV;
        bFire = 0;
        // End:0x78
        if(Pawn != none)
        {
            StopFiring();
            TgPawn(Pawn).s_bCanApplyEffects = false;
        }
        // End:0xC1
        if(IsLocalPlayerController())
        {
            SetTimeDilation(1.0000000, 0.0000000);
            SetDesaturation(0.0000000, 0.0000000);
            FadeHud();
            BeginFadeOut();
        }
        //return;        
    }

    function BeginFadeOut()
    {
        local float FadeDuration;

        FadeDuration = 0.2500000;
        SetTimer(FadeDuration, false, 'OnFadeOutComplete');
        //return;        
    }

    function OnFadeOutComplete()
    {
        local float OutroTime;

        SetTimeDilation(1.0000000, 0.0000000);
        SetDesaturation(0.0000000, 0.0000000);
        // End:0x65
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            SetViewTarget(m_EndGameFocus);
        }
        TgPlayerCamera(PlayerCamera).SwitchCameras(Class'TgGame.TgCameraModule_Attached', 0.0000000);
        OutroTime = GetOutroTime();
        SetTimer(OutroTime - 2.0000000, false, 'BeginMatchOutroFade');
        SetTimer(OutroTime, false, 'OnFinishedMatchOutro');
        AnnounceEOM();
        //return;        
    }

    function BeginMatchOutroFade()
    {
        DoFade(false, 2.0000000);
        //return;        
    }

    function OnFinishedMatchOutro()
    {
        SendGameOverEvent(c_GameWinState, (GetTaskForceNumber()) == 1);
        TgHUD(myHUD).MapOutroFinished();
        //return;        
    }

    function AnnounceEOM()
    {
        local TgPawn myPawn;
        local bool bAttackerWon, bPlayerIsAttacker;

        SetSoundMode('GA_RoundOver');
        // End:0x13B
        if(TgHUD(myHUD) != none)
        {
            bAttackerWon = int(c_GameWinState) == int(2);
            bPlayerIsAttacker = (GetTaskForceNumber()) == 1;
            TgHUD(myHUD).EndMission(bPlayerIsAttacker, c_GameWinState);
            myPawn = TgPawn(Pawn);
            // End:0x13B
            if(myPawn != none)
            {
                // End:0x10E
                if(bPlayerIsAttacker == bAttackerWon)
                {
                    myPawn.PlayEmoteSelfOnly(24);
                    NativeAnnounceEOM(true);                    
                }
                else
                {
                    myPawn.PlayEmoteSelfOnly(25);
                    NativeAnnounceEOM(false);
                }
            }
        }
        //return;        
    }
    stop;    
}

simulated state Unconscious extends PlayerWalking
{
    function BeginState(name PreviousStateName)
    {
        CleanOutSavedMoves();
        // End:0x31
        if(ShouldStunChangePhysics())
        {
            Pawn.SetPhysics(1);
        }
        //return;        
    }

    function EndState(name NextStateName)
    {
        CleanOutSavedMoves();
        Pawn.SetRotation(Rotation);
        SwitchControl(none);
        //return;        
    }

    function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
    {
        // End:0x55
        if(ControlModule != none)
        {
            ControlModule.ProcessMove(DeltaTime, newAccel, DoubleClickMove, DeltaRot);            
        }
        else
        {
            super.ProcessMove(DeltaTime, newAccel, DoubleClickMove, DeltaRot);
        }
        //return;        
    }

    function PlayerMove(float DeltaTime)
    {
        // End:0x52
        if(TgPlayerCamera(PlayerCamera) != none)
        {
            TgPlayerCamera(PlayerCamera).ProcessInput(PlayerInput, DeltaTime);
        }
        // End:0x8C
        if(ControlModule != none)
        {
            ControlModule.PlayerMove(DeltaTime);            
        }
        else
        {
            super.PlayerMove(DeltaTime);
        }
        //return;        
    }

    function UpdateRotation(float DeltaTime)
    {
        // End:0x3A
        if(ControlModule != none)
        {
            ControlModule.UpdateRotation(DeltaTime);            
        }
        else
        {
            super.UpdateRotation(DeltaTime);
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    r_bCanChangeLoadout=true
    m_bContextNotifiesEnabled=true
    m_bShowPlayerCircles=true
    m_bAllowUndrawnPurchase=true
    m_bOutlineEnemies=true
    m_bOutlineFriendlies=true
    m_bThreatSystemEnabled=true
    m_bOcclusionSystemEnabled=true
    m_bRewindMoversForReplaySavedMoves=true
    m_bShowChampionOverviewTip=true
    m_bEnableUltimateAkEventUnocclusion=true
    c_fTimeTillAFK=180.0000000
    m_fLastLostHealthTime=-1.0000000
    m_fDeathTime=-1.0000000
    DefaultControlModuleClass=Class'TgGame.TgControlModule_ThirdPerson'
    m_fPendingReloadTime=-0.5000000
    m_fPendingReloadMaxTime=0.5000000
    m_fTimeToViewOthersCamAfterDeath=2.5000000
    m_fWatchOthersFadeToBlackCamTime=0.5000000
    m_fWatchOthersFadeFromBlackCamTime=0.3000000
    r_nFlashSimProjIdx=-1
    c_nLastFlashSimProjIdx=-1
    m_fPathfinderStreamTime=1.0000000
    m_fPathfinderPulseTime=0.5000000
    m_fPathfinderLifetime=2.5000000
    m_fPathfinderSpeed=800.0000000
    m_fPathfinderStartDist=500.0000000
    c_FallWindSoundPlay=AkEvent'WW_PC_Shared.PC_Shared_Fall_Wind_LP_1P_Play'
    c_FallWindSoundStop=AkEvent'WW_PC_Shared.PC_Shared_Fall_Wind_LP_1P_Stop'
    m_nKillCamTargetId=-1
    m_nKillCamTargetBackupId=-1
    m_fMaxJumpDoubleTapTime=0.2500000
    m_fThreatCoefficientProximity=0.5000000
    m_fThreatCoefficientOcclusion=1.0000000
    m_fThreatCoefficientUlt=4.0000000
    m_fThreatCoefficientShotAt=2.0000000
    m_fThreatCoefficientSeenBy=0.7500000
    m_fThreatCoefficientDamaged=0.2500000
    m_fThreatCoefficientFocused=1.0000000
    m_fThreatCoefficientBehind=0.5000000
    m_fThreatDecayCoefficientShotAt=0.5000000
    m_fThreatDecayCoefficientSeenBy=0.5000000
    m_fThreatDecayCoefficientUlt=0.5000000
    m_nameBuyBurnCardsTimer="BuyBurnCards"
    m_RoundEndAlert=AkEvent'WW_UI_Default.UI_InGame_Alert_RoundEnd_1P_Play'
    m_CaptureProgressPlayAkEvent=AkEvent'WW_UI_Default.UI_InGame_Alert_PointProgress_LP_1P_Play'
    m_CaptureProgressStopAkEvent=AkEvent'WW_UI_Default.UI_InGame_Alert_PointProgress_LP_1P_Stop'
    m_PointGettingCapturedPlayAkEvent=AkEvent'WW_UI_Default.UI_InGame_Alert_Point_Getting_Captured_1P_Play'
    m_fShowChampionOverviewTipDelay=3.0000000
    s_fIdleTimeReduction=1.0000000
    c_nLeadingTeam=1
    c_nLeadingTeamTicketAmount=15
    m_nMaxPartyPublicConnections=5
    CameraClass=Class'TgGame.TgPlayerCamera'
    bCheckSoundOcclusion=true
    FOVAngle=100.0000000
    DesiredFOV=100.0000000
    DefaultFOV=100.0000000
    SavedMoveClass=Class'TgGame.TgSavedMove'
    CheatClass=Class'TgGame.TgBattleCheatManager'
    InputClass=Class'TgGame.TgPlayerInput'
    // Reference: CylinderComponent'TgGame.Default__TgPlayerController.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'PlatformCommon.Default__PComPlayerController.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    MinHitWall=0.1000000
    Components[0]=CollisionCylinder
    s_bThrottleNetRelevancy=true
    CollisionComponent=CollisionCylinder
}