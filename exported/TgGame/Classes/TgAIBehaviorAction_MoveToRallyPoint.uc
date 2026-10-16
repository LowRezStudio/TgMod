class TgAIBehaviorAction_MoveToRallyPoint extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object);

var() TgAIController_Behavior.ESelectionArbitrator ArbitratorOnMultipleValid;
var() bool bMustBeSameLane;

defaultproperties
{
    ArbitratorOnMultipleValid=ESelectionArbitrator.ARBITRATE_RANDOM
    TitleName="MoveToRallyPoint"
    NodeToken=1048615
}