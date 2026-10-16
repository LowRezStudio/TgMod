class TgControlModule_SpectatorOverview extends TgControlModule_Spectator
    config(Game);

var() const config float DirectorModeSpectatorStallZ;
var() const config float DirectorModeSpectatorMinStallZ;

function float GetMaxStallZ()
{
    local TgDemoRecSpectator DemoPC;

    DemoPC = TgDemoRecSpectator(Controller);
    // End:0x94
    if(((DemoPC != none) && DemoPC.m_SpectatorDirector != none) && DemoPC.m_SpectatorDirector.IsCurrentlyViewing())
    {
        return DirectorModeSpectatorMinStallZ;
    }
    return SpectatorStallZ;
    //return ReturnValue;    
}

function float GetMinStallZ()
{
    local TgDemoRecSpectator DemoPC;

    DemoPC = TgDemoRecSpectator(Controller);
    // End:0x94
    if(((DemoPC != none) && DemoPC.m_SpectatorDirector != none) && DemoPC.m_SpectatorDirector.IsCurrentlyViewing())
    {
        return DirectorModeSpectatorMinStallZ;
    }
    return SpectatorMinStallZ;
    //return ReturnValue;    
}

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
{
    local float VelSize, VelocityZ;
    local Vector AccelZAdjusted, VelocityXY, Loc;
    local TgSpectatorController TgPC;
    local TgCameraModule_SpectatorOverview CameraModule;
    local Rotator Rot;

    CameraModule = TgCameraModule_SpectatorOverview(Controller.GetCurrentCameraModule());
    // End:0xBF
    if((newAccel.Z > 0.0000000) && Controller.Location.Z >= (GetMaxStallZ()))
    {
        newAccel.Z = 0.0000000;        
    }
    else
    {
        // End:0x149
        if((newAccel.Z < 0.0000000) && Controller.Location.Z <= (GetMinStallZ()))
        {
            newAccel.Z = 0.0000000;
        }
    }
    AccelZAdjusted = newAccel;
    AccelZAdjusted.Z = 0.0000000;
    AccelZAdjusted += ((newAccel.Z * vect(0.0000000, 0.0000000, -1.0000000)) * -1.0000000);
    Controller.Acceleration = Normal(AccelZAdjusted) * Controller.SpectatorCameraSpeed;
    VelSize = VSize(Controller.Velocity);
    // End:0x2E2
    if(VelSize > float(0))
    {
        Controller.Velocity = Controller.Velocity - ((Controller.Velocity - (Normal(Controller.Acceleration) * VelSize)) * FMin(DeltaTime * float(8), 1.0000000));
    }
    Controller.Velocity = Controller.Velocity + (Controller.Acceleration * DeltaTime);
    VelocityXY = Controller.Velocity;
    VelocityXY.Z = 0.0000000;
    VelocityZ = Controller.Velocity.Z;
    // End:0x43A
    if(VSize2D(VelocityXY) > Controller.SpectatorCameraSpeed)
    {
        VelocityXY = Normal(VelocityXY) * Controller.SpectatorCameraSpeed;
    }
    // End:0x491
    if(VelocityZ > Controller.SpectatorCameraSpeed)
    {
        VelocityZ = Controller.SpectatorCameraSpeed;        
    }
    else
    {
        // End:0x4F3
        if(VelocityZ < (Controller.SpectatorCameraSpeed * -1.0000000))
        {
            VelocityZ = Controller.SpectatorCameraSpeed * -1.0000000;
        }
    }
    Controller.Velocity.X = VelocityXY.X;
    Controller.Velocity.Y = VelocityXY.Y;
    Controller.Velocity.Z = VelocityZ;
    TgPC = TgSpectatorController(Controller);
    // End:0x700
    if((((TgPC != none) && CameraModule != none) && TgPawn(TgPC.ViewTarget) != none) && (newAccel.X != 0.0000000) || newAccel.Y != 0.0000000)
    {
        TgPC.GetPlayerViewPoint(Loc, Rot);
        TgPC.SetLocation(Loc);
        TgPC.SpectatorSetViewTarget(TgPC);
    }
    Controller.MoveSmooth(TgPC.Velocity * DeltaTime);
    // End:0x7EF
    if(TgPC.Location.Z > DirectorModeSpectatorMinStallZ)
    {
        Loc = TgPC.Location;
        Loc.Z = DirectorModeSpectatorMinStallZ;
        TgPC.SetLocation(Loc);
    }
    //return;    
}

function PlayerMove(float DeltaTime)
{
    local Vector X, Y, Z, newAccel, Loc;

    local Rotator Rot;
    local TgPlayerController TgPC;

    TgPC = Controller;
    // End:0x24
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
    // End:0x243
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

function UpdateRotation(float DeltaTime)
{
    local Rotator NewRotation;

    super.UpdateRotation(DeltaTime);
    NewRotation = Controller.Rotation;
    NewRotation.Yaw = Clamp(Controller.Rotation.Yaw, -8192, 8192);
    Controller.SetRotation(NewRotation);
    //return;    
}

function OnLeftMousePressed()
{
    local TgPawn FoundPawn;
    local TgSpectatorController SpectatorController;
    local TgDemoRecSpectator DemoController;

    SpectatorController = TgSpectatorController(Controller);
    // End:0x2D
    if(SpectatorController == none)
    {
        return;
    }
    FoundPawn = TgPawn(GetPawnAtCursor());
    // End:0x189
    if(((FoundPawn != none) && FoundPawn.r_nPhysicalType == 10034) && SpectatorController.GetViewTarget() != FoundPawn)
    {
        DemoController = TgDemoRecSpectator(SpectatorController);
        // End:0x137
        if((DemoController != none) && DemoController.m_SpectatorDirector != none)
        {
            DemoController.m_SpectatorDirector.ClearAssistModeTarget();
        }
        SpectatorController.SpectatorSetViewTarget(FoundPawn, SpectatorController.GetBlendParams(FoundPawn));
        return;
    }
    super.OnLeftMousePressed();
    //return;    
}

defaultproperties
{
    DirectorModeSpectatorStallZ=2000.0000000
    DirectorModeSpectatorMinStallZ=750.0000000
    SpectatorStallZ=2000.0000000
    SpectatorMinStallZ=750.0000000
}