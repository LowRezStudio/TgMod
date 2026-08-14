class TmSpectatorController extends TgSpectatorController
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

simulated function ForwardToSpectatingMatch() {
    super.ForwardToSpectatingMatch();
    if (WorldInfo.NetMode != NM_DedicatedServer)
        SetSpectatorCameraMode(SpectatorCameraMode.SpecCam_FollowThirdPerson);
}
