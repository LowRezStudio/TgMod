class TgCameraModule_ThirdPersonVariableHeight extends TgCameraModule_ThirdPerson;

var() float ZOffset;

function OnBecomeActive(TgCameraModule OldCamera)
{
    super.OnBecomeActive(OldCamera);
    ZOffset = 0.0000000;
    //return;    
}

function Vector GetCamLocationOffset(Rotator PawnRot, Actor ViewTarget)
{
    local Vector Offset;

    Offset = super.GetCamLocationOffset(PawnRot, ViewTarget);
    Offset.Z += ZOffset;
    return Offset;
    //return ReturnValue;    
}

function zoomIn()
{
    ZOffset += float(50);
    //return;    
}

function ZoomOut()
{
    ZOffset -= float(50);
    //return;    
}
