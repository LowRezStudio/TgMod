class TgControlModule_Dead extends TgControlModule;

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
{
    // End:0x65
    if(Controller.Pawn != none)
    {
        Controller.Pawn.Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    }
    //return;    
}

function PlayerMove(float DeltaTime)
{
    // End:0xC4
    if((Controller.Pawn.bHardAttach && Controller.Pawn.Base != none) && !Controller.Pawn.Base.bWorldGeometry)
    {
        return;
    }
    // End:0x134
    if(int(Controller.Role) < int(ROLE_Authority))
    {
        Controller.ReplicateMove(DeltaTime, vect(0.0000000, 0.0000000, 0.0000000), 0, rot(0, 0, 0));        
    }
    else
    {
        Controller.ProcessMove(DeltaTime, vect(0.0000000, 0.0000000, 0.0000000), 0, rot(0, 0, 0));
    }
    //return;    
}

function UpdateRotation(float DeltaTime)
{
    local Rotator NewRotation, DeltaRot;

    // End:0x11
    if(Controller == none)
    {
        return;
    }
    NewRotation = Controller.Rotation;
    DeltaRot.Yaw = int(Controller.PlayerInput.aTurn);
    DeltaRot.Pitch = int(Controller.PlayerInput.aLookUp);
    NewRotation += DeltaRot;
    NewRotation.Pitch = int(FClamp(float(NewRotation.Pitch), -12000.0000000, 12000.0000000));
    Controller.SetRotation(NewRotation);
    //return;    
}

singular simulated function Rotator GetBaseAimRotation(Weapon W, optional bool bIgnoreAutoLock)
{
    local Rotator OutRotation;
    local TgPawn Pawn;

    // End:0x1E
    if(Controller == none)
    {
        return rot(0, 0, 0);
    }
    Pawn = TgPawn(Controller.Pawn);
    // End:0x6C
    if(Pawn == none)
    {
        return rot(0, 0, 0);
    }
    OutRotation.Yaw = Controller.Rotation.Yaw;
    OutRotation.Pitch = Controller.Rotation.Pitch;
    return OutRotation;
    //return ReturnValue;    
}
