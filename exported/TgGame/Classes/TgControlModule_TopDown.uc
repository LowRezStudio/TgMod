class TgControlModule_TopDown extends TgControlModule_Spectator
    config(Game);

var const config float DefaultStartHeight;

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
{
    local TgSpectatorController TgPC;
    local Vector NewLocation, AccelZAdjusted, ViewDir, CamToFocalPoint;
    local Rotator Rot;
    local float VelSize, Angle, Height;
    local TgCameraModule_TopDown CameraModule;

    TgPC = TgSpectatorController(Controller);
    CameraModule = TgCameraModule_TopDown(TgPC.GetCurrentCameraModule());
    // End:0x111
    if((newAccel.Z > 0.0000000) && TgPC.Location.Z >= SpectatorStallZ)
    {
        newAccel.Z = 0.0000000;
        TgPC.Velocity.Z = 0.0000000;        
    }
    else
    {
        // End:0x1D1
        if((newAccel.Z < 0.0000000) && TgPC.Location.Z <= SpectatorMinStallZ)
        {
            newAccel.Z = 0.0000000;
            TgPC.Velocity.Z = 0.0000000;
        }
    }
    newAccel = Normal(newAccel);
    Rot.Pitch = CameraModule.WorldViewPitch;
    Rot.Yaw = TgPC.Rotation.Yaw;
    ViewDir = Vector(Rot);
    AccelZAdjusted = newAccel;
    AccelZAdjusted.Z = 0.0000000;
    AccelZAdjusted += ((newAccel.Z * ViewDir) * -1.0000000);
    TgPC.Acceleration = Normal(AccelZAdjusted) * TgPC.SpectatorCameraSpeed;
    VelSize = VSize(TgPC.Velocity);
    // End:0x419
    if(VelSize > float(0))
    {
        TgPC.Velocity = TgPC.Velocity - ((TgPC.Velocity - (Normal(TgPC.Acceleration) * VelSize)) * FMin(DeltaTime * float(8), 1.0000000));
    }
    TgPC.Velocity = TgPC.Velocity + (TgPC.Acceleration * DeltaTime);
    NewLocation = TgPC.ViewTarget.Location;
    Angle = Acos(ViewDir Dot vect(0.0000000, 0.0000000, -1.0000000));
    Height = FClamp(TgPC.Location.Z, Class'TgGame.TgControlModule_TopDown'.default.SpectatorMinStallZ, Class'TgGame.TgControlModule_TopDown'.default.SpectatorStallZ);
    CamToFocalPoint = (Height / Cos(Angle)) * ViewDir;
    NewLocation.Z = 0.0000000;
    NewLocation -= CamToFocalPoint;
    TgPC.SetLocation(NewLocation);
    TgPC.MoveSmooth(TgPC.Velocity * DeltaTime);
    //return;    
}

function PlayerMove(float DeltaTime)
{
    local Vector X, Y, Z, newAccel, Loc;

    local Rotator Rot;
    local TgSpectatorController TgPC;

    TgPC = TgSpectatorController(Controller);
    // End:0x2D
    if(TgPC == none)
    {
        return;
    }
    DeltaTime = TgPC.WorldInfo.m_fRealDeltaSeconds;
    TgPC.UpdateRotation(DeltaTime);
    TgPC.GetPlayerViewPoint(Loc, Rot);
    GetAxes(MakeRotator(0, Rot.Yaw, 0), X, Y, Z);
    newAccel = (Controller.PlayerInput.aForward * X) + (Controller.PlayerInput.aStrafe * Y);
    newAccel.Z = Controller.PlayerInput.aUp;
    // End:0x24C
    if(int(TgPC.Role) < int(ROLE_Authority))
    {
        TgPC.ReplicateMove(DeltaTime, newAccel, 0, rot(0, 0, 0));        
    }
    else
    {
        TgPC.ProcessMove(DeltaTime, newAccel, 0, rot(0, 0, 0));
    }
    //return;    
}

defaultproperties
{
    DefaultStartHeight=700.0000000
    SpectatorStallZ=850.0000000
    SpectatorMinStallZ=350.0000000
}