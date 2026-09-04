class TgCameraModule_SpectatorThirdPerson extends TgCameraModule_ThirdPerson;

var transient TPOV OldViewpoint;
var transient float RemainingBlendTime;
var transient float TotalBlendTime;

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local Vector CamLocation, camOrigin, HitLocation, HitNormal;
    local Actor Target;
    local float DurationPct, BlendPct;
    local TgPawn TgP;

    // End:0x37
    if((CameraActor == none) || CameraActor.PlayerOwner == none)
    {
        return;
    }
    TgP = TgPawn(P);
    // End:0x114
    if(TgP != none)
    {
        OutVT.POV.Rotation = TgP.Rotation;
        OutVT.POV.Rotation.Pitch = TgP.m_nSmoothedRemoteViewPitch;        
    }
    else
    {
        OutVT.POV.Rotation = CameraActor.PlayerOwner.Rotation;
    }
    UpdateCameraZoom(TgP, DeltaTime);
    Target = OutVT.Target;
    // End:0x2E9
    if((((Target != none) && Target.bHardAttach) && Target.Base != none) && !Target.Base.bWorldGeometry)
    {
        Target = Target.Base;
        OutVT.POV.Rotation.Yaw = Target.Rotation.Yaw;
    }
    camOrigin = GetCamAttachPoint(Target);
    vCachedCameraAttachPoint = camOrigin;
    CamLocation = camOrigin + (GetCamLocationOffset(OutVT.POV.Rotation, Target));
    // End:0x3A8
    if(TgP != none)
    {
        CamLocation += TgP.WalkBob;
    }
    // End:0x44C
    if(camOrigin != CamLocation)
    {
        CameraActor.CameraTrace(HitLocation, HitNormal, CamLocation, camOrigin, OutVT.Target);
        // End:0x44C
        if(HitLocation != vect(0.0000000, 0.0000000, 0.0000000))
        {
            CamLocation = HitLocation;
        }
    }
    OutVT.POV.Location = CamLocation;
    // End:0x643
    if(RemainingBlendTime > float(0))
    {
        RemainingBlendTime -= DeltaTime;
        // End:0x4CC
        if(RemainingBlendTime < 0.0000000)
        {
            RemainingBlendTime = 0.0000000;
        }
        DurationPct = (TotalBlendTime - RemainingBlendTime) / TotalBlendTime;
        BlendPct = FCubicInterp(0.0000000, 0.0000000, 1.0000000, 0.0000000, DurationPct);
        OutVT.POV.Location = VLerp(OldViewpoint.Location, OutVT.POV.Location, BlendPct);
        OutVT.POV.Rotation = RLerp(OldViewpoint.Rotation, OutVT.POV.Rotation, BlendPct, true);
    }
    CameraActor.CheckPenetration(CamLocation, 20.0000000);
    //return;    
}

function BlendToTarget(float BlendTime)
{
    local Vector Loc;
    local Rotator Rot;

    PlayerCamera.PlayerOwner.GetPlayerViewPoint(Loc, Rot);
    OldViewpoint.Location = Loc;
    OldViewpoint.Rotation = Rot;
    OldViewpoint.FOV = PlayerCamera.GetFOVAngle();
    RemainingBlendTime = BlendTime;
    TotalBlendTime = BlendTime;
    //return;    
}

defaultproperties
{
    OldViewpoint=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000))
}