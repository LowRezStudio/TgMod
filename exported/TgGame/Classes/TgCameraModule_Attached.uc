class TgCameraModule_Attached extends TgCameraModule;

function Vector GetAttachLocation(Pawn ViewTarget)
{
    local Vector BoneLocation;

    // End:0x7D
    if((ViewTarget != none) && ViewTarget.Mesh != none)
    {
        BoneLocation = ViewTarget.Mesh.GetBoneLocation('EffectsSocket');
    }
    return BoneLocation;
    //return ReturnValue;    
}

function Rotator GetAttachRotation(Pawn ViewTarget)
{
    local Rotator BoneRotation;

    // End:0x87
    if((ViewTarget != none) && ViewTarget.Mesh != none)
    {
        BoneRotation = QuatToRotator(ViewTarget.Mesh.GetBoneQuaternion('EffectsSocket'));
    }
    return BoneRotation;
    //return ReturnValue;    
}

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    // End:0x98
    if(P != none)
    {
        OutVT.POV.Location = GetAttachLocation(P);
        OutVT.POV.Rotation = GetAttachRotation(P);        
    }
    else
    {
        OutVT.POV.Location = CameraActor.Location;
        OutVT.POV.Rotation = CameraActor.Rotation;
    }
    OutVT.Target = P;
    //return;    
}
