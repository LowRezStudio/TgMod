class TgAIBehaviorCondition_IsTooFarFromLane extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.ECombatTargetType TargetType;

defaultproperties
{
    TitleName="IsTooFarFromLane"
    NodeToken=305
}
