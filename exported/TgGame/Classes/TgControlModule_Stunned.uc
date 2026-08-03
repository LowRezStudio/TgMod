class TgControlModule_Stunned extends TgControlModule_ThirdPerson;

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
{
    // End:0x65
    if(Controller.Pawn != none)
    {
        Controller.Pawn.Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    }
    //return;    
}

function Vector CalcNewAccel()
{
    return vect(0.0000000, 0.0000000, 0.0000000);
    //return ReturnValue;    
}

function UpdateRotation(float DeltaTime)
{
    local TgPawn_Character myCharPawn;

    myCharPawn = TgPawn_Character(Controller.Pawn);
    // End:0x8C
    if((myCharPawn != none) && myCharPawn.HasForcedRotation())
    {
        myCharPawn.UpdateForcedRotation(DeltaTime);
    }
    //return;    
}
