class TgPlayerController extends PComPlayerController
    native(Pawns)
    nativereplication
    config(Game)
    hidecategories(Navigation)
    implements(TgPaladinsController,TgCallbackInterface)
    dependson(TgObject);

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

enum EGiveGoldResult {
    GGR_PlayerNotFound,  // 0
    GGR_PlayerNotFriendly,  // 1
    GGR_NotEnoughGold,  // 2
    GGR_Success,  // 3
};

enum EAnnouncerSeries {
    ANS_TimeRemaining,  // 0
    ANS_TotalTimeRemaining,  // 1
    ANS_Countdown,  // 2
    ANS_Overtime,  // 3
};

enum EPlayerInputType {
    PIT_MoveForward,  // 0
    PIT_MoveBackward,  // 1
    PIT_MoveRight,  // 2
    PIT_MoveLeft,  // 3
    PIT_LookLeft,  // 4
    PIT_LookRight,  // 5
    PIT_LookUp,  // 6
    PIT_LookDown,  // 7
    PIT_Auto,  // 8
    PIT_Alt,  // 9
    PIT_BattleAbility,  // 10
    PIT_MovementAbility,  // 11
    PIT_Ultimate,  // 12
    PIT_Reload,  // 13
    PIT_Jump,  // 14
    PIT_Mount,  // 15
    PIT_LoadoutMenu,  // 16
    PIT_BurnCardMenu,  // 17
    PIT_Emote,  // 18
    PIT_Spray,  // 19
};

enum TG_CAMERAPOSTURE {
    TG_CAMERAPOSTURE_None,  // 0
    TG_CAMERAPOSTURE_Emote3P,  // 1
    TG_CAMERAPOSTURE_Ability3P,  // 2
    TG_CAMERAPOSTURE_Force3P,  // 3
    TG_CAMERAPOSTURE_Force1P,  // 4
};

enum EWatchOtherPlayersMode {
    WOPM_NONE,  // 0
    WOPM_PLAYER,  // 1
};

enum EHUDOverlay {
    HO_None,  // 0
    HO_Sniper,  // 1
    HO_Binoculars,  // 2
    HO_OwlScope,  // 3
};

struct TG_LAST_PURCHASE {
    var int nItemId;
    var int nCount;
    structdefaultproperties {}
};

struct FLOOD {
    var int m_nCount;
    var float m_fLastUpdate;
    structdefaultproperties {}
};

struct CameraStackInfo {
    var TgPlayerController.TG_CAMERAPOSTURE ePosture;
    var int nStackId;
    structdefaultproperties {}
};

struct InventoryChangeFlags {
    var bool bDevice;
    var bool bComponent;
    var bool bEquipped;
    var bool bDeviceFailed;
    structdefaultproperties {}
};

struct sSimProjectileFireInfo {
    var int nOwnerFireModeId;
    var Vector vLocation;
    var Vector vVelocity;
    var Vector vDirectionMunged;
    var int nActorID;
    var int nClientFireRequestId;
    var PComStructures.CMTargetType ActorType;
    var float fGeneric1;
    var float fGeneric2;
    structdefaultproperties {}
};

struct BinocularSettings {
    var int nTargets;
    var Rotator rHeading;
    var float fRange;
    var float fTimer1;
    var float fTimer2;
    var float fTimer3;
    var float fTimerDuration;
    var float fRefireTimerPercent;
    var float fDurationPercent;
    structdefaultproperties {}
};

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
var () bool m_bOutlineEnemies;
var () bool m_bOutlineFriendlies;
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
var () editinline TgControlModule ControlModule;
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
var () const float m_fWatchOthersFadeToBlackCamTime;
var () const float m_fWatchOthersFadeFromBlackCamTime;
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
var () editinline TgCameraShake m_PreviewCameraShake;
var array<TgChaosCapturePoint> m_CapturePoints;
var () float m_fPathfinderStreamTime;
var () float m_fPathfinderPulseTime;
var () float m_fPathfinderLifetime;
var () float m_fPathfinderSpeed;
var () float m_fPathfinderStartDist;
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

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetOwner) r_LastPurchasedItems, r_TutorialBlockedClientActions, r_WatchOtherPlayer, r_bAutoPurchase, r_bAutoSkillUp, r_bCanChangeLoadout, r_bCanPurchaseItems, r_bInputEnabled, r_bLockYawRotation, r_bRove, r_bToggleZoom, r_fServerTimeStamp, r_nCurrency, r_nPerkPointsAvail, r_nStatPoints, r_nXp;
}

native function SetViewTarget(Actor NewViewTarget, optional ViewTargetTransitionParams TransitionParams);  // Export UTgPlayerController::execSetViewTarget(FFrame&, void* const)

native function CanDoFullSellback();  // Export UTgPlayerController::execCanDoFullSellback(FFrame&, void* const)

native function bool IsReadyForStart();  // Export UTgPlayerController::execIsReadyForStart(FFrame&, void* const)

native function QueueReviveTimeChanged();  // Export UTgPlayerController::execQueueReviveTimeChanged(FFrame&, void* const)

native function CueAttackedFromBehind();  // Export UTgPlayerController::execCueAttackedFromBehind(FFrame&, void* const)

native function CueAttackedFromAbove();  // Export UTgPlayerController::execCueAttackedFromAbove(FFrame&, void* const)

native function CueAttackedFromSniper();  // Export UTgPlayerController::execCueAttackedFromSniper(FFrame&, void* const)

native function int AnnouncerGetStep(TgPlayerController.EAnnouncerSeries series);  // Export UTgPlayerController::execAnnouncerGetStep(FFrame&, void* const)

native function AnnouncerReset();  // Export UTgPlayerController::execAnnouncerReset(FFrame&, void* const)

native function bool AnnouncerPlaySeries(TgPlayerController.EAnnouncerSeries series, optional int Step=0);  // Export UTgPlayerController::execAnnouncerPlaySeries(FFrame&, void* const)

native function PlayPointAlienFX(bool bPointWonLocal);  // Export UTgPlayerController::execPlayPointAlienFX(FFrame&, void* const)

native function NativeAnnounceEOM(bool bVictory);  // Export UTgPlayerController::execNativeAnnounceEOM(FFrame&, void* const)

native exec function LogPerfLeakData();  // Export UTgPlayerController::execLogPerfLeakData(FFrame&, void* const)

native exec function TestVGSPOTG(int nPackId, int nBotId, int nSkinId);  // Export UTgPlayerController::execTestVGSPOTG(FFrame&, void* const)

native function Class<HUD> GetHudClass(Class<HUD> pNewHudType);  // Export UTgPlayerController::execGetHudClass(FFrame&, void* const)

native function bool CanCameraSeePawnCenter(TgPawn Other);  // Export UTgPlayerController::execCanCameraSeePawnCenter(FFrame&, void* const)

native function bool CanCameraSeeActorCenter(Actor Other, optional float ZOffset);  // Export UTgPlayerController::execCanCameraSeeActorCenter(FFrame&, void* const)

native reliable server function ServerSetTaskforceLead(string fsName);  // Export UTgPlayerController::execServerSetTaskforceLead(FFrame&, void* const)

native exec function Friend(string sCmd, string sName);  // Export UTgPlayerController::execFriend(FFrame&, void* const)

native function ConfirmMatchLeave(bool bLeave);  // Export UTgPlayerController::execConfirmMatchLeave(FFrame&, void* const)

native exec function MatchLeave(bool bAsTeam);  // Export UTgPlayerController::execMatchLeave(FFrame&, void* const)

native event MatchAccept(bool bAccepted);  // Export UTgPlayerController::execMatchAccept(FFrame&, void* const)

native function TgClientSettings GetClientSettings();  // Export UTgPlayerController::execGetClientSettings(FFrame&, void* const)

native exec function Bug();  // Export UTgPlayerController::execBug(FFrame&, void* const)

native exec function _Crash();  // Export UTgPlayerController::exec_Crash(FFrame&, void* const)

native exec function LogTo(string fsHost, optional int nPort=4040);  // Export UTgPlayerController::execLogTo(FFrame&, void* const)

native exec function StopLogTo();  // Export UTgPlayerController::execStopLogTo(FFrame&, void* const)

native exec function ToggleInHandTargeting(bool bHide);  // Export UTgPlayerController::execToggleInHandTargeting(FFrame&, void* const)

native exec function DisableProfanityFilter(bool bDisable);  // Export UTgPlayerController::execDisableProfanityFilter(FFrame&, void* const)

native exec function SpectateDamage(bool bShow);  // Export UTgPlayerController::execSpectateDamage(FFrame&, void* const)

native exec function SpectateHeals(bool bShow);  // Export UTgPlayerController::execSpectateHeals(FFrame&, void* const)

native exec function SpectateCrits(bool bShow);  // Export UTgPlayerController::execSpectateCrits(FFrame&, void* const)

native exec function SpectateGold(bool bShow);  // Export UTgPlayerController::execSpectateGold(FFrame&, void* const)

native exec function SpectateXP(bool bShow);  // Export UTgPlayerController::execSpectateXP(FFrame&, void* const)

native exec function SpectateOutlines(bool bShow);  // Export UTgPlayerController::execSpectateOutlines(FFrame&, void* const)

native exec function ToggleCombatInfo();  // Export UTgPlayerController::execToggleCombatInfo(FFrame&, void* const)

native function FinalSave();  // Export UTgPlayerController::execFinalSave(FFrame&, void* const)

native function ForceRelevant(Actor pActor, optional float fDuration=-1.0000000);  // Export UTgPlayerController::execForceRelevant(FFrame&, void* const)

native function bool bIsEditor();  // Export UTgPlayerController::execbIsEditor(FFrame&, void* const)

native function GetValue(string fsObject, string fsValue);  // Export UTgPlayerController::execGetValue(FFrame&, void* const)

native function SetValue(string fsObject, string fsVariable, string fsValue);  // Export UTgPlayerController::execSetValue(FFrame&, void* const)

native function int GetDeviceIdByName(string sDeviceName);  // Export UTgPlayerController::execGetDeviceIdByName(FFrame&, void* const)

native function ClientLoadDevices(TgSeqAct_ClientLoadDevices Action);  // Export UTgPlayerController::execClientLoadDevices(FFrame&, void* const)

native function DumpClassInfoToFile(string sClassName);  // Export UTgPlayerController::execDumpClassInfoToFile(FFrame&, void* const)

native function SendGameOverEvent(TgObject.GAME_WIN_STATE gameWinState, bool bPlayerIsAttacker);  // Export UTgPlayerController::execSendGameOverEvent(FFrame&, void* const)

native function TgPawn GetPlayerControlPawn();  // Export UTgPlayerController::execGetPlayerControlPawn(FFrame&, void* const)

native function ConvertTimeDisplay(int nMinutes, out string sDisplay);  // Export UTgPlayerController::execConvertTimeDisplay(FFrame&, void* const)

native simulated function bool CheckMaxEffectDistance(PlayerController P, Vector SpawnLocation, optional float CullDistance);  // Export UTgPlayerController::execCheckMaxEffectDistance(FFrame&, void* const)

native simulated function BlockVGS(bool bBlock);  // Export UTgPlayerController::execBlockVGS(FFrame&, void* const)

native exec function OutputRelevantActors();  // Export UTgPlayerController::execOutputRelevantActors(FFrame&, void* const)

native function DoClientSidePerfTracking(int nLength);  // Export UTgPlayerController::execDoClientSidePerfTracking(FFrame&, void* const)

native exec function ToggleTick(string ClassName, bool bDisable);  // Export UTgPlayerController::execToggleTick(FFrame&, void* const)

native exec function SetPawnTickState(int nState);  // Export UTgPlayerController::execSetPawnTickState(FFrame&, void* const)

native exec function TgPerfTrack(bool bStart);  // Export UTgPlayerController::execTgPerfTrack(FFrame&, void* const)

native function DumpPerfTrackData();  // Export UTgPlayerController::execDumpPerfTrackData(FFrame&, void* const)

native simulated function SetSoundMode(Name InSoundModeName);  // Export UTgPlayerController::execSetSoundMode(FFrame&, void* const)

native exec function DebugGetLangMsg(int nMsgId);  // Export UTgPlayerController::execDebugGetLangMsg(FFrame&, void* const)

native simulated function HandleSimulatedProjectile();  // Export UTgPlayerController::execHandleSimulatedProjectile(FFrame&, void* const)

native simulated function SendUIXpChange();  // Export UTgPlayerController::execSendUIXpChange(FFrame&, void* const)

native simulated function SendUICurrencyChange();  // Export UTgPlayerController::execSendUICurrencyChange(FFrame&, void* const)

native function GetDamageAngle(Rotator HitDir, out float PitchDegrees, out float YawDegrees);  // Export UTgPlayerController::execGetDamageAngle(FFrame&, void* const)

native function AutoPurchase();  // Export UTgPlayerController::execAutoPurchase(FFrame&, void* const)

native function AutoSkillUp();  // Export UTgPlayerController::execAutoSkillUp(FFrame&, void* const)

native function ToggleZoom();  // Export UTgPlayerController::execToggleZoom(FFrame&, void* const)

native function SetAutoPurchaseFlag(bool bOn, optional bool bForce=false);  // Export UTgPlayerController::execSetAutoPurchaseFlag(FFrame&, void* const)

native function SetAutoSkillUpFlag(bool bOn, optional bool bForce=false);  // Export UTgPlayerController::execSetAutoSkillUpFlag(FFrame&, void* const)

native function SetToggleZoomFlag(bool bOn, optional bool bForce=false);  // Export UTgPlayerController::execSetToggleZoomFlag(FFrame&, void* const)

exec function TgPlayerController.EGiveGoldResult GiveGoldToFriendlyPlayer(int PlayerID, int GoldCount) { }

native reliable server function TgPlayerController.EGiveGoldResult ServerTransferGoldBetweenFriendlyPlayers(int ReceivingPlayerID, int GoldCount);  // Export UTgPlayerController::execServerTransferGoldBetweenFriendlyPlayers(FFrame&, void* const)

native function int GetPerkPointsAvailable();  // Export UTgPlayerController::execGetPerkPointsAvailable(FFrame&, void* const)

native function int GetPerkPointsSpent();  // Export UTgPlayerController::execGetPerkPointsSpent(FFrame&, void* const)

native function bool CanAllocateDevicePoint(int nDeviceId, TgDevice aDevice, optional bool ignorePause=false);  // Export UTgPlayerController::execCanAllocateDevicePoint(FFrame&, void* const)

native function int GetDevicePointsAvailable();  // Export UTgPlayerController::execGetDevicePointsAvailable(FFrame&, void* const)

native function int GetDevicePointsSpent();  // Export UTgPlayerController::execGetDevicePointsSpent(FFrame&, void* const)

native function bool HaveBasicAbilitiesBeenActivated();  // Export UTgPlayerController::execHaveBasicAbilitiesBeenActivated(FFrame&, void* const)

native reliable server function ServerAllocateDevicePoint(int nDeviceId);  // Export UTgPlayerController::execServerAllocateDevicePoint(FFrame&, void* const)

native function bool ClientUpdateUIDeviceState();  // Export UTgPlayerController::execClientUpdateUIDeviceState(FFrame&, void* const)

native function ClientUpdateTutorialBlockingActions();  // Export UTgPlayerController::execClientUpdateTutorialBlockingActions(FFrame&, void* const)

native function int GetTaskForceNumber();  // Export UTgPlayerController::execGetTaskForceNumber(FFrame&, void* const)

native function bool IsFiringUlt();  // Export UTgPlayerController::execIsFiringUlt(FFrame&, void* const)

native reliable server function ServerPurchaseItem(int nLootTableId, int nLootTableItemId, int nItemCount);  // Export UTgPlayerController::execServerPurchaseItem(FFrame&, void* const)

native reliable server function ServerUpgradeItem(int nLootTableId, int nLootTableItemId, int nUpgradeInvId);  // Export UTgPlayerController::execServerUpgradeItem(FFrame&, void* const)

native reliable server function ServerSellItem(int nInventoryId);  // Export UTgPlayerController::execServerSellItem(FFrame&, void* const)

native reliable server function ServerPlayVGS(int nVgsId, optional int usedVPSetting=0);  // Export UTgPlayerController::execServerPlayVGS(FFrame&, void* const)

native reliable server function ServerPlayPing(float X, float Y, float Z, TgObject.PING_TYPE pingType);  // Export UTgPlayerController::execServerPlayPing(FFrame&, void* const)

native reliable client simulated function FadeHud();  // Export UTgPlayerController::execFadeHud(FFrame&, void* const)

native reliable client simulated function ClientLogoff(bool bForced);  // Export UTgPlayerController::execClientLogoff(FFrame&, void* const)

native function LogTutorialAction(int nPlayerAction, int nEventData);  // Export UTgPlayerController::execLogTutorialAction(FFrame&, void* const)

native function TriggerTutorialEvent(int nTutEvent, int nInfoData);  // Export UTgPlayerController::execTriggerTutorialEvent(FFrame&, void* const)

native function HandleForcedClientTutorialAction(int nAction, int nActionElement);  // Export UTgPlayerController::execHandleForcedClientTutorialAction(FFrame&, void* const)

native function HandleTutorialHighlighter(bool bShow, int highlightedElement);  // Export UTgPlayerController::execHandleTutorialHighlighter(FFrame&, void* const)

native function bool HandleTutorialActionOnServer(TgSeqAct_ForceClientTutorialAction inAction);  // Export UTgPlayerController::execHandleTutorialActionOnServer(FFrame&, void* const)

native function bool IsTutorialBlockingAction(TgObject.eTutorialForceableElements Action);  // Export UTgPlayerController::execIsTutorialBlockingAction(FFrame&, void* const)

native function OnSceneLoadChange(string SceneName, bool bLoaded);  // Export UTgPlayerController::execOnSceneLoadChange(FFrame&, void* const)

native function UpdateTargetingList(array<ImpactInfo> ImpactList, optional bool bLightUp=true);  // Export UTgPlayerController::execUpdateTargetingList(FFrame&, void* const)

native function ClearTargetingList();  // Export UTgPlayerController::execClearTargetingList(FFrame&, void* const)

native function ToggleMiniMapPing(bool bStart);  // Export UTgPlayerController::execToggleMiniMapPing(FFrame&, void* const)

native function UpdatePlayerVitalsUI();  // Export UTgPlayerController::execUpdatePlayerVitalsUI(FFrame&, void* const)

native function UpdateTransitionUI();  // Export UTgPlayerController::execUpdateTransitionUI(FFrame&, void* const)

native function SetHUDOverlay(TgPlayerController.EHUDOverlay eOverlay);  // Export UTgPlayerController::execSetHUDOverlay(FFrame&, void* const)

native function SetSniperChargedMeter(float fPercent);  // Export UTgPlayerController::execSetSniperChargedMeter(FFrame&, void* const)

native function SetBinocularSettings(BinocularSettings BinocSettings);  // Export UTgPlayerController::execSetBinocularSettings(FFrame&, void* const)

native function ShowRespawnBuyback(int nCost);  // Export UTgPlayerController::execShowRespawnBuyback(FFrame&, void* const)

native function SendCombatMessage(CombatMessageInfo msgInfo);  // Export UTgPlayerController::execSendCombatMessage(FFrame&, void* const)

native event KickWarning();  // Export UTgPlayerController::execKickWarning(FFrame&, void* const)

native exec function SpectateGM(string sPlayerName, optional string sSpectatePassword);  // Export UTgPlayerController::execSpectateGM(FFrame&, void* const)

native exec function Spectate(string sPlayerName, optional string sSpectatePassword);  // Export UTgPlayerController::execSpectate(FFrame&, void* const)

native exec function SpectateStop();  // Export UTgPlayerController::execSpectateStop(FFrame&, void* const)

native function bool IsLocalPlayerController();  // Export UTgPlayerController::execIsLocalPlayerController(FFrame&, void* const)

native exec function ResetKeysToDefault(bool bSpectator);  // Export UTgPlayerController::execResetKeysToDefault(FFrame&, void* const)

native function UpdateRuntimeInput(bool bSpectator);  // Export UTgPlayerController::execUpdateRuntimeInput(FFrame&, void* const)

native function UpdateKeybindsUI();  // Export UTgPlayerController::execUpdateKeybindsUI(FFrame&, void* const)

native function StartFX();  // Export UTgPlayerController::execStartFX(FFrame&, void* const)

native function PlayEventFX();  // Export UTgPlayerController::execPlayEventFX(FFrame&, void* const)

native function CheckHealthFX(float fCurrent, float fMaximum);  // Export UTgPlayerController::execCheckHealthFX(FFrame&, void* const)

native function ClientAddCheats();  // Export UTgPlayerController::execClientAddCheats(FFrame&, void* const)

native function SendContextNotifyVGS(int ContextId);  // Export UTgPlayerController::execSendContextNotifyVGS(FFrame&, void* const)

native unreliable server function ServerPlayContextNotify(int ContextId, Vector NotifyLocation);  // Export UTgPlayerController::execServerPlayContextNotify(FFrame&, void* const)

native reliable server function ServerGiveCard(int nDeviceId);  // Export UTgPlayerController::execServerGiveCard(FFrame&, void* const)

native reliable server function ServerRequestGraphData();  // Export UTgPlayerController::execServerRequestGraphData(FFrame&, void* const)

native function AchievementPossess(Pawn aPawn);  // Export UTgPlayerController::execAchievementPossess(FFrame&, void* const)

native function AchievementUnPossess();  // Export UTgPlayerController::execAchievementUnPossess(FFrame&, void* const)

native function AchievementAchievedById(int nActivityId);  // Export UTgPlayerController::execAchievementAchievedById(FFrame&, void* const)

native function AchievementModifiedHealthProp(int nHealth, int nMaxHealth);  // Export UTgPlayerController::execAchievementModifiedHealthProp(FFrame&, void* const)

native function SetSelectedTalent(int nBotId, int nDeviceIndex);  // Export UTgPlayerController::execSetSelectedTalent(FFrame&, void* const)

native function SetSelectedDeck(int nBotId, int nIndex);  // Export UTgPlayerController::execSetSelectedDeck(FFrame&, void* const)

native function SetRewardValues(int XP, int nCredits, Actor Source, optional TgObject.ERewardValueType RewardType=0, optional bool bFlankKill=false);  // Export UTgPlayerController::execSetRewardValues(FFrame&, void* const)

native function bool OnRequestCard(int nDeviceId, int nRank);  // Export UTgPlayerController::execOnRequestCard(FFrame&, void* const)

native function OnRequestTalent(int nDeviceId);  // Export UTgPlayerController::execOnRequestTalent(FFrame&, void* const)

native function OnRequestDeck(int nDeviceId);  // Export UTgPlayerController::execOnRequestDeck(FFrame&, void* const)

native function UIFade(bool bFade, optional float fTime=0.2500000, optional float fDelay=0.0000000, optional float FailSafeTime=5.0000000);  // Export UTgPlayerController::execUIFade(FFrame&, void* const)

native function UIFadeEndOfRound(bool bFade, optional float fTime=0.2500000, optional float fDelay=0.0000000, optional float FailSafeTime=5.0000000);  // Export UTgPlayerController::execUIFadeEndOfRound(FFrame&, void* const)

native function OnScoredPoints(int nValue, TgObject.ERewardValueType eType, int nPlayerId);  // Export UTgPlayerController::execOnScoredPoints(FFrame&, void* const)

native function Actor GetBestKillCamTarget();  // Export UTgPlayerController::execGetBestKillCamTarget(FFrame&, void* const)

native function bool IsConfused();  // Export UTgPlayerController::execIsConfused(FFrame&, void* const)

native function bool ShouldHideUIWorldOverlay();  // Export UTgPlayerController::execShouldHideUIWorldOverlay(FFrame&, void* const)

native function bool Wants3P();  // Export UTgPlayerController::execWants3P(FFrame&, void* const)

native function RefreshLastActiveTime();  // Export UTgPlayerController::execRefreshLastActiveTime(FFrame&, void* const)

native function ShowAutoPurchaseTip();  // Export UTgPlayerController::execShowAutoPurchaseTip(FFrame&, void* const)

native function bool IsTopMenu(string sName);  // Export UTgPlayerController::execIsTopMenu(FFrame&, void* const)

native function CloseHUDMenus();  // Export UTgPlayerController::execCloseHUDMenus(FFrame&, void* const)

native function SetAkWorldTimeDilation();  // Export UTgPlayerController::execSetAkWorldTimeDilation(FFrame&, void* const)

native function UpdateMinimap(TgMapBoundsVolume pMapBoundsVolume);  // Export UTgPlayerController::execUpdateMinimap(FFrame&, void* const)

native function bool CanPlayKillCam(bool bPlayOfGame);  // Export UTgPlayerController::execCanPlayKillCam(FFrame&, void* const)

native exec function NextScoreboardDisplayType();  // Export UTgPlayerController::execNextScoreboardDisplayType(FFrame&, void* const)

native function SetReticleVisibility(bool bShowReticle, bool bShowReticleAccessories);  // Export UTgPlayerController::execSetReticleVisibility(FFrame&, void* const)

native function NotifyUpdatedInhandAmmoCount(int nAmmo, TgDevice pDevice, int nDeviceId);  // Export UTgPlayerController::execNotifyUpdatedInhandAmmoCount(FFrame&, void* const)

native function MaterialInstanceConstant GetMICResource(int nResourceId);  // Export UTgPlayerController::execGetMICResource(FFrame&, void* const)

native function TestCrashReport();  // Export UTgPlayerController::execTestCrashReport(FFrame&, void* const)

native function SetNWCondition(int nPktLoss, int nPktLag);  // Export UTgPlayerController::execSetNWCondition(FFrame&, void* const)

native function float StartReviveTimer(optional bool bDoNotUpdateStatsTracker);  // Export UTgPlayerController::execStartReviveTimer(FFrame&, void* const)

native function bool OnRespawnRuleChanged();  // Export UTgPlayerController::execOnRespawnRuleChanged(FFrame&, void* const)

native function SetLevel(int nLevel);  // Export UTgPlayerController::execSetLevel(FFrame&, void* const)

native function SetPlayerProfile(int nProfileId, int nSkinId, int nWeaponSkinId, int nHeadSkinId, optional int nVoicePackId=0);  // Export UTgPlayerController::execSetPlayerProfile(FFrame&, void* const)

native function SetPlayerWard(int nWardSkinId);  // Export UTgPlayerController::execSetPlayerWard(FFrame&, void* const)

native function ReloadKeybindsForPawn();  // Export UTgPlayerController::execReloadKeybindsForPawn(FFrame&, void* const)

native simulated function SetAudioFriendlyAndLocal();  // Export UTgPlayerController::execSetAudioFriendlyAndLocal(FFrame&, void* const)

native unreliable server function ServerMove(float TimeStamp, vector InAccel, vector ClientLoc, byte MoveFlags, byte ClientRoll, int View);  // Export UTgPlayerController::execServerMove(FFrame&, void* const)

function CallServerMove(SavedMove NewMove, vector ClientLoc, byte ClientRoll, int View, SavedMove OldMove) { }

exec event AllocateDevicePoint(int nDeviceId) { }

function Logoff(bool bForced) { }

unreliable client simulated function ClientPlaySound(SoundCue ASound) { }

unreliable client simulated function ClientPlaySoundBase(AkBaseSoundObject ASound) { }

reliable client simulated event ClientShowRespawnBuyback(int nCost) { }

event RequestShowRespawnBuyback() { }

function ShowRespawnTimerExpired() { }

exec function SetTaskforceLead(string fsName) { }

exec function ShowBinoculars(bool bShow) { }

function SetCanChangeLoadout(bool bCanChangeLoadout) { }

function SetCanPurchaseFlag(bool bCanPurchase) { }

exec event SetAutoPurchase(bool bAutoPurchase) { }

reliable server function ServerSetAutoPurchase(bool bAutoPurchase) { }

exec event SetAutoSkillUp(bool bAutoSkill) { }

reliable server function ServerSetAutoSkillUp(bool bAutoSkill) { }

exec event SetToggleZoom(bool bToggleZoom) { }

reliable server function ServerSetToggleZoom(bool bToggleZoom) { }

native function AddKillAlert(string KilledName, string KillerName, bool KillerWasPlayer);  // Export UTgPlayerController::execAddKillAlert(FFrame&, void* const)

native function AddAssistAlert(string KilledName, string KillerName);  // Export UTgPlayerController::execAddAssistAlert(FFrame&, void* const)

native function AddAutoKickAlert();  // Export UTgPlayerController::execAddAutoKickAlert(FFrame&, void* const)

exec function WhereAmI() { }

exec function TestScreenCapturePostProcess() { }

function RemoveScreenCapturePostProcess() { }

simulated exec event CauseClientEvent(optional name EventName) { }

exec function CCE(optional name EventName) { }

exec function OnLeftMousePressed() { }

exec function OnLeftMouseReleased() { }

exec function OnRightMousePressed() { }

exec function OnRightMouseReleased() { }

simulated function bool PingMap(Vector WorldLocation, const out array<ReplicationInfo> worldActorRepInfos, TgObject.PING_TYPE Type) { }

reliable server function ServerSetViewTarget(Actor me) { }

function SetCorrectViewTarget() { }

exec function StartWatchOthers(optional TgPlayerController.EWatchOtherPlayersMode Mode=1) { }

exec function StopWatchOthers() { }

reliable server function ServerWatchOtherPlayer(TgPlayerController.EWatchOtherPlayersMode Mode) { }

unreliable server function ServerViewSelf(optional ViewTargetTransitionParams TransitionParams) { }

exec function ToggleRove() { }

reliable server function ServerRove(bool bOn) { }

reliable client simulated event ClientSetRotationAndDesired(Rotator NewRotation, optional bool bResetCamera) { }

unreliable client simulated function ClientPingMap(Vector WorldLoc, TgObject.PING_TYPE pingType) { }

native function AddAlertScript(TgObject.AlertPriority Priority, TgObject.AlertType Type, float fDuration, int nMsgId, optional bool bBlockDuplicates=false);  // Export UTgPlayerController::execAddAlertScript(FFrame&, void* const)

native function RemoveAlertScript(int nMsgId);  // Export UTgPlayerController::execRemoveAlertScript(FFrame&, void* const)

exec function SelfAlert(int nPriority, float fDuration, int nMsgId) { }

exec function ServerProfileScript(string Command) { }

reliable server function ServerProfiling(string Command) { }

exec event PressJump(bool bOn) { }

exec event ClientPurchaseItem(int nLootTableId, int nLootTableItemId, int nItemCount) { }

exec event ClientSellItem(int nInventoryId) { }

simulated event Destroyed() { }

function InitPlayerReplicationInfo() { }

function CleanupPRI() { }

event CopyPropertiesTo(Controller C) { }

event PreRender(Canvas Canvas) { }

function SetControlModuleOnPossess() { }

function AcknowledgePossession(Pawn P) { }

reliable server function ServerAcknowledgePossession(Pawn P) { }

event Possess(Pawn aPawn, bool bVehicleTransition) { }

event UnPossess() { }

function NotifyChangedWeapon(Weapon PreviousWeapon, Weapon NewWeapon) { }

function NotifyTakeHit(Controller InstigatedBy, vector HitLocation, int Damage, class<DamageType> damageType, vector Momentum) { }

unreliable client simulated function ClientPlayTakeHit(Rotator HitDir, int Damage, Class<DamageType> DamageType) { }

function NotifyBodyUnderAttack(byte Damage) { }

reliable client simulated function ClientNotifyBodyUnderAttack(byte Damage) { }

simulated function NotifyInBombRange() { }

simulated function CancelInBombRange() { }

event RestartPlayerOnTransfer() { }

reliable server function ServerLadderLetGo() { }

function LadderLetGo() { }

event Revive() { }

function LiveRespawn(bool bResetHealth, bool bResetDevices) { }

function ReviveTimer() { }

function ViewPlayersTimer() { }

simulated function FadeForViewPlayersTimer() { }

event DisplayKillingBlowGameTip(CombatMessageInfo Info) { }

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos) { }

function OnToggleCinematicMode(SeqAct_ToggleCinematicMode Action) { }

function SetCinematicMode(bool bInCinematicMode, bool bHidePlayer, bool bAffectsHUD, bool bAffectsMovement, bool bAffectsTurning, bool bAffectsButtons) { }

reliable client simulated function ClientSetCinematicMode(bool bInCinematicMode, bool bAffectsMovement, bool bAffectsTurning, bool bAffectsHUD) { }

function Reset() { }

reliable client simulated event ClientReset() { }

exec function SetRadius(float NewRadius) { }

function bool UsingFirstPersonCamera() { }

simulated event GetAimingViewPoint(out Vector POVLocation, out Rotator POVRotation) { }

simulated event GetPlayerViewPoint(out vector out_Location, out Rotator out_rotation) { }

reliable client simulated function ClientSetHUD(class<HUD> newHUDType) { }

function AddPostRenderActors() { }

function bool AllowVoiceMessage(name MessageType) { }

singular function EnterStartState() { }

reliable client simulated function ClientEnterStartState() { }

function int BlendRot(float DeltaTime, int BlendC, int NewC) { }

event float GetFOVAngle() { }

unreliable server function ServerViewNextPlayer() { }

unreliable server function ServerViewPrevPlayer() { }

function HandleViewTargetOnAdjustPosition() { }

function ServerViewAPlayer(int Dir, optional bool bFriendlyOnly) { }

exec function ViewPlayerByName(string PlayerName) { }

exec event DoSetViewTarget(Actor NewTarget) { }

reliable server function ServerViewPlayerByName(string PlayerName) { }

function TgCameraModule GetCurrentCameraModule() { }

exec function zoomIn() { }

exec function ZoomOut() { }

unreliable server function ServerSetZoomFactor(float fZoom) { }

exec function ShowPathToNearestPOI() { }

simulated function OnNavIndicator(TgSeqAct_NavIndicator Action) { }

simulated function OnPingMinimap(TgSeqAct_PingMinimap Action) { }

simulated event TutorialMessage(int msgId, bool bTip) { }

reliable client simulated function ClientShowPathTo(Actor destActor) { }

simulated event ShowPathTo(Actor destActor) { }

native function AddNavFailedAlert(optional bool bAlreadyThere=false);  // Export UTgPlayerController::execAddNavFailedAlert(FFrame&, void* const)

exec function GoSpectate() { }

function FindGoodView() { }

event SendClientSetGameWinState(TgObject.GAME_WIN_STATE gameWinState) { }

reliable client simulated function ClientSetGameWinState(TgObject.GAME_WIN_STATE gameWinState) { }

simulated function PrepareIntro() { }

simulated function PlayIntro() { }

reliable client simulated function ClientPlayIntro() { }

reliable client simulated event ClientFinishIntro() { }

function FinishIntro() { }

event ResetPlayer() { }

function SetupIntro() { }

function EndIntro() { }

function GameHasEnded(optional Actor EndGameFocus, optional bool bIsWinner) { }

reliable client simulated function ClientGameEnded(Actor EndGameFocus, bool bIsWinner) { }

function float GetOutroTime() { }

exec function Talk() { }

exec function TeamTalk() { }

function SetPlayerTeam(TeamInfo NewTeam) { }

native function bool IsForceFeedbackEnabled();  // Export UTgPlayerController::execIsForceFeedbackEnabled(FFrame&, void* const)

event InitInputSystem() { }

event PlayerTick(float DeltaTime) { }

function GoAFKTimer() { }

unreliable server function ServerToggleAFK(bool bEnabled) { }

function bool CanAFK(TgPawn ThePawn) { }

exec function DisplayHiddenActors(optional float Time) { }

function DisplayHiddenActorsTimer() { }

reliable client simulated function ClientSetOnlineStatus() { }

simulated event Rotator ApplyAimVectorModification(TgDevice Device, Rotator InRotation) { }

simulated function Rotator GetAdjustedAimFor(Weapon W, vector StartFireLoc) { }

function bool IsTargetInFrontOfPawn(Vector TargetLocation) { }

function bool IsTargetInPawnAim(Vector TargetLocation, float MaxAimFeetOffset) { }

function bool IsTargetDied(Actor TargetActor) { }

function bool IsValidTarget(Actor HoverActor) { }

function TgDeviceFire GetEqPointDevFire() { }

function TgDevice GetEqPointDevice(TgObject.TG_EQUIP_POINT eEqPoint) { }

simulated function TgObject.TG_EQUIP_POINT GetCurrentEqPoint() { }

simulated function int GetCurrentDeviceType() { }

reliable server function ServerToggleSceneCaptureState() { }

simulated function ShowChampionOverviewTip() { }

simulated event PostBeginPlay() { }

simulated function SwitchControl(Class<TgControlModule> ControlModuleClass) { }

exec function SwitchCamera(string sCamera) { }

function int PushCameraPosture(TgPlayerController.TG_CAMERAPOSTURE eCamPosture) { }

function bool PopCameraPosture(int nStackId) { }

function OnCameraPostureChange() { }

simulated event ReceivedPlayer() { }

simulated event OnSettingsChanged(TgClientSettings Settings, optional int settingsType) { }

exec function EnableColorBlindEffect(optional bool bEnable=true, optional int Type=1, optional bool bSimulate=false) { }

simulated function UpdateAssistModeSubLevel() { }

event NotifyJumpApex() { }

function CheckJumpOrDuck() { }

exec function SetReadyToPlay() { }

reliable server function ServerSetReadyToPlay() { }

reliable client simulated function ClientSetReadyState(bool bReadyToPlay) { }

function PawnDied(Pawn P) { }

simulated function OnCanPurchaseItemChange() { }

simulated event UpdateFirstValidProjIdx() { }

simulated event ReplicatedEvent(name VarName) { }

event name GetStateNameEx() { }

function ViewObjectiveCamerasTimer() { }

reliable client simulated event UpdateReviveTimeRemaining(float fTimeRemaining) { }

simulated function bool CanUseNow() { }

unreliable server function ServerUse() { }

reliable client simulated function ClientUse() { }

function bool ServerPerformedUseAction() { }

function bool ClientPerformedUseAction() { }

function OnRestartPlayers(TgSeqAct_RestartPlayers inAction) { }

function bool ShouldStunChangePhysics() { }

reliable client simulated function ClientResetStunnedBehavior(bool bStunController, optional Controller.EStunType eType) { }

simulated function Stun(bool bStunController, optional Controller.EStunType eType=0) { }

function StunTypeChanged() { }

exec function GotoFly() { }

reliable server function ServerGotoFly() { }

exec function KillPets() { }

reliable server function ServerKillPets() { }

reliable client simulated function ClientSetValue(string strObject, string strVariable, string StrValue) { }

reliable server function ServerSetValue(string strObject, string strVariable, string StrValue) { }

reliable client simulated function ClientGetValue(string strObject, string strVariable) { }

reliable server function ServerGetValue(string strObject, string strVariable) { }

exec function SetClientValue(string strObject, string strVariable, string StrValue) { }

exec function SetServerValue(string strObject, string strVariable, string StrValue) { }

exec function GetClientValue(string strObject, string strVariable) { }

exec function GetServerValue(string strObject, string strVariable) { }

exec function StorePlayOfGame(optional float Begin=-5.0000000, optional float End=2.0000000) { }

reliable server function ServerStorePlayOfGame(float Begin, float End) { }

native function SavePlayOfGame(float Begin, float End);  // Export UTgPlayerController::execSavePlayOfGame(FFrame&, void* const)

exec function StartTimelapse(optional float Begin=-5.0000000, optional float End=2.0000000, optional bool bPlayOfGame=false, optional bool bForced=true) { }

reliable server function ServerStartTimelapse(float Begin, float End, bool bPlayOfGame, optional bool bForced=false) { }

native function StartTimelapsePlayback(float BeginTimeOffset, float EndTimeOffset, optional bool bPlayOfGame);  // Export UTgPlayerController::execStartTimelapsePlayback(FFrame&, void* const)

function StartPlayOfTheGamePlaybackDelayed() { }

event StartPlayOfGamePlayback() { }

native reliable client simulated function ClientDebugPlayPotg();  // Export UTgPlayerController::execClientDebugPlayPotg(FFrame&, void* const)

event ControllerPreTimeLapse() { }

event ControllerPostTimeLapse() { }

native function OnPreTimeLapse();  // Export UTgPlayerController::execOnPreTimeLapse(FFrame&, void* const)

native function OnPostTimeLapse();  // Export UTgPlayerController::execOnPostTimeLapse(FFrame&, void* const)

simulated function DestroySimulatedProjectiles() { }

event NotifyDirectorControl(bool bNowControlling, SeqAct_Interp CurrentMatinee) { }

simulated event ClientKillCurrentDirectorMatinee() { }

reliable server function ServerKillCurrentDirectorMatinee() { }

native simulated function KillCurrentDirectorMatinee();  // Export UTgPlayerController::execKillCurrentDirectorMatinee(FFrame&, void* const)

function SetKillCamTarget(TgPawn KillCamTarget) { }

reliable client simulated function ClientSetKillCamTarget(int KillCamTargetId, int BackupKillCamTargetId) { }

function ClearKillCamTarget() { }

function ForceKillCamViewTargetChange(optional Actor ForceTarget) { }

reliable server function ServerSkipKillCam() { }

native function EndTimelapsePlayback();  // Export UTgPlayerController::execEndTimelapsePlayback(FFrame&, void* const)

exec event SkipKillCam() { }

exec function ViewNextTeammate() { }

exec function ViewPreviousTeammate() { }

reliable server function ServerCycleTeammateView(bool bForward) { }

function TgRepInfo_TaskForce GetTFRI() { }

simulated function bool CanPlayerMove(Pawn P) { }

exec function TestCrash() { }

exec function DumpClassInfo(string sClassName) { }

simulated function SpeakTTS(coerce string S, optional PlayerReplicationInfo PRI) { }

simulated function bool CanCommunicate() { }

reliable server event ServerUpdateStats() { }

event CheatFly(bool bOn) { }

reliable client simulated function ClientCheatFly(bool bOn) { }

exec function Camera(name NewMode) { }

reliable server function ServerCamera(name NewMode) { }

reliable client simulated function ClientSetCameraMode(name NewCamMode) { }

simulated function OnClientLoadDevices(TgSeqAct_ClientLoadDevices Action) { }

exec function DoFade(bool bInToGameplay, float Time) { }

exec function Cloth(bool bEnabled) { }

function OnTgCameraShake(TgSeqAct_TgCameraShake inAction) { }

exec function TestTgCameraShake(TgCameraShake CameraShake) { }

event PlayTgCameraShake(TgCameraShake CameraShake, Vector Epicenter, Actor ShakeInstigator) { }

event StopTgCameraShake(TgCameraShake CameraShake) { }

exec function TestShake(int Index) { }

function OnTutorialPlayerAction(TgSeqAct_LogTutorialAction inAction) { }

reliable server function ServerNotifyTutorialUIEvent(int Evt, int evtData) { }

exec event ClientNotifyTutorialUIEvent(int Evt, int evtData) { }

function OnForceClientTutorialAction(TgSeqAct_ForceClientTutorialAction inAction) { }

function OnTutorialHighlighter(TgSeqAct_TutorialHighlighter inAction) { }

reliable client simulated function ClientForceTutorialAction(int Action, int ActionElement) { }

reliable client simulated function ClientTutorialHighlighter(bool bShow, int highlightedElement) { }

native function GivePlayerFullVitals();  // Export UTgPlayerController::execGivePlayerFullVitals(FFrame&, void* const)

function OnGiveFullVitals(TgSeqAct_GiveFullVitals inAction) { }

exec function AllocateAbilitySkillPoint(TgObject.TG_EQUIP_POINT eqp) { }

event DeviceOnStartBuildup(TgDevice Device) { }

event DeviceOnStopBuildup(TgDevice Device, bool WasInterrupted) { }

event DeviceOnStartFire(TgDevice Device) { }

event DeviceOnStopFire(TgDevice Device, bool WasInterrupted) { }

exec function OnRespawnBeaconButtonPressed() { }

exec function OnRespawnBeaconButtonReleased() { }

exec function OnFlourish() { }

exec function OnPerCharacterAltPressed() { }

native exec function bool OnOffhandSlotPressed(TgObject.TG_EQUIP_POINT eqp);  // Export UTgPlayerController::execOnOffhandSlotPressed(FFrame&, void* const)

native exec function bool OnOffhandSlotReleased(TgObject.TG_EQUIP_POINT eqp);  // Export UTgPlayerController::execOnOffhandSlotReleased(FFrame&, void* const)

exec event bool OnDefaultCastOffhandSlotPressed(TgObject.TG_EQUIP_POINT eqp) { }

exec event bool OnDefaultCastOffhandSlotReleased(TgObject.TG_EQUIP_POINT eqp) { }

exec event bool OnQuickCastOffhandSlotPressed(TgObject.TG_EQUIP_POINT eqp) { }

exec event bool OnQuickCastOffhandSlotReleased(TgObject.TG_EQUIP_POINT eqp) { }

exec event bool OnInstantCastOffhandSlotPressed(TgObject.TG_EQUIP_POINT eqp) { }

exec event ClientPlayVGS(int nId, optional int usedVPSetting=0) { }

exec event ClientPlayPing(float X, float Y, float Z, TgObject.PING_TYPE pingType) { }

exec event ClientSurrender(optional bool bSurrender=true) { }

reliable server function ServerSurrender(bool bSurrender) { }

simulated event UpdateLockedTarget(Actor LockedActor) { }

exec function RequestScoreBoard() { }

exec function SuppressHelpText() { }

exec function ResetGameTips() { }

reliable server function ServerRequestScoreBoard() { }

reliable server function ServerToggleAIDebug(Actor Target) { }

native function bool AllowRagdoll();  // Export UTgPlayerController::execAllowRagdoll(FFrame&, void* const)

native function AllowRagdollUpdated();  // Export UTgPlayerController::execAllowRagdollUpdated(FFrame&, void* const)

native exec function SetAllowParticleSystems(bool Value);  // Export UTgPlayerController::execSetAllowParticleSystems(FFrame&, void* const)

native exec function SetAllowAnimationFrameRateLOD(bool Value, optional float lLODDistanceFactor, optional int lLODFrameRate);  // Export UTgPlayerController::execSetAllowAnimationFrameRateLOD(FFrame&, void* const)

reliable client simulated function PlayTutorialAnnouncement(int SoundIndex, SoundCue OptionalCue, optional bool bPlayImmediately=false, optional bool bFlushOthers=false) { }

exec function DropFlag() { }

reliable server function ServerDropFlag() { }

reliable client simulated event ArenaCrowdEvent(byte EventType) { }

simulated function OnScoreChange(int nTeam) { }

exec function IgnoreOverlays(bool bIgnore) { }

reliable client simulated function InsertAdditionalPostProcess(PostProcessChain PP, optional bool bAlterMeshDepth, optional TgPawn OtherDepthTarget) { }

reliable client simulated function RemoveAdditionalPostProcess(PostProcessChain PP, optional TgPawn OtherDepthTarget) { }

event TgPlayerInput GetPlayerInputClass() { }

event TgSpectatorInput GetSpectatorInputClass() { }

exec function UnbindCommandPC(bool bSpectator, int nAlternate, string Command) { }

exec function UnbindCommandAllPC(bool bSpectator, string Command) { }

exec function SetBindPC(bool bSpectator, string ExtendedBinding, string Command) { }

exec event SetCommandBindPC(bool bSpectator, int nAlternate, string ExtendedBinding, string Command) { }

event bool IsPawnWithin(Pawn aPawn, float Distance) { }

exec function ToggleDetailedView() { }

reliable client simulated event PlayEpicFatality(byte TaskForceNumber, int MeshAsmId) { }

event EnableContextNotify(int ContextId) { }

event ReceivedContextNotify(int ContextId, Vector NotifyLocation, bool bEnemy) { }

reliable client simulated event ClientPlayRoadkillNotify() { }

exec function DoJump() { }

exec function HoldJump() { }

exec function OnJumpRelease() { }

exec function OnJumpHeldAltPressed() { }

exec function ToggleSprint() { }

simulated event SetBehindView(bool bNewBehindView) { }

function HandleWalking() { }

simulated exec function ReloadWeapon() { }

simulated exec function SSF(optional bool bSprint=true, optional bool bMinimapTeamVisibility=false, optional float DamageMultiplier=1.0000000, optional bool bForce3P=false, optional bool bForce1P=false, optional bool bOutOfCombatSprint=false) { }

simulated exec function SetServerFlags(optional bool bSprint=true, optional bool bMinimapTeamVisibility=false, optional float DamageMultiplier=1.0000000, optional bool bForce3P=false, optional bool bForce1P=false, optional bool bOutOfCombatSprint=false) { }

reliable server function ServerSetServerFlags(bool bSprint, bool bMinimapTeamVisibility, float DamageMultiplier, bool bForce3P, bool bForce1P, bool bOutOfCombatSprint) { }

exec function AutoMelee(bool bEnabled) { }

reliable server function ServerAutoMelee(bool bEnabled) { }

reliable server event ServerRequestCard(int nDeviceId, int nRank) { }

reliable server event ServerRequestTalent(int nDeviceId) { }

reliable client simulated event ClientChangedTalent(int nBotId, int nDeviceId) { }

reliable server event ServerRequestDeck(int nIndex) { }

reliable client simulated event ClientChangedDeck(int nBotId, int nDeckIndex) { }

event OnDeckUpdatedOnServer(int nBotId, int nDeckIndex) { }

event OnCardSelection(TgDevice pDevice) { }

exec event FrontFacingCamera(bool bEnabled) { }

exec function SetOutlines(bool bFriendly, bool bEnemy) { }

exec function SetJumpZ(float NewJumpZ) { }

reliable server function ServerSetJumpZ(float NewJumpZ) { }

reliable client simulated function ClientUpdateRoundEndedTimer(float RoundEndTimeRemaining, float RoundEndTotalTime) { }

reliable client simulated function ClientUpdateRoundSetupTimer(float SetupTimeRemaining) { }

reliable client simulated function ClientOnRoundEnded() { }

reliable client simulated function ClientOnRoundObjectivesCompleted() { }

reliable client simulated function SetTimeDilation(float DesiredDilation, float SecondsToInterpolate) { }

reliable client simulated function SetDesaturation(float DesiredDesaturation, float SecondsToInterpolate) { }

reliable client simulated function ClientOnRoundSetupStarted(bool bForceOpenCardMenu) { }

simulated function TorvaldCheck() { }

simulated function OpenUpgradeMenuTimer() { }

reliable client simulated function ClientPlayPointCapturedEffects(TgChaosCapturePoint CapturedPoint, bool bFriendlyCapture) { }

unreliable client simulated function ClientPlayTakeoverSecondPhaseInstructions(bool bFriendlyCapture) { }

function OnControllerChanged(int ControllerId, bool bIsConnected) { }

native function OnLoginStatusChange(OnlineSubsystem.ELoginStatus NewStatus, UniqueNetId NewId);  // Export UTgPlayerController::execOnLoginStatusChange(FFrame&, void* const)

native function OnConnectionStatusChange(OnlineSubsystem.EOnlineServerConnectionStatus ConnectionStatus);  // Export UTgPlayerController::execOnConnectionStatusChange(FFrame&, void* const)

native function OnCurrentUserChanged(byte LocalUserNum, string CurrentUser, string LoggedInUser);  // Export UTgPlayerController::execOnCurrentUserChanged(FFrame&, void* const)

native function OnRemoteTalkerStatusChange(UniqueNetId RemoteNetId, bool bIsTalking);  // Export UTgPlayerController::execOnRemoteTalkerStatusChange(FFrame&, void* const)

native function ShowControllerDisconnectedWarning();  // Export UTgPlayerController::execShowControllerDisconnectedWarning(FFrame&, void* const)

native function ShowCurrentUserChangeWarning(string CurrentUser, string LoggedInUser);  // Export UTgPlayerController::execShowCurrentUserChangeWarning(FFrame&, void* const)

native function ShowNoFriendsForPartyInviteWarning();  // Export UTgPlayerController::execShowNoFriendsForPartyInviteWarning(FFrame&, void* const)

native function ShowUnableToReadFriendsListWarning();  // Export UTgPlayerController::execShowUnableToReadFriendsListWarning(FFrame&, void* const)

native function ShowPartyFullWarning(bool bPartySession);  // Export UTgPlayerController::execShowPartyFullWarning(FFrame&, void* const)

native function ShowPartyNoLongerAvailableWarning();  // Export UTgPlayerController::execShowPartyNoLongerAvailableWarning(FFrame&, void* const)

native function ShowPackageNotInstalledForPartyInviteWarning();  // Export UTgPlayerController::execShowPackageNotInstalledForPartyInviteWarning(FFrame&, void* const)

native function ShowCustomGameDisallowedPopup();  // Export UTgPlayerController::execShowCustomGameDisallowedPopup(FFrame&, void* const)

native function bool IsInGame();  // Export UTgPlayerController::execIsInGame(FFrame&, void* const)

native function LogoutPlayer();  // Export UTgPlayerController::execLogoutPlayer(FFrame&, void* const)

native function bool TryAutoLogin();  // Export UTgPlayerController::execTryAutoLogin(FFrame&, void* const)

native function BlockPartySceneInput(bool bBlockInput);  // Export UTgPlayerController::execBlockPartySceneInput(FFrame&, void* const)

native function TryOpenPartyUI();  // Export UTgPlayerController::execTryOpenPartyUI(FFrame&, void* const)

native function UpdatePartyUI();  // Export UTgPlayerController::execUpdatePartyUI(FFrame&, void* const)

native function OnAllMarketplaceProductDetailsRead();  // Export UTgPlayerController::execOnAllMarketplaceProductDetailsRead(FFrame&, void* const)

function ShowPathfinder(bool bEnabled, float interval) { }

function SpawnPathfinder() { }

function Vector GetPathfinderStartLocation(float StartDist) { }

function Actor GetPathfinderTarget() { }

unreliable client simulated event ClientRequestHelpText(int HelpTipId) { }

exec function TestHelpTip(int HelpTipId) { }

exec function SetBlur(float TargetBlurAmount, float InterpSpeed, float BlurKernelSize) { }

function DebugNextPlayerStart() { }

function DebugEnableAllAI() { }

function DebugDisableAllAI() { }

exec function FireDebugConsoleKismetTestNode() { }

unreliable client simulated event ClientOnScoredPoints(int nValue, TgObject.ERewardValueType eType, int nPlayerId) { }

function ShowHit(Actor Target, float DamageAmount, const out ExtraDamageInfo ExtraInfo) { }

native function SendProxyDamageMessage(Actor TargetActor, int DamageAmount, const out ExtraDamageInfo ExtraInfo);  // Export UTgPlayerController::execSendProxyDamageMessage(FFrame&, void* const)

reliable client simulated function ClientSendPayloadMissionEvent(int nEventId, byte nAttackingTaskForce, byte nWinningTaskForce) { }

native function TgPawn GetTgPawn();  // Export UTgPlayerController::execGetTgPawn(FFrame&, void* const)

native function TgRepInfo_Player GetCurrentPRI();  // Export UTgPlayerController::execGetCurrentPRI(FFrame&, void* const)

event UpdateClientFOV() { }

function ClientUpdatePosition() { }

function SavePositionForSmoothServerCorrection() { }

function UpdateCameraForServerCorrectionSmoothing() { }

function bool ShouldInterpolateMovementCorrections() { }

event SetNoSmoothedMovementCorrection(bool bNoSmoothedCorrections, optional bool bManaged=false) { }

event SendClientAdjustment() { }

unreliable server function ServerAckNoSmoothCorrection(float TimeStamp) { }

simulated function RecievedServerMovement(float TimeStamp, bool bNoInterp) { }

unreliable client simulated function LongClientAdjustPositionNoInterp(float TimeStamp, name NewState, Actor.EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, float NewVelX, float NewVelY, float NewVelZ, Actor NewBase, float NewFloorX, float NewFloorY, float NewFloorZ) { }

unreliable client simulated function LongClientAdjustPosition(float TimeStamp, name newState, EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, float NewVelX, float NewVelY, float NewVelZ, Actor NewBase, float NewFloorX, float NewFloorY, float NewFloorZ) { }

unreliable client simulated function ClientAdjustPositionNoInterp(float TimeStamp, name NewState, Actor.EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, float NewVelX, float NewVelY, float NewVelZ, Actor NewBase) { }

unreliable client simulated function ClientAdjustPosition(float TimeStamp, name newState, EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, float NewVelX, float NewVelY, float NewVelZ, Actor NewBase) { }

unreliable client simulated function ShortClientAdjustPositionNoInterp(float TimeStamp, name NewState, Actor.EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, Actor NewBase) { }

unreliable client simulated function ShortClientAdjustPosition(float TimeStamp, name newState, EPhysics newPhysics, float NewLocX, float NewLocY, float NewLocZ, Actor NewBase) { }

unreliable client simulated function VeryShortClientAdjustPositionNoInterp(float TimeStamp, float NewLocX, float NewLocY, float NewLocZ, Actor NewBase) { }

unreliable client simulated function VeryShortClientAdjustPosition(float TimeStamp, float NewLocX, float NewLocY, float NewLocZ, Actor NewBase) { }

unreliable client simulated function ClientAckGoodMoveNoInterp(float TimeStamp) { }

unreliable client simulated function ClientAckGoodMove(float TimeStamp) { }

event MoveAutonomous(float DeltaTime, byte CompressedFlags, vector newAccel, rotator DeltaRot) { }

exec function PlayCameraAnim(CameraAnim CamAnim, optional float Rate=1.0000000, optional float Scale=1.0000000, optional float BlendInTime, optional float BlendOutTime, optional bool bLoop, optional bool bRandomStartTime, optional float Duration, optional bool bSingleInstance) { }

simulated function SetViewportLocationAndScale(Vector2D InOrigin, Vector2D InSize) { }

exec function ExecSetViewportLocationAndScale(optional float OriginX=0.0000000, optional float OriginY=0.0000000, optional float SizeX=1.0000000, optional float SizeY=1.0000000) { }

simulated function StartBuyBurnCardsTimer() { }

reliable client simulated function ClientStartBuyBurnCardsTimer() { }

function BuyBurnCards() { }

event bool IsPlayerDead() { }

exec function HideMeshes(bool bHide1PMesh, bool bHide3PMesh) { }

event SendEnergyUpdatedEvent() { }

simulated function bool IsDeviceLockingInput() { }

simulated function bool IsDeviceLockingCamera() { }

simulated function bool IsDeviceLockingRotation() { }

native function TgPlayerController.EPlayerInputType GetInputType(TgObject.TG_EQUIP_POINT eqp);  // Export UTgPlayerController::execGetInputType(FFrame&, void* const)

native function bool IsInputAllowed(TgPlayerController.EPlayerInputType InputType);  // Export UTgPlayerController::execIsInputAllowed(FFrame&, void* const)

native exec function SetInputAllowed(TgPlayerController.EPlayerInputType InputType, bool bEnabled);  // Export UTgPlayerController::execSetInputAllowed(FFrame&, void* const)

simulated function SetAllInputAllowed(bool bEnabled) { }

event InputReceived(TgPlayerController.EPlayerInputType InputType) { }

event OnBurnCardPurchased(TgDevice BurnCard, int nEquipSlot, int nFilledCardSlots) { }

reliable client simulated function ClientUpdateTF1Score(int nScore) { }

reliable client simulated function ClientUpdateTF2Score(int nScore) { }

function int GetCredits() { }

function SetCredits(int nCreditsAmount) { }

function ResetUlt() { }

reliable client simulated function ClientActivateSpawnGates() { }

reliable client simulated function ClientDeactivateSpawnGates() { }

reliable client simulated function ClientToggleSpawnGateTeamColors() { }

reliable client simulated function ClientDeactivateAttackersSpawnGates() { }

reliable client simulated function ClientDeactivateDefendersSpawnGates() { }

event ToggleCaptureProgressAkEvent(bool bEnable) { }

simulated exec function SetServerCorrectionCameraInterpVars(float SnapDist, float MinBaseSpeed, float MaxBaseSpeed, float BaseSpeedMult, float NewInfoWeight, float MinCorrectionMod, float MaxCorrectionMod, float CorrectionModMult) { }

native function SwitchChampion(int BotId, int BodySkinId, int HeadSkinId, int WeaponSkinId, int VoicePackId);  // Export UTgPlayerController::execSwitchChampion(FFrame&, void* const)

simulated exec function LogLocalPropertyValue(int nPropId) { }

event ResetCaptureProgressRTPC() { }

exec function FixAll() { }

exec function Unfix(name BoneName) { }

reliable client simulated event ClientDrawDebugLine(float X, float Y, float Z, float X2, float Y2, float z2, byte R, byte G, byte B) { }

reliable client simulated event ClientDrawDebugBox(float X, float Y, float Z, float extX, float extY, float extZ, byte R, byte G, byte B) { }

reliable client simulated event ClientDrawDebugSphere(float X, float Y, float Z, float Radius, int Segments, byte R, byte G, byte B) { }

exec function EnablePhysics(bool bEnabled) { }

exec function SetPhysicsWeight(float Amount) { }

simulated function bool IsForceFeedbackAllowed() { }

state PlayerWalking {}

state PlayerClimbing {}

state Dead {}

auto state PlayerWaiting {}

state Spectating {}

state RoundEnded {}

state Unconscious {}

defaultproperties
{}
