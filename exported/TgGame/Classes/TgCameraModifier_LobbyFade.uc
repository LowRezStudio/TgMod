class TgCameraModifier_LobbyFade extends CameraModifier
    native(View);

// Export UTgCameraModifier_LobbyFade::execModifyCamera(FFrame&, void* const)
native function bool ModifyCamera(Camera Camera, float DeltaTime, out TPOV OutPOV);

defaultproperties
{
    AlphaInTime=0.3000000
    AlphaOutTime=0.3000000
}