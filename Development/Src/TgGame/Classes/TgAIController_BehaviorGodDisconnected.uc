class TgAIController_BehaviorGodDisconnected extends TgAIController_BehaviorGod
    native(AI)
    config(Game)
    hidecategories(Navigation);

var bool bInitialController;

function InitPlayerReplicationInfo() { }

event Possess(Pawn inPawn, bool bVehicleTransition) { }

defaultproperties
{
    bIsPaused=false
}
