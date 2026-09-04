class TgControlModule_Stoker extends TgControlModule_ThirdPerson;

var TgPawn_Stoker m_CachedStokerPawn;

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
{
    super.ProcessMove(DeltaTime, newAccel, DoubleClickMove, DeltaRot);
    // End:0x6E
    if(m_CachedStokerPawn == none)
    {
        m_CachedStokerPawn = TgPawn_Stoker(Controller.Pawn);
    }
    // End:0xED
    if(m_CachedStokerPawn != none)
    {
        m_CachedStokerPawn.UpdateWallRun((int(Controller.m_JumpHeld) > int(0)) || int(Controller.m_JumpHeldAlt) > int(0));
    }
    //return;    
}
