class TgCameraModule_Free extends TgCameraModule
    native(View);

var float CamAltitude;
var float DesiredCamAltitude;
var float MaxCamAltitude;
var float MinCamAltitude;
var float CamZoomIncrement;

function ProcessInput(PlayerInput PlayerInput, float DeltaTime)
{
    // End:0x75
    if(PlayerCamera.CamAngle.Pitch > 5430)
    {
        PlayerCamera.CamAngle.Pitch = 5430;        
    }
    else
    {
        // End:0xE7
        if(PlayerCamera.CamAngle.Pitch < -8000)
        {
            PlayerCamera.CamAngle.Pitch = -8000;
        }
    }
    //return;    
}

function Vector GetCamLocationOffset(Pawn P)
{
    local Rotator CamRot;
    local Vector Offset;

    CamRot = PlayerCamera.CamAngle;
    CamRot.Roll = 0;
    Offset = -Vector(CamRot) * DesiredCamAltitude;
    // End:0x111
    if((PlayerCamera.ViewTarget.Target != none) && PlayerCamera.ViewTarget.Target.IsA('TgPawn_TowerBase'))
    {
        Offset.Z += float(400);
    }
    return Offset;
    //return ReturnValue;    
}

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    local Vector HitLocation, HitNormal, BoneLocation, TargetLocation, CamLocation;

    local Pawn ViewPawn;

    TargetLocation = OutVT.Target.Location;
    ViewPawn = Pawn(OutVT.Target);
    // End:0x42E
    if(ViewPawn != none)
    {
        // End:0x3B0
        if(ViewPawn.Mesh != none)
        {
            // End:0x2FA
            if(ViewPawn.Health > 0)
            {
                BoneLocation = ViewPawn.Mesh.GetBoneLocation('EffectsSocket');
                // End:0x177
                if(BoneLocation != vect(0.0000000, 0.0000000, 0.0000000))
                {
                    TargetLocation = BoneLocation;
                    TargetLocation.Z += ViewPawn.GetCollisionHeight();                    
                }
                else
                {
                    // End:0x246
                    if(ViewPawn.Mesh.MatchRefBone('Root') != -1)
                    {
                        TargetLocation = ViewPawn.Mesh.GetBoneLocation('Root');
                        TargetLocation.Z += ViewPawn.GetCollisionHeight();                        
                    }
                    else
                    {
                        TargetLocation = ViewPawn.Mesh.GetBoneLocation(ViewPawn.Mesh.GetBoneName(0));
                        TargetLocation.Z += ViewPawn.GetCollisionHeight();
                    }
                }                
            }
            else
            {
                BoneLocation = ViewPawn.Mesh.GetBoneLocation('Spine');
                // End:0x3AD
                if(BoneLocation != vect(0.0000000, 0.0000000, 0.0000000))
                {
                    TargetLocation = BoneLocation;
                    TargetLocation.Z += ViewPawn.GetCollisionHeight();
                }
            }            
        }
        else
        {
            TargetLocation = OutVT.Target.Location;
            TargetLocation.Z += (ViewPawn.GetCollisionHeight() / float(2));
        }
    }
    // End:0x521
    if(ViewPawn != none)
    {
        OutVT.POV.Location.Z += (Pawn(OutVT.Target).GetCollisionHeight() / float(2));
        TargetLocation.Z += (Pawn(OutVT.Target).GetCollisionHeight() / float(2));
    }
    CamLocation = TargetLocation;
    CamLocation += (GetCamLocationOffset(P));
    CameraActor.CameraTrace(HitLocation, HitNormal, CamLocation, TargetLocation, OutVT.Target);
    // End:0x608
    if(HitLocation != vect(0.0000000, 0.0000000, 0.0000000))
    {
        OutVT.POV.Location = HitLocation;        
    }
    else
    {
        OutVT.POV.Location = CamLocation;
    }
    OutVT.POV.Rotation = Rotator(TargetLocation - OutVT.POV.Location);
    //return;    
}

simulated function BecomeViewTarget(TgPlayerController PC)
{
    // End:0x6B
    if(LocalPlayer(PC.Player) != none)
    {
        TgPawn(PC.Pawn).SetMeshVisibility(true);
    }
    //return;    
}

function zoomIn()
{
    DesiredCamAltitude -= CamZoomIncrement;
    DesiredCamAltitude = FMin(MaxCamAltitude, FMax(MinCamAltitude, DesiredCamAltitude));
    //return;    
}

function ZoomOut()
{
    DesiredCamAltitude += CamZoomIncrement;
    DesiredCamAltitude = FMin(MaxCamAltitude, FMax(MinCamAltitude, DesiredCamAltitude));
    //return;    
}

defaultproperties
{
    CamAltitude=150.0000000
    DesiredCamAltitude=150.0000000
    MaxCamAltitude=150.0000000
    MinCamAltitude=150.0000000
    CamZoomIncrement=96.0000000
}