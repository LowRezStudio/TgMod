class TgControlModule_Spectator extends TgControlModule
    config(Game);

var() config float RotationLimit;
var() const config float SpectatorStallZ;
var() const config float SpectatorMinStallZ;

singular simulated function Rotator GetBaseAimRotation(Weapon W, optional bool bIgnoreAutoLock)
{
    local Rotator OutRotation, ViewRot;
    local Vector ViewLoc;

    // End:0x7C
    if(Controller != none)
    {
        Controller.GetPlayerViewPoint(ViewLoc, ViewRot);
        OutRotation = ViewRot;
        OutRotation.Pitch = 0;
        return OutRotation;
    }
    return rot(0, 0, 0);
    //return ReturnValue;    
}

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
{
    local float VelSize;
    local Vector CorrectedLocation;

    Controller.Acceleration = Normal(newAccel) * Controller.SpectatorCameraSpeed;
    VelSize = VSize(Controller.Velocity);
    // End:0x127
    if(VelSize > float(0))
    {
        Controller.Velocity = Controller.Velocity - ((Controller.Velocity - (Normal(Controller.Acceleration) * VelSize)) * FMin(DeltaTime * float(8), 1.0000000));
    }
    Controller.Velocity = Controller.Velocity + (Controller.Acceleration * DeltaTime);
    // End:0x231
    if(VSize(Controller.Velocity) > Controller.SpectatorCameraSpeed)
    {
        Controller.Velocity = Normal(Controller.Velocity) * Controller.SpectatorCameraSpeed;
    }
    Controller.MoveSmooth(Controller.Velocity * DeltaTime);
    // End:0x323
    if(Controller.Location.Z > SpectatorStallZ)
    {
        CorrectedLocation = Controller.Location;
        CorrectedLocation.Z = SpectatorStallZ;
        Controller.SetLocation(CorrectedLocation);        
    }
    else
    {
        // End:0x3D1
        if(Controller.Location.Z < SpectatorMinStallZ)
        {
            CorrectedLocation = Controller.Location;
            CorrectedLocation.Z = SpectatorMinStallZ;
            Controller.SetLocation(CorrectedLocation);
        }
    }
    //return;    
}

function PlayerMove(float DeltaTime)
{
    local Vector X, Y, Z, newAccel;
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
    Rot = TgPC.Rotation;
    // End:0x135
    if((int(TgPC.m_eHelicopterFlight) == int(1)) || int(TgSpectatorController(Controller).m_eHelicopterFlight) == int(2))
    {
        Rot.Pitch = 0;
    }
    // End:0x197
    if(int(TgPC.m_eHelicopterFlight) == int(2))
    {
        TgPC.PlayerInput.aUp = 0.0000000;
    }
    GetAxes(Rot, X, Y, Z);
    newAccel = ((TgPC.PlayerInput.aForward * X) + (Controller.PlayerInput.aStrafe * Y)) + (Controller.PlayerInput.aUp * vect(0.0000000, 0.0000000, 1.0000000));
    // End:0x2F5
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
    local Rotator ViewRotation, DeltaRot;

    // End:0x11
    if(Controller == none)
    {
        return;
    }
    DeltaTime = Controller.WorldInfo.m_fRealDeltaSeconds;
    ViewRotation = Controller.Rotation;
    DeltaRot = rot(0, 0, 0);
    DeltaRot.Yaw += int(Controller.PlayerInput.aTurn);
    DeltaRot.Pitch += int(Controller.PlayerInput.aLookUp);
    DeltaRot.Yaw = int(FClamp(float(DeltaRot.Yaw), -RotationLimit * DeltaTime, RotationLimit * DeltaTime));
    DeltaRot.Pitch = int(FClamp(float(DeltaRot.Pitch), -RotationLimit * DeltaTime, RotationLimit * DeltaTime));
    ViewRotation += DeltaRot;
    ViewRotation = Controller.LimitViewRotation(ViewRotation, -16384.0000000, 16383.0000000);
    Controller.SetRotation(ViewRotation);
    //return;    
}

function Pawn GetPawnAtCursor()
{
    local LocalPlayer LocalPlayer;
    local Vector2D MousePos;
    local TgSpectatorController SpecPC;

    SpecPC = TgSpectatorController(Controller);
    LocalPlayer = LocalPlayer(Controller.Player);
    // End:0xFA
    if(((LocalPlayer != none) && LocalPlayer.ViewportClient != none) && SpecPC != none)
    {
        MousePos = LocalPlayer.ViewportClient.GetMousePosition();
        return SpecPC.GetPawnFrom2DCoordinate(MousePos);
    }
    return none;
    //return ReturnValue;    
}

function GetActorListAtCursor(out array<Actor> ActorList)
{
    local LocalPlayer LocalPlayer;
    local Vector2D MousePos;
    local TgSpectatorController SpecPC;

    SpecPC = TgSpectatorController(Controller);
    LocalPlayer = LocalPlayer(Controller.Player);
    // End:0x102
    if(((LocalPlayer != none) && LocalPlayer.ViewportClient != none) && SpecPC != none)
    {
        MousePos = LocalPlayer.ViewportClient.GetMousePosition();
        SpecPC.GetActorListFrom2DCoordinate(MousePos, ActorList);
    }
    return;
    //return;    
}

function bool InterceptFlashInput(name ButtonName, Object.EInputEvent Event)
{
    // End:0x5B
    if(ButtonName == 'RightMouseButton')
    {
        // End:0x38
        if(int(Event) == int(0))
        {
            OnRightMousePressed();            
        }
        else
        {
            // End:0x56
            if(int(Event) == int(1))
            {
                OnRightMouseReleased();
            }
        }
        return true;        
    }
    else
    {
        // End:0x90
        if(ButtonName == 'LeftMouseButton')
        {
            // End:0x90
            if(int(Event) == int(0))
            {
                OnLeftMousePressed();
            }
        }
    }
    return false;
    //return ReturnValue;    
}

function OnRightMousePressed()
{
    //return;    
}

function OnRightMouseReleased()
{
    //return;    
}

function OnLeftMousePressed()
{
    local array<Actor> ActorList;
    local int ActorIdx;
    local TgDeployable deployable;
    local TgPawn TgP;
    local TgSpectatorController SpecPC;

    SpecPC = TgSpectatorController(Controller);
    GetActorListAtCursor(ActorList);
    ActorIdx = 0;
    J0x3A:

    // End:0x139 [Loop If]
    if(ActorIdx < ActorList.Length)
    {
        TgP = TgPawn(ActorList[ActorIdx]);
        // End:0xD6
        if((TgP != none) && TgP.IsGod())
        {
            SpecPC.SpectatorSetViewTarget(TgP);
            return;
        }
        deployable = TgDeployable(ActorList[ActorIdx]);
        // End:0x12B
        if(deployable != none)
        {
            deployable.ToggleSpectateFx();
        }
        ActorIdx++;
        // [Loop Continue]
        goto J0x3A;
    }
    //return;    
}

defaultproperties
{
    RotationLimit=65536.0000000
    SpectatorStallZ=99999.0000000
    SpectatorMinStallZ=-99999.0000000
}