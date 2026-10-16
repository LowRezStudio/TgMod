class TgControlModule_FrontFacingCamera extends TgControlModule_ThirdPerson;

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
{
    // End:0x65
    if(Controller.Pawn != none)
    {
        Controller.Pawn.Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    }
    // End:0x14B
    if((Controller.Pawn.IsAliveAndWell() && int(Controller.Pawn.Physics) != int(2)) && int(Controller.Pawn.Physics) != int(1))
    {
        Controller.Pawn.SetPhysics(1);
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
    //return;    
}
