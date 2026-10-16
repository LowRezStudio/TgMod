class TgControlModule_Free extends TgControlModule;

var int CameraYawOffset;

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
    // End:0x26
    if(Controller.Pawn == none)
    {
        return;
    }
    // End:0x14F
    if(int(Controller.Role) == int(ROLE_Authority))
    {
        Controller.Pawn.SetRemoteViewPitch(Controller.Rotation.Pitch);
        // End:0x14F
        if(TgPawn(Controller.Pawn) != none)
        {
            TgPawn(Controller.Pawn).SetUncompressedRemoteViewPitch(Controller.Rotation.Pitch);
        }
    }
    Controller.Pawn.Acceleration = newAccel;
    Controller.CheckJumpOrDuck();
    //return;    
}

function PlayerMove(float DeltaTime)
{
    local Vector X, Y, Z, newAccel;
    local Actor.EDoubleClickDir DoubleClickMove;
    local Rotator OldRotation;
    local bool bSaveJump;
    local Vector ViewLocation;
    local Rotator ViewRotation, flatRotation;

    // End:0x37
    if((Controller == none) || Controller.Pawn == none)
    {
        return;
    }
    // End:0xFB
    if((Controller.Pawn.bHardAttach && Controller.Pawn.Base != none) && !Controller.Pawn.Base.bWorldGeometry)
    {
        return;
    }
    OldRotation = Controller.Rotation;
    Controller.UpdateRotation(DeltaTime);
    Controller.bDoubleJump = false;
    Controller.GetPlayerViewPoint(ViewLocation, ViewRotation);
    flatRotation = ViewRotation;
    flatRotation.Pitch = 0;
    GetAxes(flatRotation, X, Y, Z);
    newAccel = (Controller.PlayerInput.aForward * X) + (Controller.PlayerInput.aStrafe * Y);
    newAccel.Z = 0.0000000;
    newAccel = Controller.Pawn.AccelRate * Normal(newAccel);
    DoubleClickMove = Controller.PlayerInput.CheckForDoubleClickMove(DeltaTime / Controller.WorldInfo.TimeDilation);
    // End:0x3EF
    if(Controller.bPressedJump && Controller.Pawn.CannotJumpNow())
    {
        bSaveJump = true;
        Controller.bPressedJump = false;        
    }
    else
    {
        bSaveJump = false;
    }
    // End:0x48B
    if(int(Controller.Role) < int(ROLE_Authority))
    {
        Controller.ReplicateMove(DeltaTime, newAccel, DoubleClickMove, OldRotation - Controller.Rotation);        
    }
    else
    {
        Controller.ProcessMove(DeltaTime, newAccel, DoubleClickMove, OldRotation - Controller.Rotation);
    }
    Controller.bPressedJump = bSaveJump;
    //return;    
}

function UpdateRotation(float DeltaTime)
{
    local Vector X, Y, Z, newAccel, ViewLocation;

    local Rotator NewRotation, ViewRotation, flatRotation;

    // End:0x11
    if(Controller == none)
    {
        return;
    }
    Controller.GetPlayerViewPoint(ViewLocation, ViewRotation);
    flatRotation = ViewRotation;
    flatRotation.Pitch = 0;
    GetAxes(flatRotation, X, Y, Z);
    newAccel = (Controller.PlayerInput.aForward * X) + (Controller.PlayerInput.aStrafe * Y);
    newAccel.Z = 0.0000000;
    // End:0x1C8
    if(VSize(newAccel) > float(0))
    {
        NewRotation = Rotator(newAccel);
        NewRotation.Pitch = ViewRotation.Pitch;
        Controller.SetRotation(NewRotation);        
    }
    else
    {
        NewRotation = Controller.Rotation;
    }
    // End:0x29B
    if(Controller.Pawn != none)
    {
        Controller.Pawn.SetDesiredRotation(NewRotation);
        Controller.Pawn.FaceRotation(NewRotation, DeltaTime);
    }
    //return;    
}
