class TgAIController_BehaviorGodDisconnected extends TgAIController_BehaviorGod
    native(AI)
    config(Game)
    hidecategories(Navigation);

var bool bInitialController;

function InitPlayerReplicationInfo()
{
    local TgRepInfo_Player PRI;

    super.InitPlayerReplicationInfo();
    PRI = TgRepInfo_Player(PlayerReplicationInfo);
    // End:0x56
    if(PRI != none)
    {
        PRI.r_bDisconnected = true;
    }
    //return;    
}

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    local TgPawn TgP;

    super(TgAIController_Behavior).Possess(inPawn, bVehicleTransition);
    NavMeshPath_SearchExtent_Modifier.X = PawnCollisionRadius * 0.2500000;
    NavMeshPath_SearchExtent_Modifier.Y = NavMeshPath_SearchExtent_Modifier.X;
    bBtDebugPaused = false;
    TgP = TgPawn(Pawn);
    // End:0x152
    if(TgP != none)
    {
        TgP.SetMovementPhysics();
        TgP.StopFiringAllDevices(false, false);
        TgP.RestartAllDevices();
        // End:0x152
        if(!TgP.IsAliveAndWell())
        {
            PawnDied(TgP);
        }
    }
    //return;    
}

defaultproperties
{
    bIsPaused=false
}