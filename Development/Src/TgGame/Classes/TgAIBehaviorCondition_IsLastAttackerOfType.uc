class TgAIBehaviorCondition_IsLastAttackerOfType extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.ECombatTargetType TargetType;

defaultproperties
{
    TitleName="IsLastAttackerOfType"
    NodeToken=292
}
