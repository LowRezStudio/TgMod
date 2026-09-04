class TgAIBehaviorAction_MoveToCapturePoint extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object);

var() TgAIController_Behavior.ESelectionArbitrator Arbitrator;
var() bool bTeleport;

defaultproperties
{
    bLookAtTarget=true
    MoveTolerance=4.0000000
    TitleName="MoveToCapturePoint"
    NodeToken=1048701
}