class TgSpectatorController extends TgPlayerController
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

const MAX_BROADCAST_CHANNELS = 4;

enum SpectatorCameraMode {
    SpecCam_None,  // 0
    SpecCam_Fly,  // 1
    SpecCam_FollowThirdPerson,  // 2
    SpecCam_FollowFirstPerson,  // 3
    SpecCam_FollowTopDown,  // 4
    SpecCam_Camera,  // 5
    SpecCam_Overview,  // 6
    SpecCam_LockedView,  // 7
};

enum SpectatorCameraCycle {
    SpecCycle_None,  // 0
    SpecCycle_PlayerFriendly,  // 1
    SpecCycle_PlayerEnemy,  // 2
    SpecCycle_Player,  // 3
    SpecCycle_TowerFriendly,  // 4
    SpecCycle_TowerEnemy,  // 5
    SpecCycle_Tower,  // 6
    SpecCycle_Cinematic,  // 7
    SpecCycle_Action,  // 8
};

enum SpecFlightMode {
    SFM_Normal,  // 0
    SFM_Heli,  // 1
    SFM_HeliNoVert,  // 2
};

enum ESpectatorMode {
    SPECMODE_Manual,  // 0
    SPECMODE_Director,  // 1
    SPECMODE_Assisted,  // 2
    SPECMODE_Broadcast1,  // 3
    SPECMODE_Broadcast2,  // 4
    SPECMODE_Broadcast3,  // 5
    SPECMODE_Broadcast4,  // 6
};

enum EZoomState {
    ZOOM_None,  // 0
    ZOOM_In,  // 1
    ZOOM_Out,  // 2
};

struct SpectatorBookmark {
    var transient Actor ViewTarget;
    var TgSpectatorController.SpectatorCameraMode ViewMode;
    var TPOV POV;
    structdefaultproperties {}
};

struct BroadcastChannel {
    var TgSpectatorController.ESpectatorMode Channel;
    var int PlayerID;
    structdefaultproperties {}
};

var transient TgSpectatorController.SpectatorCameraMode m_CameraMode;
var transient TgSpectatorController.SpectatorCameraCycle m_CurrentCycle;
var transient TgSpectatorController.SpectatorCameraCycle m_PendingCycle;
var transient TgSpectatorController.SpecFlightMode m_eHelicopterFlight;
var transient TgSpectatorController.ESpectatorMode m_CurrentSpectatorMode;
var transient TgSpectatorController.EZoomState m_CurrentZoomState;
var transient TgSpectatorTempCam m_BookmarkCamera;
var transient SpectatorBookmark m_Bookmarks[10];
var float m_fDefaultTweenTime;
var transient bool m_bOutlineCharacters;
var transient bool m_bIsMapSquashed;
var (Performance) config bool m_bIgnoreCullDistanceVolumes;
var () float m_fNameplateFadeMinDist;
var () float m_fNameplateFadeMaxDist;
var () float m_fNameplateFadeMaxAmount;
var () float m_fNameplateScaleMinDist;
var () float m_fNameplateScaleMaxDist;
var () float m_fNameplateScaleMaxAmount;
var () float m_fInterpolateCameraDistance;
var BroadcastChannel m_BroadcastChannels[4];
var config Vector c_vMouseClickDeprojectionExtent;
var () config float m_fOverviewCenterpointOffset;
var () config float m_fMouseCursorVisibleTime;
var transient float m_fRemainingCursorVisibleTime;

function Class<HUD> GetHudClass(Class<HUD> pNewHudType);  // Export UTgSpectatorController::execGetHudClass(FFrame&, void* const)

function SetNetTarget(QWord qwId, int nTaskForce);  // Export UTgSpectatorController::execSetNetTarget(FFrame&, void* const)

simulated event PostBeginPlay() { }

simulated function ForwardToSpectatingMatch() { }

reliable client simulated function ClientForwardToSpectatingMatch() { }

exec function SwitchCamera(string sCamera) { }

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams) { }

function UpdateViewTargetUI() { }

function bool ShouldFlyFromInput() { }

exec function SetNewSpectatorMode(TgSpectatorController.ESpectatorMode NewMode) { }

exec function SetSpectatorCameraMode(TgSpectatorController.SpectatorCameraMode Mode, optional bool bCameraTween=false) { }

exec function ToggleSpectatorPlayerIcons();  // Export UTgSpectatorController::execToggleSpectatorPlayerIcons(FFrame&, void* const)

reliable client simulated function ClientSetReadyState(bool bReadyToPlay) { }

exec function SetPendingSpecCycle(TgSpectatorController.SpectatorCameraCycle Mode) { }

exec function ClearPendingSpecCycle() { }

function bool InterceptFlashInput(name ButtonName, Object.EInputEvent Event) { }

exec function LockedViewCam(bool bEnabled) { }

function SnapViewToHoverTarget(optional bool bUseAltView=false) { }

simulated function bool PingMap(Vector WorldLocation, const out array<ReplicationInfo> worldActorRepInfo, TgObject.PING_TYPE Type) { }

function SetPendingOnDirectorMode() { }

function SnapViewToLocation(Vector WorldLocation, bool bUseFocalPoint) { }

function CycleNext(optional bool bSkipIfPresent=false, optional bool bReverse=false) { }

function array<Actor> GetViewTargetListForMode(TgSpectatorController.SpectatorCameraCycle cycle) { }

function array<Actor> GetPlayerList() { }

function array<Actor> GetOutermostTowerList() { }

function array<Actor> GetActionList() { }

function TgSpectatorController.SpectatorCameraMode GetDefaultModeFor(Actor Target) { }

exec function SpecViewAction() { }

exec function SpecViewPlayer(string PlayerName) { }

function ViewTargetTransitionParams GetBlendParams(Actor Target) { }

function ViewTargetTransitionParams GetDefaultBlendParams() { }

function ViewTargetTransitionParams GetSnapBlendParams() { }

exec function SetSpectatorBookmark(int nNum) { }

exec function RecallSpectatorBookmark(int nNum) { }

exec function SpecSetFlightMode(TgSpectatorController.SpecFlightMode sfm) { }

exec function GotoCinematicCam(string sCamName) { }

exec function CameraSpeed(float NewSpeed) { }

exec function IncreaseCameraSpeeed() { }

exec function DecreaseCameraSpeed() { }

function string StripClanTag(string PlayerName) { }

exec function ToggleOutlineCharacters() { }

function SetOutlineCharacters(bool bNewOutlineCharacters);  // Export UTgSpectatorController::execSetOutlineCharacters(FFrame&, void* const)

event float GetFOVAngle() { }

exec function SquashMap() { }

exec function SpecTest() { }

exec function FlipOverviewSides() { }

function Pawn GetPawnFrom2DCoordinate(Vector2D Coordinate);  // Export UTgSpectatorController::execGetPawnFrom2DCoordinate(FFrame&, void* const)

function GetActorListFrom2DCoordinate(Vector2D Coordinate, out array<Actor> ActorList);  // Export UTgSpectatorController::execGetActorListFrom2DCoordinate(FFrame&, void* const)

exec function SpectateZoomIn(bool bEnabled) { }

exec function SpectateZoomOut(bool bEnabled) { }

function ChangeZoomState(TgSpectatorController.EZoomState NewZoomState) { }

function UpdateBroadcastChannels();  // Export UTgSpectatorController::execUpdateBroadcastChannels(FFrame&, void* const)

exec function SpectatePlayerIndex(int TaskForceNum, int PlayerIndex) { }

function TgPawn GetTgPawn();  // Export UTgSpectatorController::execGetTgPawn(FFrame&, void* const)

function SetViewTarget(Actor NewViewTarget, optional ViewTargetTransitionParams TransitionParams);  // Export UTgSpectatorController::execSetViewTarget(FFrame&, void* const)

state SpectatingMatch {}

state RoundEnded {}

defaultproperties
{}
