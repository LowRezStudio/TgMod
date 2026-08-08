class TgSpectatorDirector extends Info
    native
    hidecategories(Navigation,Movement,Collision)
    config(Engine)
    dependson(TgSpectatorController);

struct ViewTargetInfo {
    var TgPawn Pawn;
    var TgPawn_Tower ClosestEnemyTower;
    var int Rating;
    var float DistSqToClosestEnemy;
    var float DistSqToClosestFriend;
    var float DistSqToGoldFury;
    var float DistSqToEnemyTower;
    var int NumCloseEnemies;
    var int NumCloseFriends;
    structdefaultproperties {}
};

var private transient bool m_bIsActive;
var private transient bool m_bIsPending;
var transient bool m_bAutoSwitchCameraViews;
var transient bool m_bForceThirdPersonView;
var float m_fRemainingAutoUpdateCheckTime;
var float m_fTimeSinceViewSwitchedTeams;
var float m_fTimeSinceViewSwitchedMode;
var float m_fRemainingAutoReturnCheckTime;
var TgSpectatorController.SpectatorCameraMode m_CurrentCameraMode;
var ViewTargetInfo m_CurrentRatedViewTarget;
var transient ViewTargetInfo m_DemoRewindViewTarget;
var transient Vector2D m_v2dForcedDirectorLocation;
var transient float m_fForcedDirectorLocationTimestamp;

native function OnPlayerMoved();  // Export UTgSpectatorDirector::execOnPlayerMoved(FFrame&, void* const)

native function UpdateOverviewCamUI(bool bEnable);  // Export UTgSpectatorDirector::execUpdateOverviewCamUI(FFrame&, void* const)

event SetViewTarget(ViewTargetInfo NewViewTarget) { }

event SetCameraMode(TgSpectatorController.SpectatorCameraMode NewCameraMode) { }

function SetActive(bool bIsActive) { }

function ResetCamera(TgSpectatorController PC) { }

function bool IsCurrentlyViewing() { }

function bool IsActive() { }

function bool IsPending() { }

simulated event PreDemoRewind() { }

simulated event PostDemoRewind() { }

event ClearAssistModeTarget() { }

function SetForcedDirectorLocation(Vector2D NewLocation) { }

defaultproperties
{
    m_CurrentCameraMode=SpecCam_Overview
    m_CurrentRatedViewTarget=(Pawn=none,ClosestEnemyTower=none,Rating=-1,DistSqToClosestEnemy=-1.0000000,DistSqToClosestFriend=0.0000000,DistSqToGoldFury=0.0000000,DistSqToEnemyTower=0.0000000,NumCloseEnemies=0,NumCloseFriends=0)
    m_DemoRewindViewTarget=(Pawn=none,ClosestEnemyTower=none,Rating=-1,DistSqToClosestEnemy=-1.0000000,DistSqToClosestFriend=0.0000000,DistSqToGoldFury=0.0000000,DistSqToEnemyTower=0.0000000,NumCloseEnemies=0,NumCloseFriends=0)
}
