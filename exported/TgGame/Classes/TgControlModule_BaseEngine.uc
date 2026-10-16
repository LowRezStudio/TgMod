class TgControlModule_BaseEngine extends TgControlModule;

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

    // End:0x35
    if(Controller.Pawn == none)
    {
        GotoState('Dead');        
    }
    else
    {
        Controller.GetAxes(Controller.Pawn.Rotation, X, Y, Z);
        newAccel = (Controller.PlayerInput.aForward * X) + (Controller.PlayerInput.aStrafe * Y);
        newAccel.Z = 0.0000000;
        newAccel = Controller.Pawn.AccelRate * Normal(newAccel);
        DoubleClickMove = Controller.PlayerInput.CheckForDoubleClickMove(DeltaTime / Controller.WorldInfo.TimeDilation);
        OldRotation = Controller.Rotation;
        UpdateRotation(DeltaTime);
        Controller.bDoubleJump = false;
        // End:0x2F1
        if(Controller.bPressedJump && Controller.Pawn.CannotJumpNow())
        {
            bSaveJump = true;
            Controller.bPressedJump = false;            
        }
        else
        {
            bSaveJump = false;
        }
        // End:0x38D
        if(int(Controller.Role) < int(ROLE_Authority))
        {
            Controller.ReplicateMove(DeltaTime, newAccel, DoubleClickMove, OldRotation - Controller.Rotation);            
        }
        else
        {
            Controller.ProcessMove(DeltaTime, newAccel, DoubleClickMove, OldRotation - Controller.Rotation);
        }
        Controller.bPressedJump = bSaveJump;
    }
    //return;    
}

function UpdateRotation(float DeltaTime)
{
    local Rotator DeltaRot, NewRotation, ViewRotation;

    ViewRotation = Controller.Rotation;
    // End:0x8D
    if(Controller.Pawn != none)
    {
        Controller.Pawn.SetDesiredRotation(ViewRotation);
    }
    DeltaRot.Yaw = int(Controller.PlayerInput.aTurn);
    DeltaRot.Pitch = int(Controller.PlayerInput.aLookUp);
    Controller.ProcessViewRotation(DeltaTime, ViewRotation, DeltaRot);
    Controller.SetRotation(ViewRotation);
    Controller.ViewShake(DeltaTime);
    NewRotation = ViewRotation;
    NewRotation.Roll = Controller.Rotation.Roll;
    // End:0x27F
    if(Controller.Pawn != none)
    {
        Controller.Pawn.FaceRotation(NewRotation, DeltaTime);
    }
    //return;    
}
