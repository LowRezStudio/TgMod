class TgCameraModifier_LobbyCameraTransition extends CameraModifier
    native(View);

enum CameraTransType
{
    CTT_None,                       // 0
    CTT_PanRight,                   // 1
    CTT_PanLeft,                    // 2
    CTT_PanUp,                      // 3
    CTT_PanDown,                    // 4
    CTT_MAX                         // 5
};

var TgLobbyCamera SourceCamera;
var TgLobbyCamera DestinationCamera;
var TgCameraModifier_LobbyCameraTransition.CameraTransType TransitionType;
var float fSlideDistance;

// Export UTgCameraModifier_LobbyCameraTransition::execModifyCamera(FFrame&, void* const)
native function bool ModifyCamera(Camera Camera, float DeltaTime, out TPOV OutPOV);

event AddCameraModifierAsEvent(Camera Cam)
{
    AddCameraModifier(Cam);
    //return;    
}

event RemoveCameraModifierAsEvent(Camera Cam)
{
    RemoveCameraModifier(Cam);
    //return;    
}

event DisableModifier(optional bool bImmediate)
{
    super.DisableModifier(bImmediate);
    RemoveCameraModifier(CameraOwner);
    //return;    
}

function bool RemoveCameraModifier(Camera Camera)
{
    // End:0x5B
    if(super.RemoveCameraModifier(Camera))
    {
        bDisabled = true;
        Camera.bEnableFading = false;
        SourceCamera = none;
        DestinationCamera = none;
        return true;
    }
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    TransitionType=CameraTransType.CTT_PanRight
    fSlideDistance=150.0000000
    AlphaInTime=0.2500000
    AlphaOutTime=0.1800000
}