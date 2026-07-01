class TgSpectatorController extends TgPlayerController
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

enum SpectatorCameraMode
{
    SpecCam_None,                   // 0
    SpecCam_Fly,                    // 1
    SpecCam_FollowThirdPerson,      // 2
    SpecCam_FollowFirstPerson,      // 3
    SpecCam_FollowTopDown,          // 4
    SpecCam_Camera,                 // 5
    SpecCam_Overview,               // 6
    SpecCam_LockedView,             // 7
};

enum ESpectatorMode
{
    SPECMODE_Manual,                // 0
    SPECMODE_Director,              // 1
    SPECMODE_Assisted,              // 2
    SPECMODE_Broadcast1,            // 3
    SPECMODE_Broadcast2,            // 4
    SPECMODE_Broadcast3,            // 5
    SPECMODE_Broadcast4,            // 6
};

var transient TgSpectatorController.ESpectatorMode m_CurrentSpectatorMode;

simulated function ForwardToSpectatingMatch() {}
simulated event PostBeginPlay(){}
exec function SpecViewPlayer(string PlayerName){}
exec function SetSpectatorCameraMode(TgSpectatorController.SpectatorCameraMode Mode, optional bool bCameraTween = false){}
function TgSpectatorController.SpectatorCameraMode GetDefaultModeFor(Actor Target){}

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams){}
function UpdateViewTargetUI(){}