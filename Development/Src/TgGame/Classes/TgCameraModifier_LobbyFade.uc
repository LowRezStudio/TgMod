class TgCameraModifier_LobbyFade extends CameraModifier
    native(View)
    config(Engine);

native function bool ModifyCamera(Camera Camera, float DeltaTime, out TPOV OutPOV);  // Export UTgCameraModifier_LobbyFade::execModifyCamera(FFrame&, void* const)

defaultproperties
{
    AlphaInTime=0.3000000
    AlphaOutTime=0.3000000
}
