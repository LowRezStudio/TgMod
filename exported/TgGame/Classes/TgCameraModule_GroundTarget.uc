class TgCameraModule_GroundTarget extends TgCameraModule_Free
    native(View);

function Vector GetCamLocationOffset(Pawn P)
{
    local Rotator CamRot;
    local Vector Offset;

    CamRot = PlayerCamera.CamAngle;
    CamRot.Pitch = -10000;
    CamRot.Roll = 0;
    Offset = -Vector(CamRot) * DesiredCamAltitude;
    return Offset;
    //return ReturnValue;    
}

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local Vector TargetLocation, CamLocation, HitLocation, HitNormal;
    local float fRange;
    local TgDeviceFire FireMode;

    // End:0xE8
    if((P != none) && TgDevice(P.Weapon) != none)
    {
        FireMode = TgDevice(P.Weapon).GetCurrentFire();
        // End:0xE8
        if(FireMode != none)
        {
            fRange = FireMode.GetRange();
            // End:0xE8
            if(fRange > float(0))
            {
                DesiredCamAltitude = fRange * 0.5000000;
            }
        }
    }
    CamLocation = OutVT.Target.Location;
    CamLocation += (GetCamLocationOffset(P));
    CameraActor.Trace(HitLocation, HitNormal, CamLocation, OutVT.Target.Location, false);
    // End:0x200
    if(HitLocation != vect(0.0000000, 0.0000000, 0.0000000))
    {
        OutVT.POV.Location = HitLocation;        
    }
    else
    {
        OutVT.POV.Location = CamLocation;
    }
    TargetLocation = OutVT.Target.Location;
    // End:0x2FE
    if(Pawn(OutVT.Target) != none)
    {
        TargetLocation.Z += (Pawn(OutVT.Target).GetCollisionHeight() / float(2));
    }
    OutVT.POV.Rotation = Rotator(TargetLocation - OutVT.POV.Location);
    OutVT.POV.Rotation.Pitch += 2500;
    //return;    
}

function zoomIn()
{
    return;
    //return;    
}

function ZoomOut()
{
    return;
    //return;    
}

defaultproperties
{
    DesiredCamAltitude=1440.0000000
}