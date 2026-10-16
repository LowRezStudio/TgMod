class TgSpectatorDirector extends Info
    native
    hidecategories(Navigation,Movement,Collision);

struct native ViewTargetInfo
{
    var TgPawn Pawn;
    var TgPawn_Tower ClosestEnemyTower;
    var int Rating;
    var float DistSqToClosestEnemy;
    var float DistSqToClosestFriend;
    var float DistSqToGoldFury;
    var float DistSqToEnemyTower;
    var int NumCloseEnemies;
    var int NumCloseFriends;

    structdefaultproperties
    {
        Pawn=none
        ClosestEnemyTower=none
        Rating=-1
        DistSqToClosestEnemy=-1.0000000
        DistSqToClosestFriend=0.0000000
        DistSqToGoldFury=0.0000000
        DistSqToEnemyTower=0.0000000
        NumCloseEnemies=0
        NumCloseFriends=0
    }
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

// Export UTgSpectatorDirector::execOnPlayerMoved(FFrame&, void* const)
native function OnPlayerMoved();

// Export UTgSpectatorDirector::execUpdateOverviewCamUI(FFrame&, void* const)
native function UpdateOverviewCamUI(bool bEnable);

event SetViewTarget(ViewTargetInfo NewViewTarget)
{
    local TgSpectatorController PC;

    PC = TgSpectatorController(Owner);
    // End:0x147
    if(PC != none)
    {
        // End:0xB5
        if(NewViewTarget.Pawn != none)
        {
            PC.SetViewTarget(NewViewTarget.Pawn);
            PC.SetSpectatorCameraMode(m_CurrentCameraMode);            
        }
        else
        {
            // End:0x147
            if(int(PC.m_CameraMode) != int(6))
            {
                PC.SetSpectatorCameraMode(1);
                PC.SpectatorSetViewTarget(PC, PC.GetSnapBlendParams());
            }
        }
    }
    //return;    
}

event SetCameraMode(TgSpectatorController.SpectatorCameraMode NewCameraMode)
{
    local TgSpectatorController PC;

    PC = TgSpectatorController(Owner);
    // End:0x90
    if((PC != none) && !PC.IsInState('RoundEnded'))
    {
        PC.SetSpectatorCameraMode(NewCameraMode);
        m_CurrentCameraMode = NewCameraMode;
    }
    //return;    
}

function SetActive(bool bIsActive)
{
    local TgDemoRecSpectator PC;

    PC = TgDemoRecSpectator(Owner);
    // End:0x7E
    if((bIsActive && PC != none) && int(PC.m_CurrentSpectatorMode) == int(2))
    {
        ClearAssistModeTarget();
        m_fRemainingAutoReturnCheckTime = 0.0000000;
    }
    m_bIsActive = bIsActive;
    // End:0x103
    if(!m_bIsActive)
    {
        PC = TgDemoRecSpectator(Owner);
        // End:0x103
        if((PC != none) && int(PC.m_CameraMode) == int(6))
        {
            UpdateOverviewCamUI(true);
        }
    }
    //return;    
}

function ResetCamera(TgSpectatorController PC)
{
    local Vector Loc;
    local Rotator Rot;

    PC.GetPlayerViewPoint(Loc, Rot);
    PC.SetLocation(Loc);
    PC.SetRotation(Rot);
    PC.SetViewTarget(PC);
    //return;    
}

function bool IsCurrentlyViewing()
{
    return m_bIsActive && !m_bIsPending;
    //return ReturnValue;    
}

function bool IsActive()
{
    return m_bIsActive;
    //return ReturnValue;    
}

function bool IsPending()
{
    return m_bIsPending;
    //return ReturnValue;    
}

simulated event PreDemoRewind()
{
    m_DemoRewindViewTarget = m_CurrentRatedViewTarget;
    //return;    
}

simulated event PostDemoRewind()
{
    local TgSpectatorController PC;

    super(Actor).PostDemoRewind();
    PC = TgSpectatorController(Owner);
    // End:0xC5
    if(PC != none)
    {
        // End:0x81
        if(int(PC.m_CurrentSpectatorMode) == int(1))
        {
            // End:0x7E
            if(IsCurrentlyViewing())
            {
                SetViewTarget(m_CurrentRatedViewTarget);
            }            
        }
        else
        {
            // End:0xC5
            if((IsCurrentlyViewing()) && m_DemoRewindViewTarget.Pawn != none)
            {
                SetViewTarget(m_DemoRewindViewTarget);
            }
        }
    }
    //return;    
}

event ClearAssistModeTarget()
{
    m_fForcedDirectorLocationTimestamp = 0.0000000;
    m_CurrentRatedViewTarget.Pawn = none;
    //return;    
}

function SetForcedDirectorLocation(Vector2D NewLocation)
{
    ClearAssistModeTarget();
    m_v2dForcedDirectorLocation = NewLocation;
    m_fForcedDirectorLocationTimestamp = WorldInfo.RealTimeSeconds;
    m_fRemainingAutoUpdateCheckTime = 0.0000000;
    //return;    
}

defaultproperties
{
    m_CurrentCameraMode=SpectatorCameraMode.SpecCam_Overview
    m_CurrentRatedViewTarget=(Pawn=none,ClosestEnemyTower=none,Rating=-1,DistSqToClosestEnemy=-1.0000000,DistSqToClosestFriend=0.0000000,DistSqToGoldFury=0.0000000,DistSqToEnemyTower=0.0000000,NumCloseEnemies=0,NumCloseFriends=0)
    m_DemoRewindViewTarget=(Pawn=none,ClosestEnemyTower=none,Rating=-1,DistSqToClosestEnemy=-1.0000000,DistSqToClosestFriend=0.0000000,DistSqToGoldFury=0.0000000,DistSqToEnemyTower=0.0000000,NumCloseEnemies=0,NumCloseFriends=0)
}