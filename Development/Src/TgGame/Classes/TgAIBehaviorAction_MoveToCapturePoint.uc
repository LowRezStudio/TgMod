class TgAIBehaviorAction_MoveToCapturePoint extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.ESelectionArbitrator Arbitrator;
var () bool bTeleport;

defaultproperties
{
    bLookAtTarget=true
    MoveTolerance=4.0000000
    TitleName="MoveToCapturePoint"
    NodeToken=1048701
}
