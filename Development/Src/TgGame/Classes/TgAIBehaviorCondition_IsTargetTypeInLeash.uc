class TgAIBehaviorCondition_IsTargetTypeInLeash extends TgAIBehaviorCondition
    hidecategories(Object)
    config(Engine)
    dependson(TgAIController_Behavior);

var () TgAIController_Behavior.ECombatTargetType TargetType;

defaultproperties
{
    TitleName="IsTargetTypeInLeash"
    NodeToken=302
}
