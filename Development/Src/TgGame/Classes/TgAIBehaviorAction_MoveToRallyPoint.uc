class TgAIBehaviorAction_MoveToRallyPoint extends TgAIBehaviorAction_MoveToTarget
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.ESelectionArbitrator ArbitratorOnMultipleValid;
var () bool bMustBeSameLane;

defaultproperties
{
    ArbitratorOnMultipleValid=ARBITRATE_RANDOM
    TitleName="MoveToRallyPoint"
    NodeToken=1048615
}
