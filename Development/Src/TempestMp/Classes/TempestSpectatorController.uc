class TempestSpectatorController extends TgSpectatorController;

// Override so characters default to third person instead of top-down
function SpectatorCameraMode GetDefaultModeFor(Actor Target)
{
    if (Target.IsInState('Dying'))
        return SpecCam_None;

    if (Target.IsA('TgPawn_Structure'))
        return SpecCam_FollowTopDown;

    if (Target.IsA('TgPawn_Character'))
        return SpecCam_FollowFirstPerson; // was 4, now 2

    if (Target.IsA('CameraActor'))
        return SpecCam_Camera;

    return SpecCam_None;
}