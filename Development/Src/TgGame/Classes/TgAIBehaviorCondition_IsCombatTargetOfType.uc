class TgAIBehaviorCondition_IsCombatTargetOfType extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.ECombatTargetType TargetType;

defaultproperties
{
    TitleName="IsCombatTargetOfType"
    NodeToken=270
}
