class TgCameraModifier_LobbyCameraTransition extends CameraModifier
    native(View)
    config(Engine);

enum CameraTransType {
    CTT_None,  // 0
    CTT_PanRight,  // 1
    CTT_PanLeft,  // 2
    CTT_PanUp,  // 3
    CTT_PanDown,  // 4
};

var TgLobbyCamera SourceCamera;
var TgLobbyCamera DestinationCamera;
var TgCameraModifier_LobbyCameraTransition.CameraTransType TransitionType;
var float fSlideDistance;

native function bool ModifyCamera(Camera Camera, float DeltaTime, out TPOV OutPOV);  // Export UTgCameraModifier_LobbyCameraTransition::execModifyCamera(FFrame&, void* const)

event AddCameraModifierAsEvent(Camera Cam) { }

event RemoveCameraModifierAsEvent(Camera Cam) { }

event DisableModifier(optional bool bImmediate) { }

function bool RemoveCameraModifier(Camera Camera) { }

defaultproperties
{
    TransitionType=CTT_PanRight
    fSlideDistance=150.0000000
    AlphaInTime=0.2500000
    AlphaOutTime=0.1800000
}
